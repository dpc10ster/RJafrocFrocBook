VarCov1_Bs <- function (zik1, zik2, B, seed = NULL) 
{ 
  I <- dim(zik1)[1]
  K1 <- dim(zik1)[2]
  K2 <- dim(zik2)[2]
  aucBs <- array(dim = c(I,B))#to save the bs Auc values
  set.seed(seed)
  for (b in 1 : B){
    k1b <- ceiling( runif(K1) * K1 ) # bs indices for non-diseased    
    k2b <- ceiling( runif(K2) * K2 ) # bs indices for diseased  
    for ( i in 1 : I) aucBs[i,b] <- Wilcoxon(zik1[i,k1b], zik2[i,k2b]) 
  }
  Covariance <- array(dim = c(I, I))
  for (i in 1:I){
    for (ip in 1:I){
      Covariance[i, ip] <- cov(aucBs[i, ], aucBs[ip, ])          
    }
  }
  Var <- 0
  count <- 0
  for (i in 1:I){    
    Var <- Var + Covariance[i, i] 
    count <- count + 1
  }
  Var <- Var / count 
  Cov1 <- 0
  count <- 0
  for (i in 1:I){    
    for (ip in 1:I){
      if (ip != i){
        Cov1 <- Cov1 + Covariance[i, ip] 
        count <- count + 1
      }
    }
  }  
  Cov1 <- Cov1 / count 
  return (list (    
    Var = Var,
    Cov1 = Cov1
  ))  
}
