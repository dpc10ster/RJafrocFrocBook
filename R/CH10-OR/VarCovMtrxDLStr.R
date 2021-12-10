VarCovMtrxDLStr <- function(dataset){ # this is implementation of un-numbered equations following Eqn. 4 in 1988 paper
  NL <- dataset$ratings$NL
  LL <- dataset$ratings$LL
  perCase <- dataset$lesions$perCase
  IDs <- dataset$IDs
  weights <- dataset$lesions$weights
  maxNL <- dim(NL)[4]
  maxLL <- dim(LL)[4]
  dataType <- dataset$descriptions$type
  modalityID <- dataset$descriptions$modalityID
  readerID <- dataset$descriptions$readerID
  I <- length(modalityID)
  J <- length(readerID)
  K <- dim(NL)[3]
  K2 <- dim(LL)[3]
  K1 <- K - K2
  
  dim(NL) <- c(I, J, K, maxNL)
  dim(LL) <- c(I, J, K2, max(perCase))
  
  fomArray <- UtilFigureOfMerit(dataset, FOM = "Wilcoxon")
  
  V10 <- array(dim = c(I, J, K2))
  V01 <- array(dim = c(I, J, K1))
  for (i in 1:I) {
    for (j in 1:J) {
      nl <- NL[i, j, 1:K1, ]
      ll <- cbind(NL[i, j, (K1 + 1):K, ], LL[i, j, , ])
      dim(nl) <- c(K1, maxNL)
      dim(ll) <- c(K2, maxNL + max(perCase))
      fp <- apply(nl, 1, max)
      tp <- apply(ll, 1, max)
      for (k in 1:K2) {
        V10[i, j, k] <- (sum(fp < tp[k]) + 0.5 * sum(fp == tp[k]))/K1
      }
      for (k in 1:K1) {
        V01[i, j, k] <- (sum(fp[k] < tp) + 0.5 * sum(fp[k] == tp))/K2
      }
    }
  }
  s10 <- array(dim = c(I, I, J, J))
  s01 <- array(dim = c(I, I, J, J))
  for (i in 1:I) {
    for (ip in 1:I) {
      for (j in 1:J) {
        for (jp in 1:J) {
          s10[i, ip, j, jp] <- sum((V10[i, j, ] - fomArray[i, j]) * (V10[ip, jp, ] - fomArray[ip, jp]))/(K2 - 1)
          s01[i, ip, j, jp] <- sum((V01[i, j, ] - fomArray[i, j]) * (V01[ip, jp, ] - fomArray[ip, jp]))/(K1 - 1)
        }
      }
    }
  }
  S <- s10/K2 + s01/K1
  return(S)
}