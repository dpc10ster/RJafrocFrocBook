DeLongCov <- function ( zrk1, zrk2, zsk1, zsk2){
  K1 <- length( zrk1 )  
  K2 <- length( zrk2 )
  
  fomr  <- Wilcoxon(zrk1, zrk2) 
  foms  <- Wilcoxon(zsk1, zsk2) 
  
  Vr01 <- array(dim = c(K1))  
  Vs01 <- array(dim = c(K1))  
  
  Vr10 <- array(dim = c(K2))
  Vs10 <- array(dim = c(K2))
  
  for (k1 in 1 : K1){
    Vr01[ k1] <- (sum(zrk1[ k1 ] < zrk2) + 0.5 * sum(zrk1[ k1 ] == zrk2)) / K2
    Vs01[ k1] <- (sum(zsk1[ k1 ] < zsk2) + 0.5 * sum(zsk1[ k1 ] == zsk2)) / K2  
  }
  
  for (k2 in 1 : K2){
    Vr10[ k2] <- (sum(zrk1 < zrk2[ k2 ]) + 0.5 * sum(zrk1 == zrk2[ k2 ])) / K1
    Vs10[ k2] <- (sum(zsk1 < zsk2[ k2 ]) + 0.5 * sum(zsk1 == zsk2[ k2 ])) / K1
    
  }
  
  srs10 <- sum((Vr10 - fomr) * (Vs10 - foms)) / (K2 - 1)   
  srs01 <- sum((Vr01 - fomr) * (Vs01 - foms)) / (K1 - 1)
  
  CovRs <- srs01 / K1 + srs10 / K2
  
  return (CovRs)
}


CovDL <- function (zijk1, zijk2) 
{ 
  I <- dim(zijk1)[1]
  J <- dim(zijk1)[2]
  K1 <- dim(zijk1)[3];K2 <- dim(zijk2)[3]
  Cov <- array(dim = c(I, I, J, J))
  
  for (i in 1:I){
    for (ip in 1:I){
      for ( j in 1:J) {   
        for ( jp in 1:J) {           
          Cov[i, ip, j, jp] <- DeLongCov(zijk1[i,j,], zijk2[i,j,],zijk1[ip,jp,], zijk2[ip,jp,])          
        }
      }
    }
  }  
#  Cov <- Cov*(K-1)^2/K  # sic!!
  
  Var <- 0
  count <- 0
  for (i in 1:I){    
    for (j in 1:J) {      
      Var <- Var + Cov[i, i, j, j] 
      count <- count + 1
    }
  }
  Var <- Var / count 

  Cov1 <- 0
  count <- 0
  for (i in 1:I){    
    for (ip in 1:I){
      for (j in 1:J) {      
        if (ip != i){
          Cov1 <- Cov1 + Cov[i, ip, j, j] 
          count <- count + 1
        }
      }
    }
  }  
  Cov1 <- Cov1 / count 
  
  Cov2 <- 0
  count <- 0
  for (i in 1:I){    
    for (j in 1:J) {      
      for (jp in 1:J){
        if (j != jp){
          Cov2 <- Cov2 + Cov[i, i, j, jp] 
          count <- count + 1
        }
      }
    }
  }  
  Cov2 <- Cov2 / count 
    
  Cov3 <- 0
  count <- 0
  for (i in 1:I){
    for (ip in 1:I){
      if (i != ip){
        for (j in 1:J) {
          for (jp in 1:J){
            if (j != jp) {
              Cov3 <- Cov3 + Cov[i, ip, j, jp] 
              count <- count + 1
            }
          }
        }
      }
    }
  }  
  Cov3 <- Cov3 / count
  
  return (list (    
    Var = Var,
    Cov1 = Cov1,
    Cov2 = Cov2,
    Cov3 = Cov3    
  ))  
}

