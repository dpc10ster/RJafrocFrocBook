# Evidence for the RSM {#rsm-evidence}





## How much finished {#rsm-evidence-how-much-finished}
70%


## Introduction {#rsm-evidence-intro}

This chapter details evidence for the validity of the radiological search model (RSM). Briefly, these are:

1.	Its correspondence to the empirical (i.e., measurement based) Kundel-Nodine model of radiological search. 
2.	In special cases, it reduces to being indistinguishable from the binormal model.
3.	It explains: 
    a. The empirical observation [@RN298] that most ROC datasets are characterized by b-parameter $b < 1$. 
    b. The empirical observation [@RN2635] that the $b$ tends to decrease as contrast increases. 
    c. The empirical observation [@RN2635], that the difference in means of the two pdfs divided by the difference in standard deviations is roughly constant.
4.	It explains data degeneracy, i.e., no interior data points, sometimes observed especially with expert observers. 
5.	It predicts FROC/AFROC and LROC curves that better fit real datasets.

As described in TBA Chapter 20, the CBM explains 3(a) and 4 while the bigamma model [@RN100] explains 3(c).

## Correspondence to the Kundel-Nodine model {#rsm-predictions-corresponence-kundel-nodine}
The strongest evidence for the validity of the RSM is its close correspondence to the Kundel-Nodine model of radiological search [@RN1533; @RN1388; @RN438; @RN1663], which in turn is derived from eye-tracking measurements made on radiologists while they perform diagnostic tasks. These show that radiologists identify suspicious regions in a short time and this ability corresponds to the $\lambda', \nu'$ parameters of the RSM. Having found suspicious regions, the next activity uncovered by eye-tracking measurements is the detailed examination of each suspicious region in order to determine if it is a significant finding. This is where the z-sample is calculated, and this process is modeled by two unit normal distributions separated by the $\mu$ parameter of the RSM. 

Other ROC models do not share this close correspondence. The CBM model comes closest ??? it models the probability that lesions are *found*, which is part of search performance, but the ability to *avoid finding NLs* is not modeled. Like other ROC models, CBM predicts that the point (1,1) is continuously accessible to observer, which implies zero search performance, TBA Fig. 17.6.

## The RSM can mimic the binormal model {#rsm-predictions-binormal-model-mimic}



ROC models assume that every case provides a finite decision variable sample. This is what permits the observer to *continuously* move the operating point to (1,1). According to the RSM a decision sample on every case is possible if $\lambda$ is large, since in the limit $\lambda \rightarrow \infty$ every case has at least one latent NL. It turns out, as shown next, that it is not necessary to go to infinite values of $\lambda$ to produce RSM-generated ratings data that are indistinguishable from those generated by the binormal model. Values of $\lambda$ around 1 to 10 are sufficient to demonstrate this fact. A factor that helps showing the indistinguishability is that the binormal model is remarkably resilient to departures from normality, its *robustness property*, demonstrated in [@RN1216]. It literally takes huge datasets, numbering in the thousands of cases, to show departures from strict normality. 

The ROC ratings datasets used in the following examples were generated by the RSM. The parameter values are listed in Table \@ref(tab:rsm-evidence-binormal-table2). RSM generated FROC datasets, in each case 500 non-diseased and 700 diseased cases were used, were converted to (highest rating) ROC datasets, each dataset was binned into 5 bins and then analyzed by an online Java program [@RN1975] which implements Metz's ROCFIT program, TBA Chapter 06, yielding the binormal parameters $a, b$ and the p-value of the chisquare goodness of fit statistic. Shown next are the binormal-model-fitted ROC curves to these datasets as well as the corresponding $a,b$ parameters. The value of Row corresponds to the row number in Table \@ref(tab:rsm-evidence-binormal-table2). 

<img src="17c-rsm-evidence_files/figure-html/rsm-evidence-binormal-plots1-do-not-use-1.png" width="672" />


<div class="figure">
<img src="17c-rsm-evidence_files/figure-html/rsm-evidence-binormal-plots2-1.png" alt="RSM generated ROC points and corresponding binormal model fitted curves." width="672" />
<p class="caption">(\#fig:rsm-evidence-binormal-plots2)RSM generated ROC points and corresponding binormal model fitted curves.</p>
</div>

Fig. \@ref(fig:rsm-evidence-binormal-plots2): ROC *operating points* obtained using RSM ratings-generator and corresponding binormal model *fitted curves*. The $a, b$ parameters are shown in the figure labels. The value of `Row` corresponds to the row number in Table \@ref(tab:rsm-evidence-binormal-table2). The plots show that over a wide range of parameters RSM generated ROC data is fitted reasonably by the binormal model. The p-values of the goodness of fit statistic, see Table \@ref(tab:rsm-evidence-binormal-table2), are all in the range of what is considered an acceptable fit to a model. As far as the binormal model-fitting software is concerned, the counts data arose from two *effectively normal distributions* (i.e., apart from the intrinsic uncertainty due to allowed arbitrary monotone transformations). Even with the large number of cases, sampling variability affects the binormal model fits: e.g., the binormal model curves in plots labeled "2" and "4" differ only in seed values. The hooks near (1,1) in the binormal ROC fitted curves are not easily visible but are nevertheless present as each of the b-parameters in Table \@ref(tab:rsm-evidence-binormal-table2) is less than unity. The error bars are exact 95% binomial confidence intervals on the operating points.   

**Since the binormal model has been used successfully for almost six decades, the ability to the RSM to mimic it is an important justification for the validity of the RSM.**









<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:rsm-evidence-binormal-table2)Simulating ROC binned ratings data using the RSM and fitting the ratings using the binormal model; s is the seed, L is the maximum number of lesions per case, A is the RSM-predicted ROC-AUC, Az is the binormal model fitted AUC and $\nu = 1$ for all datasets.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Row </th>
   <th style="text-align:left;"> s </th>
   <th style="text-align:left;"> L </th>
   <th style="text-align:left;"> $\mu$ </th>
   <th style="text-align:left;"> $\lambda$ </th>
   <th style="text-align:left;"> A </th>
   <th style="text-align:left;"> a </th>
   <th style="text-align:left;"> b </th>
   <th style="text-align:left;"> Az </th>
   <th style="text-align:left;"> pVal </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.787 </td>
   <td style="text-align:left;"> 1.002 </td>
   <td style="text-align:left;"> 0.861 </td>
   <td style="text-align:left;"> 0.776 </td>
   <td style="text-align:left;"> 0.223 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2.5 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.879 </td>
   <td style="text-align:left;"> 1.497 </td>
   <td style="text-align:left;"> 0.752 </td>
   <td style="text-align:left;"> 0.884 </td>
   <td style="text-align:left;"> 0.46 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.938 </td>
   <td style="text-align:left;"> 1.928 </td>
   <td style="text-align:left;"> 0.736 </td>
   <td style="text-align:left;"> 0.94 </td>
   <td style="text-align:left;"> 0.198 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2.5 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.879 </td>
   <td style="text-align:left;"> 1.221 </td>
   <td style="text-align:left;"> 0.682 </td>
   <td style="text-align:left;"> 0.843 </td>
   <td style="text-align:left;"> 0.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.844 </td>
   <td style="text-align:left;"> 1.25 </td>
   <td style="text-align:left;"> 0.786 </td>
   <td style="text-align:left;"> 0.837 </td>
   <td style="text-align:left;"> 0.903 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2.5 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.922 </td>
   <td style="text-align:left;"> 1.554 </td>
   <td style="text-align:left;"> 0.646 </td>
   <td style="text-align:left;"> 0.904 </td>
   <td style="text-align:left;"> 0.592 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 0.965 </td>
   <td style="text-align:left;"> 2.057 </td>
   <td style="text-align:left;"> 0.676 </td>
   <td style="text-align:left;"> 0.956 </td>
   <td style="text-align:left;"> 0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0.985 </td>
   <td style="text-align:left;"> 2.391 </td>
   <td style="text-align:left;"> 0.405 </td>
   <td style="text-align:left;"> 0.987 </td>
   <td style="text-align:left;"> 0.988 </td>
  </tr>
</tbody>
</table>


Table \@ref(tab:rsm-evidence-binormal-table2): Results of simulating ROC ratings tables using seeds and RSM parameter values specified in columns 2 ??? 5 and fitting each ratings table using the binormal model. The corresponding binormal model fitted ROC curves are shown in Fig. \@ref(fig:rsm-evidence-binormal-plots2). The number of non-diseased cases was 500, the number of diseased cases was 700, and the reporting threshold $\zeta_1 = -1$. 

Of interest in Table \@ref(tab:rsm-evidence-binormal-table2) is the observation that $b < 1$, and the qualities of the fits are quite good (p > 0.001 is generally considered acceptable, see [@RN300], 3rd edition, page 779). 

One expects $A \equiv AUC_{ROC}^{RSM}$ to exceed the binormal fitted value $A_z$. This has to do with the "proper" property of the RSM-ROC curve, which implies an *ideal observer*, while the binormal model predicts "improper" ROC curves, TBA Chapter 20. For rows 2 and 3, the expected orderings are reversed but the magnitudes of the discrepancies are small. This is because RSM-predicted values are *not* subject to sampling variability as they are derived by numerical integration, whose estimation error is very small compared to sampling error. In contrast, the estimates of $A_z$ are subject to sampling variability, even though large numbers of cases were used. Row-4 repeats Row-2 with a different value of `seed`: this time the expected ordering is observed $A > Az$. 


## Empirical observations
As summarized previously, there are three empirical observations regarding binormal parameters: 

* $b < 1$. 
* $b$ decreases as $a$ increases. 
* For fixed experimental conditions $R_{Swets} \equiv \frac {a}{1-b}$ is approximately constant.  


## Explanation for $b < 1$
The RSM-predicted ROC curves are consistent with empirical observations [@RN298] that observed ROC data, when fitted by the unequal variance binormal model, yield $b < 1$, implying that the diseased case pdf is wider than the non-diseased case pdf. The RSM provides an explanation for this: diseased cases yield two types of z-samples, namely NL z-samples from a zero-centered unit variance normal distribution and LL z-samples from a  $\mu$-centered unit variance normal distribution. The resulting *mixture distribution* is expected, when one attempts to fit it with a normal distribution, to yield standard deviation for diseased cases greater than 1, or, equivalently, $b < 1$. The fit is not expected to be ideal, but it is known that for relatively small numbers of cases, as is true with clinical data sets, it is difficult to detect deviations from strict normality; indeed, the binormal model is quite robust with respect to deviations from strict normality [@RN298]. Several examples of this were evident in the goodness of fit p-values in Table \@ref(tab:rsm-evidence-binormal-table2), which show good binormal fits to RSM generated data even with 1200 cases. 






<div class="figure">
<img src="17c-rsm-evidence_files/figure-html/rsm-evidence-pdf-plots-1.png" alt="pdfs along with the parameter values. The dotted curves correspond to non-diseased cases while solid curves correspond to diseased cases." width="672" />
<p class="caption">(\#fig:rsm-evidence-pdf-plots)pdfs along with the parameter values. The dotted curves correspond to non-diseased cases while solid curves correspond to diseased cases.</p>
</div>


Fig. \@ref(fig:rsm-evidence-pdf-plots): This figure provides an explanation for empirical observation $b < 1$. Displayed are pdfs along with the parameter values. For all plots $\lambda = 1$ and $L_{max} = 1$. The dotted curves correspond to non-diseased cases while the solid curves correspond to diseased cases. The solid curves are broader than the dotted ones. In (A) and (B) the solid curve is noticeably broader. In (D) there is a hint of a secondary peak at zero, which is quite prominent in (C), which corresponds to the largest $\mu$ and the smallest $\nu$. In each case the resulting mixture distribution is expected to lead to a larger estimate of standard deviation of the assumed normal distribution of diseased cases relative to non-diseased cases. 


## Explanation of Swets et al observations 

More than 55 years ago, [@RN2635] noticed in two non-medical imaging contexts:
 
* The standard deviation of the non-diseased distribution divided by the standard deviation of the diseased distribution, tended to decrease as contrast increased. In binormal parameter terms, $b$ decreases as $a$ increases.

* The ratio $R_{Swets} \equiv \Delta(mean) / \Delta(\sigma)$, henceforth referrd to as the Swets Ratio, has been conjectured to be approximately constant for a fixed set of experimental conditions. $\Delta(mean)$ is the separation of the means of the two distributions and $\Delta(\sigma)$ is the difference of the two standard deviations (diseased minus non-diseased). In binormal parameter terms, $R_{Swets} \equiv \frac{a}{1-b}$ is supposed to be approximately constant ^[The separation is $a$, the wider signal distribution has standard deviation unity while the narrower noise distribution has standard deviation $b$.].

The second observation implies a peculiar relation between the $a$ and $b$ parameters. Recall Figure TBA (fig:binormal-model-ab2-mu-sigma), Plot A, which shows the definitions of the binormal $a$ and $b$ parameters. The diseased pdf has unit standard deviation, while the non-diseased has standard deviation $b < 1$, and the separation of the two distributions is $a$. The constancy of Swets Ratio implies that as $a$ increases $b$ decreases (which implies that the first Swets observation is actually contained in the second) so as to increase $1-b$ by the same factor. Since $b$ is a standard deviation, i.e., $b > 0$, it can only shrink so far, and eventually, for large enough $a$, the presumed constancy must fail. In particular, as $b$ approaches unity (corresponding to the equal variance binormal model) the ratio must approach infinity. Nevertheless, it is interesting to use the RSM to test this hypothesis.

Testing over a range of $\mu$ using binormal model maximum likelihood fitting is direct but cumbersome and subject to failure as it depends on convergence of the binormal model algorithm, which is problematical for larger values of $\mu$, which lead to degenerate datasets. Instead, the following method was used. The search model predicted pdfs were normalized so that they individually integrated to unit areas over the continuous sections. Normalization was accomplished by dividing the non-diseased pdf by the x-coordinate of the end-point, and the diseased pdf by the y-coordinate of the end-point. The means and standard deviations of these distributions were calculated by numerical integration. Since the binormal model is not used, the effective binormal parameters will henceforth be referred to as $a_{eff}$ and $b_{eff}$. In this notation, the Swets Ratio is $R_{Swets} \equiv \frac{a_{eff}}{1-b_{eff}}$.  

The following equations describe the calculations involved, which are implemented in the code:

\begin{equation}
\left. 
\begin{aligned}
\left \langle x \right \rangle_N = & \int_{-\infty}^{\infty} xf_N(x) dx \\
\left \langle x \right \rangle_D = & \int_{-\infty}^{\infty} xf_D(x) dx \\
\sigma_N^2 = & \int_{-\infty}^{\infty} \left (x - \left \langle x \right \rangle_N  \right )^2f_N(x) dx \\
\sigma_D^2 = & \int_{-\infty}^{\infty} \left (x - \left \langle x \right \rangle_D  \right )^2f_D(x) dx \\
\end{aligned}
\right \}
(\#eq:rsm-evidence-x-sigmax2)
\end{equation}


Subscripts $N$ and $D$ refer to non-diseased and diseased cases, respectively, while $f(x)$ is the normalized $pdf$ function. The effective binormal parameters are defined as:


\begin{equation}
\left. 
\begin{aligned}
a_{eff} = & \frac{\left \langle x \right \rangle_D - \left \langle x \right \rangle_N  } {\sigma_D}\\
b_{eff} = & \frac{\sigma_N}{\sigma_D}\\
R_{Swets} = & \frac{a_{eff}}{1 - b_{eff} }
\end{aligned}
\right \}
(\#eq:rsm-evidence-delta-mean-sigma)
\end{equation}


Varying experimental conditions were simulated by individually varying two of the three parameters of the RSM under the constraint that the RSM predicted AUC (assuming $\zeta_1 = -\infty$) remains constant at a specified value. Without this constraint, variation of a single parameter, e.g., $\mu$, would cause AUC to vary over the entire range 0.5 to 1, which is uncharacteristic of radiologists interpreting the same case set. Rather, we assume that observers characterized by different RSM parameters nevertheless converge to roughly the same RSM-AUCs. In other words, they trade deficiencies in one area (e.g., finding too many NLs, large $\lambda$) with increased performance in other areas (e.g., finding more lesions, i.e., larger $\nu$, and/or greater perceptual signal to noise ratio, i.e., larger $\mu$).


In the code, the number of lesions per diseased case was set to one. The function `FindParamFixAuc()` finds the missing RSM parameter, indicated by initializing it with `NA`. The function `effectiveAB()` calculates the separation $a_{eff}$ and standard deviation ratio $b_{eff}$ (non-diseased to diseased) of the two distributions, after normalizing each to unit area. 










Perhaps the best way of illustrating the near constancy of the Swets Ratio is by fixing $\lambda = 2$ and varying $\mu$ and $\nu$ to keep AUC constant, as in Table \@ref(tab:rsm-evidence-table1A). This results in a large range over which $\mu$ is varied, from 2.000 to 5.000. The RSM $\mu$ parameter controls the separation of non-diseased and diseased pdfs and as such directly affects the binormal $a_{eff}$ parameter. Hence the corresponding large range for $a_{eff}$, from 1.064 to 2.869. The RSM $\nu'$ parameter is relatively constant, ranging from 0.1474 to 0.4376. Note that the *physical $\lambda'$ and $\nu'$ (i.e., primed) quantities* are shown in the table. This table shows that the Swets Ratio is near constant, ranging from 4.928 to 7.706. Note the increase in the ratio for the largest value of $b_{eff}$, i.e., that closest to unity, which, as noted earlier, is as expected. 


<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:rsm-evidence-table1A)Here $\lambda = 2$ is held constant while the other two parameters are varied to keep AUC at 0.7. The last column lists the Swets Ratio. Note the inverse relation between $a_{eff}$ and $b_{eff}$.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> $AUC$ </th>
   <th style="text-align:left;"> $\mu$ </th>
   <th style="text-align:left;"> $\lambda'$ </th>
   <th style="text-align:left;"> $\nu'$ </th>
   <th style="text-align:left;"> $a_{eff}$ </th>
   <th style="text-align:left;"> $b_{eff}$ </th>
   <th style="text-align:left;"> $\frac{a_{eff}}{1-b_{eff}}$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="10"> 0.7 </td>
   <td style="text-align:left;"> 2.000 </td>
   <td style="text-align:left;"> 1.0000 </td>
   <td style="text-align:left;"> 0.4376 </td>
   <td style="text-align:left;"> 1.064 </td>
   <td style="text-align:left;"> 0.7852 </td>
   <td style="text-align:left;"> 4.953 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2.214 </td>
   <td style="text-align:left;"> 0.9032 </td>
   <td style="text-align:left;"> 0.3815 </td>
   <td style="text-align:left;"> 1.192 </td>
   <td style="text-align:left;"> 0.7582 </td>
   <td style="text-align:left;"> 4.928 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2.452 </td>
   <td style="text-align:left;"> 0.8158 </td>
   <td style="text-align:left;"> 0.3349 </td>
   <td style="text-align:left;"> 1.336 </td>
   <td style="text-align:left;"> 0.7337 </td>
   <td style="text-align:left;"> 5.018 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 2.714 </td>
   <td style="text-align:left;"> 0.7368 </td>
   <td style="text-align:left;"> 0.2957 </td>
   <td style="text-align:left;"> 1.498 </td>
   <td style="text-align:left;"> 0.7120 </td>
   <td style="text-align:left;"> 5.200 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 3.005 </td>
   <td style="text-align:left;"> 0.6655 </td>
   <td style="text-align:left;"> 0.2622 </td>
   <td style="text-align:left;"> 1.677 </td>
   <td style="text-align:left;"> 0.6929 </td>
   <td style="text-align:left;"> 5.461 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 3.327 </td>
   <td style="text-align:left;"> 0.6011 </td>
   <td style="text-align:left;"> 0.2333 </td>
   <td style="text-align:left;"> 1.875 </td>
   <td style="text-align:left;"> 0.6764 </td>
   <td style="text-align:left;"> 5.793 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 3.684 </td>
   <td style="text-align:left;"> 0.5429 </td>
   <td style="text-align:left;"> 0.2081 </td>
   <td style="text-align:left;"> 2.092 </td>
   <td style="text-align:left;"> 0.6620 </td>
   <td style="text-align:left;"> 6.190 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 4.079 </td>
   <td style="text-align:left;"> 0.4903 </td>
   <td style="text-align:left;"> 0.1856 </td>
   <td style="text-align:left;"> 2.330 </td>
   <td style="text-align:left;"> 0.6494 </td>
   <td style="text-align:left;"> 6.645 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 4.516 </td>
   <td style="text-align:left;"> 0.4429 </td>
   <td style="text-align:left;"> 0.1655 </td>
   <td style="text-align:left;"> 2.588 </td>
   <td style="text-align:left;"> 0.6380 </td>
   <td style="text-align:left;"> 7.151 </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> 5.000 </td>
   <td style="text-align:left;"> 0.4000 </td>
   <td style="text-align:left;"> 0.1474 </td>
   <td style="text-align:left;"> 2.869 </td>
   <td style="text-align:left;"> 0.6276 </td>
   <td style="text-align:left;"> 7.706 </td>
  </tr>
</tbody>
</table>


In Table \@ref(tab:rsm-evidence-table1B) the parameter $\nu = 1$ is held fixed while $\mu$ and $\lambda$ are varied. This time $a_{eff}$ is relatively constant, ranging from \infty{} to -\infty{}, while $b_{eff}$ is very close to unity, ranging from \infty{} to -\infty{}, leading to the very large and varying values of the Swets Ratio, ranging from \infty{} to -\infty{}.







