# ROC paradigm negative of log likelihood function
LL <- function (ThetaPrime, K1, K2){
  R <- length(K1) # number of ratings bins
  lp <- length(ThetaPrime)# this should be R + 1
  Theta <- Theta(ThetaPrime)
  a <- Theta[1]
  b <- Theta[2]
  zeta <- c(-Inf, Theta[3:lp], +Inf)
  ll = 0
  for (r in 1:R){
    ll <- ll + K1[r]*log(pnorm(zeta[r+1])-pnorm(zeta[r])) +
      K2[r]*log(pnorm(b*zeta[r+1]-a)-pnorm(b*zeta[r]-a))
  } 
  
  return (-ll) # returning negative as we wish to maximize ll
}

# ROC paradigm negative of log likelihood function
LL_theta <- function (Theta, K1, K2){
  R <- length(K1) # number of ratings bins
  lp <- length(Theta)# this should be R + 1
  a <- Theta[1]
  b <- Theta[2]
  zeta <- c(-Inf, Theta[3:lp], +Inf)
  ll = 0
  for (r in 1:R){
    ll <- ll + K1[r]*log(pnorm(zeta[r+1])-pnorm(zeta[r])) +
      K2[r]*log(pnorm(b*zeta[r+1]-a)-pnorm(b*zeta[r]-a))
  } 
  
  return (-ll) # returning negative as we wish to maximize ll
}



