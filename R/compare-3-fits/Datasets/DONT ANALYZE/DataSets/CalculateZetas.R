# categorized integer or floating point z-samples
# to 5 bins for compatibility with CorROCII
# considered using CLabRoc, but extra dimensions of Covariancd matrix
# could make positive definiteness problem worse
CalculateZetas <- function (Z1,Z2)
{
  
  K1 <- length(Z1)
  K2 <- length(Z2)
  
  #   Data <- array(dim=c(K1+K2,2))
  #   Data[1:K1,1] <- Z1;Data[1:K1,2] <- -1
  #   Data[(K1+1):(K1+K2),1] <- Z2;Data[(K1+1):(K1+K2),2] <- +1
  #   ret <-  sort(Data[,1],index.return=TRUE)
  #   Data1 <- Data[ret$ix,]
  #   
  #   fp1 <- Data1[which(Data1[,2]==-1),1]
  #   tp1 <- Data1[which(Data1[,2]==+1),1]  
  fp1 <- Z1
  tp1 <- Z2
  fp <- Z1
  tp <- Z2
  zetas <- array(dim=200)
  z1 <- array(dim=200)
  z2 <- array(dim=200)
  r <- 1
  while(1) {
    zetas[r] <- min( c( fp1, tp1 ) )
    fp1 <- fp[fp > zetas[r]]
    tp1 <- tp[tp > zetas[r]]
    z1[r] <- length( fp )-length( fp1 )
    z2[r] <- length( tp )-length( tp1 )
    r <- r+1
    fp <- fp1
    tp <- tp1
    if( sum(z1[!is.na(z1)]) == K1 && sum(z2[!is.na(z2)]) == K2) break
  }
  zetas <- zetas[!is.na(zetas)]
  return(zetas)
  
}
