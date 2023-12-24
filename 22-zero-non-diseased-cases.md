# Analyzing a dataset with only diseased cases {#analyze-diseased-only-dataset}

---
output:
  rmarkdown::pdf_document:
    fig_caption: yes        
---






## TBA How much finished {#analyze-diseased-only-dataset-how-much-finished}
0%


## The problem {#analyze-diseased-only-dataset-methods}

How to analyze $K_1 = 0$ datasets.

ROC-like plot of TPF vs. FPF1 is possible, see Section \@ref(empirical-definition-empirical-auc-afroc1). Can create a ROC-like dataset with equal number of "non-diseased" and diseased cases (the ratings of the non-diseased cases are the FP ratings on diseased cases). Fit RSM to this dataset. Proceed as before. Key assumption being violated: the FP ratings on diseased cases are independent of the TP ratings on same cases. However, without this assumption one cannot estimate RSM parameters. Need `RJafroc` function to handle this special case: `FitRsmRoc1`? No! Just need function to create a "ROC" dataset from one that only has diseased cases. e.g., `DfNoNormalsDataset`?


### Step 1: Create a test (diseased cases only) dataset {#analyze-diseased-only-dataset-step-1}

Save TONY dataset to `dsTony`. Create copy `dsNoNormals`. Remove all normal cases from it. 


```r
dsTony <- RJafroc::dataset01 # TONY dataset
K2 <- length(dsTony$lesions$perCase)
K1 <- length(dsTony$ratings$NL[1,1,,1]) - K2
dsNoNormals <- dsTony
# Remove all normal cases
dsNoNormals$ratings$NL <- dsNoNormals$ratings$NL[,,-(1:K1),] 
# And fix truthTableStr
dsNoNormals$descriptions$truthTableStr <- 
  dsNoNormals$descriptions$truthTableStr[,,-(1:K1),]
RJafroc::UtilFigureOfMerit(dsTony,FOM = "wAFROC")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.7602704 0.8406191 0.8171524 0.8153090 0.8278324
#> trtDM 0.6425854 0.7049977 0.7518434 0.7724426 0.6836962
#RJafroc::UtilFigureOfMerit(dsNoNormals,FOM = "wAFROC") #this will generate an error
RJafroc::UtilFigureOfMerit(dsTony,FOM = "wAFROC1")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.8079866 0.8696629 0.8747798 0.8517613 0.8563468
#> trtDM 0.7277103 0.7781506 0.8225630 0.7968418 0.7496963
RJafroc::UtilFigureOfMerit(dsNoNormals,FOM = "wAFROC1")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.8594559 0.9009910 0.9369398 0.8910807 0.8871039
#> trtDM 0.8195304 0.8570572 0.8988448 0.8231600 0.8208875
st <- St(dsTony,FOM = "wAFROC")
st1 <- St(dsNoNormals,FOM = "wAFROC1")
st$RRRC
#> $FTests
#>                 DF          MS    FStat           p
#> Treatment  1.00000 0.025564954 10.29883 0.003668578
#> Error     24.70276 0.002482317       NA          NA
#> 
#> $ciDiffTrt
#>              Estimate     StdErr       DF        t       PrGTt    CILower
#> trtBT-trtDM 0.1011236 0.03151074 24.70276 3.209178 0.003668578 0.03618638
#>               CIUpper
#> trtBT-trtDM 0.1660608
#> 
#> $ciAvgRdrEachTrt
#>        Estimate     StdErr       DF   CILower   CIUpper         Cov2
#> trtBT 0.8122367 0.02698434 59.28149 0.7582465 0.8662268 0.0005390098
#> trtDM 0.7111131 0.03391021 17.78930 0.6398098 0.7824163 0.0006046324
st1$RRRC
#> $FTests
#>                 DF           MS    FStat           p
#> Treatment   1.0000 0.0065582806 7.957961 0.005193632
#> Error     236.8821 0.0008241157       NA          NA
#> 
#> $ciDiffTrt
#>               Estimate     StdErr       DF        t       PrGTt    CILower
#> trtBT-trtDM 0.05121828 0.01815616 236.8821 2.820986 0.005193632 0.01545011
#>                CIUpper
#> trtBT-trtDM 0.08698645
#> 
#> $ciAvgRdrEachTrt
#>        Estimate     StdErr       DF   CILower   CIUpper         Cov2
#> trtBT 0.8951143 0.01974550 24.73302 0.8544254 0.9358031 0.0002330913
#> trtDM 0.8438960 0.02497063 27.62144 0.7927144 0.8950776 0.0003862498
```


* `dsNoNormals` is the dataset with no non-diseased cases. 

* `st` contains the results of significance testing using the wAFROC-AUC figure of merit for the full dataset. 

* `st1` contains the results of significance testing using the wAFROC1-AUC figure of merit for the dataset with no non-diseased cases.


