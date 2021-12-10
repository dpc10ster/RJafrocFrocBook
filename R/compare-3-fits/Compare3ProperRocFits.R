UtilBinCountsOpPts <- function(dataset, trt = 1, rdr = 1)
{
  NL <- dataset$ratings$NL
  LL <- dataset$ratings$LL
  nlDim <- dim(NL)
  llDim <- dim(LL)
  I <- nlDim[1]
  J <- nlDim[2]
  K <- nlDim[3]
  K2 <- llDim[3]
  K1 <- K - K2
  
  fp <- NL[trt,rdr,1:K1,,drop = TRUE] 
  tp <- LL[trt,rdr,,,drop = TRUE]
  
  bins <- sort(unique(c(fp,tp)))
  nBins <- length(bins)
  
  fpCounts <- array(0, dim = nBins)
  tpCounts <- array(0, dim = nBins)
  
  for (b in 1:nBins){
    fpCounts[b] <- sum(fp == bins[b])
    tpCounts[b] <- sum(tp == bins[b])
  }
  
  fpf <- cumsum(rev(fpCounts)) / K1
  tpf <- cumsum(rev(tpCounts)) / K2
  fpf <- fpf[-length(fpf)]
  tpf <- tpf[-length(tpf)]
  
  return(list(
    fpCounts = fpCounts,
    tpCounts = tpCounts,
    fpf = fpf,
    tpf = tpf
  ))
}



# Compare three proper-ROC curve fitting models 
Compare3ProperRocFits <- function(datasetNames,
                                  startIndx = 1, 
                                  endIndx = 14, 
                                  saveProprocLrcFile = FALSE, 
                                  reAnalyze = FALSE)
{
  ####  DPC notes on updating the results 2/17/18
  ####  First run PROPROC on all datasets (see book Chapter 20)
  ####  1. ret14 <- Compare3ProperRocFits(saveProprocLrcFile = TRUE) 
  ####     this generates 14 .lrc files in RJafroc
  ####  2. Move these files to VmWareShared folder
  ####  3. Start VmWare and Windows 8
  ####  4. Start OR DBM MRMC, select .lrc file, select PROPROC AUC and RUN ALL
  ####  5. Repeat for each dataset
  ####  6. Move 2 files (ending with .lroc and PROPROC area pooled.csv) from 
  ####     VmWareShared to MRMCRuns to appropriate subdirectories.
  ####  7. Remove spaces in names of all "proproc area pooled.csv" files  
  ####  8. ret14 <- Compare3ProperRocFits(reAnalyze = TRUE) 
  ####     this generates new results files in RSM6
  ####
  # 
  # Peter Philips showed me (06/21/19) that this line was causing testthat failures
  # in function expect_known_output()
  # 
  
  options(warn = 2) # warnings AS errors
  # NOTE added 6/25/19 - this is matched at exit with: 
  # options(warn = 0) # warnings NOT as errors 
  # datasetNames <-  c("TONY", "VD", "FR", 
  #                 "FED", "JT", "MAG", 
  #                 "OPT", "PEN", "NICO",
  #                 "RUS", "DOB1", "DOB2", 
  #                 "DOB3", "FZR")
  if (!(startIndx %in% seq(1,14) && endIndx %in% seq(1,14))) stop("illegal values for startIndx and/ or endIndx")
  allBinnedDatasets <- as.list(array(dim = endIndx - startIndx + 1))
  allResults1 <- as.list(array(dim = endIndx - startIndx + 1))
  allPlots <- as.list(array(dim = endIndx - startIndx + 1))
  for (f in startIndx:endIndx) {
    fileName <- datasetNames[f]
    theData <- get(sprintf("dataset%02d", f)) # the datasets already exist as R objects
    lesDistr <- UtilLesionDistr(theData) # RSM ROC fitting needs to know lesDistr
    
    # convert to HR ROC data; and remove negative infinities
    if (theData$descriptions$type == "FROC") rocData <- DfFroc2Roc(theData) else rocData <- theData  
    
    if (saveProprocLrcFile) {
      DfSaveDataFile(rocData, 
                     fileName = paste0(fileName,".lrc"), format = "MRMC")
    }
    I <- length(rocData$descriptions$modalityID);J <- length(rocData$descriptions$readerID)
    K <- dim(rocData$ratings$NL)[3];K2 <- dim(rocData$ratings$LL)[3];K1 <- K - K2
    
    ## retrieve PROPROC parameters
    csvFileName <- paste0(fileName, "proprocareapooled.csv") # runs on July 29, 2017
    sysCsvFileName <- paste0("R/compare-3-fits/MRMCRuns/",fileName, "/", csvFileName)
    if (!file.exists(sysCsvFileName)) stop("need to run Windows PROPROC for this dataset using VMware Fusion")
    proprocRet <- read.csv(sysCsvFileName)
    c1 <- matrix(data = proprocRet$c, nrow = length(unique(proprocRet$T)), 
                 ncol = length(unique(proprocRet$R)), byrow = TRUE)
    da <- matrix(data = proprocRet$d_a, nrow = length(unique(proprocRet$T)), 
                 ncol = length(unique(proprocRet$R)), byrow = TRUE)
    
    retFileName <- paste0("R/compare-3-fits/RSM6/", "allResults", fileName) 
    if (!all(isBinnedDataset(rocData))){
      binnedRocData <- DfBinDataset(rocData, desiredNumBins = 5, opChType = "ROC") # new function
    }else{
      binnedRocData <- rocData
    }
    
    #cat(fileName,	" i, j, mu, lambdaP,	nuP, c,	da,	alpha, muCbm,	AUC-RSM, AUC-PROPROC, AUC-CBM, chisq, p-value,  df\n")
    if (reAnalyze || !file.exists(retFileName)){
      allResults <- list()
      AllResIndx <- 0
      compPlot <- array(list(), dim = c(I,J))
      for (i in 1:I){
        for (j in 1:J){
          #if (!(f == 2 && i == 2 && j == 2)) next ## investigating warnings
          AllResIndx <- AllResIndx + 1
          retCbm <- FitCbmRoc(binnedRocData, trt = i, rdr = j)
          retRsm <- FitRsmRoc(binnedRocData, trt = i, rdr = j, lesDistr = lesDistr[,2]) # fit to RSM, need lesDistr matrix
          retCbm1 <- retCbm[-10] # deleting plots as they generate Notes in R CMD CHK -> file size too large
          retRsm1 <- retRsm[-11] #   do:
          aucProproc <- UtilAucPROPROC(c1[i,j], da[i,j])
          allResults[[AllResIndx]] <- list(retRsm = retRsm1, retCbm = retCbm1, lesDistr = lesDistr, 
                                           c1 = c1[i, j], da = da[i, j], aucProp = aucProproc, 
                                           I = I, J = J, K1 = K1, K2 = K2)
          x <- allResults[[AllResIndx]]
          lesDistr <- x$lesDistr
          empOp <- UtilBinCountsOpPts(binnedRocData, trt = i, rdr = j)
          fpf <- empOp$fpf; tpf <- empOp$tpf
          compPlot[[i,j]] <- gpfPlotRsmPropCbm(
            datasetNames[which(datasetNames == fileName)], x$retRsm$mu, x$retRsm$lambdaP, x$retRsm$nuP, 
            lesDistr, c1[i, j], da[i, j],
            x$retCbm$mu, x$retCbm$alpha,
            fpf, tpf, i, j, K1, K2, c(1, length(fpf)))
          allPlots[[f-startIndx + 1]] <- compPlot
          # follows same format as RSM Vs. Others.xlsx
          # cat(fileName, i, j, x$retRsm$mu, x$retRsm$lambdaP, x$retRsm$nuP,
          #     c1[i,j], da[i,j],
          #     x$retCbm$alpha, x$retCbm$mu,
          #     x$retRsm$AUC, x$aucProp, x$retCbm$AUC,
          #     x$retRsm$ChisqrFitStats[[1]], x$retRsm$ChisqrFitStats[[2]],
          #     x$retRsm$ChisqrFitStats[[3]],"\n")
          next
        }
      }
      allResults1[[f-startIndx + 1]] <- allResults
      allBinnedDatasets[[f-startIndx + 1]] <- binnedRocData
      # cat("\n")
      ### safety comments
      ### to update allResults, make sure correct path is defined below
      ### in git version it is rjafroc; in CRAN version it is rjafroc
      ### uncomment the following two statements and run ret <- Compare3ProperRocFits(reAnalyze = TRUE)
      ### the sytem files are updated on next build (the writes occur to savFileName, which are used to update system files) 
      # savFileName <- paste0("RSM6/", retFileName) # git version
      # save(allResults, file = savFileName)
    } else {
      load(retFileName)
      AllResIndx <- 0
      #cat(fileName,	" i, j, mu, lambdaP,	nuP, c,	da,	alpha, muCbm,	AUC-RSM, AUC-PROPROC, AUC-CBM, chisq, p-value,  df\n")
      compPlot <- array(list(), dim = c(I,J))
      for (i in 1:I){
        for (j in 1:J){
          AllResIndx <- AllResIndx + 1
          x <- allResults[[AllResIndx]]
          empOp <- UtilBinCountsOpPts(binnedRocData, trt = i, rdr = j)
          fpf <- empOp$fpf; tpf <- empOp$tpf
          compPlot[[i,j]]  <- gpfPlotRsmPropCbm(
            datasetNames[which(datasetNames == fileName)], x$retRsm$mu, x$retRsm$lambdaP, x$retRsm$nuP, 
            lesDistr, c1[i, j], da[i, j],
            x$retCbm$mu, x$retCbm$alpha,
            fpf, tpf, i, j, K1, K2, c(1, length(fpf)))
          allPlots[[f-startIndx + 1]] <- compPlot
          # follows same format as RSM Vs. Others.xlsx
          # cat(fileName, i, j, x$retRsm$mu, x$retRsm$lambdaP, x$retRsm$nuP, 
          #     c1[i,j], da[i,j], 
          #     x$retCbm$alpha, x$retCbm$mu,
          #     x$retRsm$AUC, x$aucProp, x$retCbm$AUC, 
          #     x$retRsm$ChisqrFitStats[[1]], x$retRsm$ChisqrFitStats[[2]], 
          #     x$retRsm$ChisqrFitStats[[3]],"\n")
          next
        }
      }
      allResults1[[f-startIndx + 1]] <- allResults
      allBinnedDatasets[[f-startIndx + 1]] <- binnedRocData
      # cat("\n\n\n")
    }
  }
  
  options(warn = 0) # warnings NOT as errors
  
  return(list(
    allResults = allResults1,
    allBinnedDatasets = allBinnedDatasets,
    allPlots = allPlots
  ))
}



gpfPlotRsmPropCbm <- function(fileName, mu, lambdaP, nuP, lesDistr, c1, da, 
                              muCbm, alpha, fpf, tpf, i, j, K1, K2, ciIndx) {
  
  retProproc <- gpfPropRocOperatingCharacteristic(c1,da)
  FPFProp <- c(1, retProproc$FPF);TPFProp <- c(1, retProproc$TPF) # make sure it goes to upper-right corner
  plotProp <- data.frame(FPF = FPFProp, TPF = TPFProp, Model = "PROP")
  retRsm <- gpfRsmOperatingCharacteristic (mu, lambdaP, nuP, lesDistr = lesDistr[,2]) # dpc 1/1/2021
  FPFRsm <- retRsm$FPF;TPFRsm <- retRsm$TPF
  plotRsm <- data.frame(FPF = FPFRsm, TPF = TPFRsm, Model = "RSM")
  dashedRsm <- data.frame(FPF = c(FPFRsm[1], 1), TPF = c(TPFRsm[1], 1), Model = "RSM")
  
  retCbm <- gpfCbmOperatingCharacteristic (muCbm, alpha)
  FPFCbm <- retCbm$FPF;TPFCbm <- retCbm$TPF
  plotCbm <- data.frame(FPF = FPFCbm, TPF = TPFCbm, Model = "CBM")
  
  plotCurve <- rbind(plotProp, plotCbm, plotRsm)
  plotCurve <- as.data.frame(plotCurve)
  plotOp <- data.frame(FPF = fpf, TPF = tpf)
  plotOp <- as.data.frame(plotOp)
  
  ij <- paste0(fileName, ", i = ", i, ", j = ", j)
  Model <- NULL # to get around R CMD CHK throwing a Note
  FPF <- fpf
  TPF <- tpf
  FPF <- FPF[ciIndx]
  TPF <- TPF[ciIndx]
  fitPlot <- ggplot(data = plotCurve) + 
    geom_line(mapping = aes(x = FPF, y = TPF, color = Model)) + 
    geom_line(data = dashedRsm, aes(x = FPF, y = TPF, color = Model), linetype = 3) + 
    scale_color_manual(values = c("red", "darkblue", "black")) # color corresponds to order of plots in plotCurve
  
  fitPlot <- fitPlot + 
    geom_point(mapping = aes(x = FPF, y = TPF), data = plotOp) +
    theme(legend.position = "none") + 
    ggtitle(ij)# + theme(plot.title = element_text(size = 0.5,face="bold"))
  
  ciX <- binom.confint(x = FPF * K1, n = K1, methods = "exact")
  ciY <- binom.confint(x = TPF * K2, n = K2, methods = "exact")
  ciXUpper <- ciX$upper
  ciXLower <- ciX$lower
  ciYUpper <- ciY$upper
  ciYLower <- ciY$lower
  for (i in 1:length(FPF)){
    ciX <- data.frame(FPF = c(ciXUpper[i], ciXLower[i]), TPF = c(TPF[i], TPF[i]))
    ciY <- data.frame(FPF = c(FPF[i], FPF[i]), TPF = c(ciYUpper[i], ciYLower[i]))
    fitPlot <- fitPlot + geom_line(data = ciY, aes(x = FPF, y = TPF), color = "black") + 
      geom_line(data = ciX, aes(x = FPF, y = TPF), color = "black")
    barRgt <- data.frame(FPF = c(ciXUpper[i], ciXUpper[i]), TPF = c(TPF[i] - 0.01, TPF[i] + 0.01))
    barLft <- data.frame(FPF = c(ciXLower[i], ciXLower[i]), TPF = c(TPF[i] - 0.01, TPF[i] + 0.01))
    barUp <- data.frame(FPF = c(FPF[i] - 0.01, FPF[i] + 0.01), TPF = c(ciYUpper[i], ciYUpper[i]))
    barBtm <- data.frame(FPF = c(FPF[i] - 0.01, FPF[i] + 0.01), TPF = c(ciYLower[i], ciYLower[i]))
    fitPlot <- fitPlot + geom_line(data = barRgt, aes(x = FPF, y = TPF), color = "black") + 
      geom_line(data = barLft, aes(x = FPF, y = TPF), color = "black") + 
      geom_line(data = barUp, aes(x = FPF, y = TPF), color = "black") + 
      geom_line(data = barBtm, aes(x = FPF, y = TPF), color = "black")
  }
  return(fitPlot)
}


gpfPropRocOperatingCharacteristic <- function(c1, da){
  if (c1 < 0){
    plotZeta <- seq(da/(4 * c1) * sqrt(1 + c1^2), 8, by = 0.01)
  }else if(c1 > 0){
    plotZeta <- seq(-4, da/(4 * c1) * sqrt(1 + c1^2), by = 0.01)
  }else{
    plotZeta <- seq(-4, 10, by = 0.01)
  }
  FPFProp <- pnorm(-(1 - c1) * plotZeta - da/2 * sqrt(1 + c1^2)) + 
    pnorm(-(1 - c1) * plotZeta + da/(2*c1) * sqrt(1 + c1^2)) - ifelse(c1 >= 0, 1, 0)
  TPFProp <- pnorm(-(1 + c1) * plotZeta + da/2 * sqrt(1 + c1^2)) + 
    pnorm(-(1 + c1) * plotZeta + da/(2*c1) * sqrt(1 + c1^2)) - ifelse(c1 >= 0, 1, 0)
  if ((c1 == 1) && (da == 0)) {
    FPFProp <- c(FPFProp, seq(0,1,length.out = length(FPFProp)))
    TPFProp <- c(TPFProp, rep(1,length(TPFProp)))
  }
  return(list(FPF = FPFProp,
              TPF = TPFProp
  ))
}

gpfCbmOperatingCharacteristic <- function(mu, alpha){
  
  plotZeta <- seq(-4, mu+4, by = 0.1)
  
  FPFCbm <- 1 - pnorm(plotZeta)
  TPFCbm <- (1 - alpha) * (1 - pnorm(plotZeta)) + alpha * (1 - pnorm(plotZeta, mean = mu))
  
  return(list(FPF = FPFCbm,
              TPF = TPFCbm
  ))
}



gpfRsmOperatingCharacteristic <- function(mu, lambdaP, nuP, lesDistr){
  
  x <- UtilPhysical2IntrinsicRSM(mu,lambdaP,nuP)
  lambda <- x$lambda
  nu <- x$nu
  plotZeta <- seq(-4, mu+4, by = 0.01)
  
  FPFRsm <- sapply(plotZeta, RSM_xROC, lambda = lambda)
  TPFRsm <- sapply(plotZeta, RSM_yROC, mu = mu, lambda = lambda, 
                   nu = nu, lesDistr = lesDistr)
  
  return(list(FPF = FPFRsm,
              TPF = TPFRsm
  ))
}


