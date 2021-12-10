GenerateCaseSamples <- function( K, mu, sigma, zetas, bin=TRUE) 
{  
  case_kt <- array( dim = c( 2, max(K)))
  case_kt[ 1, 1:K[1]] <- rnorm(K[1])
  case_kt[ 2, 1:K[2]] <- rnorm(K[2], mean = mu, sd = sigma)
  if (bin) {
    fb <- cut(case_kt[ 1, 1:K[1]], c(-Inf, zetas, Inf), labels = FALSE, right = FALSE)
    tb <- cut(case_kt[ 2, 1:K[2]], c(-Inf, zetas, Inf), labels = FALSE, right = FALSE)
    case_kt[ 1, 1:K[1]] <- fb
    case_kt[ 2, 1:K[2]] <- tb
  }
  z1 <- case_kt[1,!is.na(case_kt[1, ])]
  z2 <- case_kt[2,!is.na(case_kt[2, ])] 
  
  return( list(
    z1 = z1, 
    z2 = z2)
  )
  
}
