mu <- fit$mu
lambda <- fit$lambda
nu <- fit$nu
wafrocArr <- array(dim = c(2))
zetaOptArr1 <- array(dim = c(2))
rocAucArr <- array(dim = c(2))
nlfOptArr <- array(dim = c(2))
llfOptArr <- array(dim = c(2))
for (y in 1:2) {
  if (y == 1) {
    x <- optimize(wAFROC, 
                  interval = c(-5,5), 
                  mu, 
                  lambda = lambda, 
                  nu = nu, 
                  lesDistrCad, 
                  relWeightsCad)
    zetaOptArr1[y] <- x$minimum
    wafrocArr[y] <- -x$objective  # safe to use objective here
    rocAucArr[y] <- UtilAnalyticalAucsRSM(
      mu, 
      lambda = lambda, 
      nu = nu, 
      zeta1 = x$minimum, 
      lesDistrCad, 
      relWeightsCad)$aucROC
    nlfOptArr[y] <- RSM_NLF(
      z = x$minimum, 
      lambda = lambda)
    llfOptArr[y] <- RSM_LLF(
      z = x$minimum, 
      mu, 
      nu)
  } else if (y == 2) {
    x <- optimize(Youden, 
                  interval = c(-5,5), 
                  mu, 
                  lambda = lambda, 
                  nu = nu, 
                  lesDistrCad)
    zetaOptArr1[y] <- x$minimum
    wafrocArr[y] <- UtilAnalyticalAucsRSM(
      mu, 
      lambda = lambda, 
      nu = nu, 
      zeta1 = x$minimum, 
      lesDistrCad, 
      relWeightsCad)$aucwAFROC
    rocAucArr[y] <- UtilAnalyticalAucsRSM(
      mu, 
      lambda = lambda, 
      nu = nu, 
      zeta1 = x$minimum, 
      lesDistrCad, 
      relWeightsCad)$aucROC
    nlfOptArr[y] <- RSM_NLF(
      z = x$minimum, 
      lambda = lambda)
    llfOptArr[y] <- RSM_LLF(
      z = x$minimum, mu, nu)
  } else stop("incorrect y")
}

