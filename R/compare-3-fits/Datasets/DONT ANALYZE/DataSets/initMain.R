rm(list = ls())

library(xlsx)

# following needed to read JAFROC data file and convert to ROC
source("ReadJAFROC.R")
source("ConvertFROC2HRatings.R")
source("CnvrtContinuousToIntegerRatings.R")
source("CalculateZetas.R")
UNINITIALIZED <<- -2000 # global
MAX_MARKS <<- 20 # global
# end JAFROC




