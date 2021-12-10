FixRocCountsTable  <- function (RocCountsTable) {
  
  R  <- length(RocCountsTable[1,])
  while(1) {
    if (!any(RocCountsTable == 0)) return (RocCountsTable) else {
      for (i in 1:2) {
        if (!any(RocCountsTable[i,] == 0)) next else {
          if (R - length(which(RocCountsTable[i,] == 0)) <= 2) return(-1)#this needs some more thought
          newBins  <- R - length(which(RocCountsTable[i,] == 0))
          zeroColumn <- which(RocCountsTable[i,] == 0)[1]
          if (zeroColumn == R) {
            RocCountsTable[1,R-1]  <- sum(RocCountsTable[1,(R-1):R]) 
            RocCountsTable[2,R-1]  <- sum(RocCountsTable[2,(R-1):R])
            RocCountsTable  <- RocCountsTable[,-zeroColumn]
          } else if (zeroColumn == 1) {
            RocCountsTable[1,2]  <- sum(RocCountsTable[1,1:2]) 
            RocCountsTable[2,2]  <- sum(RocCountsTable[2,1:2])
            RocCountsTable  <- RocCountsTable[,-zeroColumn]
          } else {
            RocCountsTable[1,zeroColumn-1]  <- sum(RocCountsTable[1,(zeroColumn-1):zeroColumn]) 
            RocCountsTable[2,zeroColumn-1]  <- sum(RocCountsTable[2,(zeroColumn-1):zeroColumn])
            RocCountsTable  <- RocCountsTable[,-zeroColumn]         
          }
          R  <- R - 1
        }
      }
    }
    if (!any(RocCountsTable == 0)) return (RocCountsTable) 
  }
}