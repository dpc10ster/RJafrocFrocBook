#MainAnalyzeData.R
rm(list = ls())
library(RJafroc)
## First dataset
###fileName <- "./Datasets/RayAndrewPerCase.xlsx"
## May Dataset
#fileName <- "./Datasets/RA_Lesion_Ca_OP.xlsx"
#fileName <- "./Datasets/RA_Lesion_Bx_OP.xlsx"
#fileName <- "./Datasets/RA_Lesion_Ca_Certainty.xlsx"
fileName <- "./Datasets/RA_Lesion_Bx_Certainty.xlsx"

frocData <- ReadDataFile(fileName)

# wAFROC analysis
ResultsFroc <- ORHAnalysis(frocData, fom = "wJAFROC", alpha = 0.05,
                           covEstMethod = "Jackknife", option = "FRRC")

EmpiricalOpCharac(frocData, trts = c(1,2), rdrs = 1, opChType = "wAFROC")

# inferred ROC analysis
rocData <- FROC2HrROC(frocData)
ResultsRoc <- ORHAnalysis(rocData, fom = "Wilcoxon", alpha = 0.05,
                          covEstMethod = "Jackknife", option = "FRRC")

EmpiricalOpCharac(rocData, trts = c(1,2), rdrs = 1, opChType = "ROC")
