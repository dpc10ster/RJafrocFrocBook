ThetaPrime <- function (Theta)
{
  # the vector of Theta, starting with a, b, zeta2,..., zeta_R-1
  # R is the number of ratings bins; 5 in the example below
  R <- length(Theta) - 1 
  ThetaPrime <- Theta # allocates the output vector   
  ThetaPrime[ 1 ] <- log(-log((Theta[1]-a_min)/(a_max-a_min))) # a to a'
	ThetaPrime[ 2 ] <- log(-log((Theta[2]-b_min)/(b_max-b_min))) # b to b'
  ThetaPrime[ 3 ] <- Theta[3];		# zeta1 to zeta1' no change needed  
  for (r in 4:(R+1)) ThetaPrime[r] <- log(Theta[r] - Theta[r-1])
  return (ThetaPrime)
}
  


Theta <- function (ThetaPrime)
{
  # the vector of transformed ThetaPrime, starting with a', b', zeta2', zeta2',..., zeta_R-1'
  # R is the number of ratings bins; 5 in the example below
  R <- length(ThetaPrime) - 1  
  Theta <- ThetaPrime # allocates the output vector  
  Theta[ 1 ] <- a_min+(a_max-a_min)*exp(-exp(ThetaPrime[1]))# a' --> a
  Theta[ 2 ] <- b_min+(b_max-b_min)*exp(-exp(ThetaPrime[2]))# b' --> b
  Theta[ 3 ] <- ThetaPrime[ 3 ];	# # zeta1' to zeta1 no change needed
  for (r in 4:(R+1)) Theta[r] <- exp(ThetaPrime[r]) + Theta[r-1]
  return (Theta)
}

 