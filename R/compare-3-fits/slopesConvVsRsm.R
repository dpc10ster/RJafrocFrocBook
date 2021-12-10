slopesConvVsRsm <- function(datasetNames) {
  path <- "R/compare-3-fits/"
  m_pro_rsm <- data.frame(m_pro_rsm = rep(NA, length(datasetNames)), 
                          r2_pro_rsm = rep(NA, length(datasetNames)),
                          stringsAsFactors = FALSE)
  m_cbm_rsm <- data.frame(m_cbm_rsm = rep(NA, length(datasetNames)), 
                          r2_cbm_rsm = rep(NA, length(datasetNames)),
                          stringsAsFactors = FALSE)
  p2 <- p1 <- array(list(), dim = c(length(datasetNames)))
  for (f in 1:length(datasetNames)){
      retFileName <- paste0("R/compare-3-fits/RSM6/", "allResults", datasetNames[f])
    if (file.exists(retFileName)){
      load(retFileName)
      # following allows elimination of the Datasets directory TBA
      #theData <- get(sprintf("dataset%02d", f)) # the datasets already exist as R objects
      theData <- loadDataFile(path = path, datasetNames[f])
      I <- length(theData$descriptions$modalityID)
      J <- length(theData$descriptions$readerID)
      aucRsm <- array(dim = c(I, J));aucCbm <- array(dim = c(I, J));aucPro <- array(dim = c(I, J))
      muRsm <- array(dim = c(I, J));muCbm <- array(dim = c(I, J))
      nupRsm <- array(dim = c(I, J));alphaCbm <- array(dim = c(I, J))
      s <- 1
      for (i in 1:I){
        for (j in 1:J){
          aucRsm[i, j] <- allResults[[s]]$retRsm$AUC
          aucPro[i, j] <- allResults[[s]]$aucProp
          aucCbm[i, j] <- allResults[[s]]$retCbm$AUC
          muRsm[i, j] <- allResults[[s]]$retRsm$mu
          nupRsm[i, j] <- allResults[[s]]$retRsm$nuP
          muCbm[i, j] <- allResults[[s]]$retCbm$mu
          alphaCbm[i, j] <- allResults[[s]]$retCbm$alpha
          s <- s + 1
        }
      }
      df <- data.frame(aucPro = as.vector(aucPro), aucRsm = as.vector(aucRsm))
      ij <- paste0(datasetNames[f], ", nPts = ", I * J)
      p1[[f]] <- ggplot(data = df, aes(x = aucRsm, y = aucPro)) +
        geom_smooth(method = "lm", se = FALSE, color = "black", formula = y ~ 0 + x) +
        geom_point() + 
        labs(title = ij) 
      x <- lm(aucPro ~ 0 + aucRsm, df)
      m_pro_rsm[f,] <- list(x$coefficients, (summary(x)$r.squared))

      df <- data.frame(aucCbm = as.vector(aucCbm), aucRsm = as.vector(aucRsm))
      ij <- paste0(datasetNames[f], ", nPts = ", I * J)
      p2[[f]] <- ggplot(data = df, aes(x = aucRsm, y = aucCbm)) +
        geom_smooth(method = "lm", se = FALSE, color = "black", formula = y ~ 0 + x) +
        geom_point() + 
        labs(title = ij) 
      x <- lm(aucCbm ~ 0 + aucRsm, df)
      m_cbm_rsm[f,] <- list(x$coefficients, (summary(x)$r.squared))
      next
    }else{
      stop("Results file does not exist. Must analyze all datasets before running this.")
    }
  }
  
  return(list(
    p1 = p1,
    p2 = p2,
    m_pro_rsm = m_pro_rsm,
    m_cbm_rsm = m_cbm_rsm))
}
