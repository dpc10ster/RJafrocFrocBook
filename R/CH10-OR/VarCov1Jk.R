VarCov1_Jk <- function (zik1, zik2) 
{ 
  I <- dim(zik1)[1]
  K1 <- dim(zik1)[2]
  K2 <- dim(zik2)[2]
  K <- K1+K2
  FOM <- array(dim=c(I))
  for (i in 1:I) {
    FOM[i] <- Wilcoxon(zik1[i,],zik2[i,])    
  }
  
  FOMik <- array(dim = c(I,  K))
  for (i in 1:I) {
    for (k in 1:K) {
      if (k <= K1) {
        FOMik[i,k] <- Wilcoxon(zik1[i,-k], zik2[i,])
      } else {
        FOMik[i,k] <- Wilcoxon(zik1[i,], zik2[i,-(k-K1)])
      } 
    }
  }
  
  Cov <- array(dim = c(I, I))
  
  for (i in 1:I){
    for (ip in 1:I){
      Cov[i, ip] <- cov(FOMik[i,], FOMik[ip,])          
    }
  }  
  
  Var <- 0
  count <- 0
  for (i in 1:I){    
    Var <- Var + Cov[i, i] 
    count <- count + 1
  }
  Var <- Var / count 
  Var <- Var * (K-1)^2/K
  
  Cov1 <- 0
  count <- 0
  for (i in 1:I){    
    for (ip in 1:I){
      if (ip != i){
        Cov1 <- Cov1 + Cov[i, ip] 
        count <- count + 1
      }
    }
  }  
  Cov1 <- Cov1 / count 
  Cov1 <- Cov1 * (K-1)^2/K
  return (list (    
    Var = Var,
    Cov1 = Cov1
  ))  
}
