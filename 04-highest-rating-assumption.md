# Validity of the highest rating assumption {#highest-rating}








## How much finished 0% {#highest-rating-how-much-finished}



## Introduction {#highest-rating-intro}


## The FROC and real ROC datasets {#highest-rating-2-datasets}

## Code implementation {#highest-rating-code}




## Load the three datasets



```{.r .numberLines}
# start with original Federica FROC dataset
ds <- dataset04
# convert it to ROC and extract modalities 4 and 5
# infd_ds means the highest rating inferred ROC dataset, 
# implemented in DfFroc2Roc
infd_ds <- DfExtractDataset(DfFroc2Roc(ds), trts = c(4,5))

# Federica real ROC dataset; this used modalities 4 and 5, 
# same readers and same cases as the previous FROC study 
real_ds <- dataset14

# load a cross modality dataset
# This will serve as a template whose list elements will be modified to create 
# the desired cross modality dataset
xds <- datasetXModality
```

Line 2, `ds <- dataset04`, is the Federica Zanca 5 modality, 4 reader, 200 case FROC dataset.

Line 6 converts this to an **inferred** ROC dataset `infd_ds` containing treatments 4 and 5 only.

Line 10, `real_ds <- dataset14` is the Federica Zanca 2 modality, 4 reader, 200 case **real** ROC dataset. The two modalities correspond to treatments 4 and 5 in the FROC dataset `dataset04`.

Line 15 assigns a pre-loaded **crossed** modality dataset `xds <- datasetXModality` which serves as a template to be modified to meet our needs. 

The original dimensions of `xds$ratings$NL` is `dim(xds$ratings$NL) = 2, 4, 11, 68, 5`. This because it represents a crossed modality dataset with two modality-1 factors (adaptive iterative dose reduction and filtered back projection) crossed with 4 modality-2 factors (x-ray tube charge = 20 mAs, 40 mAs, 60 mAs and 80 mAs), 11 readers, and 68 cases with a maximum of 5 marks per case.

## Modify the template 

Any dataset is a multilevel list containing three list members at level 1, as shown below:


```r
str(xds, max.level = 1)
#> List of 3
#>  $ ratings     :List of 3
#>  $ lesions     :List of 3
#>  $ descriptions:List of 8
```

Each of these lists needs to be modified as shown next for the `ratings` list member.

### Modify the `ratings` list member


```{.r .numberLines}
# modify the ratings list
xds$ratings$NL <- array(dim = c(2,2,4,200,1))
xds$ratings$NL[1,,,,] <- infd_ds$ratings$NL
xds$ratings$NL[2,,,,] <- real_ds$ratings$NL

xds$ratings$LL <- array(dim = c(2,2,4,100,1))
xds$ratings$LL[1,,,,] <- infd_ds$ratings$LL
xds$ratings$LL[2,,,,] <- real_ds$ratings$LL
```


Since the desired crossed modality dataset has two modality-1 factors (inferred ROC and real ROC), two modality-2 treatments (the investigated image processing algorithms), 4 readers, 200 cases and a maximum of 1 mark per case (because it is ROC data) we initialize the array with `NA`s, see line 2, `xds$ratings$NL <- array(dim = c(2,2,4,200,1))`.  

Line 3, `xds$ratings$NL[1,,,,] <- infd_ds$ratings$NL`, copies the NL ratings from the inferred dataset `infd_ds` to `xds`. The index 1 refers to the modality-1 factor (inferred-ROC). 

Line 4, `xds$ratings$NL[2,,,,] <- real_ds$ratings$NL`, copies the NL ratings from the real dataset `real`_ds` to `xds`. The index 2 refers to the modality-2 factor (real-ROC). 

Lines 6-8 repeats the above steps for the LL events. In the initialization at line 6, `xds$ratings$LL <- array(dim = c(2,2,4,100,1))`, the 100 follows from the fact that the maximum number of diseased cases is 100 each with 1 true lesion per case.


### Modify the `lesions` list member


```{.r .numberLines}
# modify the lesions list
xds$lesions$perCase <- array(1,dim = c(100))
xds$lesions$IDs <- array(1,dim = c(100,1))
xds$lesions$weights <- array(1,dim = c(100,1))
```


The next three lines, 2-4, modify the lesions list. `xds$lesions$perCase` is set to an array of one-hundred  ones, as each diseased case has one lesion. Likewise for the `xds$lesions$IDs` and `xds$lesions$weights` (the redundant dimension is necessary for compatibility with other code in `RJafroc`).


### Modify the `descriptions` list member


```{.r .numberLines}
# modify the descriptions list
xds$descriptions$fileName <- "combined dataset04 & dataset14"
xds$descriptions$type <- "ROC"
xds$descriptions$name <- "FEDERICA-INFERRED-PLUS-REAL"
xds$descriptions$design <- "FCTRL-X-MOD"
xds$descriptions$modalityID1 <- c("infd", "real")
xds$descriptions$modalityID2 <- c("trt4", "trt5")
xds$descriptions$readerID <- c("rdr1","rdr2","rdr3","rdr4")
```


Lines 2-8 update the `descriptions` list. As examples, `xds$descriptions$type <- "ROC"` sets the `type` member to "ROC", `xds$descriptions$design <- "FCTRL-X-MOD"` sets the `design` member to "FCTRL-X-MOD", for factorial crossed modality, `xds$descriptions$modalityID1 <- c("infd", "real")` sets the two levels of the `modalityID1` member to `c("infd", "real")`, corresponding to inferred and real, respectively, `xds$descriptions$modalityID2 <- c("trt4", "trt5")` sets the two levels of the `modalityID2` member to `c("trt4", "trt5")`, corresponding to the two image processing algorithms and `xds$descriptions$readerID <- c("rdr1","rdr2","rdr3","rdr4")` sets the `readerID` member to the indicated labels.

This completes the merging of the two datasets, inferred ROC and real ROC, into a crossed modality dataset.

## Analysis of the crossed modality dataset

This is done as shown next.


```r
st <- StSignificanceTestingCrossedModalities(
  xds, 
  avgIndx = 2, 
  FOM <- "Wilcoxon", 
  analysisOption = "RRRC")
#> Averaging over modality index = 2
```


```r
st
#> $fomArray
#>          [,1]    [,2]     [,3]     [,4]
#> [1,] 0.871875 0.80225 0.779900 0.863900
#> [2,] 0.889025 0.86520 0.845075 0.863525
#> 
#> $msT
#> [1] 0.002624501
#> 
#> $msTR
#> [1] 0.000542624
#> 
#> $varComp
#>                  varCov
#> Var(R)     0.0005905767
#> Var(T*R)   0.0003041707
#> COV1       0.0003005249
#> COV2       0.0002561530
#> COV3       0.0002410342
#> Var(Error) 0.0005540970
#> 
#> $fRRRC
#> [1] 4.351692
#> 
#> $ddfRRRC
#> [1] 3.70596
#> 
#> $pRRRC
#> [1] 0.1108024
#> 
#> $ciDiffTrtRRRC
#>        Treatment  Estimate     StdErr      DF         t     PrGTt     CILower
#> 1 Row1_infd-real -0.036225 0.01736518 3.70596 -2.086071 0.1108024 -0.08598526
#>      CIUpper
#> 1 0.01353526
#> 
#> $ciAvgRdrEachTrtRRRC
#>   Treatment      Area     StdErr        DF   CILower   CIUpper
#> 1      infd 0.8294812 0.02710049  6.097804 0.7634257 0.8955368
#> 2      real 0.8657063 0.01934464 63.712979 0.8270575 0.9043550
```
