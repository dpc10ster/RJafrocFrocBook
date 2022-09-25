# Three proper ROC fits {#rsm-3-fits}





## TBA How much finished {#rsm-3-fits-how-much-finished}
85%


## TBA Introduction {#rsm-3-fits-intro}

A proper ROC curve is one whose slope decreases monotonically as the operating point moves up the curve, a consequence of which is that a proper ROC does not display an inappropriate chance line crossing followed by a sharp upward turn, i.e., a "hook", usually near the (1,1) upper right corner. 

There are three methods for fitting proper curves to ROC datasets: 

* The radiological search model (RSM) described in Chapter \@ref(rsm-fitting), 
* The PROPROC (proper ROC) model described in TBA Chapter 20. 
* The CBM (contaminated binormal model) described in TBA Chapter 20. 

This chapter compares these methods by fitting the to 14 multiple-treatment multiple-reader datasets described in Chapter \@ref(datasets). ^[Comparing the RSM to the binormal model would be inappropriate, as the latter does not predict proper ROCs.]

Both RSM and CBM are implemented in `RJafroc`. `PROPROC` is implemented in Windows software ^[OR DBM-MRMC 2.5, Sept. 04, 2014; the version used in this chapter is no longer distributed but is available from me upon request.] available [here](https://perception.lab.uiowa.edu/OR-DBM-MRMC-252), last accessed 1/4/21.


## Application to two datasets {#rsm-3-fits-applications}

The RSM, PROPROC and CBM algorithms were applied to the 14 datasets described in Chapter \@ref(datasets). 



```r
datasetNames <-  
  c("TONY", "VD", "FR", 
  "FED", "JT", "MAG", 
  "OPT", "PEN", "NICO",
  "RUS", "DOB1", "DOB2", 
  "DOB3", "FZR")
```


In the following we focus on just two ROC datasets which have been widely used in the literature to illustrate ROC methodological advances, namely the Van Dyke (VD) and the Franken (FR) datasets.







```r
results <- array(list(), dim = 2)

results[[1]] <- Compare3ProperRocFits(datasetNames, 2) # VD dataset
results[[2]] <- Compare3ProperRocFits(datasetNames, 3) # FR dataset

resultsArr <- plotArr <- array(list(), dim = 2)

for (i in 1:2) {
  plotArr[[i]] <- results[[i]]$allPlots
  resultsArr[[i]] <- results[[i]]$allResults
}
```


* The supporting code is in the function `Compare3ProperRocFits()` located at `R/compare-3-fits/Compare3ProperRocFits.R`. 
* The analyzed results file locations are shown in Section \@ref(rsm-3-fits-pre-analyzed-results).
* The fitted parameter results are contained in `resultsArr` and the composite plots (i.e., 3 combined plots corresponding to the three proper ROC fitting algorithms for each treatment and reader) are contained in `plotArr`. 


## Composite plots {#rsm-3-fits-composite-plots}

* The `plotArr` list contains plots for the two datasets. The Van Dyke plots are in `plotArr[[1]]` and the Franken in `plotArr[[2]]`. The double bracket is `R`-usage to index `lists`.
* The Van Dyke dataset contains $I \times J = 2 \times 5 = 10$ composite plots. 
* The Franken dataset contains $I \times J = 2 \times 4 = 8$ composite plots. 
* The following shows how to display the composite plot for the Van Dyke dataset for treatment 1 and reader 2. 



```r
plotArr[[1]][[1,2]]
```

<img src="12-rsm-3-fits_files/figure-html/unnamed-chunk-2-1.png" width="672" />


The plot is labeled `D2, i = 1, j = 2`, meaning the second dataset in the `datasetNames` array, i.e., `datasetNames[2]`, the second treatment and the second reader. It contains 3 plots:

* The RSM fitted curve is in black. 
* The PROPROC fitted curve is in red. 
* The CBM fitted curve is in blue. 
* Three operating points from the binned data are shown as well as 95% confidence intervals for the lowest and uppermost operating points. 


All 10 composite plots for the Van Dyke dataset are shown in Appendix \@ref(rsm-3-fits-representative-plots-van-dyke).



## RSM parameters {#rsm-3-fits-rsm-parameters}

The parameters corresponding to the RSM plots are accessed as shown next. 

* `resultsArr[[1]][[1,2]]$retRsm$mu` is the RSM $\mu$ parameter for the Van Dyke dataset for treatment 1 and reader 2, 
* `resultsArr[[1]][[1,2]]$retRsm$lambda` is the RSM $\lambda$ parameter;  
* `resultsArr[[1]][[1,2]]$retRsm$nu` is the RSM $\nu$ parameter; 
* `resultsArr[[1]][[1,2]]$retRsm$zeta1` is the RSM $\zeta_1$ parameter; 
* In general the values are accessed as `[[f]][[i,j]]`, where `f` is the dataset index, `i` is the treatment index and `j` is the reader index; 
* For the Van Dyke dataset `f = 1` and for the Franken dataset `f = 2`.

The following displays RSM parameters for the Van Dyke dataset, treatment 1 and reader 2:



```
## RSM parameters, Van Dyke Dataset, treatment 1, reader 2: 
## mu =  2.201413 
## lambda =  0.2569453 
## nu =  0.7524016 
## zeta_1 =  -0.1097901 
## AUC =  0.8653694 
## sigma_AUC =  0.04740562 
## NLLini =  96.48516 
## NLLfin =  85.86244
```


The first four values are the fitted values for the RSM parameters $\mu$, $\lambda$, $\nu$ and $\zeta_1$. The next value is the AUC under the fitted RSM curve followed by its standard error. The last two values are the initial and final values of negative log-likelihood ^[The initial value is calculated using initial estimates of parameters and the final value is that resulting from the log-likelihood maximization procedure. Since negative log-likelihood is being *minimized*, the final value is smaller than the initial value.].  


Displayed next are RSM parameters for the Franken dataset, treatment 2 and reader 3:







```
## RSM parameters, Franken dataset, treatment 2, reader 3: 
## mu =  2.641412 
## lambda =  2.137379 
## nu =  0.784759 
## zeta_1 =  -1.858565 
## AUC =  0.8552573 
## sigma_AUC =  0.03809136 
## NLLini =  132.6265 
## NLLfin =  127.9418
```



## CBM parameters {#rsm-3-fits-cbm-parameters}

The parameters of the CBM plots are accessed as shown next. 

* `resultsArr[[f]][[i,j]]$retCbm$mu` is the CBM $\mu$ parameter; 
* `resultsArr[[f]][[i,j]]$retCbm$alpha` is the CBM $\alpha$ parameter;   
* `as.numeric(resultsArr[[f]][[i,j]]$retCbm$zetas[1])` is the CBM $\zeta_1$ parameter, the threshold corresponding to the highest non-trivial operating point; 
* `resultsArr[[f]][[i,j]]$retCbm$AUC` is the CBM AUC; 
* `as.numeric(resultsArr[[f]][[i,j]]$retCbm$StdAUC)` is the standard deviation of the CBM AUC;
* `resultsArr[[f]][[i,j]]$retCbm$NLLIni` is the initial negative log-likelihood value;
* `rresultsArr[[f]][[i,j]]$retCbm$NLLFin)` is the final negative log-likelihood value.

The next example displays CBM parameters and AUC etc. for the Van Dyke dataset, treatment 1 and reader 2:



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






```
## CBM parameters, Franken dataset, treatment 2, reader 3: 
## mu =  2.340719 
## alpha =  0.7860465 
## zeta_1 =  -1.144089 
## AUC =  0.8545476 
## sigma_AUC =  0.03825439 
## NLLini =  131.8453 
## NLLfin =  128.0437
```


The first three values are the fitted values for the CBM parameters $\mu$, $\alpha$ and $\zeta_1$. The next value is the AUC under the fitted CBM curve followed by its standard error. The last two values are the initial and final values of negative log-likelihood.  


## PROPROC parameters {#rsm-3-fits-proproc-parameters}


`PROPROC` displayed parameters are accessed as follows: 


* `resultsArr[[f]][[i,j]]$c1` is the PROPROC $c$ parameter; 
* `resultsArr[[f]][[i,j]]$da` is the PROPROC $d_a$ parameter;   
* `resultsArr[[f]][[i,j]]$aucProp` is the PROPROC AUC; 

Other statistics, such as standard error of AUC, are not provided by PROPROC software.

The next example displays PROPROC parameters for the Van Dyke dataset, treatment 1 and reader 2:



```
## PROPROC parameters, Van Dyke Dataset, treatment 1, reader 2: 
## c =  -0.2809004 
## d_a =  1.731472 
## AUC =  0.8910714
```


The values are identical to those listed for treatment 1 and reader 2 in Fig. \@ref(fig:rsm-3-fits-proproc-output-van-dyke). 

The next example displays PROPROC parameters for the Franken dataset, treatment 2 and reader 3:






```
## PROPROC parameters, Franken dataset, treatment 2, reader 3: 
## c =  -0.3551936 
## d_a =  1.401807 
## AUC =  0.8541372
```




The next section provides an overview of the most salient findings from analyzing the datasets.


## Overview of findings {#rsm-3-fits-overview}

With 14 datasets the total number of individual modality-reader combinations is 236: in other words, there are 236 datasets to *each* of which three fitting algorithms were applied. 

It is easy to be overwhelmed by the numbers and this section summarizes an important conclusion: 

*The three fitting methods are consistent with a single method-independent AUC*.


If the AUCs of the three methods are identical the following relations hold with each slope $\text{m}_{PR}$ and $\text{m}_{CR}$ equal to unity: 


\begin{equation}
\left. 
\begin{aligned}
\text{AUC}_{PRO} =& \text{m}_{PR} \text{AUC}_{PRO}  \\
\text{AUC}_{CBM} =& \text{m}_{CR} \text{AUC}_{PRO} \\
\text{m}_{PR}    =& 1 \\
\text{m}_{CR}    =& 1
\end{aligned}
\right \}
(\#eq:rsm-3-fits-slopes-equation1)
\end{equation}

The abbreviations are as follows: 

* PRO = PROPROC 
* PR = PROPROC vs. RSM 
* CR = CBM vs. RSM. 

For each dataset the plot of PROPROC AUC vs. RSM AUC should be linear with zero intercept and slope $\text{m}_{PR}$, and likewise for the plots of CBM AUC vs. RSM AUC. The reason for the *zero intercept* is that if the AUCs are identical one cannot have an offset (i.e., intercept) term.  


### Slopes {#rsm-3-fits-slopes}

* Denote PROPROC AUC for dataset $f$, treatment $i$ and reader $j$ by $\text{AUC}^{PRO}_{fij}$. Likewise, the corresponding RSM and CBM values are denoted by $\text{AUC}^{RSM}_{fij}$ and $\text{AUC}^{CBM}_{fij}$, respectively. 

* For a given dataset the slope of the PROPROC values vs. the RSM values is denoted $\text{m}_{PR,f}$. 
* The (grand) average over all datasets is denoted $m^{PR}_\bullet$. Likewise, the (grand) average of the CBM AUC vs. the RSM slopes is denoted $m^{CR}_\bullet$. 

An analysis was conducted to determine the average slopes and bootstrap confidence intervals. 

The code for calculating the average slopes is in `R/compare-3-fits/slopesConvVsRsm.R` and that for the bootstrap confidence intervals is in  `R/compare-3-fits/slopesAucsConvVsRsmCI.R`.   







```r
slopes <- slopesConvVsRsm(datasetNames)
slopeCI <- slopesAucsConvVsRsmCI(datasetNames)
```


The call to function `slopesConvVsRsm()` returns `slopes`, which contains, for each of 14 datasets, four `lists`: two plots and two slopes. For example:

* PRO vs. RSM: `slopes$p1[[2]]` is the plot of $\text{AUC}^{PRO}_{2 \bullet \bullet}$ vs. $\text{AUC}^{RSM}_{2 \bullet \bullet}$ for all treatments and readers in the Van Dyke dataset. The plot for dataset $f, f = 1, 2, ...14$ is accessed as `slopes$p1[[f]]` which yields the plot of $\text{AUC}^{PRO}_{f \bullet \bullet}$ vs. $\text{AUC}^{RSM}_{f \bullet \bullet}$.
* CBM vs. RSM: `slopes$p2[[2]]` is the plot of $\text{AUC}^{CBM}_{2 \bullet \bullet}$ vs. $\text{AUC}^{RSM}_{2 \bullet \bullet}$ for for all treatments and readers in the Van Dyke dataset. The plot for dataset $f$ is accessed as `slopes$p2[[f]]`.
* PRO vs. RSM: `slopes$m_pro_rsm` has two columns, each of length 14, the slopes $\text{m}_{PR,f}$ for the datasets (indexed by $f$) and the corresponding $R^2$ values, where $R^2$ is the fraction of variance explained by the constrained straight line fit. The first column is `slopes$m_pro_rsm[[1]]` and the second column is `slopes$m_pro_rsm[[2]]`.
* CBM vs. RSM: `slopes$m_cbm_rsm` has two columns, each of length 14, the slopes $\text{m}_{CR,f}$ for the datasets and the corresponding $R^2$ values. The first column is `slopes$m_cbm_rsm[[1]]` and the second column is `slopes$m_cbm_rsm[[2]]`.


As an example, for the Van Dyke dataset, `slopes$p1[[2]]` which is shown in the left in Fig. \@ref(fig:rsm-3-fits-plots-2), is the plot of $\text{AUC}^{PRO}_{2 \bullet \bullet}$ vs. $\text{AUC}^{RSM}_{2 \bullet \bullet}$. Shown in the right is `slopes$p2[[2]]`, the plot of $\text{AUC}^{CBM}_{2 \bullet \bullet}$ vs. $\text{AUC}^{RSM}_{2 \bullet \bullet}$. Each plot has the constrained linear fit superposed on the $2\times5 = 10$ data points; each data point represents a distinct modality-reader combination. 


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-2-1.png" alt="Van Dyke dataset: Left plot is PROPROC-AUC vs. RSM-AUC with the superposed constrained linear fit. The number of data points is `nPts` = 10. Right plot is CBM-AUC vs. RSM-AUC." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-2)Van Dyke dataset: Left plot is PROPROC-AUC vs. RSM-AUC with the superposed constrained linear fit. The number of data points is `nPts` = 10. Right plot is CBM-AUC vs. RSM-AUC.</p>
</div>


The next plot shows corresponding plots for the Franken dataset in which there are  $2\times 4 = 8$ points in each plot.


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-3-1.png" alt="Similar to previous plot, for Franken dataset." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-3)Similar to previous plot, for Franken dataset.</p>
</div>




### Confidence intervals {#rsm-3-fits-confidence-intervals}


The call to `slopesAucsConvVsRsmCI` returns `slopeCI`, containing the results of the bootstrap analysis (the bullet symbols $\bullet$ denote grand averages over 14 datasets):

* `slopeCI$cislopeProRsm` 95-percent confidence interval for $m_{PR \bullet}$
* `slopeCI$cislopeCbmRsm` 95-percent confidence interval for $m_{CR \bullet}$
* `slopeCI$histSlopeProRsm` histogram of 200 bootstrap values of $m_{PR \bullet}$
* `slopeCI$histSlopeCbmRsm` histogram of 200 bootstrap values of $m_{CR \bullet}$
* `slopeCI$ciAvgAucRsm` confidence interval from 200 bootstrap values of $\text{AUC}^{RSM}_\bullet$
* `slopeCI$ciAvgAucPro` confidence interval for 200 bootstrap values of $\text{AUC}^{PRO}_\bullet$
* `slopeCI$ciAvgAucCbm` confidence interval for 200 bootstrap values of $\text{AUC}^{CBM}_\bullet$

As examples,



```
##           m-PR      m-CR
## 2.5%  1.005092 0.9919886
## 97.5% 1.012285 0.9966149
```


The CI for $m_{PR \bullet}$ is slightly above unity, while that for $m_{CR \bullet}$ is slightly below. Shown next is the histogram plot for $m_{PR \bullet}$ (left plot) and $m_{CR \bullet}$ (right plot). Quantiles of these histograms were used to compute the confidence intervals cited above. 


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-histo-slopes-1.png" alt="Histograms of slope PROPROC AUC vs. RSM AUC (left) and slope CBM AUC vs. RSM AUC (right)." width="672" />
<p class="caption">(\#fig:rsm-3-fits-histo-slopes)Histograms of slope PROPROC AUC vs. RSM AUC (left) and slope CBM AUC vs. RSM AUC (right).</p>
</div>


### Summary of slopes and confidence intervals {#rsm-3-fits-slopes-confidence-intervals-summary}




<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:rsm-3-fits-slopes-table1)Summary of slopes and correlations for the two constrained fits: PROPROC AUC vs. RSM AUC and CBM AUC vs. RSM AUC. The average of each slope equals unity to within 0.6 percent.</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> $\text{m}_{PR}$ </th>
   <th style="text-align:left;"> $R^2_{PR}$ </th>
   <th style="text-align:left;"> $\text{m}_{CR}$ </th>
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
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
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


In Table \@ref(tab:rsm-3-fits-slopes-table1) the second column, labeled $\text{m}_{PR}$, shows slopes of straight lines, constrained to go through the origin, to PROPROC AUC vs. RSM AUC values, for each of the 14 datasets, as labeled in the fits column. The third column, labeled $R^2_{PR}$, lists the square of the correlation coefficient for each fit. The fourth and fifth columns list the corresponding values for the CBM AUC vs. RSM AUC fits. The second last row lists the grand averages (AVG) and the last row lists the 95 percent confidence intervals.


## TBA Discussion / Summary {#rsm-3-fits-discussion-summary}



## Appendices {#rsm-3-fits-appendices}

### Location of PROPROC files {#rsm-3-fits-one-dataset-proproc}

For each dataset PROPROC parameters were obtained by running the Windows software with PROPROC selected as the curve-fitting method. The results are saved to files that end with `proprocnormareapooled.csv` ^[In accordance with R-package policies white-spaces in the original `PROPROC` output file names have been removed.] contained in "R/compare-3-fits/MRMCRuns/C/", where `C` denotes the name of the dataset (for example, for the Van Dyke dataset, `C` = "VD"). Examples are shown in the next two screen-shots.


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/MRMCRuns.png" alt="Screen shot (1 of 2) of `R/compare-3-fits/MRMCRuns` showing the folders containing the results of PROPROC analysis on 14 datasets." width="300pt" />
<p class="caption">(\#fig:rsm-3-fits-mrmc-runs)Screen shot (1 of 2) of `R/compare-3-fits/MRMCRuns` showing the folders containing the results of PROPROC analysis on 14 datasets.</p>
</div>



<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/MRMCRuns-VD.png" alt="Screen shot (2 of 2) of `R/compare-3-fits/MRMCRuns/VD` showing files containing the results of PROPROC analysis for the Van Dyke dataset." width="300pt" />
<p class="caption">(\#fig:rsm-3-fits-mrmc-runs-vd)Screen shot (2 of 2) of `R/compare-3-fits/MRMCRuns/VD` showing files containing the results of PROPROC analysis for the Van Dyke dataset.</p>
</div>



The contents of `R/compare-3-fits/MRMCRuns/VD/VDproprocnormareapooled.csv` are shown next, see Fig. \@ref(fig:rsm-3-fits-proproc-output-van-dyke). ^[The `VD.lrc` file in this directory is the Van Dyke data formatted for input to OR DBM-MRMC 2.5.] The PROPROC parameters $c$ and $d_a$  are in the last two columns. The column names are `T` = treatment; `R` = reader; `return-code` = undocumented value, `area` = PROPROC AUC; `numCAT` = number of ROC bins; `adjPMean` = undocumented value; `c` =  $c$ and `d_a` =  $d_a$, are the PROPROC parameters defined in [@metz1999proper].


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/vanDyke.png" alt="PROPROC output for the Van Dyke ROC data set. The first column is the treatment, the second is the reader, the fourth is the AUC and the last two columns are the c and $d_a$ parameters." width="50%" height="20%" />
<p class="caption">(\#fig:rsm-3-fits-proproc-output-van-dyke)PROPROC output for the Van Dyke ROC data set. The first column is the treatment, the second is the reader, the fourth is the AUC and the last two columns are the c and $d_a$ parameters.</p>
</div>





### Location of pre-analyzed results {#rsm-3-fits-pre-analyzed-results}

The following screen shot shows the pre-analyzed files created by the function `Compare3ProperRocFits()` described below. Each file is named `allResultsC`, where `C` is the abbreviated name of the dataset (uppercase C denotes one or more uppercase characters; for example, `C` = `VD` denotes the Van Dyke dataset.).



<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/RSM6.png" alt="Screen shot of `R/compare-3-fits/RSM6` showing the results files created by  `Compare3ProperRocFits()`." width="300pt" />
<p class="caption">(\#fig:rsm-3-fits-all-results-rsm6)Screen shot of `R/compare-3-fits/RSM6` showing the results files created by  `Compare3ProperRocFits()`.</p>
</div>



### Plots for Van Dyke dataset {#rsm-3-fits-representative-plots-van-dyke}

The following plots are arranged in pairs, with the left plot corresponding to treatment 1 and the right to treatment 2. 


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-1-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 1." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-1)Composite plots in both treatments for Van Dyke dataset, reader 1.</p>
</div>


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-2-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 2. For treatment 2 the RSM and PROPROC fits are indistinguishable." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-2)Composite plots in both treatments for Van Dyke dataset, reader 2. For treatment 2 the RSM and PROPROC fits are indistinguishable.</p>
</div>



The RSM parameter values for the treatment 2 plot are: $\mu$ = 5.9346513, $\lambda$ = 0.3809031, $\nu$ = 0.9292484, $\zeta_1$ = 0.479145. The corresponding CBM values are $\mu$ = 5.9356142, $\alpha$ = 0.9292952, $\zeta_1$ = 1.20877. The RSM and CBM $\mu$ parameters are very close and likewise the RSM $\nu$ and CBM $\alpha$ parameters are very close - this is because they have similar physical meanings, which is investigated later in this chapter TBA. [The CBM does not have a parameter analogous to the RSM $\lambda$ parameter.] 



<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-3-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 3." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-3)Composite plots in both treatments for Van Dyke dataset, reader 3.</p>
</div>



The RSM parameters for the treatment 1 plot are: $\mu$ = 2.2014133, $\lambda$ = 0.2569453, $\nu$ = 0.7524016, $\zeta_1$ = -0.1097901. The corresponding CBM values are $\mu$ = 2.7457914, $\alpha$ = 0.7931264, $\zeta_1$ = 1.1250285. 



<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-4-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 4. For treatment 2 the 3 plots are indistinguishable and each one has AUC = 1. The degeneracy is due to all operating points being on the axes of the unit square." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-4)Composite plots in both treatments for Van Dyke dataset, reader 4. For treatment 2 the 3 plots are indistinguishable and each one has AUC = 1. The degeneracy is due to all operating points being on the axes of the unit square.</p>
</div>


<div class="figure">
<img src="12-rsm-3-fits_files/figure-html/rsm-3-fits-plots-1-5-1.png" alt="Composite plots in both treatments for Van Dyke dataset, reader 5." width="672" />
<p class="caption">(\#fig:rsm-3-fits-plots-1-5)Composite plots in both treatments for Van Dyke dataset, reader 5.</p>
</div>



## References {#rsm-3-fits-references}

