OpPtStr <- function(x,y) {
  y <- paste0("(", sprintf("%.3f", x), ", ", sprintf("%.3f", y), ")")
  return(y)
}

simplePrint <- function(x) {
  sprintf("%.3f", x)
}


wAFROC <- function (
  zeta1, mu, lambdaP, nuP, 
  lesDistr, 
  relWeights) {
  # return negative of aucwAFROC 
  # (as optimize finds minimum of function)
  return(-UtilAnalyticalAucsRSM(mu, lambdaP = lambdaP, nuP = nuP, zeta1, lesDistr, relWeights)$aucwAFROC)
}


Youden <- function (zeta1, mu, lambdaP, nuP, lesDistr) {
  # add sensitivity and specificity 
  # and subtract 1, i.e., Youden's index
  x <- RSM_yROC(zeta1, mu, lambdaP, nuP, lesDistr) + 
    (1 - RSM_xROC(zeta1, lambdaP)) - 1
  # return negative of Youden-index 
  # (as optimize finds minimum of function)
  return(-x)
}


doOneSet <- function(muArr, lambdaPArr, nuPArr, lesDistr, relWeights) {
  wAfrocArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  rocArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  zetaOptArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  fpfOptArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  tpfOptArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  nlfOptArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  llfOptArr <- array(dim = c(2,length(muArr), length(lambdaPArr), length(nuPArr)))
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaPArr)) {
      for (i3 in 1:length(nuPArr)) {
        mu <- muArr[i1]
        lambdaP <- lambdaPArr[i2]
        nuP <- nuPArr[i3]
        for (y in 1:2) {
          if (y == 1) {
            x <- optimize(wAFROC, 
                          interval = c(-5,5), 
                          mu, 
                          lambdaP = lambdaP, 
                          nuP = nuP, 
                          lesDistr, 
                          relWeights)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- -x$objective # safe to use objective here
            rocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambdaP = lambdaP, 
              nuP = nuP, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RSM_xROC(
              z = x$minimum, 
              lambdaP = lambdaP)
            tpfOptArr[y,i1,i2,i3] <- RSM_yROC(
              z = x$minimum, 
              mu, 
              lambdaP = lambdaP,
              nuP = nuP,
              lesDistr = lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RSM_xFROC(
              z = x$minimum, 
              lambdaP = lambdaP)
            llfOptArr[y,i1,i2,i3] <- RSM_yFROC(
              z = x$minimum, 
              mu, 
              nuP = nuP)
          } else if (y == 2) {
            x <- optimize(Youden, 
                          interval = c(-5,5), 
                          mu, 
                          lambdaP = lambdaP, 
                          nuP = nuP, 
                          lesDistr)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambdaP = lambdaP, 
              nuP = nuP, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucwAFROC
            rocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambdaP = lambdaP, 
              nuP = nuP, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RSM_xROC(
              z = x$minimum, 
              lambdaP = lambdaP)
            tpfOptArr[y,i1,i2,i3] <- RSM_yROC(
              z = x$minimum, 
              mu, 
              lambdaP = lambdaP,
              nuP = nuP,
              lesDistr = lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RSM_xFROC(
              z = x$minimum, 
              lambdaP = lambdaP)
            llfOptArr[y,i1,i2,i3] <- RSM_yFROC(
              z = x$minimum, mu, nuP)
          } else stop("incorrect y")
        }
      }
    }
  }
  return(list(
    zetaOptArr = zetaOptArr,
    nlfOptArr = nlfOptArr,
    llfOptArr = llfOptArr,
    fpfOptArr = fpfOptArr,
    tpfOptArr = tpfOptArr,
    wAfrocArr = wAfrocArr, 
    rocArr = rocArr)
  )
}



plotFroc <- function(muArr, lambdaPArr, nuPArr) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaPArr)) {
      for (i3 in 1:length(nuPArr)) {
        mu <- muArr[i1]
        lambdaP <- lambdaPArr[i2]
        nuP <- nuPArr[i3]
        z <- seq(-5,mu+5,0.1)
        xFROC <- RSM_xFROC(z, lambdaP)
        yFROC <- RSM_yFROC(z, mu, nuP)
        df_froc <- data.frame(
          NLF = xFROC, 
          LLF = yFROC)
        plotArr[[i]] <- ggplot2::ggplot(
          df_froc, 
          aes(x = NLF, y = LLF)) + 
          geom_line() +
          scale_x_continuous(limits = c(0,lambdaP)) + 
          scale_y_continuous(limits = c(0,1)) #+
          #ggtitle(paste0("mu = ", mu, ", nu = ", nuP, ", lambda = ", lambdaP))
          # DpcBugFix 8/28/22
          # fix the following error in GitHub Actions 
          # Quitting from lines 340-341 (22-optim-op-point.Rmd) 
          # Error in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  : 
          #    polygon edge not found
        for (y in 1:2) {
          optPt <- data.frame(
            NLF = nlfOptArr[y,i1,i2,i3], 
            LLF = llfOptArr[y,i1,i2,i3])
          plotArr[[i]] <- plotArr[[i]] + 
            geom_point(data = optPt, color = y) 
        }
        i <- i + 1
      }
    }
  }
  return (plotArr)
}  



plotwAfroc <- function(muArr, lambdaPArr, nuPArr, lesDistr, relWeights) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaPArr)) {
      for (i3 in 1:length(nuPArr)) {
        mu <- muArr[i1]
        lambdaP <- lambdaPArr[i2]
        nuP <- nuPArr[i3]
        x <- UtilPhysical2IntrinsicRSM(mu, lambdaP = lambdaP, nuP = nuP)
        lambda <- x$lambda
        nu <- x$nu
        plotArr[[i]] <- PlotRsmOperatingCharacteristics(
          c(mu,mu),
          c(lambda,lambda),
          c(nu,nu),
          c(zetaOptArr[1,i1,i2,i3], zetaOptArr[2,i1,i2,i3]),
          lesDistr,
          relWeights,
          OpChType = "wAFROC",
          legendPosition = "null"
        )$wAFROCPlot +
          ggtitle(paste0("mu = ", mu, ", nu = ", nuP, ", lambda = ", lambdaP))
        i <- i + 1
      }
    }
  }
  return(plotArr)
}



plotRoc <- function(muArr, lambdaPArr, nuPArr, lesDistr, relWeights) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaPArr)) {
      for (i3 in 1:length(nuPArr)) {
        mu <- muArr[i1]
        lambdaP <- lambdaPArr[i2]
        nuP <- nuPArr[i3]
        x <- UtilPhysical2IntrinsicRSM(mu, lambdaP = lambdaP, nuP = nuP)
        lambda <- x$lambda
        nu <- x$nu
        plotArr[[i]] <- PlotRsmOperatingCharacteristics(
          c(mu,mu),
          c(lambda,lambda),
          c(nu,nu),
          c(zetaOptArr[1,i1,i2,i3], zetaOptArr[2,i1,i2,i3]),
          lesDistr,
          relWeights,
          OpChType = "ROC",
          legendPosition = "null"
        )$ROCPlot +
          ggtitle(paste0("mu = ", mu, ", nu = ", nuP, ", lambda = ", lambdaP))
        i <- i + 1
      }
    }
  }
  return(plotArr)
}



doOneTable <- function(parmArr, zetaOptArr, wAfrocArr, rocArr, nlfOptArr, llfOptArr, ind1,ind2,ind3, labelIndx) {
  if (labelIndx == 1) {
    x1 <- cbind(rep("wAFROC",4), mu = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden",4), mu = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\mu$", "$\\zeta_1$", "$\\text{wAFROC}$", "$\\text{ROC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else if (labelIndx == 2) {
    x1 <- cbind(rep("wAFROC",4), lambda = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden",4), lambda = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\lambda$", "$\\zeta_1$", "$\\text{wAFROC}$", "$\\text{ROC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else if (labelIndx == 3) {
    x1 <- cbind(rep("wAFROC",4), nu = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden",4), nu = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\nu$", "$\\zeta_1$", "$\\text{wAFROC}$", "$\\text{ROC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else stop("incorrect label index")
  return(x12)
}



  
  