VarPopSampling <- function ( K, mu, sigma, zetas, P)
{
  AUC <- array(dim = P) 
  for (p in 1:P)
  {
    z <- GenerateCaseSamples(K, mu, sigma, zetas)
    z1 <- z$z1
    z2 <- z$z2
    AUC[p] <- Wilcoxon(z1, z2)
  }
  
  return (var(AUC))
}
