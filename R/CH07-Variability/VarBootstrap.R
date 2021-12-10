VarBootstrap <- function (K, mu, sigma, zetas, B)
{
  AUC <- array(dim = B) 
  z <- GenerateCaseSamples(K, mu, sigma, zetas)    
  z1 <- z$z1
  z2 <- z$z2    
  
  for ( i in 1 : B){
    k_b1 <- ceiling( runif( K[ 1 ] ) * K[ 1 ] )     
    k_b2 <- ceiling( runif( K[ 2 ] ) * K[ 2 ] )
    AUC[ i ] <- Wilcoxon(z1[ k_b1 ], z2[ k_b2 ])
  }
  Var <- var(AUC)
  
  return (Var)
}