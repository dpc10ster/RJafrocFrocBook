rm(list = ls()) # mainDLEqn4StrCompJk.R
library(RJafroc)
source("VarCovMtrxDLStr.R")
source("VarCovMtrxDLEqn4.R")
source("VarCovMtrxJK.R")
source("VarCovs.R")
source("Wilcoxon.R")
ROC <- FALSE
if (ROC) {
  #fileName <- "Franken1.lrc"
  fileName <- "VanDyke.lrc"
  rocData <- ReadDataFile(fileName, format = "MRMC", renumber = "TRUE")
} else {
  fileName <- "CXRinvisible3-20mm.xlsx"
  frocData <- ReadDataFile(fileName, format = "JAFROC", renumber = "TRUE")
  rocData <- FROC2HrROC(frocData)
}
cat("data file = ", fileName, "\n")

mtrxDLEqn4 <- VarCovMtrxDLEqn4(rocData)
VarCovDLEqn4 <- VarCovs(mtrxDLEqn4)

mtrxDLStr <- VarCovMtrxDLStr(rocData)
VarCovDLStr <- VarCovs(mtrxDLStr)

mtrxJK <- VarCovMtrxJK(rocData)
VarCovJK <- VarCovs(mtrxJK)
cat("Var estimates: (Eqn4, Str Comp, Jackknife):", VarCovDLEqn4$var,VarCovDLStr$var, VarCovJK$var, "\n")
cat("Cov1 estimates: (Eqn4, Str Comp, Jackknife):", VarCovDLEqn4$cov1,VarCovDLStr$cov1, VarCovJK$cov1, "\n")
cat("Cov2 estimates: (Eqn4, Str Comp, Jackknife):", VarCovDLEqn4$cov2,VarCovDLStr$cov2, VarCovJK$cov2, "\n")
cat("Cov3 estimates: (Eqn4, Str Comp, Jackknife):", VarCovDLEqn4$cov3,VarCovDLStr$cov3, VarCovJK$cov3, "\n")
