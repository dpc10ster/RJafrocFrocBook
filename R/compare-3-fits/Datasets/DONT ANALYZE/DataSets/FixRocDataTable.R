FixRocDataTable  <- function (RocDataTable) {
  
  R  <- length(RocDataTable[1,])
  while(1) {
    if (!any(RocDataTable == 0)) return (RocDataTable) else {
      for (i in 1:2) {
        if (!any(RocDataTable[i,] == 0)) next else {
          if (R - length(which(RocDataTable[i,] == 0)) <= 2) return(-1)#this needs some more thought
          newBins  <- R - length(which(RocDataTable[i,] == 0))
          zeroColumn <- which(RocDataTable[i,] == 0)[1]
          if (zeroColumn == R) {
            RocDataTable[1,R-1]  <- sum(RocDataTable[1,(R-1):R]) 
            RocDataTable[2,R-1]  <- sum(RocDataTable[2,(R-1):R])
            RocDataTable  <- RocDataTable[,-zeroColumn]
          } else if (zeroColumn == 1) {
            RocDataTable[1,2]  <- sum(RocDataTable[1,1:2]) 
            RocDataTable[2,2]  <- sum(RocDataTable[2,1:2])
            RocDataTable  <- RocDataTable[,-zeroColumn]
          } else {
            RocDataTable[1,zeroColumn-1]  <- sum(RocDataTable[1,(zeroColumn-1):zeroColumn]) 
            RocDataTable[2,zeroColumn-1]  <- sum(RocDataTable[2,(zeroColumn-1):zeroColumn])
            RocDataTable  <- RocDataTable[,-zeroColumn]         
          }
          R  <- R - 1
        }
      }
    }
    if (!any(RocDataTable == 0)) return (RocDataTable) 
  }
}