# K1 and K2 are as in book chapter 5
RocOperatingPoints <- function( K1, K2 ) {
  
  nOpPts <- length(K1) - 1 # number of op points
  FPF <- array(0,dim = nOpPts)
  TPF <- array(0,dim = nOpPts)
   
  for (r in (nOpPts+1):2) {
    FPF[r-1] <- sum(K1[r:(nOpPts+1)])/sum(K1)
    TPF[r-1] <- sum(K2[r:(nOpPts+1)])/sum(K2)    
  }
  FPF <- rev(FPF)
  TPF <- rev(TPF)
  
  return( list(
    FPF = FPF,
    TPF = TPF
  ) )
   
}
