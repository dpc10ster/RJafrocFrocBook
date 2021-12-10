WilcoxonCountsTable <- function (RocCountsTable)
{
  
  zk1  <- rep(1:length(RocCountsTable[1,]),RocCountsTable[1,])#convert frequency table to array
  zk2  <- rep(1:length(RocCountsTable[2,]),RocCountsTable[2,])#do:
  
  K1 = length(zk1)
  K2 = length(zk2)
  
  W <- 0
  for (k1 in 1:K1) {
    W <- W + sum(zk1[k1] < zk2)
    W <- W + 0.5 * sum(zk1[k1] == zk2)
  }
  W <- W/K1/K2
  
  return (list(
    AUC = W)
  )
  
}
