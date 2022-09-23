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
                                  f,
                                  saveProprocLrcFile = FALSE, 
                                  reAnalyze = FALSE)
{
  options(warn = 2) # warnings AS errors
  fileName <- datasetNames[f]
  theData <- get(sprintf("dataset%02d", f)) # the datasets already exist as R objects
  lesDistr <- UtilLesionDistrVector(theData) # RSM ROC fitting needs to know lesDistr
  
  # convert to HR ROC data; and remove negative infinities
  if (theData$descriptions$type == "FROC") rocData <- DfFroc2Roc(theData) else rocData <- theData  
  
  if (saveProprocLrcFile) {
    DfSaveDataFile(rocData, 
                   fileName = paste0(fileName,".lrc"), format = "MRMC")
  }
  
  I <- length(rocData$descriptions$modalityID)
  J <- length(rocData$descriptions$readerID)
  K <- dim(rocData$ratings$NL)[3]
  K2 <- dim(rocData$ratings$LL)[3];K1 <- K - K2
  
  ## retrieve PROPROC parameters
  csvFileName <- paste0(fileName, "proprocareapooled.csv") # runs on July 29, 2017
  sysCsvFileName <- paste0("R/compare-3-fits/MRMCRuns/",fileName, "/", csvFileName)
  if (!file.exists(sysCsvFileName)) stop("need to run Windows PROPROC for this dataset using VMware Fusion")
  proprocRet <- read.csv(sysCsvFileName)
  c1 <- matrix(data = proprocRet$c, nrow = length(unique(proprocRet$T)), 
               ncol = length(unique(proprocRet$R)), byrow = TRUE)
  da <- matrix(data = proprocRet$d_a, nrow = length(unique(proprocRet$T)), 
               ncol = length(unique(proprocRet$R)), byrow = TRUE)

  ## retrieve prenanalyzed results
  retFileName <- paste0("R/compare-3-fits/RSM6/", "allResults", fileName)
  
  if (!all(isBinnedDataset(rocData))){
    binnedRocData <- DfBinDataset(rocData, desiredNumBins = 5, opChType = "ROC") # new function
  }else{
    binnedRocData <- rocData
  }
  
  compPlot_ij <- array(list(), dim = c(I, J))
  allResults_ij <- array(list(), dim = c(I, J))
  
  if (reAnalyze || !file.exists(retFileName)){
    AllResIndx <- 0
    for (i in 1:I){
      for (j in 1:J){
        AllResIndx <- AllResIndx + 1
        ret_C <- FitCbmRoc(binnedRocData, trt = i, rdr = j)
        ret_R <- FitRsmRoc(binnedRocData, trt = i, rdr = j, lesDistr = lesDistr) # fit to RSM, need lesDistr vector
        retCbm <- ret_C[-10] # deleting plots as they generate Notes in R CMD CHK -> file size too large
        retRsm <- ret_R[-11] #   do:
        aucProproc <- UtilAucPROPROC(c1[i,j], da[i,j])
        allResults_ij[[i,j]] <- list(retRsm = retRsm, retCbm = retCbm, lesDistr = lesDistr, 
                                         c1 = c1[i, j], da = da[i, j], aucProp = aucProproc, 
                                         I = I, J = J, K1 = K1, K2 = K2)
        x <- allResults_ij[[i,j]]
        lesDistr <- x$lesDistr
        empOp <- UtilBinCountsOpPts(binnedRocData, trt = i, rdr = j)
        fpf <- empOp$fpf; tpf <- empOp$tpf
        compPlot_ij[[i, j]] <- gpfPlotRsmPropCbm(
          fileName, x$retRsm$mu, x$retRsm$lambda, x$retRsm$nu, 
          lesDistr, c1[i, j], da[i, j],
          x$retCbm$mu, x$retCbm$alpha,
          fpf, tpf, i, j, K1, K2, c(1, length(fpf)))
        next
      }
    }
    
    ### safety comments
    ### to update allResults_ij, make sure correct path is defined below
    ### in git version it is rjafroc; in CRAN version it is rjafroc
    ### uncomment the following two statements and run ret <- Compare3ProperRocFits(reAnalyze = TRUE)
    ### the sytem files are updated on next build (the writes occur to savFileName, which are used to update system files) 
    # savFileName <- paste0("/Users/Dev/rjafroc/inst/ANALYZED/RSM6/", retFileName) # git version
    # save(allResults, file = savFileName)
  } else {
    load(retFileName)
    AllResIndx <- 0
    for (i in 1:I){
      for (j in 1:J){
        AllResIndx <- AllResIndx + 1
        x <- allResults[[AllResIndx]]
        allResults_ij[[i,j]] <- x
        empOp <- UtilBinCountsOpPts(binnedRocData, trt = i, rdr = j)
        fpf <- empOp$fpf; tpf <- empOp$tpf
        compPlot_ij[[i,j]] <- gpfPlotRsmPropCbm(
          f, x$retRsm$mu, x$retRsm$lambda, x$retRsm$nu, 
          lesDistr, c1[i, j], da[i, j],
          x$retCbm$mu, x$retCbm$alpha,
          fpf, tpf, i, j, K1, K2, c(1, length(fpf)))
        next
      }
    }
  }
  
  options(warn = 0) # warnings NOT as errors
  
  return(list(
    allPlots = compPlot_ij,
    allResults = allResults_ij,
    allDatasets = binnedRocData
  ))
}



gpfPlotRsmPropCbm <- function(f, mu, lambda, nu, lesDistr, c1, da, 
                              muCbm, alpha, fpf, tpf, i, j, K1, K2, ciIndx) {
  
  ret_P <- gpfPropRocOperatingCharacteristic(c1,da)
  FPF_P <- c(1, ret_P$FPF);TPF_P <- c(1, ret_P$TPF) # make sure it goes to upper-right corner
  plotProp <- data.frame(FPF = FPF_P, TPF = TPF_P, Model = "PROP")
  
  ret_R <- gpfRsmOperatingCharacteristic (mu, lambda, nu, lesDistr = lesDistr) # dpc 7/20/2022
  FPF_R <- ret_R$FPF;TPF_R <- ret_R$TPF
  plotRsm <- data.frame(FPF = FPF_R, TPF = TPF_R, Model = "RSM")
  dashedRsm <- data.frame(FPF = c(FPF_R[1], 1), TPF = c(TPF_R[1], 1), Model = "RSM")
  
  ret_C <- gpfCbmOperatingCharacteristic (muCbm, alpha)
  FPF_C <- ret_C$FPF;TPF_C <- ret_C$TPF
  plotCbm <- data.frame(FPF = FPF_C, TPF = TPF_C, Model = "CBM")
  
  plotCurve <- rbind(plotProp, plotCbm, plotRsm)
  plotCurve <- as.data.frame(plotCurve)
  plotOp <- data.frame(FPF = fpf, TPF = tpf)
  plotOp <- as.data.frame(plotOp)
  
  ij <- paste0("D", f, ", i = ", i, ", j = ", j)
  Model <- NULL # to get around R CMD CHK throwing a Note
  FPF <- fpf
  TPF <- tpf
  FPF <- FPF[ciIndx]
  TPF <- TPF[ciIndx]
  fitPlot <- ggplot(data = plotCurve) + 
    geom_line(mapping = aes(x = FPF, y = TPF, color = Model), size = 2) + 
    geom_line(data = dashedRsm, aes(x = FPF, y = TPF, color = Model), linetype = 3, size = 2) + 
    scale_color_manual(values = c("red", "darkblue", "black")) # color corresponds to order of plots in plotCurve

  fitPlot <- fitPlot + 
    geom_point(mapping = aes(x = FPF, y = TPF), data = plotOp, size = 5) +
    theme(legend.position = "none") + 
    ggtitle(ij) + theme(plot.title = element_text(size = 20,face="bold"))
  
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
  FPF_P <- pnorm(-(1 - c1) * plotZeta - da/2 * sqrt(1 + c1^2)) + 
    pnorm(-(1 - c1) * plotZeta + da/(2*c1) * sqrt(1 + c1^2)) - ifelse(c1 >= 0, 1, 0)
  TPF_P <- pnorm(-(1 + c1) * plotZeta + da/2 * sqrt(1 + c1^2)) + 
    pnorm(-(1 + c1) * plotZeta + da/(2*c1) * sqrt(1 + c1^2)) - ifelse(c1 >= 0, 1, 0)
  if ((c1 == 1) && (da == 0)) {
    FPF_P <- c(FPF_P, seq(0,1,length.out = length(FPF_P)))
    TPF_P <- c(TPF_P, rep(1,length(TPF_P)))
  }
  return(list(FPF = FPF_P,
              TPF = TPF_P
  ))
}



gpfCbmOperatingCharacteristic <- function(mu, alpha){
  
  plotZeta <- seq(-4, mu+4, by = 0.1)
  
  FPF_C <- 1 - pnorm(plotZeta)
  TPF_C <- (1 - alpha) * (1 - pnorm(plotZeta)) + alpha * (1 - pnorm(plotZeta, mean = mu))
  
  return(list(FPF = FPF_C,
              TPF = TPF_C
  ))
}



gpfRsmOperatingCharacteristic <- function(mu, lambda, nu, lesDistr){
  
  plotZeta <- seq(-4, mu+4, by = 0.1)
  
  FPF_R <- sapply(plotZeta, RSM_xROC, lambda = lambda)
  TPF_R <- sapply(plotZeta, RSM_yROC, mu = mu, lambda = lambda, 
                  nu = nu, lesDistr = lesDistr)
  
  return(list(FPF = FPF_R,
              TPF = TPF_R
  ))
}


