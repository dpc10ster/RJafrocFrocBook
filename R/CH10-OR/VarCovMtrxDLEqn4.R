VarCovMtrxDLEqn4 <- function(dataset){ # this implements Eqn. 3 and 4 in Delong 1988 paper
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
  
  fomArray <- FigureOfMerit(dataset, "Wilcoxon")
  
  Xi10 <- array(dim = c(I, I, J, J))
  Xi01 <- array(dim = c(I, I, J, J))
  Xi11 <- array(dim = c(I, I, J, J))
  for (i in 1:I) {
    for (j in 1:J) {
      nl <- NL[i, j, 1:K1, ]
      ll <- cbind(NL[i, j, (K1 + 1):K, ], LL[i, j, , ])
      dim(nl) <- c(K1, maxNL)
      dim(ll) <- c(K2, maxNL + max(lesionNum))
      Xr <- apply(nl, 1, max)
      Yr <- apply(ll, 1, max)
      for (ip in 1:I) {
        for (jp in 1:J) {
          nl <- NL[ip, jp, 1:K1, ]
          ll <- cbind(NL[ip, jp, (K1 + 1):K, ], LL[ip, jp, , ])
          dim(nl) <- c(K1, maxNL)
          dim(ll) <- c(K2, maxNL + max(lesionNum))
          Xs <- apply(nl, 1, max)
          Ys <- apply(ll, 1, max)
          
          psi10_1 <- array(dim = c(K1, K2))
          psi10_2 <- array(dim = c(K1, K2, K2 - 1 ))
          psi10 <- array(dim = c(K1, K2, K2 - 1))
          for (k in 1:K1) {      
            psi10_1[ k , ] <- (Xr[k] < Yr) + 0.5 * (Xr[k] == Yr)       
            for (kp in 1:K2) {
              psi10_2[ k , kp , ] <- (Xs[k] < Ys[-kp]) + 0.5 * (Xs[k] == Ys[-kp])
            }
            for (kp in 1:K2) {
              psi10[ k , kp, ] <- psi10_1[ k , kp] * psi10_2[ k , kp , ]
            }
          }
          Xi10[i, ip, j, jp] <- mean(psi10) - fomArray[i, j] * fomArray[ip, jp]
          
          psi01_1 <- array(dim = c(K2, K1))
          psi01_2 <- array(dim = c(K2, K1, K1 - 1 ))
          psi01 <- array(dim = c(K2, K1, K1 - 1))
          for (k in 1:K2) {      
            psi01_1[ k , ] <- (Xr < Yr[k]) + 0.5 * (Xr == Yr[k])       
            for (kp in 1:K1) {
              psi01_2[ k , kp , ] <- (Xs[-kp] < Ys[k]) + 0.5 * (Xs[-kp] == Ys[k])
            }
            for (kp in 1:K1) {
              psi01[ k , kp, ] <- psi01_1[ k , kp] * psi01_2[ k , kp , ]
            }
          }
          Xi01[i, ip, j, jp] <- mean(psi01) - fomArray[i, j] * fomArray[ip, jp]
          
          
          psi11_1 <- array(dim = c(K1, K2))
          psi11_2 <- array(dim = c(K1, K2))
          for (k in 1:K1) {     
            psi11_1[ k , ] <- (Xr[k] < Yr) + 0.5 * (Xr[k] == Yr)     
            psi11_2[ k , ] <- (Xs[k] < Ys) + 0.5 * (Xs[k] == Ys)
          }
          Xi11[i, ip, j, jp] <- mean(psi11_1 * psi11_2) - fomArray[i, j] * fomArray[ip, jp]
        }
      }
    }
  }
  CovDeLong <- ((K2 - 1) * Xi10 + (K1 - 1) * Xi01 + Xi11) / (K1 * K2)
  return(CovDeLong)
}