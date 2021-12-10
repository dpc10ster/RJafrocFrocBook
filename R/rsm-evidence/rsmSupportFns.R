intROC <- function(FPF, mu, lambdaP, nuP, lesDistr){
  # returns TPF, the ordinate of ROC curve; takes FPF as the variable.
  # AUC is calculated by integrating this function wrt FPF
  tmp <- 1 / lambdaP * log(1 - FPF) + 1
  tmp[tmp < 0] <- pnorm(-20)
  zeta <- qnorm(tmp)
  TPF <- RSM_yROC(zeta, mu, lambdaP, nuP, lesDistr) 
  return (TPF)
}

yFROC <- function(zeta, mu, nuP){
  # returns LLF, the ordinate of FROC, AFROC curve
  LLF <- nuP * (1 - pnorm(zeta - mu))
  return(LLF)
}

# intAFROC <- function(FPF, mu, lambdaP, nuP){
#   # returns LLF, the ordinate of AFROC curve; takes FPF as the variable. 
#   # AUC is calculated by integrating this function wrt FPF
#   tmp <- 1 / lambdaP * log(1 - FPF) + 1
#   tmp[tmp < 0] <- pnorm(-20)
#   zeta <- qnorm(tmp)
#   LLF <- yFROC(zeta, mu, nuP)
#   return(LLF)
# }