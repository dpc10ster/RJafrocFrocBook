VarCovMtrxJK <- function(dataset){
  NL <- dataset$NL
  LL <- dataset$LL
  lesionNum <- dataset$lesionNum
  lesionID <- dataset$lesionID
  lesionWeight <- dataset$lesionWeight
  maxNL <- dim(NL)[4]
  maxLL <- dim(LL)[4]
  dataType <- dataset$dataType
  modalityID <- dataset$modalityID
  readerID <- dataset$readerID
  I <- length(modalityID)
  J <- length(readerID)
  K <- dim(NL)[3]
  K2 <- dim(LL)[3]
  K1 <- K - K2
  
  dim(NL) <- c(I, J, K, maxNL)
  dim(LL) <- c(I, J, K2, max(lesionNum))
  
  jkFOMArray <- array(dim = c(I, J, K))
  pseudoValues <- array(dim = c(I, J, K))
  for (i in 1:I) {
    for (j in 1:J) {
      for (k in 1:K) {
        if (k <= K1) {
          nl <- NL[i, j, 1:K1, ]
          ll <- cbind(NL[i, j, (K1 + 1):K, ], LL[i, j, , ])
          dim(nl) <- c(K1, maxNL)
          dim(ll) <- c(K2, maxNL + max(lesionNum))
          fp <- apply(nl, 1, max)
          tp <- apply(ll, 1, max)
          fp <- fp[-k]
          jkFOMArray[i, j, k] <- Wilcoxon(fp, tp)
        } else {
          nl <- NL[i, j, 1:K1, ]
          ll <- cbind(NL[i, j, (K1 + 1):K, ], LL[i, j, , ])
          dim(nl) <- c(K1, maxNL)
          dim(ll) <- c(K2, maxNL + max(lesionNum))
          fp <- apply(nl, 1, max)
          tp <- apply(ll, 1, max)
          tp <- tp[-(k - K1)]
          jkFOMArray[i, j, k] <- Wilcoxon(fp, tp)
        }
      }
    }
  }
  
  covariances <- array(dim = c(I, I, J, J))
  
  for (i in 1:I) {
    for (ip in 1:I) {
      for (j in 1:J) {
        for (jp in 1:J) {
          covariances[i, ip, j, jp] <- cov(jkFOMArray[i, j, ], jkFOMArray[ip, jp, ])
        }
      }
    }
  }
  covariances <- covariances * (K - 1)^2/K
  return(covariances)
}