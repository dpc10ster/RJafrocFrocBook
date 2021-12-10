rm(list = ls()) #MainJkPseudoVsJkFom.R
library(RJafroc)
source("CovJk.R")
source("Wilcoxon.R")

alpha <- 0.05
if (TRUE) {
  #fileName <- "Franken1.lrc"
  fileName <- "VanDyke.lrc"
  rocData <- ReadDataFile(fileName, format = "MRMC", renumber = "TRUE")
} else {
  fileName <- "CXRinvisible3-20mm.xlsx"
  frocData <- ReadDataFile(fileName, format = "JAFROC", renumber = "TRUE")
  rocData <- FROC2HrROC(frocData)
  rm(frocData)
}
zijk1 <- rocData$NL[,,,1];K <- dim(zijk1)[3];I <- dim(zijk1)[1];J <- dim(zijk1)[2]
zijk2 <- rocData$LL[,,,1];K2 <- dim(zijk2)[3];K1 <- K-K2;zijk1 <- zijk1[,,1:K1]

cat("data file = ", fileName, "\n")
cat("number of treatments = ", I, ", number of readers = ", J, ", number of non-diseased cases = ", K1, 
    ", number of diseased cases =  = ", K2, "\n")

pseudoVals <- PseudoValues(rocData, fom = "Wilcoxon")

RHO <- 0
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      RHO <- RHO + cor(pseudoVals[i1,j,], pseudoVals[i2,j,])
    }  
  }
}
RHO <- RHO / count
cat("RHO pseudoVals = ", RHO, "\n")

ret <- FomJkValues(zijk1, zijk2)
FOMijk <- ret$FOM_ijk

RHO <- 0
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      RHO <- RHO + cor(FOMijk[i1,j,], FOMijk[i2,j,])
    }  
  }
}
RHO <- RHO / count
cat("RHO FOMijk = ", RHO, "\n")

VAR <- 0
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      VAR <- VAR + var(pseudoVals[i1,j,], pseudoVals[i2,j,])
    }  
  }
}
VAR <- VAR / count
cat("VAR pseudoVals = ", VAR, "\n")

ret <- FomJkValues(zijk1, zijk2)
FOMijk <- ret$FOM_ijk

VAR <- 0
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      VAR <- VAR + var(FOMijk[i1,j,], FOMijk[i2,j,])
    }  
  }
}
VAR <- VAR / count
cat("VAR FOMijk = ", VAR, "\n")

diff <- array(0, dim = K)
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      diff <- diff + (pseudoVals[i1,j,]-pseudoVals[i2,j,])
    }
  }
}
diff <- diff / count
hist(diff, breaks = 20, main = NULL)

diff <- array(0, dim = K)
count <- 0
for (j in 1:J) {
  for (i1 in 1:(I-1)) {
    for (i2 in (i1+1):I) {
      count <- count + 1
      diff <- diff + (FOMijk[i1,j,]-FOMijk[i2,j,])
    }
  }
}
diff <- diff / count
hist(diff, breaks = 20, main = NULL)

