#MainAnalyzeSingleFixedFactorData.R
rm(list = ls())
library(RJafroc)
#fileName <- "./Datasets/FedericaALL.xlsx"
fileName <- "./Datasets/RayAndrew.xlsx"
frocData <- ReadDataFile(fileName)
myData <- ExtractDataset(frocData, trts = 1)
myDataRes <- SingleFixedFactorAnalysis(myData, fom = "wJAFROC")
print(myDataRes)
