rm(list = ls()) #mainOrDbm1R.R
library(RJafroc)
source("Wilcoxon.R")
source("VarCov1Jk.R")
ROC <- FALSE
if (ROC) {
  #fileName <- "Franken1.lrc"
  fileName <- "VanDyke.lrc"
  rocData <- DfReadDataFile(fileName, format = "MRMC", renumber = "TRUE")
} else {
  fileName <- "CXRinvisible3-20mm.xlsx"
  frocData <- DfReadDataFile(fileName, format = "JAFROC", renumber = "TRUE")
  rocData <- DfFroc2HrRoc(frocData)
}
jSelect <- 1
rocData <- DfExtractDataset(rocData, rdrs = jSelect)
cat("data file = ", fileName, "\n")
cat("selected reader = ", jSelect, "\n")

ret1 <- SignificanceTesting(rocData,fom = "Wilcoxon", method = "DBM", option = "FRRC")
cat("DBM: F-stat = ", ret1$fFRRC, ", ddf = ", ret1$ddfFRRC, ", P-val = ", ret1$pFRRC,"\n")

ret2 <- SignificanceTesting(rocData,fom = "Wilcoxon", method = "OR", option = "FRRC")
cat("OR (Jackknife):  F-stat = ", ret2$fFRRC, ", ddf = ", ret2$ddfFRRC, ", P-val = ", ret2$pFRRC,"\n")

ret3 <- SignificanceTesting(rocData,fom = "Wilcoxon", method = "OR", option = "FRRC", 
                            covEstMethod = "DeLong")
cat("OR (DeLong):  F-stat = ", ret3$fFRRC, ", ddf = ", ret3$ddfFRRC, ", P-val = ", ret3$pFRRC,"\n")

ret4 <- SignificanceTesting(rocData,fom = "Wilcoxon", method = "OR", option = "FRRC", 
                            covEstMethod = "Bootstrap")
cat("OR (Bootstrap):  F-stat = ", ret4$fFRRC, ", ddf = ", ret4$ddfFRRC, ", P-val = ", ret4$pFRRC,"\n")