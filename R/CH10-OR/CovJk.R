FomJkValues <- function(zijk1, zijk2) {
  
  K1 <- length(zijk1[1,1,]);K2 <- length(zijk2[1,1,]);I <-  length(zijk2[,1,1])
  K  <- K1 + K2; J <- length(zijk1[1,,1])
  
  FOM <- array(dim=c(I,J))
  for (i in 1:I) {
    for (j in 1:J) {    
      FOM[i,j] <- Wilcoxon(zijk1[i,j,],zijk2[i,j,])    
    }
  }
  
  FOM_ijk <- array(dim = c(I, J, K))
  for (i in 1:I) {
    for (j in 1:J) {        
      for (k in 1:K) {
        if (k <= K1) {
          FOM_ijk[i,j,k] <- Wilcoxon(zijk1[i,j,-k], zijk2[i,j,])
        } else {
          FOM_ijk[i,j,k] <- Wilcoxon(zijk1[i,j,], zijk2[i,j,-(k-K1)])
        } 
      }
    }
  }
  
  return (list (    
    FOM = FOM,
    FOM_ijk = FOM_ijk
  ))    
}


CovJk <- function (zijk1, zijk2) 
{ 
  ret <- FomJkValues(zijk1,zijk2)
  JackFoMMatrix <- ret$FOM_ijk
    
  I <- dim(JackFoMMatrix)[1]
  J <- dim(JackFoMMatrix)[2]
  K <- dim(JackFoMMatrix)[3]
  Cov <- array(dim = c(I, I, J, J))
  
  for (i in 1:I){
    for (ip in 1:I){
      for ( j in 1:J) {   
        for ( jp in 1:J) {           
          Cov[i, ip, j, jp] <- cov(JackFoMMatrix[i, j, ], JackFoMMatrix[ip, jp, ])          
        }
      }
    }
  }  
  Cov <- Cov*(K-1)^2/K
  
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

