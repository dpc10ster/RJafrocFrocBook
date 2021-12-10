ReadCorROCII <- function(filename)
{  
  lines <- readLines(filename)
  
  for (lineNumber in 1:length(lines)){
    temp <- lines[lineNumber]
    if (length(grep("ARE DEGENERATE", temp)) != 0) {
      return(-1)
    }
  }
  
  lineNumber <- 1
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("FINAL ESTIMATES OF THE PARAMETERS:", temp)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  lineNumber  <- lineNumber + 1 
  temp <- lines[lineNumber]
  temp <- unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))) 
  ax  <- as.numeric(temp[1])
  bx  <- as.numeric(temp[2])
  ay  <- as.numeric(temp[3])
  by  <- as.numeric(temp[4])
  
  lineNumber  <- lineNumber + 1 
  temp <- lines[lineNumber]
  temp <- unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))) 
  rhon  <- as.numeric(temp[1])
  rhos  <- as.numeric(temp[2])
  
  lineNumber  <- lineNumber + 1 
  temp <- lines[lineNumber]
  temp <- unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp)))
  zetan <- array(dim = length(temp))
  for (i in 1:length(temp)) {
    zetan[i]  <- as.numeric(temp[i])
  }
  
  lineNumber  <- lineNumber + 1 
  temp <- lines[lineNumber]
  temp <- unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp)))
  zetas <- array(dim = length(temp))
  for (i in 1:length(temp)) {
    zetas[i]  <- as.numeric(temp[i])
  }
  
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("VARIANCE-COVARIANCE MATRIX", temp)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  
  lineNumber  <- lineNumber + 1 
  temp <- lines[lineNumber]
  dimCov <- as.numeric(temp)
  
  Cov <- array(0,dim = c(dimCov,dimCov))
  
  for (i in 1:dimCov) {
    for (j in 1:dimCov) {   
      Cov[i,j] <- as.numeric(lines[lineNumber+dimCov*(i-1)+j])
    }
  }
  
  lineNumber <- lineNumber+dimCov*(i-1)+j+1
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("AREA(X)=", temp, fixed = TRUE)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  temp <- as.numeric(unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))))
  Ax  <- temp[1]
  Ay  <- temp[2]
  
  lineNumber <- lineNumber+1  
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("STD DEV OF AREA(X)=", temp, fixed = TRUE)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  temp <- as.numeric(unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))))
  StdAx  <- temp[1]
  StdAy  <- temp[2]
    
  lineNumber <- lineNumber+1  
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("CORRELATION OF AREA(X) AND AREA(Y) =", temp, fixed = TRUE)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  temp <- as.numeric(unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))))
  RhoAxAy  <- temp[1]
    
  lineNumber <- lineNumber+1  
  while(1){
    temp <- lines[lineNumber]
    if (length(grep("WITH A CORRESPONDING TWO-TAILED P-LEVEL OF", temp, fixed = TRUE)) == 0) lineNumber  <- lineNumber + 1 else break
  }
  temp <- as.numeric(unlist(regmatches(temp, gregexpr('[-0-9]+.[0-9]+',temp))))
  pValue  <- temp[1]  
  
  return(list(
    ax = ax,
    ay = ay,    
    bx = bx,
    by = by,
    rhon = rhon,
    rhos = rhos,  
    zetan = zetan,
    zetas = zetas,
    Cov = Cov,
    Ax = Ax,
    Ay = Ay,
    StdAx = StdAx,
    StdAy = StdAy,
    RhoAxAy=RhoAxAy,
    pValue = pValue))
  
}

