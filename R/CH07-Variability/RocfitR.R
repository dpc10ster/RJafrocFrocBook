RocfitR  <- function(K)
{

a_min <<- 0.001 # clamps on range of allowed values
a_max <<- 6
b_min <<- 0.001 
b_max <<- 6

K <- FixRocCountsTable(K)
if (K[1] == -1) return(-1)

K1 <- K[1,] # this is the observed data!
K2 <- K[2,] # this is the observed data!

# initial estimates of a and b parameters
ret <- RocOperatingPoints(K1, K2)
FPF <- ret$FPF; TPF <- ret$TPF

ph_inv_FPF <- qnorm(FPF); ph_inv_TPF <- qnorm(TPF)
fit <- lm(ph_inv_TPF~ph_inv_FPF) # straight line fit method of estimating a and b

a <- fit$coefficients[[1]] # these is the initial estimate of a 
b <- fit$coefficients[[2]] # these is the initial estimate of b

# thresholds can be estimated by by applying inverse function to Eqn. xx and solving to zeta
zeta_initial_fpf <- -ph_inv_FPF # see Eqn. xx
zeta_initial_tpf <- (a - ph_inv_TPF)/b # see Eqn. xx
zeta_initial <- (zeta_initial_fpf + zeta_initial_tpf)/2 # average the two estimates
zeta_initial <- rev(zeta_initial) # apply reverse order to correct the ordering of the cutoffs
zeta_initial_guess <- seq(-b, a + 1, length.out = length(K1)-1) # to test stability of alg. to guess choice

param_initial <- c(a, b, zeta_initial) 
#param_initial <- c(1, 1, zeta_initial_guess) # to test stability of alg. to other choices

param_initial_prime <- ThetaPrime(param_initial)# use this method to test variation of -LL with parameters
LLval_initial <- LL(param_initial_prime, K1, K2) # use this method to test variation of -LL with parameters

ret_nlm <- nlm(LL, param_initial_prime, K1 = K1, K2 = K2, stepmax = 1) # this does the actual minimization of -LL
parameters_final_nlm <- Theta(ret_nlm$estimate)

a <- parameters_final_nlm[1];b <- parameters_final_nlm[2]
zeta <- parameters_final_nlm[3:length(parameters_final_nlm)]
AUC <- pnorm(a/sqrt(1+b^2))

return (list( 
          AUC = AUC,
          a = a,
          b = b,
          zeta  = zeta))
}

