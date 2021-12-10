rm(list = ls()) # mainSingleModality.R
library(RJafroc)
source("Wilcoxon.R")
source("CovJk.R")
source("CovDL.R")
source("SingleTreatmentAnalysis.R")
alpha <- 0.05
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
cat("data file = ", fileName, "\n")

i <- 1 # select the treatment to be analyzed
singleData <- DfExtractDataset(rocData, trts = i) # extract the first treatment
fomArray <- UtilFigureOfMerit(singleData, FOM = "Wilcoxon")
thetaDot <- mean(fomArray[i, ])
mu0 <- 0.583422#mu0 <- 0.6
ret <- SingleTreatmentAnalysis(singleData, mu0, covEstMthd = "JK", alpha = alpha)
cat("The NH is that thetaDot = mu0, where thetaDot= ", thetaDot, "and mu0 = ", mu0,"\n")
cat("The mean FOM for the anal2zed treatment is:", thetaDot,"\n")
cat("The", 100 * (1 - alpha), "% CI for the preceding value is:", "(", ret$ci[1], ",", ret$ci[2], ")\n")
cat("The t-statistic and p-value to test H0: (analyzed treatment = standard) are:", ret$tStat, ", and ", ret$pVal, "\n")
cat("The difference in reader averaged analyzed treatment minus standard = ",thetaDot - mu0, "\n")
cat("The", 100 * (1 - alpha), "% CI of the preceding value is", "(", ret$ciDiff[1], ",", ret$ciDiff[2], ")\n")
