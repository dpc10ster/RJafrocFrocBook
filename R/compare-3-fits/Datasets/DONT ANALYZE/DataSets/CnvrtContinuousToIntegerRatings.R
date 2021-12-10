# categorized integer or floating point z-samples
# to 5 bins for compatibility with CorROCII
# considered using CLabRoc, but extra dimensions of Covariancd matrix
# could make positive definiteness problem worse
CnvrtContinuousToIntegerRatings <- function (f,t,DesiredNumBins)
{
  zetas <- CalculateZetas(f,t)    
    
  fb <- as.vector(table(cut(f,c(-Inf, zetas, Inf)))) 
  tb <- as.vector(table(cut(t,c(-Inf, zetas, Inf)))) 
  if (length(fb) != length(tb)) stop
  RocDataTable <- array(dim = c(2,length(fb)))
  RocDataTable[1,1:length(fb)] <- fb;
  RocDataTable[2,1:length(tb)] <- tb;
    
  minValue <- 0
  while(1) {
    if (length(which(RocDataTable == minValue)) == 0) minValue <- minValue+1  
    for (t1 in 1:2) {
      R1 <- length(RocDataTable[1,])
      if (R1 == DesiredNumBins) break    
      minValueColumn <- which(RocDataTable[t1,] == minValue)[1]
      if (is.na(minValueColumn)) next
      if (minValueColumn == R1) {
        RocDataTable[1,R1-1]  <- sum(RocDataTable[1,(R1-1):R1]) 
        RocDataTable[2,R1-1]  <- sum(RocDataTable[2,(R1-1):R1])
        RocDataTable  <- RocDataTable[,-minValueColumn]
        zetas <- zetas[-(minValueColumn-1)]        
      } else if (minValueColumn == 1) {
        RocDataTable[1,2]  <- sum(RocDataTable[1,1:2]) 
        RocDataTable[2,2]  <- sum(RocDataTable[2,1:2])
        RocDataTable  <- RocDataTable[,-minValueColumn]
        zetas <- zetas[-1]        
      } else {
        RocDataTable[1,minValueColumn-1]  <- sum(RocDataTable[1,(minValueColumn-1):minValueColumn]) 
        RocDataTable[2,minValueColumn-1]  <- sum(RocDataTable[2,(minValueColumn-1):minValueColumn])
        RocDataTable  <- RocDataTable[,-minValueColumn]
        zetas <- zetas[-(minValueColumn-1)]
      }
    }
    if (R1 == (DesiredNumBins)) break      
  }
  
  fb <- as.vector(table(cut(f,c(-Inf, zetas, Inf)))) 
  tb <- as.vector(table(cut(t,c(-Inf, zetas, Inf)))) 
  
  f <- cut(f,c(-Inf, zetas, Inf),labels=FALSE) 
  t <- cut(t,c(-Inf, zetas, Inf),labels=FALSE) 
  
  
  return(list(fb=fb, tb=tb, f=f,t=t,zetas=zetas))
  
  #  return(list(f=f,t=t))
  
}
