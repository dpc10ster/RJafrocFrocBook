OpPtStr <- function(x,y) {
  y <- paste0("(", sprintf("%.3f", x), ", ", sprintf("%.3f", y), ")")
  return(y)
}

simplePrint <- function(x) {
  sprintf("%.3f", x)
}


wAFROC <- function (
  zeta1, mu, lambda, nu, 
  lesDistr, 
  relWeights) {
  # return negative of aucwAFROC 
  # (as optimize finds minimum of function)
  return(-UtilAnalyticalAucsRSM(mu, lambda = lambda, nu = nu, zeta1, lesDistr, relWeights)$aucwAFROC)
}


Youden <- function (zeta1, mu, lambda, nu, lesDistr) {
  # add sensitivity and specificity 
  # and subtract 1, i.e., Youden's index
  x <- RSM_yROC(zeta1, mu, lambda, nu, lesDistr) + 
    (1 - RSM_xROC(zeta1, lambda)) - 1
  # return negative of Youden-index 
  # (as optimize finds minimum of function)
  return(-x)
}


doOneSet <- function(muArr, lambdaArr, nuArr, lesDistr, relWeights) {
  wAfrocArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  rocArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  zetaOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  fpfOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  tpfOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  nlfOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  llfOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaArr)) {
      for (i3 in 1:length(nuArr)) {
        mu <- muArr[i1]
        lambda <- lambdaArr[i2]
        nu <- nuArr[i3]
        for (y in 1:2) {
          if (y == 1) {
            x <- optimize(wAFROC, 
                          interval = c(-5,5), 
                          mu, 
                          lambda = lambda, 
                          nu = nu, 
                          lesDistr, 
                          relWeights)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- -x$objective # safe to use objective here
            rocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambda = lambda, 
              nu = nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RSM_xROC(
              z = x$minimum, 
              lambda = lambda)
            tpfOptArr[y,i1,i2,i3] <- RSM_yROC(
              z = x$minimum, 
              mu, 
              lambda = lambda,
              nu = nu,
              lesDistr = lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RSM_xFROC(
              z = x$minimum, 
              lambda = lambda)
            llfOptArr[y,i1,i2,i3] <- RSM_yFROC(
              z = x$minimum, 
              mu, 
              nu = nu)
          } else if (y == 2) {
            x <- optimize(Youden, 
                          interval = c(-5,5), 
                          mu, 
                          lambda = lambda, 
                          nu = nu, 
                          lesDistr)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambda = lambda, 
              nu = nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucwAFROC
            rocArr[y,i1,i2,i3] <- UtilAnalyticalAucsRSM(
              mu, 
              lambda = lambda, 
              nu = nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RSM_xROC(
              z = x$minimum, 
              lambda = lambda)
            tpfOptArr[y,i1,i2,i3] <- RSM_yROC(
              z = x$minimum, 
              mu, 
              lambda = lambda,
              nu = nu,
              lesDistr = lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RSM_xFROC(
              z = x$minimum, 
              lambda = lambda)
            llfOptArr[y,i1,i2,i3] <- RSM_yFROC(
              z = x$minimum, mu, nu)
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



plotFroc <- function(muArr, lambdaArr, nuArr) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaArr)) {
      for (i3 in 1:length(nuArr)) {
        mu <- muArr[i1]
        lambda <- lambdaArr[i2]
        nu <- nuArr[i3]
        z <- seq(-5,mu+5,0.1)
        xFROC <- RSM_xFROC(z, lambda)
        yFROC <- RSM_yFROC(z, mu, nu)
        df_froc <- data.frame(
          NLF = xFROC, 
          LLF = yFROC)
        plotArr[[i]] <- ggplot2::ggplot(
          df_froc, 
          aes(x = NLF, y = LLF)) + 
          geom_line() +
          scale_x_continuous(limits = c(0,lambda)) + 
          scale_y_continuous(limits = c(0,1))
          #ggtitle(paste0("mu = ", mu, ", nu = ", nu, ", lambda = ", lambda))
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
            geom_point(data = optPt, color = 3-y) 
        }
        i <- i + 1
      }
    }
  }
  return (plotArr)
}  



plotwAfroc <- function(muArr, lambdaArr, nuArr, lesDistr, relWeights) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaArr)) {
      for (i3 in 1:length(nuArr)) {
        mu <- muArr[i1]
        lambda <- lambdaArr[i2]
        nu <- nuArr[i3]
        plotArr[[i]] <- PlotRsmOperatingCharacteristics(
          c(mu,mu),
          c(lambda,lambda),
          c(nu,nu),
          c(zetaOptArr[1,i1,i2,i3], zetaOptArr[2,i1,i2,i3]),
          lesDistr,
          relWeights,
          OpChType = "wAFROC",
          legendPosition = "null"
        )$wAFROCPlot
        #ggtitle(paste0("mu = ", mu, ", nu = ", nu, ", lambda = ", lambda))
        # DpcBugFix 9/24/22
        # fix the following error in GitHub Actions 
        # Quitting from lines 378-379 (22-optim-op-point.Rmd) 
        # Error in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  : 
        #     polygon edge not found
        i <- i + 1
      }
    }
  }
  return(plotArr)
}



plotRoc <- function(muArr, lambdaArr, nuArr, lesDistr, relWeights) {
  plotArr <- array(list(), dim = 8)
  i <- 1
  for (i1 in 1:length(muArr)) {
    for (i2 in 1:length(lambdaArr)) {
      for (i3 in 1:length(nuArr)) {
        mu <- muArr[i1]
        lambda <- lambdaArr[i2]
        nu <- nuArr[i3]
        plotArr[[i]] <- PlotRsmOperatingCharacteristics(
          c(mu,mu),
          c(lambda,lambda),
          c(nu,nu),
          c(zetaOptArr[1,i1,i2,i3], zetaOptArr[2,i1,i2,i3]),
          lesDistr,
          relWeights,
          OpChType = "ROC",
          legendPosition = "null"
        )$ROCPlot
          #ggtitle(paste0("mu = ", mu, ", nu = ", nu, ", lambda = ", lambda))
          # DpcBugFix 9/24/22
          # fix the following error in GitHub Actions 
          # Quitting from lines 378-379 (22-optim-op-point.Rmd) 
          # Error in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  : 
          #     polygon edge not found
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



  
  