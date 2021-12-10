source("initMain.R")
options(digits=3)
ret <- ReadJAFROC("DataSets/FedericaAll.xlsx")
NL <- ret$NL;LL <- ret$LL
ret <- ConvertFROC2HRatings(NL,LL)
Hratings <- ret$Hratings
truth <- ret$truth
Nk <- truth[truth == 1]
K2 <- length(Nk);K1 <- length(truth) - K2;I <- length(Hratings[,1,1])
Jall <- length(Hratings[1,,1])# total number of readers in data file

jSelected <- 2
DesiredNumBins <- 4 
cat("# non-diseased images is ", K1, "# diseased images is ", K2, "\n")
cat("Total number of readers in data set is ", Jall, "\n")
cat("Selected reader to analyze is ", jSelected, "\n")
cat("Ratings are binned into this number of bins ", DesiredNumBins, "\n")

z1 <- array(dim=c(I,1,K1))#this contortion needed to preserve the one dimension for reader index
z2 <- array(dim=c(I,1,K2))
z1[,1,] <- Hratings[,jSelected,1:K1]
z2[,1,] <- Hratings[,jSelected,(K1+1):(K1+K2)]

x1  <- NULL;x2  <- NULL
for (i in 1:I){
  if (length(x1) == 0) x1 <- z1[i,1,] else x1 <- c(x1, z1[i,1,])
  if (length(x2) == 0) x2 <- z2[i,1,] else x2 <- c(x2, z2[i,1,]) 
}

# x1 <- c(z1[1,1,],z1[2,1,]) # all modalities; this critical code allows one modality binning code to be used
# x2 <- c(z2[1,1,],z2[2,1,])
ret <- CnvrtContinuousToIntegerRatings(x1,x2,DesiredNumBins)# one modality binning code

z1b <- array(dim = dim(z1)) # allocate space for binned data
for (i in 1:I){
  lo <- (i-1)*K1+1
  hi <- lo + K1 - 1
  z1b[i,1,1:K1] <- ret$f[lo:hi]   
}
z2b <- array(dim = dim(z2)) # allocate space for binned data
for (i in 1:I){
  lo <- (i-1)*K2+1
  hi <- lo + K2 - 1
  z2b[i,1,1:K2] <- ret$t[lo:hi]   
}


stop("take a break")



