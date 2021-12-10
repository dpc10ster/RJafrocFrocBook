SingleTreatmentAnalysis <- function(singleData, theta0, covEstMthd = "JK", alpha = 0.05){
  fomArray <- UtilFigureOfMerit(singleData, FOM = "Wilcoxon")
  J <- length(fomArray)
  NL <- singleData$NL
  LL <- singleData$LL
  K <- dim(NL)[3]
  K2 <- dim(LL)[3]
  K1 <- K - K2
  msR <- 0
  thetaDot <- mean(fomArray)
  for (j in 1:J){
    msR <- msR + (fomArray[j] - thetaDot)^2
  }
  msR <- msR / (J - 1)
  zijk1 <- NL[ , , 1:K1, ]
  dim(zijk1) <- c(1, J, K1)
  zijk2 <- LL
  dim(zijk2) <- c(1, J, K2)
  if (covEstMthd == "JK"){
    cov2 <- CovJk(zijk1, zijk2)$Cov2  
  }else if (covEstMthd == "DL"){
    cov2 <- CovDL(zijk1, zijk2)$Cov2
  }
  
  msSingle <- msR + max(J * cov2, 0)
  dfSingle <- msSingle^2 / (msR^2/(J - 1))
  sigmaSingle <- sqrt(msSingle / J)
  tStat <- (thetaDot - theta0)/sigmaSingle
  pVal <- 2 * pt(abs(tStat), dfSingle, lower.tail = FALSE)
  halfCIWidth <- qt(alpha/2, dfSingle, lower.tail = FALSE) * sigmaSingle
  ci <- c(thetaDot - halfCIWidth, thetaDot + halfCIWidth)
  ciDiff <- ci - theta0
  return(list(
    ci = ci, 
    tStat = tStat,
    pVal = pVal,
    ciDiff = ciDiff
  ))
}