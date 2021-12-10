CovarianceFirstPrinciples  <- function (FomBs) 
{ 
  I <- dim(FomBs)[1]
  B <- dim(FomBs)[2]
  Covariance <- array(0, dim = c(I, I))
  
  for (b in 1:B) {
    for (i in 1:I) {
      for (ip in 1:I) {
        Covariance[i,ip] <- Covariance[i,ip] + (FomBs[i,b] - mean(FomBs[i,]))*(FomBs[ip,b] - mean(FomBs[ip,])) 
      }
    }    
  }
  Covariance <- Covariance/(B-1)
  
  return(Covariance)
  
}