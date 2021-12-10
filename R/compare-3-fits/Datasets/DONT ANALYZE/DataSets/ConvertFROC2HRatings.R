ConvertFROC2HRatings <- function (NL, LL ) {
  
  I <- length(NL[,1,1,1])
  J <- length(NL[1,,1,1])
  K1 <- length(NL[1,1,,1])
  K2 <- length(LL[1,1,,1])
  K1 <- K1 - K2
  
  truth <- c(rep(0,K1),rep(1,K2))
  Hratings <- array(dim = c(I, J, K1+K2))
  
  for (i in 1:I) {
    for (j in 1:J) {
      for (k in 1:K1) {
        Hratings[i,j,k] <- max(NL[i,j,k,],na.rm=TRUE) 
      }
    }
  }
  for (i in 1:I) {
    for (j in 1:J) {
      for (k in (K1+1):(K1+K2)) {
        Hratings[i,j,k] <- max(c(NL[i,j,k,],LL[i,j,k-K1,]),na.rm=TRUE) 
      }
    }
  }
  
  return (list (
    Hratings = Hratings,
    truth = truth
  ) )
  
}