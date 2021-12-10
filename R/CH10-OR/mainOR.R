rm(list = ls()) #mainOR.R
library(RJafroc);library(ggplot2)
source("VarCovMtrxJK.R")
source("VarCovs.R")
source("Wilcoxon.R")
alpha <- 0.05;options(digits = 4);cat("alpha =", alpha,"\n")
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

zijk1 <- rocData$NL[,,,1];K <- dim(zijk1)[3];I <- dim(zijk1)[1];J <- dim(zijk1)[2]
zijk2 <- rocData$LL[,,,1];K2 <- dim(zijk2)[3];K1 <- K-K2;zijk1 <- zijk1[,,1:K1]

cat("data file = ", fileName, "\n")
cat("number of treatments = ", I, ", number of readers = ", J, ", number of non-diseased cases = ", K1, 
    ", number of diseased cases =  = ", K2, "\n")

FOM <- UtilFigureOfMerit(rocData, fom = "Wilcoxon")

mtrxJK <- VarCovMtrxJK(rocData)
VarCovJK <- VarCovs(mtrxJK)
Var <- VarCovJK$var;Cov1 <- VarCovJK$cov1;Cov2 <- VarCovJK$cov2;Cov3 <- VarCovJK$cov3

msT <- 0
for (i in 1:I){
  msT <- msT + (mean(FOM[i,]) - mean(FOM))^2
}
msT <- msT * J / (I - 1)

msTR <- 0
for (i in 1:I){
  for (j in 1:J) {    
    msTR <- msTR + (FOM[i,j] - mean(FOM[i,]) - mean(FOM[,j]) + mean(FOM))^2    
  }  
}
msTR <- msTR / ((I - 1)*(J - 1))

cat("\nRandom reader random case analysis\n")
MS_DEN_DIFF_FOM_RRRC <- (msTR+max(J*(Cov2-Cov3),0))
F_OR <- msT / MS_DEN_DIFF_FOM_RRRC
ndf <- (I-1)
ddfH <- MS_DEN_DIFF_FOM_RRRC^2/(msTR^2/((I-1)*(J-1)))
cat("Hillis ddfH = ", ddfH, "\n")
FCrit <- qf(1 - alpha, ndf, ddfH);cat("F statistic is ", F_OR, "and critical value of F is ", FCrit, "\n")  
pValue <- 1 - pf(F_OR, ndf, ddfH);cat("pvalue = ", pValue, "\n")

trtMeans <- array(dim = I)
for (i in 1:I) trtMeans[i] <- mean(FOM[i,])
trtDiff <- array(dim = c(I,I))
trtStr <- array(dim = c(I,I))
for (i1 in 1:(I-1)) {    
  for (i2 in (i1+1):I) {
    trtDiff[i1,i2] <- trtMeans[i1]- trtMeans[i2]    
    trtStr[i1,i2] <- gsub(", ", "", toString(c(i1,-i2)))
  }
}
trtDiff <- trtDiff[!is.na(trtDiff)];strDiff <- trtStr[!is.na(trtStr)]

std_DIFF_FOM_RRRC <- sqrt(2*MS_DEN_DIFF_FOM_RRRC/J)
nDiffs <- I*(I-1)/2
CI_DIFF_FOM_RRRC <- array(dim = c(nDiffs, 3))
for (i in 1 : nDiffs) {
  CI_DIFF_FOM_RRRC[i,1] <- trtDiff[i]
  CI_DIFF_FOM_RRRC[i,2] <- qt(alpha/2,df = ddfH)*std_DIFF_FOM_RRRC + trtDiff[i]
  CI_DIFF_FOM_RRRC[i,3] <- qt(1-alpha/2,df = ddfH)*std_DIFF_FOM_RRRC + trtDiff[i]
  cat("For pairing", strDiff[i], ", mean diff is ", CI_DIFF_FOM_RRRC[i,1], " and 95% CI is ", CI_DIFF_FOM_RRRC[i,2], CI_DIFF_FOM_RRRC[i,3], "\n")
}

cat("\nFixed reader random case analysis\n")
MS_DEN_DIFF_FOM_FRRC <- Var-Cov1+(J-1)*max((Cov2-Cov3),0)
FDbmFR <- msT / MS_DEN_DIFF_FOM_FRRC
ndf <- (I-1)
ddf <- Inf
cat("ddf = ", ddf, "\n")
FCrit <- qf(1 - alpha, ndf, ddf);cat("F statistic is ", FDbmFR, "and critical value of F is ", FCrit, "\n")  
pValue <- 1 - pf(FDbmFR, ndf, ddf);cat("p-value is ", pValue, "\n")

std_DIFF_FOM_FRRC <- sqrt(2*MS_DEN_DIFF_FOM_FRRC/J)
nDiffs <- I*(I-1)/2
CI_DIFF_FOM_FRRC <- array(dim = c(nDiffs, 3))
for (i in 1 : nDiffs) {
  CI_DIFF_FOM_FRRC[i,1] <- trtDiff[i]
  CI_DIFF_FOM_FRRC[i,2] <- qt(alpha/2,df = ddf)*std_DIFF_FOM_FRRC + trtDiff[i]
  CI_DIFF_FOM_FRRC[i,3] <- qt(1-alpha/2,df = ddf)*std_DIFF_FOM_FRRC + trtDiff[i]
  cat("For pairing", strDiff[i], ", mean diff is ", CI_DIFF_FOM_FRRC[i,1], " and 95% CI is ", CI_DIFF_FOM_FRRC[i,2], CI_DIFF_FOM_FRRC[i,3], "\n")
}

cat("\nRandom reader fixed case analysis\n")
MS_DEN_DIFF_FOM_RRFC <- msTR
FDbmFC <- msT / MS_DEN_DIFF_FOM_RRFC
ndf <- (I-1)
ddf <- (I-1)*(J-1)
cat("ddf = ", ddf, "\n")
FCrit <- qf(1 - alpha, ndf, ddf);cat("F statistic is ", FDbmFC, "and critical value of F is ", FCrit, "\n")  
pValue <- 1 - pf(FDbmFC, ndf, ddf);cat("p-value is ", pValue, "\n")

std_DIFF_FOM_RRFC <- sqrt(2*MS_DEN_DIFF_FOM_RRFC/J)
nDiffs <- I*(I-1)/2
CI_DIFF_FOM_RRFC <- array(dim = c(nDiffs, 3))
for (i in 1 : nDiffs) {
  CI_DIFF_FOM_RRFC[i,1] <- trtDiff[i]
  CI_DIFF_FOM_RRFC[i,2] <- qt(alpha/2,df = ddf)*std_DIFF_FOM_RRFC + trtDiff[i]
  CI_DIFF_FOM_RRFC[i,3] <- qt(1-alpha/2,df = ddf)*std_DIFF_FOM_RRFC + trtDiff[i]
  cat("For pairing", strDiff[i], ", mean diff is ", CI_DIFF_FOM_RRFC[i,1], " and 95% CI is ", CI_DIFF_FOM_RRFC[i,2], CI_DIFF_FOM_RRFC[i,3], "\n")
}

plotM <- list(1, 2, 3, 4)
plotR <- list(c(1:5), c(1:5), c(1:5), c(1:5))
plot <- PlotEmpiricalOperatingCharacteristics(dataset = rocData, trts = plotM, rdrs = plotR,legendPosition = "NULL")
p <- plot$ROCPlot +
  scale_colour_manual(values=c("black","grey", "blue", "darkblue")) + 
  theme(axis.title.y = element_text(size = 25,face="bold"),
        axis.title.x = element_text(size = 30,face="bold"),
        legend.position = c(1,0.01), legend.direction = "horizontal", 
        legend.text = element_text(size = 15, face = "bold"),legend.key.size = unit(1.5, "lines"))
p$layers[[1]]$aes_params$size <- 2 # line
p$layers[[2]]$aes_params$size <- 5 # points
print(p)

