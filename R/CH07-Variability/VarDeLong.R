VarDeLong <- function ( K, mu, sigma, zetas){

  z <- GenerateCaseSamples(K, mu, sigma, zetas)  
  zk1 <- z$z1
  zk2 <- z$z2
  K1 <- length( zk1 )  
  K2 <- length( zk2 )
  
  fom  <- Wilcoxon(zk1, zk2) 
  
  V10 <- array(dim = c(K2))
  V01 <- array(dim = c(K1))
  for (k in 1 : K2){
    V10[ k] <- (sum(zk1 < zk2[ k ]) + 0.5 * sum(zk1 == zk2[ k ])) / K1
  }
  for (k in 1 : K1){
    V01[ k] <- (sum(zk1[ k ] < zk2) + 0.5 * sum(zk1[ k ] == zk2)) / K2
  }
  s10 <- sum((V10 - fom) * (V10 - fom)) / (K2 - 1)
  s01 <- sum((V01 - fom) * (V01 - fom)) / (K1 - 1)
  var <- s10 / K2 + s01 / K1
  
  return (var)
}
