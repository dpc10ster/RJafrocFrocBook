rm(list = ls()) #mainOrDbm.R
library(RJafroc)
ROC <- FALSE
if (ROC) {
  #fileName <- "Franken1.lrc"
  fileName <- "VanDyke.lrc"
  rocData <- DfReadDataFile(fileName, format = "MRMC", renumber = "TRUE")
} else {
  fileName <- "CXRinvisible3-20mm.xlsx"
  frocData <- DfReadDataFile(fileName, format = "JAFROC", renumber = "TRUE")
  rocData <- DfFRoc2HrRoc(frocData)
  rm(frocData)
}

UtilOutputReport(dataset = rocData,fom = "Wilcoxon",method = "DBM", 
             reportFormat = "xlsx",reportFile = "DBM.xlsx", showWarnings = FALSE)
UtilOutputReport(dataset = rocData,fom = "Wilcoxon",method = "OR", 
             reportFormat = "xlsx",reportFile = "OR.xlsx", showWarnings = FALSE)
