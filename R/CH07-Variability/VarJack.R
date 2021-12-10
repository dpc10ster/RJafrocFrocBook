VarJack <- function (K, mu, sigma, zetas)
{
  Ktot <- sum(K)
  AUC <- array( dim = Ktot )
  
  z <- GenerateCaseSamples(K, mu, sigma, zetas)  
  z1 <- z$z1
  z2 <- z$z2
  
  z1_jk  <- array(dim = Ktot)
  for ( k in 1 : Ktot){
    if ( k <= K[ 1 ]){
      z1_jk <- z1[ -k ]
      z2_jk <- z2
    }else{
      z1_jk <- z1
      z2_jk <- z2[ -(k - K[ 1 ]) ] 
    }  
    AUC[ k ] <- Wilcoxon(z1_jk, z2_jk)
  }
  Var <- var(AUC) * ( Ktot - 1)^2 / Ktot #Efron and Stein's paper
  
  return (Var)
}