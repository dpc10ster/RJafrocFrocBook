

slopesAucsConvVsRsmCI <- function(dN) {
  
  path <- "R/compare-3-fits/"
  
  F <- length(dN)
  avgAucPro_f <- array(dim = F)
  avgAucRsm_f <- array(dim = F)
  avgAucCbm_f <- array(dim = F)
  # slopeProRsm_f <- array(dim = F) 
  # avgR2ProRsm_f <- array(dim = F)
  # slopeCbmRsm_f <- array(dim = F)
  # avgR2CbmRsm_f <- array(dim = F) 
  # rhoMuRsmMuCbm_f <- array(dim = F)
  # rhoNupAlpha_f <- array(dim = F)
  
  clParms <- NULL # parameters passed to cluster
  for (f in 1:F){
    retFileName <- paste0("R/compare-3-fits/RSM6/", "allResults", dN[f])
    if (file.exists(retFileName)){
      load(retFileName)
      #following allows elimination of the Datasets directory TBA
      #theData <- get(sprintf("dataset%02d", f)) # the datasets already exist as R objects
      theData <- loadDataFile(path = path, dN[f])
      I <- length(theData$descriptions$modalityID)
      J <- length(theData$descriptions$readerID)
      aucRsm_ij <- array(dim = c(I, J))
      aucCbm_ij <- array(dim = c(I, J))
      aucPro_ij <- array(dim = c(I, J))
      muRsm_ij <- array(dim = c(I, J))
      muCbm_ij <- array(dim = c(I, J))
      nupRsm_ij <- array(dim = c(I, J))
      alphaCbm_ij <- array(dim = c(I, J))
      
      s <- 1
      for (i in 1:I){
        for (j in 1:J){
          aucRsm_ij[i, j] <- allResults[[s]]$retRsm$AUC
          aucPro_ij[i, j] <- allResults[[s]]$aucPro
          aucCbm_ij[i, j] <- allResults[[s]]$retCbm$AUC
          muRsm_ij[i, j] <- allResults[[s]]$retRsm$mu
          muCbm_ij[i, j] <- allResults[[s]]$retCbm$mu
          nupRsm_ij[i, j] <- allResults[[s]]$retRsm$nuP
          alphaCbm_ij[i, j] <- allResults[[s]]$retCbm$alpha
          s <- s + 1
        }
      }
      avgAucRsm_f[f] <- mean(aucRsm_ij)
      avgAucPro_f[f] <- mean(aucPro_ij)
      avgAucCbm_f[f] <- mean(aucCbm_ij)
      
      # rhoMuRsmMuCbm_f[f] <- cor(as.vector(muRsm_ij), as.vector(muCbm_ij),method = "pearson")
      # rhoNupAlpha_f[f]<- cor(as.vector(nupRsm_ij), as.vector(alphaCbm_ij),method = "pearson")
      
      # df <- data.frame(aucRsm = as.vector(aucRsm_ij), aucPro = as.vector(aucPro_ij))
      # m <- lm(aucPro ~ 0 + aucRsm, data = df)
      # slopeProRsm_f[f] <- coef(m)
      # avgR2ProRsm_f[f] <- summary(m)$r.squared
      
      # df <- data.frame(aucRsm = as.vector(aucRsm_ij), aucCbm = as.vector(aucCbm_ij))
      # m <- lm(aucCbm ~ 0 + aucRsm, data = df)
      # slopeCbmRsm_f[f] <- coef(m)
      # avgR2CbmRsm_f[f] <- summary(m)$r.squared
      
      clParms <- c(clParms, list(
        list(aucRsm_ij = aucRsm_ij, 
             aucPro_ij = aucPro_ij, 
             aucCbm_ij = aucCbm_ij, 
             muRsm_ij = muRsm_ij, 
             muCbm_ij = muCbm_ij,
             nupRsm_ij = nupRsm_ij, 
             alphaCbm_ij = alphaCbm_ij
      )))
    }else{
      stop("Results file does not exist. Must analyze all datasets before running this.")
    }
  }
  
  avgAucRsm <- mean(avgAucRsm_f)
  avgAucPro <- mean(avgAucPro_f)
  avgAucCbm <- mean(avgAucCbm_f)
  
  # bootstrap cluster code follows 
  names(clParms) <- dN
  cl <- makeCluster(detectCores())
  registerDoParallel(cl)
  B <- 200
  seed <- 1 # don't use NULL as then results keep changing
  bootStrapResults <- foreach (b = 1:B, .options.RNG = seed, .combine = "rbind", .packages = "RJafroc") %dorng% {
    slopeCbmRsm_f <- rep(NA, F)
    avgR2CbmRsm_f <- rep(NA, F)
    slopeProRsm_f <- rep(NA, F)
    avgR2ProRsm_f <- rep(NA, F)
    rhoMuRsmMuCbm_f <- rep(NA, F)
    rhoNupAlpha_f <- rep(NA, F)
    aucRsm_ij <- array(dim = c(F))
    aucPro_ij <- array(dim = c(F))
    aucCbm_ij <- array(dim = c(F))
    
    for (f in 1:F){
      retFileName <- paste0("R/compare-3-fits/RSM6/", "allResults", dN[f])
      if (file.exists(retFileName)){
        I <- length(clParms[[dN[f]]]$aucRsm_ij[,1])
        J <- length(clParms[[dN[f]]]$aucRsm_ij[1,])
        
        jBs <- ceiling(runif(J) * J) # here is were we bootstrap readers
        
        aucRsm_ij[f] <- mean(clParms[[dN[f]]]$aucRsm_ij[ , jBs])
        aucPro_ij[f] <- mean(clParms[[dN[f]]]$aucPro_ij[ , jBs])
        aucCbm_ij[f] <- mean(clParms[[dN[f]]]$aucCbm_ij[ , jBs])
        
        # constrained fit thru origin; aucPro_ij vs. aucRsm_ij 
        df1 <- data.frame(aucRsm_ij = as.vector(clParms[[dN[f]]]$aucRsm_ij[ , jBs]), 
                          aucPro_ij = as.vector(clParms[[dN[f]]]$aucPro_ij[, jBs]))
        m <- lm(aucPro_ij ~ 0 + aucRsm_ij, data = df1)
        slopeProRsm_f[f] <- coef(m)
        avgR2ProRsm_f[f] <- summary(m)$r.squared
        
        # constrained fit thru origin; aucCbm_ij vs. aucRsm_ij 
        df2 <- data.frame(aucRsm_ij = as.vector(clParms[[dN[f]]]$aucRsm_ij[ , jBs]), 
                          aucCbm_ij = as.vector(clParms[[dN[f]]]$aucCbm_ij[, jBs]))
        m <- lm(aucCbm_ij ~ 0 + aucRsm_ij, data = df2)
        slopeCbmRsm_f[f] <- coef(m)
        avgR2CbmRsm_f[f] <- summary(m)$r.squared
        
        # correlation between muRsm_ij and muCbm_ij
        df1 <- data.frame(muRsm_ij = as.vector(clParms[[dN[f]]]$muRsm_ij[ , jBs]), 
                          muCbm_ij = as.vector(clParms[[dN[f]]]$muCbm_ij[, jBs]))
        rhoMuRsmMuCbm_f[f] <- cor(df1$muRsm_ij, df1$muCbm_ij,method = "pearson")
        
        # correlation between nupRsm_ij and alphaCbm_ij
        df2 <- data.frame(nupRsm_ij = as.vector(clParms[[dN[f]]]$nupRsm_ij[ , jBs]), 
                          alphaCbm_ij = as.vector(clParms[[dN[f]]]$alphaCbm_ij[, jBs]))
        rhoNupAlpha_f[f] <- cor(df2$nupRsm_ij, df2$alphaCbm_ij,method = "pearson")
        
      }else{
        stop("Results file does not exist.")
      }
    }
    # following is return of bootstrap code 
    # for each value of b
    # average is over 14 datasets
    c(mean(slopeProRsm_f), 
      mean(avgR2ProRsm_f), 
      mean(slopeCbmRsm_f), 
      mean(avgR2CbmRsm_f), 
      mean(rhoMuRsmMuCbm_f), 
      mean(rhoNupAlpha_f),
      mean(aucRsm_ij), 
      mean(aucPro_ij), 
      mean(aucCbm_ij),
      mean(aucPro_ij-aucRsm_ij), 
      mean(aucCbm_ij-aucRsm_ij), 
      mean(aucPro_ij-aucCbm_ij)
    )
  }
  stopCluster(cl)
  
  slopeProRsm_f <- data.frame(value = bootStrapResults[ , 1])
  avgR2ProRsm_f <- data.frame(value = bootStrapResults[ , 2])
  slopeCbmRsm_f <- data.frame(value = bootStrapResults[ , 3])
  avgR2CbmRsm_f <- data.frame(value = bootStrapResults[ , 4])
  rhoMuRsmMuCbm_f <- data.frame(value = bootStrapResults[ , 5])
  rhoNupAlpha_f <- data.frame(value = bootStrapResults[ , 6])
  aucRsm_ij <- data.frame(value = bootStrapResults[ , 7])
  aucPro_ij <- data.frame(value = bootStrapResults[ , 8])
  aucCbm_ij <- data.frame(value = bootStrapResults[ , 9])
  diffAucProRsm_ij <- data.frame(value = bootStrapResults[ , 10])
  diffAucCbmRsm_ij <- data.frame(value = bootStrapResults[ , 11])
  diffAucProCbm_ij <- data.frame(value = bootStrapResults[ , 12])
  
  alpha <- 0.05 # alpha <- 0.05
  ciAvgAucRsm <- quantile(aucRsm_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  ciAvgAucPro <- quantile(aucPro_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  ciAvgAucCbm <- quantile(aucCbm_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  
  ciDiffAucProRsm <- quantile(diffAucProRsm_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  ciDiffAucCbmRsm <- quantile(diffAucCbmRsm_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  ciDiffAucProCbm <- quantile(diffAucProCbm_ij$value, c(alpha/2, 1-alpha/2), type = 1)
  
  histSlopeProRsm <- ggplot(slopeProRsm_f, aes(x = value)) + 
    geom_histogram(color = "white", binwidth = (max(slopeProRsm_f$value) - min(slopeProRsm_f$value))/30) +
    xlab("m-PR")
  cislopeProRsm <- quantile(slopeProRsm_f$value, c(alpha/2, 1-alpha/2), type = 1)
  histSlopeCbmRsm <- ggplot(slopeCbmRsm_f, aes(x = value)) + 
    geom_histogram(color = "white", binwidth = (max(slopeCbmRsm_f$value) - min(slopeCbmRsm_f$value))/30) +
    xlab("m-CR")
  cislopeCbmRsm <- quantile(slopeCbmRsm_f$value, c(alpha/2, 1-alpha/2), type = 1)
  
  # h3 <- ggplot(rhoMuRsmMuCbm_f, aes(x = value)) + geom_histogram(color = "white") +
  #   xlab("rhoMuRsmMuCbm_f")
  # print(h3)
  # ciRhoMuRsmMuCbm <- quantile(rhoMuRsmMuCbm_f$value, c(alpha/2, 1-alpha/2), type = 1)
  # cat("The empirical 95% CI of rhoMuRsmMuCbm_f is", paste(ciRhoMuRsmMuCbm, collapse = ", "), "\n")
  # 
  # h4 <- ggplot(rhoNupAlpha_f, aes(x = value)) + geom_histogram(color = "white", binwidth = 0.003) +
  #   xlab("rhoNupAlpha_f")
  # print(h4)
  # ciRhoNupRsmAlphaCbm <- quantile(rhoNupAlpha_f$value, c(alpha/2, 1-alpha/2), type = 1, na.rm = TRUE)
  # cat("The empirical 95% CI of rhoNupAlpha_f is", paste(ciRhoNupRsmAlphaCbm, collapse = ", "), "\n")
  
  return(list(
    avgAucRsm = avgAucRsm,
    avgAucPro = avgAucPro,
    avgAucCbm = avgAucCbm,
    ciAvgAucRsm = ciAvgAucRsm,
    ciAvgAucPro = ciAvgAucPro,
    ciAvgAucCbm = ciAvgAucCbm,
    ciDiffAucProRsm = ciDiffAucProRsm,
    ciDiffAucCbmRsm = ciDiffAucCbmRsm,
    ciDiffAucProCbm = ciDiffAucProCbm,
    histSlopeProRsm = histSlopeProRsm,
    histSlopeCbmRsm = histSlopeCbmRsm,
    cislopeProRsm = cislopeProRsm,
    cislopeCbmRsm = cislopeCbmRsm
  ))
}

