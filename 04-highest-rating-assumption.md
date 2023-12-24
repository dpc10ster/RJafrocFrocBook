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
xds <- datasetX
```

Line 2, `ds <- dataset04`, is the Federica Zanca 5 modality, 4 reader, 200 case FROC dataset.

Line 6 converts this to an **inferred** ROC dataset `infd_ds` containing treatments 4 and 5 only.

Line 10, `real_ds <- dataset14` is the Federica Zanca 2 modality, 4 reader, 200 case **real** ROC dataset. The two modalities correspond to treatments 4 and 5 in the FROC dataset `dataset04`.

Line 15 assigns a pre-loaded **crossed** modality dataset `xds <- datasetX` which serves as a template to be modified to meet our needs. 

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
st <- St(
  xds, 
  FOM <- "Wilcoxon", 
  analysisOption = "RRRC")
```


```r
st
#> $FOMs
#> $FOMs$foms
#> $FOMs$foms$AvgMod1
#>          rdrrdr1  rdrrdr2  rdrrdr3  rdrrdr4
#> trttrt4 0.903125 0.848875 0.825100 0.879300
#> trttrt5 0.857775 0.818575 0.799875 0.848125
#> 
#> $FOMs$foms$AvgMod2
#>          rdrrdr1 rdrrdr2  rdrrdr3  rdrrdr4
#> trtinfd 0.871875 0.80225 0.779900 0.863900
#> trtreal 0.889025 0.86520 0.845075 0.863525
#> 
#> 
#> $FOMs$trtMeans
#> $FOMs$trtMeans$AvgMod1
#>          Estimate
#> trttrt4 0.8641000
#> trttrt5 0.8310875
#> 
#> $FOMs$trtMeans$AvgMod2
#>          Estimate
#> trtinfd 0.8294812
#> trtreal 0.8657063
#> 
#> 
#> $FOMs$trtMeanDiffs
#> $FOMs$trtMeanDiffs$AvgMod1
#>                  Estimate
#> trttrt4-trttrt5 0.0330125
#> 
#> $FOMs$trtMeanDiffs$AvgMod2
#>                  Estimate
#> trtinfd-trtreal -0.036225
#> 
#> 
#> 
#> $ANOVA
#> $ANOVA$TRanova
#> $ANOVA$TRanova$AvgMod1
#>            SS DF           MS
#> T  0.00217965  1 2.179650e-03
#> R  0.00217965  3 1.842759e-03
#> TR 0.00217965  3 3.726552e-05
#> 
#> $ANOVA$TRanova$AvgMod2
#>             SS DF          MS
#> T  0.005528277  1 0.002624501
#> R  0.005528277  3 0.001842759
#> TR 0.005528277  3 0.000542624
#> 
#> 
#> $ANOVA$VarCom
#> $ANOVA$VarCom$AvgMod1
#>           Estimates      Rhos
#> VarR   0.0008321326        NA
#> VarTR -0.0001789411        NA
#> Cov1   0.0003146504 0.5827166
#> Cov2   0.0002531509 0.4688227
#> Cov3   0.0002440363 0.4519429
#> Var    0.0005399715        NA
#> 
#> $ANOVA$VarCom$AvgMod2
#>          Estimates      Rhos
#> VarR  0.0005905767        NA
#> VarTR 0.0003041707        NA
#> Cov1  0.0003005249 0.5423688
#> Cov2  0.0002561530 0.4622891
#> Cov3  0.0002410342 0.4350036
#> Var   0.0005540970        NA
#> 
#> 
#> $ANOVA$IndividualTrt
#> $ANOVA$IndividualTrt$AvgMod1
#>         DF  msREachTrt   varEachTrt  cov2EachTrt
#> trttrt4  3 0.001168930 0.0005165784 0.0002390223
#> trttrt5  3 0.000711094 0.0005633647 0.0002672795
#> 
#> $ANOVA$IndividualTrt$AvgMod2
#>         DF   msREachTrt   varEachTrt  cov2EachTrt
#> trtinfd  3 0.0020605739 0.0005708085 0.0002192931
#> trtreal  3 0.0003248089 0.0005373855 0.0002930128
#> 
#> 
#> $ANOVA$IndividualRdr
#> $ANOVA$IndividualRdr$AvgMod1
#>         DF   msTEachRdr   varEachRdr  cov1EachRdr
#> rdrrdr1  1 0.0010283113 0.0004861758 0.0003203932
#> rdrrdr2  1 0.0004590450 0.0005679882 0.0003195145
#> rdrrdr3  1 0.0003181503 0.0006937098 0.0003582329
#> rdrrdr4  1 0.0004859403 0.0004120123 0.0002604610
#> 
#> $ANOVA$IndividualRdr$AvgMod2
#>         DF   msTEachRdr   varEachRdr  cov1EachRdr
#> rdrrdr1  1 1.470612e-04 0.0004777946 0.0003287743
#> rdrrdr2  1 1.981351e-03 0.0005660321 0.0003214706
#> rdrrdr3  1 2.123890e-03 0.0006664924 0.0003854503
#> rdrrdr4  1 7.031250e-08 0.0005060688 0.0001664044
#> 
#> 
#> 
#> $RRRC
#> $RRRC$FTests
#> $RRRC$FTests$AvgMod1
#>                 DF           MS    FStat            p
#> Treatment  1.00000 2.179650e-03 29.56509 0.0001627221
#> Error     11.74146 7.372378e-05       NA           NA
#> 
#> $RRRC$FTests$AvgMod2
#>                DF           MS    FStat         p
#> Treatment 1.00000 0.0026245013 4.351692 0.1108024
#> Error     3.70596 0.0006030991       NA        NA
#> 
#> 
#> $RRRC$ciDiffTrt
#> $RRRC$ciDiffTrt$AvgMod1
#>                  Estimate      StdErr       DF        t        PrGTt    CILower
#> trttrt4-trttrt5 0.0330125 0.006071399 11.74146 5.437379 0.0001627221 0.01975168
#>                    CIUpper
#> trttrt4-trttrt5 0.04627332
#> 
#> $RRRC$ciDiffTrt$AvgMod2
#>                  Estimate     StdErr      DF         t     PrGTt     CILower
#> trtinfd-trtreal -0.036225 0.01736518 3.70596 -2.086071 0.1108024 -0.08598526
#>                    CIUpper
#> trtinfd-trtreal 0.01353526
#> 
#> 
#> $RRRC$ciAvgRdrEachTrt
#> $RRRC$ciAvgRdrEachTrt$AvgMod1
#>          Estimate     StdErr        DF   CILower   CIUpper         Cov2
#> trttrt4 0.8641000 0.02304897  9.914476 0.8126836 0.9155164 0.0002390223
#> trttrt5 0.8310875 0.02109628 18.802288 0.7869010 0.8752740 0.0002672795
#> 
#> $RRRC$ciAvgRdrEachTrt$AvgMod2
#>          Estimate     StdErr        DF   CILower   CIUpper         Cov2
#> trtinfd 0.8294812 0.02710049  6.097804 0.7634257 0.8955368 0.0002192931
#> trtreal 0.8657063 0.01934464 63.712979 0.8270575 0.9043550 0.0002930128
```
