# How to analyze a dataset with only diseased cases  {#analyze-diseased-only-dataset}

---
output:
  rmarkdown::pdf_document:
    fig_caption: yes        
---






## TBA How much finished {#analyze-diseased-only-dataset-how-much-finished}
0%


## The problem {#analyze-diseased-only-dataset-methods}

How to analyze $K_1 = 0$ datasets.


## Handling diseased-only datasets {#diseased-only-dataset}

ROC-like plot of TPF vs. FPF1 is possible, see Section \@ref(empirical-definition-empirical-auc-afroc1). Can create a ROC-like dataset with equal number of "non-diseased" and diseased cases (the ratings of the non-diseased cases are the FP ratings on diseased cases). Fit RSM to this dataset. Proceed as before. Key assumption being violated: the FP ratings on diseased cases are independent of the TP ratings on same cases. However, without this assumption one cannot estimate RSM parameters. Need `RJafroc` function to handle this special case: `FitRsmRoc1`? No! Just need function to create a "ROC" dataset from one that only has diseased cases. e.g., FixK1eq0dataset?


Save TONY dataset to `dsTony`. Create copy `dsNoNormals`. Replace all marks with case indices greater than $K_2$ with `NA`. This creates a dataset with no marks on non-diseased cases.


```r
dsTony <- RJafroc::dataset01 # TONY dataset
K2 <- length(dsTony$lesions$perCase)
K1 <- length(dsTony$ratings$NL[1,1,,1]) - K2
I <- length(dsTony$ratings$NL[,1,1,1]) - K2
J <- length(dsTony$ratings$NL[1,,1,1]) - K2
dsNoNormals <- dsTony
dsNoNormals$ratings$NL <- dsNoNormals$ratings$NL[,,-(1:K1),]
RJafroc::UtilFigureOfMerit(dsTony,FOM = "wAFROC")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.7602704 0.8406191 0.8171524 0.8153090 0.8278324
#> trtDM 0.6425854 0.7049977 0.7518434 0.7724426 0.6836962
#RJafroc::UtilFigureOfMerit(dsNoNormals,FOM = "wAFROC")
RJafroc::UtilFigureOfMerit(dsTony,FOM = "wAFROC1")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.8079866 0.8696629 0.8747798 0.8517613 0.8563468
#> trtDM 0.7277103 0.7781506 0.8225630 0.7968418 0.7496963
RJafroc::UtilFigureOfMerit(dsNoNormals,FOM = "wAFROC1")
#>            rdr1      rdr2      rdr3      rdr4      rdr5
#> trtBT 0.8594559 0.9009910 0.9369398 0.8910807 0.8871039
#> trtDM 0.8195304 0.8570572 0.8988448 0.8231600 0.8208875
```



