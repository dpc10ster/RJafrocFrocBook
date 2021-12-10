PlotBMErrBar <- function(a, b, rocDataTable){
  K1 <- sum(rocDataTable[1, ]); K2 <- sum(rocDataTable[2, ])
  FPF <- cumsum(rev(rocDataTable[1, ]))/K1; FPF <- FPF[-length(FPF)]
  TPF <- cumsum(rev(rocDataTable[2, ]))/K2; TPF <- TPF[-length(TPF)]
  
  plotZeta <- seq(-20, qnorm(1-1e-15, mean = a/b, sd = 1/b), by = 0.01)
  FPFBM <- 1 - pnorm(plotZeta)
  TPFBM <- 1 - pnorm(plotZeta, mean = a/b, sd = 1/b)
  plotBM <- data.frame(FPF = FPFBM, TPF = TPFBM)
  plotOpPnts <- data.frame(FPF = FPF, TPF = TPF)
  
  fitPlot <- ggplot() + geom_line(mapping = aes(x = FPF, y = TPF), data = plotBM, size = 1) + 
    geom_point(mapping = aes(x = FPF, y = TPF), data = plotOpPnts, size = 3) + 
    # labs(title = rowIndx) + theme(plot.title = element_text(hjust = 0.5)) +
    scale_x_continuous(expand = c(0, 0)) + 
    scale_y_continuous(expand = c(0, 0))
  
  ciX <- binom.confint(x = FPF * K1, n = K1, method = "exact")
  ciY <- binom.confint(x = TPF * K2, n = K2, method = "exact")
  ciXUpper <- ciX$upper
  ciXLower <- ciX$lower
  ciYUpper <- ciY$upper
  ciYLower <- ciY$lower
  
  for (i in c(1, length(FPF))){
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