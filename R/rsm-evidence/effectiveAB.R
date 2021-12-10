effectiveAB <- function(mu, lambda, nu, lesDistr){
  ret <- UtilIntrinsic2PhysicalRSM(mu,lambda, nu)
  lambdaP <- ret$lambdaP
  nuP <- ret$nuP
  
  FPFmax <- RSM_xROC(-Inf, lambdaP)
  meanN <- integrate(meanNInt, -Inf, Inf, lambdaP = lambdaP, FPFmax = FPFmax)$value
  varN <- integrate(varNInt, -Inf, Inf, lambdaP = lambdaP, FPFmax = FPFmax)$value - meanN^2 # https://en.wikipedia.org/wiki/Variance
  stdErrN <- sqrt(varN)
  
  lesDistr <- 1
  TPFmax <- RSM_yROC(-Inf, mu, lambdaP, nuP, 1) # DPC TBA
  meanD <- integrate(meanDInt, -Inf, Inf, mu = mu, lambdaP = lambdaP, nuP = nuP, lesDistr = lesDistr, TPFmax = TPFmax)$value
  varD <- integrate(varDInt, -Inf, Inf, mu = mu, lambdaP = lambdaP, nuP = nuP, lesDistr = lesDistr, TPFmax = TPFmax, meanD = meanD)$value# - meanD^2 # https://en.wikipedia.org/wiki/Variance
  stdErrD <- sqrt(varD)
  
  return(list(
    a = (meanD - meanN) / stdErrD,
    b = stdErrN / stdErrD
  ))
}



# not used, just here for check on normalization
meanpdfN <- function(z, lambdaP, FPFmax){
  # divide by FPFmax to normalize integral to unity
  # confirmed that this integrates to unity, 12/22/20
  return(RSM_pdfN(z, lambdaP)/FPFmax)
}



meanNInt <- function(z, lambdaP, FPFmax){
  # divide by FPFmax to normalize integral to unity
  # multiply by z as we want average of z using
  # the prescribed normalized pdf
  return(RSM_pdfN(z, lambdaP) / FPFmax * z)
}



varNInt <- function(z, lambdaP, FPFmax){
  # divide by FPFmax to normalize integral to unity
  # multiply by z^2 as we want average of z^2 using
  # the prescribed normalized pdf
  return(RSM_pdfN(z, lambdaP) / FPFmax * z^2)
}



meanDInt <- function(z, mu, lambdaP, nuP, lesDistr, TPFmax){
  # divide by TPFmax to normalize integral to unity
  # multiply by z as we want average of z using
  # the prescribed normalized pdf
  return(RSM_pdfD(z, mu, lambdaP, nuP, 1) / TPFmax * z)
}


# subtracting out meanD to improve numerical property
# warning on Wikepedia about catastrophic cancellation otherwise
varDInt <- function(z, mu, lambdaP, nuP, lesDistr, TPFmax, meanD){
  # divide by TPFmax to normalize integral to unity
  # multiply by z^2 as we want average of z^2 using
  # the prescribed normalized pdf
  return(RSM_pdfD(z, mu, lambdaP, nuP, 1) / TPFmax * (z - meanD)^2)
}

