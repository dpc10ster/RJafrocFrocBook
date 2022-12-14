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
st <- StSignificanceTesting(dsTony,FOM = "wAFROC")
st1 <- StSignificanceTesting(dsNoNormals,FOM = "wAFROC1")
st$RRRC
#> $FTests
#>                  DF         MS     FStat            p
#> Treatment  1.000000 4.72951648 10.298825 0.0036685784
#> Error     24.702758 0.45922873        NA           NA
#> 
#> $ciDiffTrt
#>              Estimate      StdErr        DF         t        PrGTt     CILower
#> trtBT-trtDM 0.1011236 0.031510744 24.702758 3.2091783 0.0036685784 0.036186385
#>                CIUpper
#> trtBT-trtDM 0.16606081
#> 
#> $ciAvgRdrEachTrt
#>         Estimate      StdErr        DF    CILower    CIUpper
#> trtBT 0.81223666 0.026984337 59.281486 0.75824649 0.86622683
#> trtDM 0.71111306 0.033910209 17.789298 0.63980982 0.78241630
st1$RRRC
#> $FTests
#>                  DF          MS     FStat            p
#> Treatment   1.00000 0.583686978 7.9579613 0.0051936318
#> Error     236.88206 0.073346295        NA           NA
#> 
#> $ciDiffTrt
#>                Estimate      StdErr        DF         t        PrGTt
#> trtBT-trtDM 0.051218281 0.018156163 236.88206 2.8209859 0.0051936318
#>                 CILower    CIUpper
#> trtBT-trtDM 0.015450111 0.08698645
#> 
#> $ciAvgRdrEachTrt
#>         Estimate      StdErr        DF    CILower    CIUpper
#> trtBT 0.89511425 0.019745498 24.733020 0.85442537 0.93580314
#> trtDM 0.84389597 0.024970629 27.621445 0.79271436 0.89507759
```


* `dsNoNormals` is the dataset with no non-diseased cases. 

* `st` contains the results of significance testing using the wAFROC-AUC figure of merit for the full dataset. 

* `st1` contains the results of significance testing using the wAFROC1-AUC figure of merit for the dataset with no non-diseased cases.


