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
  return(-RJafroc::UtilAnalyticalAucsRSM(mu, lambda, nu, zeta1, lesDistr, relWeights)$aucwAFROC)
}


Youden <- function (zeta1, mu, lambda, nu, lesDistr) {
  # add sensitivity and specificity 
  # and subtract 1, i.e., Youden's index
  x <- RJafroc::RSM_TPF(zeta1, mu, lambda, nu, lesDistr) + 
    (1 - RJafroc::RSM_FPF(zeta1, lambda)) - 1
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
  wllfOptArr <- array(dim = c(2,length(muArr), length(lambdaArr), length(nuArr)))
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
                          lambda, 
                          nu, 
                          lesDistr, 
                          relWeights)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- -x$objective # safe to use objective here
            rocArr[y,i1,i2,i3] <- RJafroc::UtilAnalyticalAucsRSM(
              mu, 
              lambda, 
              nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RJafroc::RSM_FPF(
              z = x$minimum, 
              lambda)
            tpfOptArr[y,i1,i2,i3] <- RJafroc::RSM_TPF(
              z = x$minimum, 
              mu, 
              lambda,
              nu,
              lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RJafroc::RSM_NLF(
              z = x$minimum, 
              lambda)
            llfOptArr[y,i1,i2,i3] <- RJafroc::RSM_LLF(
              z = x$minimum, 
              mu, 
              nu)
            wllfOptArr[y,i1,i2,i3] <- RJafroc::RSM_wLLF(
              z = x$minimum, 
              mu, 
              nu,
              lesDistr,
              relWeights = relWeights)
          } else if (y == 2) {
            x <- optimize(Youden, 
                          interval = c(-5,5), 
                          mu, 
                          lambda, 
                          nu, 
                          lesDistr)
            zetaOptArr[y,i1,i2,i3] <- x$minimum
            wAfrocArr[y,i1,i2,i3] <- RJafroc::UtilAnalyticalAucsRSM(
              mu, 
              lambda, 
              nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucwAFROC
            rocArr[y,i1,i2,i3] <- RJafroc::UtilAnalyticalAucsRSM(
              mu, 
              lambda, 
              nu, 
              zeta1 = x$minimum, 
              lesDistr, 
              relWeights)$aucROC
            fpfOptArr[y,i1,i2,i3] <- RJafroc::RSM_FPF(
              z = x$minimum, 
              lambda)
            tpfOptArr[y,i1,i2,i3] <- RJafroc::RSM_TPF(
              z = x$minimum, 
              mu, 
              lambda,
              nu,
              lesDistr)
            nlfOptArr[y,i1,i2,i3] <- RJafroc::RSM_NLF(
              z = x$minimum, 
              lambda)
            llfOptArr[y,i1,i2,i3] <- RJafroc::RSM_LLF(
              z = x$minimum, 
              mu, 
              nu)
            wllfOptArr[y,i1,i2,i3] <- RJafroc::RSM_wLLF(
              z = x$minimum, 
              mu, 
              nu,
              lesDistr,
              relWeights = relWeights)
          } else stop("incorrect y")
        }
      }
    }
  }
  return(list(
    zetaOptArr = zetaOptArr,
    nlfOptArr = nlfOptArr,
    llfOptArr = llfOptArr,
    wllfOptArr = wllfOptArr,
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
        xFROC <- RJafroc::RSM_NLF(z, lambda)
        yFROC <- RJafroc::RSM_LLF(z, mu, nu)
        df_froc <- data.frame(
          NLF = xFROC, 
          LLF = yFROC)
        plotArr[[i]] <- ggplot2::ggplot(
          df_froc, 
          ggplot2::aes(x = NLF, y = LLF)) + 
          ggplot2::geom_line() +
          ggplot2::scale_x_continuous(limits = c(0,lambda)) + 
          ggplot2::scale_y_continuous(limits = c(0,1))
          #ggtitle(paste0("mu = ", mu, ", nu = ", nu, ", lambda = ", lambda))
        for (y in 1:2) {
          optPt <- data.frame(
            NLF = nlfOptArr[y,i1,i2,i3], 
            LLF = llfOptArr[y,i1,i2,i3])
          plotArr[[i]] <- plotArr[[i]] + 
            ggplot2::geom_point(data = optPt, color = 3-y) 
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
        plotArr[[i]] <- RJafroc::PlotRsmOperatingCharacteristics(
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
        #     polygon edge not found
        for (y in 1:2) {
          optPt <- data.frame(
            FPF = fpfOptArr[y,i1,i2,i3], 
            wLLF = wllfOptArr[y,i1,i2,i3])
          plotArr[[i]] <- plotArr[[i]] + 
            ggplot2::geom_point(data = optPt, ggplot2::aes(x = FPF, y = wLLF), color = 3-y) 
        }
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
        plotArr[[i]] <- RJafroc::PlotRsmOperatingCharacteristics(
          c(mu,mu),
          c(lambda,lambda),
          c(nu,nu),
          c(zetaOptArr[1,i1,i2,i3], zetaOptArr[2,i1,i2,i3]),
          lesDistr,
          relWeights,
          OpChType = "ROC",
          legendPosition = "null"
        )$ROCPlot
        for (y in 1:2) {
          optPt <- data.frame(
            FPF = fpfOptArr[y,i1,i2,i3], 
            TPF = tpfOptArr[y,i1,i2,i3])
          plotArr[[i]] <- plotArr[[i]] + 
            ggplot2::geom_point(data = optPt, ggplot2::aes(x = FPF, y = TPF), color = 3-y) 
        }
        #ggtitle(paste0("mu = ", mu, ", nu = ", nu, ", lambda = ", lambda))
        #     polygon edge not found
        i <- i + 1
      }
    }
  }
  return(plotArr)
}



doOneTable <- function(parmArr, zetaOptArr, wAfrocArr, rocArr, nlfOptArr, llfOptArr, ind1,ind2,ind3, labelIndx) {
  if (labelIndx == 1) {
    x1 <- cbind(rep("$\\text{wAFROC}_\\text{AUC}$",4), mu = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden-index",4), mu = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\mu$", "$\\zeta_1$", "$\\text{wAFROC}_\\text{AUC}$", "$\\text{ROC}_\\text{AUC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else if (labelIndx == 2) {
    x1 <- cbind(rep("$\\text{wAFROC}_\\text{AUC}$",4), lambda = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden-index",4), lambda = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\lambda$", "$\\zeta_1$", "$\\text{wAFROC}_\\text{AUC}$", "$\\text{ROC}_\\text{AUC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else if (labelIndx == 3) {
    x1 <- cbind(rep("$\\text{wAFROC}_\\text{AUC}$",4), nu = parmArr, zeta1 = simplePrint(zetaOptArr[1,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[1,ind1,ind2,ind3]), ROC = simplePrint(rocArr[1,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[1,ind1,ind2,ind3], llfOptArr[1,ind1,ind2,ind3]))
    x2 <- cbind(rep("Youden-index",4), nu = parmArr, zeta1 = simplePrint(zetaOptArr[2,ind1,ind2,ind3]), wAFROC = simplePrint(wAfrocArr[2,ind1,ind2,ind3]), ROC = simplePrint(rocArr[2,ind1,ind2,ind3]), OptOpPt = OpPtStr(nlfOptArr[2,ind1,ind2,ind3], llfOptArr[2,ind1,ind2,ind3]))
    x12 <- as.data.frame(rbind(x1,x2))
    colnames(x12) <- c("FOM", "$\\nu$", "$\\zeta_1$", "$\\text{wAFROC}_\\text{AUC}$", "$\\text{ROC}_\\text{AUC}$", "$\\left( \\text{NLF}, \\text{LLF}\\right)$")
  } else stop("incorrect label index")
  return(x12)
}



  
  