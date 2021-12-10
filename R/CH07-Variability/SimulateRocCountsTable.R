SimulateRocCountsTable <- function(K,mu,sigma,zetas)
{
  
  z1 <- rnorm(K[1])
  z2 <- rnorm(K[2], mean = mu, sd = sigma)
  
  zetas <- c(-Inf,zetas,Inf)
  
  for (k in 1:K[1]) {
    for (b in 1:(length(zetas)-1)) {
      if ((z1[k] > zetas[b]) && (z1[k] <= zetas[b+1])) {
        z1[k] <- b
        break
      }
    }
  }
  for (k in 1:K[2]) {
    for (b in 1:(length(zetas)-1)) {
      if ((z2[k] > zetas[b]) && (z2[k] <= zetas[b+1])) {
        z2[k] <- b
        break
      }
    }          
  }
  
  RocCountsTable = array(dim = c(2,length(zetas)-2+1))
  RocCountsTable[1,1:length(table(z1))] <- table(z1)  
  RocCountsTable[2,1:length(table(z2))] <- table(z2)
  #replace NAs with zeroes (this happens if any cell has zero counts)
  RocCountsTable[is.na(RocCountsTable)] <- 0
  
  return(RocCountsTable)
  
}
