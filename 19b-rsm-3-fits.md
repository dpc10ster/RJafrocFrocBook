# Three proper ROC fits {#rsm-3-fits}





## TBA How much finished {#rsm-3-fits-how-much-finished}
75%


## Introduction {#rsm-3-fits-intro}
A proper ROC curve is one whose slope decreases monotonically as the operating point moves up the curve, a consequence of which is that a proper ROC does not display an inappropriate chance line crossing followed by a sharp upward turn, i.e., a "hook", usually near the (1,1) upper right corner. 

There are three methods for fitting proper curves to ROC datasets: 

* The radiological search model (RSM) described in Chapter \@ref(rsm-fitting), 
* The PROPROC (proper ROC) and CBM (contaminated binormal model) described in TBA Chapter 20. 

This chapter compares these methods for a number of datasets. Comparing the RSM to the binormal model would be inappropriate, as the latter does not predict proper ROCs.

* Both RSM and CBM are implemented in `RJafroc`. 
* `PROPROC` is implemented in Windows software ^[OR DBM-MRMC 2.5, Sept. 04, 2014; this version, used in this chapter, is no longer distributed but is available from me upon request.] available [here](https://perception.lab.uiowa.edu/OR-DBM-MRMC-252), last accessed 1/4/21.


## Applications {#rsm-3-fits-applications}

The RSM, PROPROC and CBM algorithms were applied to the 14 embedded datasets described in \@ref(rsm-3-fits-14-datasets). The datasets have already been analyzed and the location of pre-analyzed results files are in \@ref(rsm-3-fits-pre-analyzed-results).



```r
datasetNames <-  c("TONY", "VD", "FR", 
            "FED", "JT", "MAG", 
            "OPT", "PEN", "NICO",
            "RUS", "DOB1", "DOB2", 
            "DOB3", "FZR")
```


In the following we focus on just two ROC datasets, which have been widely used in the literature to illustrate ROC methodological advances, namely the Van Dyke (VD) and the Franken (FR) datasets.


### Application to two datasets {#rsm-3-fits-two-datasets}

* The code uses the function `Compare3ProperRocFits()`. 
* The code file is `R/compare-3-fits/Compare3ProperRocFits.R`. 
* `startIndx` is the  first `index` to analyze and `endIndx` is the last. 
* In the current example `startIndx = 2` and `endIndx = 3`; i.e., two datasets are analyzed corresponding to `datasetNames[2]` and `datasetNames[3]`, i.e., the VD and FR datasets. ^[To analyze all datasets one sets `startIndx <-  1` and `endIndx <-  14`.] 
* `reAnalyze` is set to `FALSE` causing pre-analyzed results (to be found in directory `R/compare-3-fits/RSM6`) to be retrieved. If `reAnalyze` is `TRUE` the analysis is repeated, leading to possibly slightly different results (the maximum likelihood parameter-search algorithm has inherent randomness aimed at avoiding finding false local maxima). 
* The fitted parameter results are contained in `ret$allResults` and the *composite plots* (i.e., 3 combined plots corresponding to the three proper ROC fitting algorithms) are contained in `ret$allPlots`. 
* These are saved to lists `plotArr` and `resultsArr`. 






```r
startIndx <-  2
endIndx <- 3
ret <- Compare3ProperRocFits(datasetNames,
                             startIndx = startIndx, 
                             endIndx = endIndx, 
                             reAnalyze = FALSE)

resultsArr <- plotArr <- array(list(), 
                               dim = c(endIndx - startIndx + 1))

for (f in 1:(endIndx-startIndx+1)) {
  plotArr[[f]] <- ret$allPlots[[f]]
  resultsArr[[f]] <- ret$allResults[[f]]
}
```


We show next how to display the composite plots.


## Displaying composite plots {#rsm-3-fits-composite-plots}

* The `plotArr` list contains plots for the two datasets. The Van Dyke plots are in `plotArr[[1]]` and the Franken in `plotArr[[2]]`. 
* The Van Dyke plots contain $I \times J = 2 \times 5 = 10$ composite plots, and similarly for the Franken dataset (both datasets consist of 2 treatments and 5 readers). 
* The following shows how to display the composite plot for the Van Dyke dataset for treatment 1 and reader 2. 



```r
plotArr[[1]][[1,2]]
```

<img src="19b-rsm-3-fits_files/figure-html/unnamed-chunk-2-1.png" width="672" />


The plot is labeled **D2, i = 1, j = 2**, meaning the second dataset, the first treatment and the second reader. It contains 3 curves:

* The RSM fitted curve is in black. It is the only one with a dotted line connecting the uppermost continuously accessible operating point to (1,1).
* The PROPROC fitted curve is in red. 
* The CBM fitted curve is in blue. 
* Three operating points from the binned data are shown as well as exact 95% confidence intervals for the lowest and uppermost operating points. 

The following example displays the composite plots for the Franken dataset, treatment 2 and reader 3:


```r
plotArr[[2]][[2,3]]
```

<img src="19b-rsm-3-fits_files/figure-html/unnamed-chunk-3-1.png" width="672" />


Shown next is how to display the parameters corresponding to the fitted curves.


## Displaying RSM parameters {#rsm-3-fits-rsm-parameters}

The RSM has parameters: $\mu$, $\lambda'$, $\nu'$ and $\zeta_1$. The parameters corresponding to the RSM plots are accessed as shown next. 

* `resultsArr[[1]][[2]]$retRsm$mu` is the RSM $\mu$ parameter for dataset 1 (i.e., Van Dyke dataset), treatment 1 and reader 2, 
* `resultsArr[[1]][[2]]$retRsm$lambdaP` is the corresponding $\lambda'$ parameter, and  
* `resultsArr[[1]][[2]]$retRsm$nuP` is the corresponding $\nu'$ parameter. 
* `resultsArr[[1]][[2]]$retRsm$zeta1` is the corresponding $\zeta_1$ parameter. 
* Treatment 2 and reader 1 values would be accessed as 
`resultsArr[[1]][[6]]$retRsm$mu`, etc.
* More generally the values are accessed as `[[f]][[(i-1)*J+j]]`, where `f` is the dataset index, `i` is the treatment index, `j` is the reader index and `J` is the total number of readers. 
* For the Van Dyke dataset `f = 1` and for the Franken dataset `f = 2`.

The first example displays RSM parameters for the Van Dyke dataset, treatment 1 and reader 2:



```r
f <- 1;i <- 1; j <- 2;J <- 5
cat("RSM parameters, Van Dyke Dataset, treatment 1, reader 2:",
"\nmu = ",        resultsArr[[f]][[(i-1)*J+j]]$retRsm$mu,
"\nlambdaP = ",   resultsArr[[f]][[(i-1)*J+j]]$retRsm$lambdaP,
"\nnuP = ",       resultsArr[[f]][[(i-1)*J+j]]$retRsm$nuP,
"\nzeta_1 = ",    as.numeric(resultsArr[[f]][[(i-1)*J+j]]$retRsm$zetas[1]),
"\nAUC = ",       resultsArr[[f]][[(i-1)*J+j]]$retRsm$AUC,
"\nsigma_AUC = ", as.numeric(resultsArr[[f]][[(i-1)*J+j]]$retRsm$StdAUC),
"\nNLLini = ",    resultsArr[[f]][[(i-1)*J+j]]$retRsm$NLLIni,
"\nNLLfin = ",    resultsArr[[f]][[(i-1)*J+j]]$retRsm$NLLFin)
```

```
## RSM parameters, Van Dyke Dataset, treatment 1, reader 2: 
## mu =  2.201413 
## lambdaP =  0.2569453 
## nuP =  0.7524016 
## zeta_1 =  -0.1097901 
## AUC =  0.8653694 
## sigma_AUC =  0.04740562 
## NLLini =  96.48516 
## NLLfin =  85.86244
```


The next example displays RSM parameters for the Franken dataset, treatment 2 and reader 3:



```r
f <- 2;i <- 2; j <- 3;J <- 5
```




```
## RSM parameters, Franken dataset, treatment 2, reader 3: 
## mu =  3.287996 
## lambdaP =  9.371198 
## nuP =  0.7186006 
## zeta_1 =  1.646943 
## AUC =  0.8234519 
## sigma_AUC =  0.04054005 
## NLLini =  128.91 
## NLLfin =  122.4996
```


The first four values are the fitted values for the RSM parameters $\mu$, $\lambda'$, $\nu'$ and $\zeta_1$. The next value is the AUC under the fitted RSM curve followed by its standard error. The last two values are the initial and final values of negative log-likelihood ^[The initial value is calculated using initial estimates of parameters and the final value is that resulting from the log-likelihood maximization procedure. Since negative log-likelihood is being *minimized*, the final value is smaller than the initial value.].  


## Displaying CBM parameters {#rsm-3-fits-cbm-parameters}

CBM has parameters $\mu_{CBM}$, $\alpha$ and $\zeta_1$. The next example displays CBM parameters and AUC etc. for the Van Dyke dataset, treatment 1 and reader 2:



```r
f <- 1;i <- 1; j <- 2;J <- 5
cat("CBM parameters, Van Dyke Dataset, treatment 1, reader 2:",
"\nmu = ",         resultsArr[[f]][[(i-1)*J+j]]$retCbm$mu,
"\nalpha = ",      resultsArr[[f]][[(i-1)*J+j]]$retCbm$alpha,
"\nzeta_1 = ",     as.numeric(resultsArr[[f]][[(i-1)*J+j]]$retCbm$zetas[1]),
"\nAUC = ",        resultsArr[[f]][[(i-1)*J+j]]$retCbm$AUC,
"\nsigma_AUC = ",  as.numeric(resultsArr[[f]][[(i-1)*J+j]]$retCbm$StdAUC),
"\nNLLini = ",     resultsArr[[f]][[(i-1)*J+j]]$retCbm$NLLIni,
"\nNLLfin = ",     resultsArr[[f]][[(i-1)*J+j]]$retCbm$NLLFin)
```

```
## CBM parameters, Van Dyke Dataset, treatment 1, reader 2: 
## mu =  2.745791 
## alpha =  0.7931264 
## zeta_1 =  1.125028 
## AUC =  0.8758668 
## sigma_AUC =  0.03964492 
## NLLini =  86.23289 
## NLLfin =  85.88459
```


The next example displays CBM parameters for the Franken dataset, treatment 2 and reader 3:



```r
f <- 2;i <- 2; j <- 3;J <- 5
```



```
## CBM parameters, Franken dataset, treatment 2, reader 3: 
## mu =  2.533668 
## alpha =  0.6892561 
## zeta_1 =  0.3097191 
## AUC =  0.8194009 
## sigma_AUC =  0.03968962 
## NLLini =  122.6812 
## NLLfin =  122.5604
```


The first three values are the fitted values for the CBM parameters $\mu$, $\alpha$ and $\zeta_1$. The next value is the AUC under the fitted CBM curve followed by its standard error. The last two values are the initial and final values of negative log-likelihood.  


## Displaying PROPROC parameters {#rsm-3-fits-proproc-parameters}

`PROPROC` displayed parameters are $c$ and $d_a$. The next example displays PROPROC parameters for the Van Dyke dataset, treatment 1 and reader 2:



```r
f <- 1;i <- 1; j <- 2;J <- 5
cat("PROPROC parameters, Van Dyke Dataset, treatment 1, reader 2:",
"\nc = ",     resultsArr[[f]][[(i-1)*J+j]]$c1,
"\nd_a = ",   resultsArr[[f]][[(i-1)*J+j]]$da,
"\nAUC = ",   resultsArr[[f]][[(i-1)*J+j]]$aucProp)
```

```
## PROPROC parameters, Van Dyke Dataset, treatment 1, reader 2: 
## c =  -0.2809004 
## d_a =  1.731472 
## AUC =  0.8910714
```


The values are identical to those listed for treatment 1 and reader 2 in Fig. \@ref(fig:rsm-3-fits-proproc-output-van-dyke). Other statistics, such as standard error of AUC, are not provided by PROPROC software.

The next example displays PROPROC parameters for the Franken dataset, treatment 2 and reader 3:



```r
f <- 2;i <- 2; j <- 3;J <- 5
```



```
## PROPROC parameters, Franken dataset, treatment 2, reader 3: 
## c =  -0.4420007 
## d_a =  0.9836615 
## AUC =  0.8252824
```


All 10 composite plots for the Van Dyke dataset are shown in the Appendix to this chapter,  \@ref(rsm-3-fits-representative-plots-van-dyke).


The next section provides an overview of the most salient findings from analyzing the datasets.


## Overview of findings {#rsm-3-fits-overview}

With 14 datasets the total number of individual modality-reader combinations is 236: in other words, there are 236 datasets to each of which three algorithms were applied. It is easy to be overwhelmed by the numbers and this section summarizes the most important conclusion: *for each dataset, treatment and reader, the three fitting methods are consistent with a single method-independent AUC*.


If the AUCs of the three methods are identical the following relations hold with slopes equal to unity: 


\begin{equation}
\left. 
\begin{aligned}
AUC_{PRO} =& m_{PR} AUC_{PRO}  \\
AUC_{CBM} =& m_{CR} AUC_{PRO} \\
m_{PR}    =& 1 \\
m_{CR}    =& 1
\end{aligned}
\right \}
(\#eq:rsm-3-fits-slopes-equation1)
\end{equation}

The abbreviations are as follows: 

* PRO = PROPROC 
* PR = PROPROC vs. RSM 
* CR = CBM vs. RSM. 

For each dataset the plot of PROPROC AUC vs. RSM AUC should be linear with zero intercept and slope $m_{PR}$. The reason for the *zero intercept* is that if one of the AUCs indicates zero performance the other AUC must also be zero. Likewise, chance level performance (AUC = 0.5) must be common to all method of estimating AUC. Finally, perfect performance must be common to all methods. All of these conditions require a zero-intercept linear fit. 


### Slopes {#rsm-3-fits-slopes}

Denote PROPROC AUC for dataset $f$, treatment $i$ and reader $j$ by $\theta^{PRO}_{fij}$. Likewise, the corresponding RSM and CBM values are denoted by $\theta^{RSM}_{fij}$ and $\theta^{CBM}_{fij}$, respectively. For a given dataset the slope of the PROPROC values vs. the RSM values is denoted $m_{PR,f}$. The (grand) average over all datasets is denoted $m^{PR}_\bullet$. Likewise, the average of the CBM AUC values vs. the RSM value is denoted $m^{CR}_\bullet$. 

An analysis was conducted to determine the average slopes and a bootstrap analysis was conducted to determine the corresponding confidence intervals. 

The code for calculating the average slopes is in `R/compare-3-fits/slopesConvVsRsm.R` and that for calculating the bootstrap confidence intervals is in  `R/compare-3-fits/slopesAucsConvVsRsmCI.R`.   







```r
ret <- slopesConvVsRsm(datasetNames)
retCI <- slopesAucsConvVsRsmCI(datasetNames)
```


The call to function `slopesConvVsRsm()` returns `ret`, which contains, for each of 14 datasets, two plots and two slopes. For example:


* `ret$p1[[2]]` is the plot of $\theta^{PRO}_{2ij}$ vs. $\theta^{RSM}_{2ij}$ for the Van Dyke dataset.
* `ret$p2[[2]]` is the plot of $\theta^{CBM}_{2ij}$ vs. $\theta^{RSM}_{2ij}$ for the Van Dyke dataset.
* `ret$m_pro_rsm` has two columns, each of length 14, the slopes $m_{PR,f}$ for the datasets (indexed by `f`) and the corresponding $R^2$ values. The first column is `ret$m_pro_rsm[[1]]` and the second is `ret$m_pro_rsm[[2]]`.
* `ret$m_cbm_rsm` has two columns, each of length 14, the slopes $m_{CR,f}$ for the datasets and the corresponding $R^2$ values.

Likewise,

* `ret$p1[[3]]` is the plot of $\theta^{PRO}_{3ij}$ vs. $\theta^{RSM}_{3ij}$ for the Franken dataset.
* `ret$p2[[3]]` is the plot of $\theta^{CBM}_{3ij}$ vs. $\theta^{RSM}_{3ij}$ for the Franken dataset.


As  examples, `ret$p1[[2]]` is the plot of $\theta^{PRO}_{2ij}$ vs. $\theta^{RSM}_{2ij}$ for the Van Dyke dataset and `ret$p1[[3]]` is the plot of $\theta^{CBM}_{2ij}$ vs. $\theta^{RSM}_{2ij}$ for the Van Dyke dataset, shown next. Each plot has the constrained linear fit superposed on the data points; each data point represents a distinct modality-reader combination. 


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-2-1.png" alt="Van Dyke dataset: Left plot is PROPROC-AUC vs. RSM-AUC with the superposed constrained linear fit. The number of data points is `nPts` = 10. Right plot is CBM-AUC vs. RSM-AUC." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-2)Van Dyke dataset: Left plot is PROPROC-AUC vs. RSM-AUC with the superposed constrained linear fit. The number of data points is `nPts` = 10. Right plot is CBM-AUC vs. RSM-AUC.</p>
</div>


The next plot shows corresponding plots for the Franken dataset.


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-3-1.png" alt="Similar to previous plot, for Franken dataset." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-3)Similar to previous plot, for Franken dataset.</p>
</div>


The average slopes and $R^2$ values ($R^2$ is the fraction of variance explained by the constrained straight line fit) are listed in Table \@ref(tab:rsm-3-fits-slopes-table1). 


The slopes and $R^2$ values for the Van Dyke dataset are shown next:


```
##        m-PR    R2-PR     m-CR     R2-CR
## VD 1.006127 0.999773 1.000699 0.9999832
```


### Confidence intervals {#rsm-3-fits-confidence-intervals}


The call to `slopesAucsConvVsRsmCI` returns `retCI`, containing the results of the bootstrap analysis (note the bullet symbols $\bullet$ denoting averages over 14 datasets):

* `retCI$cislopeProRsm` confidence interval for $m^{PR}_\bullet$
* `retCI$cislopeCbmRsm` confidence interval for $m^{CR}_\bullet$
* `retCI$histSlopeProRsm` histogram plot for 200 bootstrap values of $m^{PR}_\bullet$
* `retCI$histSlopeCbmRsm` histogram plot for 200 bootstrap values of $m^{CR}_\bullet$
* `retCI$ciAvgAucRsm` confidence interval for 200 bootstrap values of $\theta^{RSM}_\bullet$
* `retCI$ciAvgAucPro` confidence interval for 200 bootstrap values of $\theta^{PRO}_\bullet$
* `retCI$ciAvgAucCbm` confidence interval for 200 bootstrap values of $\theta^{CBM}_\bullet$

As examples,



```
##           m-PR      m-CR
## 2.5%  1.005092 0.9919886
## 97.5% 1.012285 0.9966149
```


The CI for $m^{PR}_\bullet$ is slightly above unity, while that for $m^{CR}_\bullet$ is slightly below. Shown next is the histogram plot for $m^{PR}_\bullet$ (left plot) and $m^{CR}_\bullet$ (right plot). Quantiles of these histograms were used to compute the confidence intervals cited above. 


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-histo-slopes-1.png" alt="Histograms of slope PROPROC AUC vs. RSM AUC (left) and slope CBM AUC vs. RSM AUC (right)." width="672" />
<p class="caption">(\#fig:rsm-3-fits-histo-slopes)Histograms of slope PROPROC AUC vs. RSM AUC (left) and slope CBM AUC vs. RSM AUC (right).</p>
</div>


### Summary of slopes and confidence intervals {#rsm-3-fits-slopes-confidence-intervals-summary}




<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:rsm-3-fits-slopes-table1)Summary of slopes and correlations for the two constrained fits: PROPROC AUC vs. RSM AUC and CBM AUC vs. RSM AUC. The average of each slope equals unity to within 0.6 percent.</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> $m_{PR}$ </th>
   <th style="text-align:left;"> $R^2_{PR}$ </th>
   <th style="text-align:left;"> $m_{CR}$ </th>
   <th style="text-align:left;"> $R^2_{CR}$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> TONY </td>
   <td style="text-align:left;"> 1.0002 </td>
   <td style="text-align:left;"> 0.9997 </td>
   <td style="text-align:left;"> 0.9933 </td>
   <td style="text-align:left;"> 0.9997 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VD </td>
   <td style="text-align:left;"> 1.0061 </td>
   <td style="text-align:left;"> 0.9998 </td>
   <td style="text-align:left;"> 1.0007 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FR </td>
   <td style="text-align:left;"> 0.9995 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0.9977 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FED </td>
   <td style="text-align:left;"> 1.0146 </td>
   <td style="text-align:left;"> 0.9998 </td>
   <td style="text-align:left;"> 0.9999 </td>
   <td style="text-align:left;"> 0.9999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> JT </td>
   <td style="text-align:left;"> 0.9964 </td>
   <td style="text-align:left;"> 0.9995 </td>
   <td style="text-align:left;"> 0.9972 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> MAG </td>
   <td style="text-align:left;"> 1.036 </td>
   <td style="text-align:left;"> 0.9983 </td>
   <td style="text-align:left;"> 0.9953 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> OPT </td>
   <td style="text-align:left;"> 1.0184 </td>
   <td style="text-align:left;"> 0.9997 </td>
   <td style="text-align:left;"> 1.0059 </td>
   <td style="text-align:left;"> 0.9997 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PEN </td>
   <td style="text-align:left;"> 1.0081 </td>
   <td style="text-align:left;"> 0.9996 </td>
   <td style="text-align:left;"> 0.9976 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NICO </td>
   <td style="text-align:left;"> 0.9843 </td>
   <td style="text-align:left;"> 0.9998 </td>
   <td style="text-align:left;"> 0.997 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RUS </td>
   <td style="text-align:left;"> 0.9989 </td>
   <td style="text-align:left;"> 0.9999 </td>
   <td style="text-align:left;"> 0.9921 </td>
   <td style="text-align:left;"> 0.9999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> DOB1 </td>
   <td style="text-align:left;"> 1.0262 </td>
   <td style="text-align:left;"> 0.9963 </td>
   <td style="text-align:left;"> 0.9886 </td>
   <td style="text-align:left;"> 0.9962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> DOB2 </td>
   <td style="text-align:left;"> 1.0056 </td>
   <td style="text-align:left;"> 0.9987 </td>
   <td style="text-align:left;"> 0.971 </td>
   <td style="text-align:left;"> 0.9978 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> DOB3 </td>
   <td style="text-align:left;"> 1.0211 </td>
   <td style="text-align:left;"> 0.998 </td>
   <td style="text-align:left;"> 0.9847 </td>
   <td style="text-align:left;"> 0.9986 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FZR </td>
   <td style="text-align:left;"> 1.0027 </td>
   <td style="text-align:left;"> 0.9999 </td>
   <td style="text-align:left;"> 0.9996 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AVG </td>
   <td style="text-align:left;"> 1.0084 </td>
   <td style="text-align:left;"> 0.9992 </td>
   <td style="text-align:left;"> 0.9943 </td>
   <td style="text-align:left;"> 0.9994 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CI </td>
   <td style="text-align:left;"> (1.005, 1.012) </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> (0.992, 0.997) </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>


Table \@ref(tab:rsm-3-fits-slopes-table1): The first column, labeled $m_{PR}$, shows results of fitting straight lines, constrained to go through the origin, to fitted PROPROC AUC vs. RSM AUC results, for each of the 14 datasets, as labeled. The second column, labeled $R^2_{PR}$, lists the square of the correlation coefficient for each fit. The third and fourth columns list the corresponding values for the CBM AUC vs. RSM AUC fits. The second last row lists the averages (AVG) and the last row lists the 95 percent confidence intervals (CI) for the average slopes.


## Discussion / Summary {#rsm-3-fits-discussion-summary}

Over the years, there have been several attempts at fitting FROC data. Prior to the RSM-based ROC curve approach described in this chapter, all methods were aimed at fitting FROC curves, in the mistaken belief that this approach was using all the data. The earliest was my FROCFIT software TBA 36. This was followed by Swensson's approach37, subsequently shown to be equivalent to my earlier work, as far as predicting the FROC curve was concerned TBA 11. In the meantime, CAD developers, who relied heavily on the FROC curve to evaluate their algorithms, developed an empirical approach that was subsequently put on a formal basis in the IDCA method12. 

This chapter describes an approach to fitting ROC curves, instead of FROC curves, using the RSM. Fits were described for 14 datasets, comprising 236 distinct treatment-reader combinations. All fits and parameter values are viewable in the online "Supplemental Material" directory corresponding to this chapter. Validity of fit was assessed by the chisquare goodness of fit p-value; unfortunately using adjacent bin combining this could not be calculated in most instances; ongoing research at other ways of validating the fits is underway. PROPROC and CBM were fitted to the same datasets, yielding further validation and insights. One of the insights was the finding that the AUCS were almost identical, with PROPROC yielding the highest value, followed by CBM and closely by the RSM. The PROPROC-AUC / CBM-AUC, vs. RSM-AUC straight-line fits, constrained to go through the origin, had slopes 1.0255 (1.021, 1.030) and 1.0097 (1.006, 1.013), respectively. The $R^2$ values were generally in excess of 0.999, indicative of excellent fits.

On the face of it, fitting the ROC curve seems to be ignoring much of the data. As an example, the ROC rating on a non-diseased case is the rating of the highest-rated mark on that image, or negative infinity if the case has no marks. If the case has several NL marks, only the highest rated one is used. In fact the highest rated mark contains information about the other marks on the case, namely they were all rated lower. There is a statistical term for this, namely sufficiency38. As an example, the highest of a number of samples from a uniform distribution is a sufficient statistic, i.e., it contains all the information contained in the observed samples. While not quite the same for normally distributed values, neglect of the NLs rated lower is not as bad as might seem at first. A similar argument applies to LLs and NLs on diseased cases. The advantage of fitting to the ROC is that the coupling of NLs and LLs on diseased cases breaks the degeneracy problem described in §18.2.3.

The reader may wonder why I chose not to fit the wAFROC TBA. After all, it is the recommended figure of merit for FROC studies. While the methods described in this chapter are readily adapted to the wAFROC, they are more susceptible to degeneracy issues. The reason is that the y-axis is defined by LL-events, in other words by the   parameters, while the x-axis is defined by the highest rated NL on non-diseased cases, in other words by the   parameter. The consequent decoupling of parameters leads to degeneracy of the type described in §18.2.3. This is avoided in ROC fitting because the y-axis is defined by LLs and NLs, in other words all parameters of the RSM are involved. The situation with the wAFROC is not quite as severe as with fitting FROC curves but it does have a problem with degeneracy. There are some ideas on how to improve the fits, perhaps by simultaneously fitting ROC and wAFROC-operating points, which amounts to putting constraints on the parameters, but for now this remains an open research subject. Empirical wAFROC, which is the current method implemented in RJafroc, is expected to have the same issues with variability of thresholds between treatments as the empirical ROC-AUC, as discussed in §5.9. So the fitting problem has to be solved. There is no need to fit the FROC, as it should never be used as a basis of a figure of merit for human observer studies; this is distinct from the severe degeneracy issues encountered with fitting it for human observers.

The application to a large number (236) of real datasets revealed that PROPROC has serious issues. These were apparently not revealed by the millions of simulations used to validate it39. To quote the cited reference, "The new algorithm never failed to converge and produced good fits for all of the several million datasets on which it was tested". This is a good illustration of why simulations studies are not a good alternative to the method described in §18.5.1.3.  In my experience this is a common misconception in this field, and is discussed further in the following chapter. Fig. 18.5, panels (J), (K) and (L) show that PROPROC, and to a lesser extent CBM, can, under some circumstances, severely overestimate performance. Recommendations regarding usage of PROPROC and CBM are deferred to Chapter 20. 

The current ROC-based effort led to some interesting findings. The near equality of the AUCs predicted by the three proper ROC fitting methods, summarized in Table 18.4, has been noted, which is explained by the fact that proper ROC fitting methods represent different approaches to realizing an ideal observer, and the ideal observer must be unique, §18.6. 

This chapter explores what is termed inter-correlations, between RSM and CBM parameters. Since they have similar physical meanings, the RSM and CBM separation parameters were found to be significantly correlated,   = 0.86 (0.76, 0.89), as were the RSM and CBM parameters corresponding to the fraction of lesions that was actually visible,  = 0.77 (0.68, 0.82). This type of correspondence between two different models can be interpreted as evidence of mutually reinforcing validity of each of the models.

The CBM method comes closest to the RSM in terms of yielding meaningful measures, but the fact that it allows the ROC curve to go continuously to (1,1) implies that it is not completely accounting for search performance, §17.8. There are two components to search performance: finding lesions and avoiding non-lesions. The CBM model accounts for finding lesions, but it does not account for avoiding suspicious regions that are non-diseased, an important characteristic of expert radiologists.

An important finding is the inverse correlation between search performance and lesion-classification performance, which suggest there could be tradeoffs in attempts to optimize them. As a simplistic illustration, a low-resolution gestalt-view of the image1, such as seen by the peripheral viewing mechanism, is expected to make it easier to rapidly spot deviations from the expected normal template described in Chapter 15. However, the observer may not be able to switch effectively between this and the high-resolution viewing mode necessary to correctly classify found suspicious region. 

The main scientific conclusion of this chapter is that search-performance is the primary bottleneck in limiting observer performance. It is unfortunate that search is ignored in the ROC paradigm, usage of which is decreasing, albeit at an agonizingly slow rate. Evidence presented in this chapter should convince researchers to reconsider the focus of their investigations, most of which is currently directed at improving classification performance, which has been shown not to be the bottleneck. Another conclusion is that the three method of fitting ROC data yield almost identical AUCs. Relative to the RSM the PROPROC estimates are about 2.6% larger while CBM estimates are about 1% larger. This was a serendipitous finding that makes sense, in retrospect, but to the best of my knowledge is not known in the research community. PROPROC and to a lesser extent CBM are prone to severely overestimating performance in situations where the operating points are limited to a steep ascending section at the low end of false positive fraction scale. This parallels an earlier comment regarding the FROC, namely measurements derived from the steep part of the curve are unreliable, §17.10.1.


## Appendices {#rsm-3-fits-appendices}
## Datasets {#rsm-3-fits-14-datasets}

The datasets are embedded in ther `RJafroc` package. They can be viewed in the help file of the package, a partial screen-shot of which is shown next ^[The raw datasets (Excel files) are in folder `R/compare-3-fits/Datasets` and file `R/compare-3-fits/loadDataFile.R` shows the correspondence between `datasetNames` and a dataset: for example, the Van Dyke dataset corresponds to file `VanDykeData.xlsx` in the `R/compare-3-fits/Datasets` folder.].


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/datasets.png" alt="Partial screen shot of `RJafroc` help file showing the datasets included with the current distribution (v2.0.1)."  />
<p class="caption">(\#fig:rsm-3-fits-datasets)Partial screen shot of `RJafroc` help file showing the datasets included with the current distribution (v2.0.1).</p>
</div>


The datasets are identified in the code by dataset`dd` (where `dd` is an integer in the range `01` to `14`) as follows:

* `dataset01` "TONY" FROC dataset [@RN2125]


```
## List of 3
##  $ NL   : num [1:2, 1:5, 1:185, 1:3] 3 -Inf 3 -Inf 4 ...
##  $ LL   : num [1:2, 1:5, 1:89, 1:2] 4 4 3 -Inf 3.5 ...
##  $ LL_IL: logi NA
```


* `dataset02` "VAN-DYKE" Van Dyke ROC dataset [@RN1993]


```
## List of 3
##  $ NL   : num [1:2, 1:5, 1:114, 1] 1 3 2 3 2 2 1 2 3 2 ...
##  $ LL   : num [1:2, 1:5, 1:45, 1] 5 5 5 5 5 5 5 5 5 5 ...
##  $ LL_IL: logi NA
```


* `dataset03` "FRANKEN" Franken ROC dataset [@RN1995]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:100, 1] 3 3 4 3 3 3 4 1 1 3 ...
##  $ LL   : num [1:2, 1:4, 1:67, 1] 5 5 4 4 5 4 4 5 2 2 ...
##  $ LL_IL: logi NA
```


* `dataset04` "FEDERICA" Federica Zanca FROC dataset [@RN1882]


```
## List of 3
##  $ NL   : num [1:5, 1:4, 1:200, 1:7] -Inf -Inf 1 -Inf -Inf ...
##  $ LL   : num [1:5, 1:4, 1:100, 1:3] 4 5 4 5 4 3 5 4 4 3 ...
##  $ LL_IL: logi NA
```


* `dataset05` "THOMPSON" John Thompson FROC dataset [@RN2368]


```
## List of 3
##  $ NL   : num [1:2, 1:9, 1:92, 1:7] 4 5 -Inf -Inf 8 ...
##  $ LL   : num [1:2, 1:9, 1:47, 1:3] 5 9 -Inf 10 8 ...
##  $ LL_IL: logi NA
```



* `dataset06` "MAGNUS" Magnus Bath FROC dataset [@RN1929]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:89, 1:17] 1 -Inf -Inf -Inf 1 ...
##  $ LL   : num [1:2, 1:4, 1:42, 1:15] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset07` "LUCY-WARREN" Lucy Warren FROC dataset [@RN2507]


```
## List of 3
##  $ NL   : num [1:5, 1:7, 1:162, 1:4] 1 2 1 2 -Inf ...
##  $ LL   : num [1:5, 1:7, 1:81, 1:3] 2 -Inf 2 -Inf 1 ...
##  $ LL_IL: logi NA
```


* `dataset08` "PENEDO" Monica Penedo FROC dataset [@RN1520]


```
## List of 3
##  $ NL   : num [1:5, 1:5, 1:112, 1] 3 2 3 2 3 0 0 4 0 2 ...
##  $ LL   : num [1:5, 1:5, 1:64, 1] 3 2 4 3 3 3 3 4 4 3 ...
##  $ LL_IL: logi NA
```


* `dataset09` "NICO-CAD-ROC" Nico Karssemeijer ROC dataset [@hupse2013standalone]


```
## List of 3
##  $ NL   : num [1, 1:10, 1:200, 1] 28 0 14 0 16 0 31 0 0 0 ...
##  $ LL   : num [1, 1:10, 1:80, 1] 29 12 13 10 41 67 61 51 67 0 ...
##  $ LL_IL: logi NA
```


* `dataset10` "RUSCHIN" Mark Ruschin ROC dataset [@RN1646]


```
## List of 3
##  $ NL   : num [1:3, 1:8, 1:90, 1] 1 0 0 0 0 0 1 0 0 0 ...
##  $ LL   : num [1:3, 1:8, 1:40, 1] 2 1 1 2 0 0 0 0 0 3 ...
##  $ LL_IL: logi NA
```


* `dataset11` "DOBBINS-1" Dobbins I FROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:158, 1:4] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL   : num [1:4, 1:5, 1:115, 1:20] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset12`  "DOBBINS-2" Dobbins II ROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:152, 1] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL   : num [1:4, 1:5, 1:88, 1] 3 4 4 -Inf -Inf ...
##  $ LL_IL: logi NA
```



* `dataset13` "DOBBINS-3" Dobbins III FROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:158, 1:4] -Inf 3 -Inf 4 5 ...
##  $ LL   : num [1:4, 1:5, 1:106, 1:15] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset14` "FEDERICA-REAL-ROC" Federica Zanca *real* ROC dataset [@RN2318]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:200, 1] 2 2 2 2 1 3 2 2 3 1 ...
##  $ LL   : num [1:2, 1:4, 1:100, 1] 6 5 6 4 5 5 5 5 5 4 ...
##  $ LL_IL: logi NA
```



## Location of PROPROC files {#rsm-3-fits-one-dataset-proproc}

For each dataset PROPROC parameters were obtained by running the Windows software with PROPROC selected as the curve-fitting method. The results are saved to files that end with `proprocnormareapooled.csv` ^[In accordance with R-package policies white-spaces in the original `PROPROC` output file names have been removed.] contained in "R/compare-3-fits/MRMCRuns/C/", where `C` denotes the name of the dataset (for example, for the Van Dyke dataset, `C` = "VD"). Examples are shown in the next two screen-shots.


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/MRMCRuns.png" alt="Screen shot (1 of 2) of `R/compare-3-fits/MRMCRuns` showing the folders containing the results of PROPROC analysis on 14 datasets."  />
<p class="caption">(\#fig:rsm-3-fits-mrmc-runs)Screen shot (1 of 2) of `R/compare-3-fits/MRMCRuns` showing the folders containing the results of PROPROC analysis on 14 datasets.</p>
</div>


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/MRMCRuns-VD.png" alt="Screen shot (2 of 2) of `R/compare-3-fits/MRMCRuns/VD` showing files containing the results of PROPROC analysis for the Van Dyke dataset."  />
<p class="caption">(\#fig:rsm-3-fits-mrmc-runs-vd)Screen shot (2 of 2) of `R/compare-3-fits/MRMCRuns/VD` showing files containing the results of PROPROC analysis for the Van Dyke dataset.</p>
</div>

The contents of `R/compare-3-fits/MRMCRuns/VD/VDproprocnormareapooled.csv` are shown next, see Fig. \@ref(fig:rsm-3-fits-proproc-output-van-dyke). ^[The `VD.lrc` file in this directory is the Van Dyke data formatted for input to OR DBM-MRMC 2.5.] The PROPROC parameters $c$ and $d_a$  are in the last two columns. The column names are `T` = treatment; `R` = reader; `return-code` = undocumented value, `area` = PROPROC AUC; `numCAT` = number of ROC bins; `adjPMean` = undocumented value; `c` =  $c$ and `d_a` =  $d_a$, are the PROPROC parameters defined in [@metz1999proper].


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/vanDyke.png" alt="PROPROC output for the Van Dyke ROC data set." width="50%" height="20%" />
<p class="caption">(\#fig:rsm-3-fits-proproc-output-van-dyke)PROPROC output for the Van Dyke ROC data set.</p>
</div>





## Location of pre-analyzed results {#rsm-3-fits-pre-analyzed-results}

The following screen shot shows the pre-analyzed files created by the function `Compare3ProperRocFits()` described below. Each file is named `allResultsC`, where `C` is the abbreviated name of the dataset (uppercase C denotes one or more uppercase characters; for example, `C` = `VD` denotes the Van Dyke dataset.).

<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/RSM6.png" alt="Screen shot of `R/compare-3-fits/RSM6` showing the results files created by  `Compare3ProperRocFits()` ."  />
<p class="caption">(\#fig:rsm-3-fits-all-results-rsm6)Screen shot of `R/compare-3-fits/RSM6` showing the results files created by  `Compare3ProperRocFits()` .</p>
</div>

## Plots for Van Dyke dataset {#rsm-3-fits-representative-plots-van-dyke}

The following plots are arranged in pairs, with the left plot corresponding to treatment 1 and the right to treatment 2. 


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-1-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 1." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-1)Composite plots in both treatments for Van Dyke dataset, reader 1.</p>
</div>


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-2-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 2. For treatment 2 the RSM and PROPROC fits are indistinguishable." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-2)Composite plots in both treatments for Van Dyke dataset, reader 2. For treatment 2 the RSM and PROPROC fits are indistinguishable.</p>
</div>



The RSM parameter values for the treatment 2 plot are: $\mu$ = 5.767237, $\lambda'$ = 2.7212621, $\nu'$ = 0.8021718, $\zeta_1$ = -1.5717303. The corresponding CBM values are $\mu$ = 5.4464738, $\alpha$ = 0.8023609, $\zeta_1$ = -1.4253826. The RSM and CBM $\mu$ parameters are very close and likewise the RSM $\nu'$ and CBM $\alpha$ parameters are very close - this is because they have similar physical meanings, which is investigated later in this chapter TBA. [The CBM does not have a parameter analogous to the RSM $\lambda'$ parameter.] 



<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-3-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 3." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-3)Composite plots in both treatments for Van Dyke dataset, reader 3.</p>
</div>



The RSM parameters for the treatment 1 plot are: $\mu$ = 3.1527627, $\lambda'$ = 9.9986154, $\nu'$ = 0.9899933, $\zeta_1$ = 1.1733988. The corresponding CBM values are $\mu$ = 2.1927712, $\alpha$ = 0.98, $\zeta_1$ = -0.5168848. 



<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-4-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 4. For treatment 2 the 3 plots are indistinguishable and each one has AUC = 1. The degeneracy is due to all operating points being on the axes of the unit square." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-4)Composite plots in both treatments for Van Dyke dataset, reader 4. For treatment 2 the 3 plots are indistinguishable and each one has AUC = 1. The degeneracy is due to all operating points being on the axes of the unit square.</p>
</div>


<div class="figure">
<img src="19b-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-5-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 5." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-5)Composite plots in both treatments for Van Dyke dataset, reader 5.</p>
</div>



## References {#rsm-3-fits-references}


