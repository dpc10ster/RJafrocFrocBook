# Optimal operating point {#optim-op-point}

---
output:
  rmarkdown::pdf_document:
    fig_caption: yes        
    includes:  
      in_header: R/learn/my_header.tex
---






## TBA How much finished {#optim-op-point-how-much-finished}
95%

Discussion needs more work


## Introduction {#optim-op-point-intro}

A familiar problem for the computer aided detection or artificial intelligence (CAD/AI) algorithm designer is how to determine the optimal reporting threshold of the algorithm. Assuming that designer level mark-rating FROC data is available for the algorithm, a decision needs to be made as to the optimal reporting threshold, i.e., the minimum rating of a mark before it is shown to the radiologist (or the next stage of the AI algorithm -- in what follows references to CAD apply equally to AI algorithms). 

The problem has been solved in the context of ROC analysis [@metz1978rocmethodology], namely, the optimal operating point on the ROC corresponds to a slope determined by disease prevalence and the cost of decisions in the four basic binary paradigm categories: true and false positives and true and false negatives. In practice the costs are difficult to quantify. However, for equal numbers of diseased and non-diseased cases and equal costs it can be shown that the slope of the ROC curve at the optimal point is unity. For a proper ROC curve this corresponds to the point that maximizes the Youden-index [@youden1950index]. Typically it is maximized at the point that is closest to the (0,1) corner of the ROC. 

Lacking a procedure for determining it analytically CAD designers, in consultation with radiologists, set site-specific reporting thresholds. For example, if radiologists at a site are comfortable with more false marks as the price of potentially greater lesion-level sensitivity, the reporting threshold for them is adjusted downward. 

This chapter describes an analytic method for finding the optimal reporting threshold. The method is based on maximizing AUC (area under curve) of the wAFROC curve. The method is compared to the Youden-index based method.   



## Methods {#optim-op-point-methods}

Terminology: 
Non-lesion localizations = NLs, i.e., location level "false positives".
Lesion localizations = LLs, i.e., location level "true positives".
Latent marks = perceived suspicious regions that are not necessarily marked.

Background on the radiological search model (RSM) is provided in Chapter \@ref(rsm). The model predicts ROC, FROC and wAFROC curves: these are completely defined by the four RSM parameters -- $\mu, \lambda, \nu, \zeta_1$ -- which have the following meanings:

* The $\mu$ parameter, $\mu \ge 0$, is the perceptual signal-to-noise-ratio of lesions. Higher values of $\mu$ lead to increased separation of two unit variance normal distributions determining the ratings of perceived NLs and LL. As $\mu$ increases performance of the algorithm increases.

* The $\lambda$ parameter, $\lambda \ge 0$, determines the mean number of latent NLs per case. Higher values lead to more latent NL marks per case and decreased performance. 

* The $\nu$ parameter, $0 \le \nu \le 1$, determines the probability of latent LLs, i.e., the probability that any present lesion will be perceived. Higher values of $\nu$ lead to more latent LL marks and increased performance.  

* The $\zeta_1$ parameter determines if a suspicious region found by the algorithm is actually marked: if the z-sample exceeds $\zeta_1$ the latent mark is actually marked. Higher values correspond to more stringent reporting criteria and fewer reported marks. Performance, as measured by wAFROC-AUC or the Youden-index, peaks at an optimal value of $\zeta_1$. The purpose of this chapter is to investigate this effect, i.e., given values of the other RSM parameters and the figure of merit to be optimized (i.e., wAFROC-AUC or the Youden-index), to determine the optimal value of $\zeta_1$.  


In the following sections each of the first three parameters is varied in turn and the corresponding optimal $\zeta_1$ determined by maximizing one of two figures of merit (FOMs), namely, the wAFROC-AUC and the Youden-index. The value maximizing wAFROC-AUC is denoted $\zeta_{1} \left ( 1, \mu, \lambda, \nu \right )$ and that maximizing the Youden-index is denoted $\zeta_{1} \left ( 2, \mu, \lambda, \nu \right )$. 


The wAFROC figure of merit is implemented in the `RJafroc` function `UtilAnalyticalAucsRSM`. It is calculated using Eqn. \@ref(eq:rsm-pred-wllf). 

The Youden-index is defined as sensitivity plus specificity minus 1. Sensitivity is implemented in function `RSM_yROC` and specificity is the complement of `RSM_xROC`. 


## Varying $\lambda$ optimizations{#optim-op-point-vary-lambda}

In the following $f = 1$ denotes wAFROC-AUC optimization and $f = 2$ denotes Youden-index optimization.





```r
muArr <- c(2)
lambdaPArr <- c(1, 2, 5, 10)
nuPArr <- c(0.9)
lesDistr <- c(0.5, 0.5)
relWeights <- c(0.5, 0.5)
```









For $\mu = 2$ and $\nu = 0.9$ both wAFROC-AUC and Youden-index optimizations were performed for $\lambda = 1, 2, 5, 10$. It is assumed that half of the diseased cases contain one lesion, the rest contain two lesions, and the lesions are assigned equal weights (i.e., equal clinical importance).



The following quantities were calculated:

1. $\zeta_{1} \left ( f, \mu, \lambda, \nu \right )$: the optimal thresholds;

1. $\text{wAFROC} \left (f, \mu, \lambda, \nu \right )$: the value of the wAFROC-AUC. For consistency we always report wAFROC-AUC even when the optimized quantity is the Youden-index;

1. $\text{ROC} \left (f, \mu, \lambda, \nu \right )$: the AUCs under the ROC curves; 

1. $\text{NLF} \left (f, \mu, \lambda, \nu \right )$ and $\text{LLF} \left (f, \mu, \lambda, \nu \right )$: the coordinates of the operating point on the FROC curve corresponding to $\zeta_{1} \left ( f, \mu, \lambda, \nu \right )$.   


### Summary table


Table \@ref(tab:optim-op-point-table-vary-lambda) summarizes the results. The column labeled FOM shows the quantity being maximized (wAFROC-AUC or the Youden-index), the column labeled $\lambda$ lists the 4 values of $\lambda$, $\zeta_1$ is the optimal value of $\zeta_1$ that maximizes the chosen figure of merit. The column labeled wAFROC is the AUC under the wAFROC curve, the column labeled ROC is the AUC under the ROC curve, and $\left( \text{NLF},  \text{LLF}\right)$ is the operating point on the FROC curve corresponding to the value of $\zeta_1$ in the third column. All quantities in columns 3 through 6 are functions of $f, \mu, \lambda, \nu$. 








<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:optim-op-point-table-vary-lambda)Summary of optimization results for $\mu = 2$, $\nu = 0.9$ and 4 values of $\lambda$. FOM = figure of merit. wAFROC = wAFROC-AUC, ROC = ROC-AUC, (NLF,LLF) = operating point on FROC.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> FOM </th>
   <th style="text-align:left;"> $\lambda$ </th>
   <th style="text-align:left;"> $\zeta_1$ </th>
   <th style="text-align:left;"> $\text{wAFROC}$ </th>
   <th style="text-align:left;"> $\text{ROC}$ </th>
   <th style="text-align:left;"> $\left( \text{NLF}, \text{LLF}\right)$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> wAFROC </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> -0.007 </td>
   <td style="text-align:left;"> 0.864 </td>
   <td style="text-align:left;"> 0.929 </td>
   <td style="text-align:left;"> (0.503, 0.880) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wAFROC </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 0.474 </td>
   <td style="text-align:left;"> 0.809 </td>
   <td style="text-align:left;"> 0.900 </td>
   <td style="text-align:left;"> (0.636, 0.843) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wAFROC </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1.272 </td>
   <td style="text-align:left;"> 0.715 </td>
   <td style="text-align:left;"> 0.840 </td>
   <td style="text-align:left;"> (0.509, 0.690) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wAFROC </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 1.856 </td>
   <td style="text-align:left;"> 0.645 </td>
   <td style="text-align:left;"> 0.774 </td>
   <td style="text-align:left;"> (0.317, 0.502) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Youden </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1.095 </td>
   <td style="text-align:left;"> 0.831 </td>
   <td style="text-align:left;"> 0.899 </td>
   <td style="text-align:left;"> (0.137, 0.735) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Youden </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1.362 </td>
   <td style="text-align:left;"> 0.781 </td>
   <td style="text-align:left;"> 0.865 </td>
   <td style="text-align:left;"> (0.173, 0.664) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Youden </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1.695 </td>
   <td style="text-align:left;"> 0.705 </td>
   <td style="text-align:left;"> 0.811 </td>
   <td style="text-align:left;"> (0.225, 0.558) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Youden </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 1.934 </td>
   <td style="text-align:left;"> 0.644 </td>
   <td style="text-align:left;"> 0.766 </td>
   <td style="text-align:left;"> (0.265, 0.474) </td>
  </tr>
</tbody>
</table>



Inspection of this table reveals the following effects:

1. For either FOM, as $\lambda$ increases the optimal threshold $\zeta_{1} \left ( f, \mu, \lambda, \nu \right )$ increases and $\text{wAFROC} \left ( f, \mu, \lambda, \nu \right )$, $\text{ROC} \left ( f, \mu, \lambda, \nu \right )$ and $\text{LLF} \left ( f, \mu, \lambda, \nu \right )$ decrease. Equivalently, CAD performance decreases, regardless of how it is measured (i.e., wAFROC-AUC or ROC-AUC). This is due to two reinforcing effects: performance goes down with increasing numbers of NLs per case and performance goes down with increasing optimal reporting threshold (see Section \@ref(rsm-pred-roc-curve-aucs-zeta1) for explanation of the $\zeta_1$ dependence of AUC performance). It is difficult to unambiguously infer performance based on the FROC operating points: as $\lambda$ increases LLF decreases but for $f = 1$ NLF peaks while for $f = 2$ it increases. 



1. The wAFROC based based optimal thresholds are smaller than the corresponding Youden-index based optimal thresholds, i.e., $\zeta_{1} \left ( 1, \mu, \lambda, \nu \right ) < \zeta_{1} \left ( 2, \mu, \lambda, \nu \right )$. A small threshold corresponds to a less strict reporting criterion.

1. For fixed $\mu, \lambda, \nu$ the operating point on the FROC for $f = 2$ is below that corresponding to $f = 1$:
    + $\text{NLF} \left (2, \mu, \lambda, \nu \right ) < \text{NLF} \left (1, \mu, \lambda, \nu \right )$ and $\text{LLF} \left (2, \mu, \lambda, \nu \right ) < \text{LLF} \left (1, \mu, \lambda, \nu \right )$. 
    + The difference decreases with increasing $\lambda$. 
    + These effects are illustrated in Fig. \@ref(fig:optim-op-point-vary-lambda-froc).

1. For fixed $\mu, \lambda, \nu$ the Youden-index based optimization yields lesser performance than the corresponding wAFROC-AUC based optimization:

    + $\text{wAFROC} \left (2, \mu, \lambda, \nu \right ) < \text{wAFROC} \left (1, \mu, \lambda, \nu \right )$ and $\text{ROC} \left (2, \mu, \lambda, \nu \right ) < \text{ROC} \left (1, \mu, \lambda, \nu \right )$. 
    + The difference decreases with increasing $\lambda$. 
    + These effects are illustrated in Fig. \@ref(fig:optim-op-point-vary-lambda-wafroc).



### FROC


The third effect is illustrated by the FROC plots with superimposed operating points for varying $\lambda$ shown in Fig. \@ref(fig:optim-op-point-vary-lambda-froc). The black dots correspond to $f = 1$ and the red dots correspond to $f = 2$. The black dots are consistently above the red dots and the separation of the dots is greatest for $\lambda = 1$ and smallest for $\lambda = 10$.  

The FROC plots also illustrate the decrease in $\text{LLF} \left ( f, \mu, \lambda, \nu \right )$ with increasing $\lambda$: the black dots move to smaller ordinates, as do the red dots, which would seem to imply decreasing performance. However, the accompanying change in $\text{NLF} \left ( f, \mu, \lambda, \nu \right )$ rules out an unambiguous determination of the direction of the change in overall performance based on the FROC. 

 





<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-vary-lambda-froc-1.png" alt="FROC plots with superimposed operating points for varying $\lambda$. The black dot corresponds to wAFROC AUC optimization and the red dot to Youden-index optimization." width="672" />
<p class="caption">(\#fig:optim-op-point-vary-lambda-froc)FROC plots with superimposed operating points for varying $\lambda$. The black dot corresponds to wAFROC AUC optimization and the red dot to Youden-index optimization.</p>
</div>



### wAFROC







The decrease in $\text{wAFROC} \left ( f, \mu, \lambda, \nu \right )$ with increasing $\lambda$ (contained in the first effect) is illustrated in Fig. \@ref(fig:optim-op-point-vary-lambda-wafroc) which shows wAFROC plots for the two optimization methods. Each plot consists of a continuous curve followed by a dashed line. The red curve, which appears as a "green red red-dashed" curve ^[The curve for $f = 1$ is in fact a red curve, complicated by superposition of the green curve over part of its traverse.] corresponds to wAFROC-AUC optimization $f = 1$ and the green green-dashed curve corresponds to Youden-index optimization $f = 2$. 

The transition from continuous to dashed is determined by the value of $\zeta_1$. The transition occurs at a higher value of $\zeta_1$ for the Youden-index optimization. The stricter Youden-index based reporting threshold sacrifices some of the area under the wAFROC. This results in lower performance particularly for the lower values of $\lambda$. At the highest value of $\lambda$ the values of optimal $\zeta_1$ are similar and both methods make similar predictions, as evident in Fig. \@ref(fig:optim-op-point-vary-lambda-wafroc).




<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-vary-lambda-wafroc-1.png" alt="wAFROC plots for the two optimization methods: the green red red-dashed curve curve corresponds to wAFROC-AUC optimization and the green green-dashed curve corresponds to Youden-index optimization. For all except the highest value of $\lambda$ the wAFROC optimizations yield greater performance than do the Youden-index based optimizations." width="672" />
<p class="caption">(\#fig:optim-op-point-vary-lambda-wafroc)wAFROC plots for the two optimization methods: the green red red-dashed curve curve corresponds to wAFROC-AUC optimization and the green green-dashed curve corresponds to Youden-index optimization. For all except the highest value of $\lambda$ the wAFROC optimizations yield greater performance than do the Youden-index based optimizations.</p>
</div>




### ROC






The decrease in $\text{ROC} \left ( f, \mu, \lambda, \nu \right )$ with increasing $\lambda$ (also contained in the first effect) is illustrated in Fig. \@ref(fig:optim-op-point-vary-lambda-roc) which shows RSM-predicted ROC plots for the two optimization methods. Again, each plot consists of a continuous curve followed by a dashed curve and a similar color-coding convention is used as in Fig. \@ref(fig:optim-op-point-vary-lambda-wafroc). The ROC plots show similar dependencies as described for the wAFROC plots: specifically, the stricter Youden-index based reporting threshold sacrifices some of the area under the ROC resulting in lower performance, particularly for the lower values of $\lambda$. 



<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-vary-lambda-roc-1.png" alt="ROC plots for the two optimization methods: the green-red-red-dashed curve corresponds to wAFROC-AUC optimization and the green-green curve corresponds to Youden-index optimization." width="672" />
<p class="caption">(\#fig:optim-op-point-vary-lambda-roc)ROC plots for the two optimization methods: the green-red-red-dashed curve corresponds to wAFROC-AUC optimization and the green-green curve corresponds to Youden-index optimization.</p>
</div>


### Comment

Since the ROC curves show a similar dependence as the wAFROC curves why not maximize the AUC under the ROC, instead of AUC under the wAFROC? It can be [shown](https://dpc10ster.github.io/RJafrocRocBook/binormal-model.html#binormal-model-partial-true) that as long as one restricts to proper ROC models, this will always result in $\zeta_1 = -\infty$. 

For a proper ROC curve the slope decreases monotonically as the operating point moves up the curve and at each point the slope is greater than that of the straight curve connecting the point to (1,1). This geometry ensures that AUC under any curve with a finite $\zeta_1$ is smaller than that under the full curve. Therefore maximum AUC can only be attained by choosing $\zeta_1 = -\infty$. This is illustrated in Fig. \@ref(fig:binormal-model-threshold-dependence-2) which shows a binormal ROC curve corresponding to $a = 2$ and $b = 1$, which is a proper ROC curve. The dot is the operating point corresponding to $\zeta_1 = 1.5$. In the region above the dot the continuous curve is above the dotted line, meaning AUC performance of an observer who adopts a finite $\zeta_1$ is less than performance of an observer who rates all cases, i.e., adopts $\zeta_1 = -\infty$.






<div class="figure">
<img src="21-optim-op-point_files/figure-html/binormal-model-threshold-dependence-2-1.png" alt="In the region above the dot the proper curve is above the dotted line, meaning performance of an observer who adopts a finite $\zeta_1$ is less than performance of an observer who adopts $\zeta_1 = -\infty$." width="672" />
<p class="caption">(\#fig:binormal-model-threshold-dependence-2)In the region above the dot the proper curve is above the dotted line, meaning performance of an observer who adopts a finite $\zeta_1$ is less than performance of an observer who adopts $\zeta_1 = -\infty$.</p>
</div>





## Varying $\nu$ and $\mu$ optimizations{#optim-op-point-vary-nu-mu}

Details of varying $\nu$ are in Appendix \@ref(optim-op-point-vary-nu). The results are similar to those just described for varying $\lambda$ but, since increasing $\nu$ results in *increasing* performance, the directions of the effects are *reversed*. As $\nu$ increases wAFROC-AUC and ROC-AUC performances increase and the reporting threshold $\zeta_1$ decreases. The Youden-index based optimal threshold is almost independent of $\nu$ and NLF is relatively constant while LLF increases. Examination of the plots confirms that FPF and NLF are relatively constant for Youden-index optimization. As before, wAFROC optimization yields lower reporting threshold and higher performance than Youden-index optimization and the difference between the two methods decreases as performance decreases. 

Details of varying $\mu$ are in Appendix \@ref(optim-op-point-vary-mu). Increasing $\mu$ results in increasing performance and is accompanied by increasing $\zeta_1$, and this time LLF is relatively constant while NLF decreases for both optimization methods. These findings are evident in the cited table and figures. wAFROC optimization yields lower reporting threshold and higher performance than Youden-index optimization. In this example the difference in wAFROC-AUC, ROC-AUC and the operating points between the two methods decreases as performance *increases*, which is the opposite of that found when $\lambda$ or $\nu$ were varied. With constant $\lambda$ and $\nu$ the *numbers* of NLs and LLs are unchanging; all that happens is the *values* of the z-samples from LLs increase as $\mu$ increases, which allows the optimal threshold to increase (this can be understood as a pure "ROC-type" effect: as the normal distributions are more widely separated, the optimal threshold will increase, approaching, in the limit, half the separation, since in that limit TPF = 1 and FPF = 0).


Limiting situations covering very high and very low performances when $\mu$, $\lambda$ and $\nu$ are varied individually, are described in Appendix \@ref(optim-op-point-limiting-situations). 

For very high performance, defined as $\text{ROC-AUC} > 0.9$, both methods place the optimal operating point on the sharp bend near the upper-left corner of all operating characteristics. The wAFROC based method chooses a somewhat lower threshold than the Youden-index method resulting in a higher operating point on the FROC. 

For very low performance, defined as $0.5 < \text{ROC-AUC} < 0.6$, the Youden-index method chooses a lower threshold compared to wAFROC optimization, resulting in a higher operating point on the FROC, greater ROC-AUC but sharply lower wAFROC-AUC. In this limit the wAFROC method severly limits the numbers of marks shown to the radiologist as compared to the Youden-index based method.  



## Using the method {#optim-op-point-how-to-use-method}
Assume that one has designed an algorithmic observer that has been optimized with respect to all other parameters except the reporting threshold. At this point the algorithm reports every suspicious region, no matter how low the malignancy index. The mark-rating pairs are entered into a `RJafroc` format Excel input file, as describe [here](https://dpc10ster.github.io/RJafrocQuickStart/quick-start-froc-data-format.html). The next step is to read the data file -- `DfReadDataFile()` -- convert it to an ROC dataset -- `DfFroc2Roc()` -- and then perform a radiological search model (RSM) fit to the dataset using function `FitRsmRoc()`. This yields the necessary $\lambda, \mu, \nu$ parameters. These values are used to perform the computations described in this chapter to determine the optimal reporting threshold. The RSM parameter values and the reporting threshold determine the optimal reporting point on the FROC curve. The designer sets the algorithm to only report marks with confidence levels exceeding this threshold. 




## A CAD application {#optim-op-point-application}

The standalone CAD LROC dataset described in [@hupse2013standalone] was used to create the quasi-FROC ROC-AUC equivalent dataset embedded in `RJafroc` as object `datasetCadSimuFroc`. In the following code the first reader for this dataset, corresponding to CAD, is extracted using `DfExtractDataset` (the other reader data, corresponding to radiologists who interpreted the same cases, are not used here). The function `DfFroc2Roc` converts this to an ROC dataset. The function `DfBinDataset` bins the data to about 7 bins. Each diseased case contains one lesion: `lesDistr = c(1)`. `FitRsmRoc` fits the binned ROC dataset to the radiological search model (RSM). Object `fit` contains the RSM parameters required to perform the optimizations described in previous sections.  


```r
ds <- datasetCadSimuFroc
dsCad <- DfExtractDataset(ds, rdrs = 1)
dsCadRoc <- DfFroc2Roc(dsCad)
dsCadRocBinned <- DfBinDataset(dsCadRoc, opChType = "ROC")
lesDistrCad <- c(1)
relWeightsCad <- c(1)
fit <- FitRsmRoc(dsCadRocBinned, lesDistrCad)
cat("fitted values: \nmu = ", fit$mu, 
    "\nlambda = ", fit$lambdaP, 
    "\nnu = ", fit$nuP, "\n")
#> fitted values: 
#> mu =  2.755784 
#> lambda =  6.778332 
#> nu =  0.8033886
```








### Summary table

Table \@ref(tab:optim-op-point-table4) summarizes the results. As compared to Youden-index optimization the wAFROC-AUC based optimization results in a lower reporting threshold $\zeta_1$, larger figures of merit -- see Fig. \@ref(fig:optim-op-point-application-wafroc) for wAFROC-AUC and Fig. \@ref(fig:optim-op-point-application-roc) for ROC-AUC -- and a higher operating point on the FROC, see Fig. \@ref(fig:optim-op-point-application-froc). These results match the trends shown in Table \@ref(tab:optim-op-point-table-vary-lambda).  





<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:optim-op-point-table4)Summary of optimization results for example CAD FROC dataset. Table header row as in the previous table.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> FOM </th>
   <th style="text-align:left;"> $\lambda$ </th>
   <th style="text-align:left;"> $\zeta_1$ </th>
   <th style="text-align:left;"> $\text{wAFROC}$ </th>
   <th style="text-align:left;"> $\text{ROC}$ </th>
   <th style="text-align:left;"> $\left( \text{NLF}, \text{LLF}\right)$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> wAFROC </td>
   <td style="text-align:left;"> 6.778 </td>
   <td style="text-align:left;"> 1.739 </td>
   <td style="text-align:left;"> 0.774 </td>
   <td style="text-align:left;"> 0.815 </td>
   <td style="text-align:left;"> (0.278, 0.679) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Youden </td>
   <td style="text-align:left;"> 6.778 </td>
   <td style="text-align:left;"> 1.982 </td>
   <td style="text-align:left;"> 0.770 </td>
   <td style="text-align:left;"> 0.798 </td>
   <td style="text-align:left;"> (0.161, 0.627) </td>
  </tr>
</tbody>
</table>




### FROC





Fig. \@ref(fig:optim-op-point-application-froc) shows FROC curves with superimposed optimal operating points. With NLF = 0.278, a four-view mammogram would show about 1.2 false CAD marks per patient and lesion-level sensitivity would be about 68 percent.


<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-application-froc-1.png" alt="FROC plots with superposed optimal operating points. Black dot is using wAFROC optimization and red dot is using Youden-index optimization." width="672" />
<p class="caption">(\#fig:optim-op-point-application-froc)FROC plots with superposed optimal operating points. Black dot is using wAFROC optimization and red dot is using Youden-index optimization.</p>
</div>


### wAFROC





Fig. \@ref(fig:optim-op-point-application-wafroc) shows wAFROC curves using the two methods. The red curve is using wAFROC-AUC optimization and the green curve is using Youden-index optimization. The difference in AUCs is small - following the trend described in Section \@ref(optim-op-point-vary-nu-mu) for the larger values of $\lambda$.


<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-application-wafroc-1.png" alt="The color coding is as in previous figures. The two wAFROC-AUCs are 0.774 (wAFROC optimization) and 0.770 (Youden-index optimization)." width="672" />
<p class="caption">(\#fig:optim-op-point-application-wafroc)The color coding is as in previous figures. The two wAFROC-AUCs are 0.774 (wAFROC optimization) and 0.770 (Youden-index optimization).</p>
</div>



### ROC





Fig. \@ref(fig:optim-op-point-application-roc) shows ROC curves using the two methods. The red curve is using wAFROC-AUC optimization and the green curve is using Youden-index optimization. The difference in AUCs is larger, but recall that ROC-AUC performance is not being optimized.


<div class="figure">
<img src="21-optim-op-point_files/figure-html/optim-op-point-application-roc-1.png" alt="The color coding is as in previous figures. The two ROC-AUCs are 0.815 (wAFROC-AUC optimization) and 0.798 (Youden-index optimization)." width="672" />
<p class="caption">(\#fig:optim-op-point-application-roc)The color coding is as in previous figures. The two ROC-AUCs are 0.815 (wAFROC-AUC optimization) and 0.798 (Youden-index optimization).</p>
</div>


## TBA Discussion {#optim-op-point-discussion}

In Table \@ref(tab:optim-op-point-table-vary-lambda) the $\lambda$ parameter controls the average number of perceived NLs per case. For $\lambda = 1$ there is, on average, one perceived NL for every non-diseased case and the optimal wAFROC-based threshold is TBA $\zeta_{1;1,\mu, \lambda = 1, \nu}$ = -0.007. For $\lambda = 10$ there are ten perceived NLs for every non-diseased case and the optimal wAFROC-based threshold is $\zeta_{1;1,\mu, \lambda = 10, \nu}$ = -0.007. The increase in $\zeta_1$ should make sense to CAD algorithm designers: with increasing numbers of NLs per case it is necessary to increase the reporting threshold (i.e., adopt a stricter criteria) if only because otherwise the reader would be subjected to 10 times the number of NLs/case for the same number of LLs/case. 


The ROC-AUCs are reported as a check of the less familiar wAFROC-AUC figure of merit. The ordering of the two optimization methods is independent of whether it is measured via the wAFROC-AUC or the ROC-AUC: either way the wAFROC-AUC optimizations yield higher AUC values and higher operating points on the FROC than the corresponding Youden-index optimizations.   


## References {#optim-op-point-references}
