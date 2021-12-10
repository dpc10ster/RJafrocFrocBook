VarCov1_FomInput <- function (Foms) 
{ 
  I <- dim(Foms)[1]

  Covariance <- array(dim = c(I, I))
  for (i in 1:I){
    for (ip in 1:I){
      Covariance[i, ip] <- cov(Foms[i, ], Foms[ip, ])          
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



VarCov2_FomInput <- function (Foms) 
{ 
  J <- dim(Foms)[1]
  
  Covariance <- array(dim = c(J, J))
  for (j in 1:J){
    for (jp in 1:J){
      Covariance[j, jp] <- cov(Foms[j, ], Foms[jp, ])          
    }
  }
  
  Var <- 0
  count <- 0
  for (j in 1:J){    
    Var <- Var + Covariance[j, j] 
    count <- count + 1
  }
  Var <- Var / count 
  
  Cov2 <- 0
  count <- 0
  for (j in 1:J){    
    for (jp in 1:J){
      if (jp != j){
        Cov2 <- Cov2 + Covariance[j, jp] 
        count <- count + 1
      }
    }
  }  
  Cov2 <- Cov2 / count 
  
  return (list (    
    Var = Var,
    Cov2 = Cov2
  ))  
}
