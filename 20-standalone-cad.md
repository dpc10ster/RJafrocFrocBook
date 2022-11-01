# (PART\*) CAD applications {-}

# Standalone CAD vs. Radiologists {#standalone-cad-radiologists}





## TBA How much finished {#standalone-cad-radiologists-how-much-finished}
60%

<!-- ### This does not work -->

<!-- ```{r} -->
<!-- df <- data.frame(C1 = c(rep("a", 10), rep("b", 5)), -->
<!--                  C2 = c(rep("c", 7), rep("d", 3), rep("c", 2), rep("d", 3)), -->
<!--                  C3 = 1:15, -->
<!--                  C4 = sample(c(0,1), 15, replace = TRUE)) -->
<!-- ``` -->



<!-- ```{r} -->
<!-- kbl(df, align = "c") %>% -->
<!--   kable_paper(full_width = F) %>% -->
<!--   column_spec(1, bold = T) %>% -->
<!--   collapse_rows(columns = 1:2, valign = "top") -->
<!-- ``` -->


<!-- ### This works! -->


<!-- Define this function: -->




<!-- Now apply it: -->

<!-- ```{r} -->
<!-- kbl(collapse_rows_df(collapse_rows_df(df,C1), C2), align = "c") %>% -->
<!--   kable_paper(full_width = F) %>% -->
<!--   column_spec(1, bold = T) %>% -->
<!--   collapse_rows(columns = 1:2, valign = "top") -->
<!-- ```   -->


## Introduction {#standalone-cad-radiologists-introduction}

In the US the majority of screening mammograms are analyzed by computer aided detection (CAD) algorithms [@rao2010widely]. Almost all major imaging device manufacturers provide CAD as part of their imaging workstation display software. In the United States CAD is approved for use as a second reader, i.e., the radiologist first interprets the images (typically 4 views, 2 views of each breast) without CAD and then CAD information (i.e., cued suspicious regions, possibly shown with associated probabilities of malignancies) is shown and the radiologist has the opportunity to revise the initial interpretation. In response to the FDA-approved second reader usage, the evolution of CAD algorithms has been guided mainly by comparing observer performance of radiologists with and without CAD.

Clinical CAD systems sometimes only report the locations of suspicious regions, i.e., it may not provide ratings. Analysis of this type of date is deferred to a following TBA chapter. However, a malignancy index (a continuous variable) for every CAD-found suspicious region is available to the algorithm designer [@edwards2002maximum]. Standalone performance, i.e., performance of designer-level CAD by itself, regarded as an algorithmic reader, vs. radiologists, is rarely measured. In breast cancer screening I am aware of only one study [@hupse2013standalone] where standalone performance was measured. ^[Standalone performance has been measured in CAD for computed tomography colonography, chest radiography and three dimensional ultrasound [@hein2010computeraided; @summers2008performance; @taylor2006computerassisted; @deBoo2011computeraided; @tan2012computeraided]].

One possible reason for not measuring standalone performance of CAD is the lack of an accepted assessment method for such measurements. The purpose of this work is to remove that impediment. It describes a method for comparing standalone performance of designer-level CAD to radiologists interpreting the same cases and compares the method to those described in two recent publications [@hupse2013standalone; @kooi2016comparison].

## Overview {#standalone-cad-radiologists-overview}

This chapter extends the method used in a recent study of standalone CAD performance [@hupse2013standalone], termed one-treatment random-reader fixed case or **1T-RRFC** analysis, since CAD is treated as an additional reader within a single treatment and since it only accounts for reader variability but does not account for case-variability. 

The extension includes the effect of case-sampling variability and is hence termed one-treatment random-reader random-case or **1T-RRRC** analysis. The method is based on an existing method allowing comparison of the average performance of readers in a single treatment to a specified value. The key modification is to regard the difference in performance between radiologists over CAD as a figure of merit to which the existing work is directly applicable. The 1T-RRRC method is compared to 1T-RRFC. 

The 1T-RRRC method is also compared to an unorthodox usage of conventional multiple-treatment multiple-reader method, termed **2T-RRRC** analysis, which involves replicating the CAD ratings as many times as there are radiologists, in effect simulating a second treatment, i.e., CAD is regarded as the second treatment (with identical readers within this treatment) to which existing methods (DBM or OR, as described in [RJafrocRocBook](https://dpc10ster.github.io/RJafrocRocBook/dbm-analysis-significance-testing.html)) is applied. 
`

## Methods {#standalone-cad-radiologists-methods}



Summarized are two recent studies of CAD vs. radiologists in mammography. This is followed by comments on the methods used in the two studies. The second study used multi-treatment multi-reader receiver operating characteristic (ROC) software in an unorthodox way. A statistical model and analysis method is described that avoids the unorthodox usage of ROC software and has fewer model parameters.

### Studies assessing performance of CAD vs. radiologists {#standalone-cad-radiologists-two-previous-studies}

The first study [@hupse2013standalone] measured performance in finding and localizing lesions in mammograms, i.e., visual search was involved, while the second study [@kooi2016comparison] measured lesion classification performance between non-diseased and diseased regions of interest (ROIs) previously found on mammograms by an independent algorithmic reader, i.e., visual search was not involved.

#### Study - 1 {#standalone-cad-radiologists-study1}

The first study [@hupse2013standalone] compared standalone performance of a CAD device to that of 9 radiologists interpreting the same cases (120 non-diseased and 80 with a single malignant mass per case). It used the LROC (localization ROC) paradigm [@starr1975visual; @metz1976observer; @swensson1996unified], in which the observer gives an overall rating for presence of disease (an integer 0 to 100 scale was used) and indicates the location of the most suspicious region. On a non-diseased case the rating is classified as a false positive (FP) but on a diseased case it is classified as a *correct localization* (CL) if the location is sufficiently close to the lesion and otherwise it is classified as an *incorrect localization*. For a given reporting threshold, the number of correct localizations divided by the number of diseased cases estimates the probability of correct localization (PCL) at that threshold. On non-diseased cases the number of false positives (FPs) divided by the number of non-diseased cases estimates the probability of a false positive, or false positive fraction (FPF), at that threshold. The plot of PCL (ordinate) vs. FPF defines the empirical LROC curve. Study - 1 used as figures of merit (FOMs) the interpolated PCL at two values of FPF, specifically FPF = 0.05 and FPF = 0.2, denoted $\text{PCL}_{0.05}$ and $\text{PCL}_{0.2}$, respectively. A t-test between the radiologist $\text{PCL}_{\text{FPF}}$ values and that of CAD was used to compute the two-sided p-value for rejecting the NH of equal performance. Study - 1 reported p-value = 0.17 for $\text{PCL}_{0.05}$ and p-value $\leq$ 0.001, with CAD being inferior, for $\text{PCL}_{0.2}$.


#### Study - 2 {#standalone-cad-radiologists-study2}

The second study [@kooi2016comparison] used 199 diseased and 199 non-diseased ROIs extracted by an independent CAD algorithm. These were analyzed by a different CAD algorithmic observer from that used to determine the ROIs and by four expert radiologists. In either case the ROC paradigm was used (i.e., a rating was obtained for each ROI) The figure of merit was the empirical area (AUC) under the respective ROC curves (one for each radiologist and one for CAD). The p-value for the difference in AUCs between the average radiologist's AUC and CAD AUC was determined using an unorthodox application of the Dorfman-Berbaum-Metz [@dorfman1992receiver] multiple-treatment multiple-reader multiple-case (DBM-MRMC) software. 

The application was unorthodox in the sense that in the input data file **radiologists and CAD were entered as two treatments**. In conventional (or orthodox) DBM-MRMC each reader provides two ratings per case and the data file would consist of paired ratings of a set of cases interpreted by 4 readers. To accommodate the paired data structure assumed by the software, the authors of Study - 2 **replicated the CAD ratings four times in the input data file**, as explained in the caption to Table \@ref(tab:standalone-cad-table-conventional). By this artifice they converted a single-treatment 5-reader (4 radiologists plus CAD) data file to a two-treatment 4-reader data file in which the four readers in treatment 1 were the radiologists, and the four "readers" in treatment 2 were CAD replicated ratings. Note that for each case the four readers in the second treatment had identical ratings. In Table 1 the replicated CAD readers are labeled C1, C2, C3 and C4.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:standalone-cad-table-conventional)The differences between the data structures in conventional DBM-MRMC analysis and the unorthodox application of the software used in Study - 2. There are four radiologists, labeled R1, R2, R3 and R4 interpreting 398 cases labeled 1, 2, …, 398, in two treatments, labeled 1 and 2. Sample ratings are shown only for the first and last radiologist and the first and last case. In the first four columns, labeled "Standard DBM-MRMC", each radiologist interprets each case twice. In the next four columns, labeled "Unorthodox DBM-MRMC", the radiologists interpret each case once. CAD ratings are replicated four times to effectively create the second "treatment". The quotations emphasize that there is, in fact, only one treatment. The replicated CAD observers are labeled C1, C2, C3 and C4.</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="4"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Standard DBM-MRMC</div></th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1"></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="4"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Unorthodox DBM-MRMC</div></th>
</tr>
  <tr>
   <th style="text-align:left;"> Reader </th>
   <th style="text-align:left;"> Treatment </th>
   <th style="text-align:left;"> Case </th>
   <th style="text-align:left;"> Rating </th>
   <th style="text-align:left;">  </th>
   <th style="text-align:left;"> Reader </th>
   <th style="text-align:left;"> Treatment </th>
   <th style="text-align:left;"> Case </th>
   <th style="text-align:left;"> Rating </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 75 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 50 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> C1 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 55 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R1 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> C1 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 95 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> C4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 55 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
   <td style="text-align:left;"> ... </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> C4 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 398 </td>
   <td style="text-align:left;"> 5 </td>
  </tr>
</tbody>
</table>

Study -- 2 reported a not significant difference between CAD and the radiologists (p = 0.253).

#### Comments {#standalone-cad-radiologists-comments}

For the purpose of this work, which focuses on the respective analysis methods, the difference in observer performance paradigms between the two studies, namely a search paradigm in Study - 1 vs. an ROI classification paradigm in Study -- 2, is inconsequential. The paired t-test used in Study - 1 treats the case-sample as fixed. In other words, the analysis is not accounting for case-sampling variability but it is accounting for reader variability. While not explicitly stated, the reason for the unorthodox analysis in Study -- 2 was the desire to include case-sampling variability. [^standalone-cad-1]

[^standalone-cad-1]: Prof. Karssemeijer (private communication, 10/27/2017) had consulted with a few ROC experts to determine if the procedure used in Study -- 2 was valid, and while the experts thought it was probably valid they were not sure.

In what follows, the analysis in Study -- 1 is referred to as **single-treatment random-reader fixed-case (1T-RRFC)** while that in Study -- 2 is referred to as **dual-treatment random-reader random-case (2T-RRRC)**.

### The 1T-RRFC analysis model
The sampling model for the FOM is:

```{=tex}
\begin{equation}
\left.
\begin{aligned}
\theta_j=\mu+R_j \\
\left (j = 1,2,...J  \right )
\end{aligned}
\right \}
(\#eq:standalone-1t-rrfc)
\end{equation}
```


Here $\mu$ is a constant, $\theta_j$ is the FOM for reader $j$, and $R_j$ is the random contribution for reader $j$ distributed as:

```{=tex}
\begin{equation}
R_j \sim  N\left ( 0,\sigma_R^2 \right )
(\#eq:standalone-cad-2t-rrfc-rj-sampling)
\end{equation}
```

Because of the assumed normal distribution of $R_j$, in order to compare the readers to a fixed value, that of CAD denoted $\theta_0$, one uses the (unpaired) t-test, as done in Study -- 1. As evident from the model, no allowance is made for case-sampling variability, which is the reason for calling it the 1T-RRFC method.

Performance of CAD on a fixed dataset does exhibit within-CAD variability, i.e., CAD applied repeatedly to a fixed dataset does not always produce the same mark-rating data. However, this source of within-CAD variability is much smaller than *inter-reader* variability of radiologists interpreting the same dataset. The *within-reader* variability of radiologists is smaller than *inter-reader* variability and *within-CAD* variability is even smaller. For this reason one is justified in regarded $\theta_0$ as a fixed quantity for a given dataset. Varying the dataset will result in different values for $\theta_0$ reflecting case sampling variability which needs to be accounted for as done in the following analyses. 


### The 2T-RRRC analysis model {#standalone-cad-radiologists-2TRRRC-anlaysis}

This could be termed the conventional or the orthodox method. There are two treatments and the study design is fully crossed: each reader interprets each case in each treatment, i.e., the data structure is as in the left half of Table \@ref(tab:standalone-cad-table-conventional). 

The following approach, termed 2T-RRRC, uses the Obuchowski and Rockette (OR) figure of merit sampling model [@obuchowski1995hypothesis]. The OR model is:


```{=tex}
\begin{equation}
\theta_{ij\{c\}}=\mu+\tau_i+\left ( \tau \text{R} \right )_{ij}+\epsilon_{ij\{c\}}
(\#eq:standalone-cad-model-2t-rrrc)
\end{equation}
```


Assuming two treatments, $i$ ($i = 1, 2$) is the treatment index, $j$ ($j = 1, ..., J$) is the reader index, and $k$ ($k = 1, ..., K$) is the case index, and $\theta_{ij\{c\}}$ is the figure of merit in treatment $i$ for reader $j$ and case-sample $\{c\}$. A case-sample is a set or ensemble of cases, diseased and non-diseased, and different integer values of $c$ correspond to different case-samples. 

The first two terms on the right hand side of Eqn. \@ref(eq:standalone-cad-model-2t-rrrc) are fixed effects (average performance and treatment effect, respectively). The next two terms are random effect variables that, by assumption, are sampled as follows:

```{=tex}
\begin{equation}
\left.
\begin{aligned}  
R_j \sim  N\left ( 0,\sigma_R^2 \right )\\
\left ( \tau R \right )_{ij} \sim N\left ( 0,\sigma_{\tau R}^2 \right )\\
\end{aligned}
\right \}
(\#eq:standalone-cad-2t-r-taur-sampling)
\end{equation}
```

The terms $R_j$ represents the random treatment-independent contribution of reader $j$, modeled as a sample from a zero-mean normal distribution with variance $\sigma_R^2$, $\left ( \tau R \right )_{ij}$ represents the random treatment-dependent contribution of reader $j$ in treatment $i$, modeled as a sample from a zero-mean normal distribution with variance $\sigma_{\tau R}^2$. The sampling of the last (error) term is described by:

```{=tex}
\begin{equation}
\epsilon_{ij\{c\}}\sim N_{I \times J}\left ( \vec{0} , \Sigma \right )
(\#eq:standalone-cad-2t-eps-sampling)
\end{equation}
```

Here $N_{I \times J}$ is the $I \times J$ variate normal distribution and $\vec{0}$, a  $I \times J$ length zero-vector, represents the mean of the distribution. The $\{I \times J\} \times \{I \times J\}$ dimensional covariance matrix $\Sigma$ is defined by 4 parameters, $\text{Var}$, $\text{Cov}_1$, $\text{Cov}_2$, $\text{Cov}_3$, defined as follows:

```{=tex}
\begin{equation}
\text{Cov} \left (\epsilon_{ij\{c\}},\epsilon_{i'j'\{c\}} \right ) =
\left\{\begin{matrix}
\text{Var} \; (i=i',j=j') \\
\text{Cov1} \; (i\ne i',j=j')\\ 
\text{Cov2} \; (i = i',j \ne j')\\ 
\text{Cov3} \; (i\ne i',j \ne j')
\end{matrix}\right\}
(\#eq:standalone-cad-2t-rrrc-cov)
\end{equation}
```

Software {U of Iowa and `RJafroc`} yields estimates of all terms appearing on the right hand side of Eqn. \@ref(eq:standalone-cad-2t-rrrc-cov). Excluding fixed effects the model represented by Eqn. \@ref(eq:standalone-cad-model-2t-rrrc) contains six parameters:

```{=tex}
\begin{equation}
\sigma_R^2, \sigma_{\tau R}^2, \text{Var}, \text{Cov}_1, \text{Cov}_2, \text{Cov}_3
(\#eq:standalone-cad-2t-rrrc-varcom)
\end{equation}
```

The meanings the last four terms are described in [@hillis2007comparison; @obuchowski1995hypothesis; @hillis2005comparison; @chakraborty2017observer]. Briefly, $\text{Var}$ is the variance of a reader's FOMs, in a given treatment, over interpretations of different case-samples, averaged over readers and treatments; $\text{Cov}_1/\text{Var}$ is the correlation of a reader's FOMs, over interpretations of different case-samples in different treatments, averaged over all different-treatment same-reader pairings; $\text{Cov}_2/\text{Var}$ is the correlation of different reader's FOMs, over interpretations of different case-samples in the same treatment, averaged over all same- treatment different-reader pairings and finally, $\text{Cov}_3/\text{Var}$ is the correlation of different reader's FOMs, over interpretations of different case-samples in different treatments, averaged over all different-treatment different-reader pairings. One expects the following inequalities to hold:

```{=tex}
\begin{equation}
\text{Var} \geq \text{Cov}_1 \geq \text{Cov}_2 \geq \text{Cov}_3
(\#eq:standalone-cad-2t-rrrc-varcom-ordering)
\end{equation}
```

In practice, since one is usually limited to one case-sample, i.e., $c = 1$, resampling techniques [@efron1994introduction] -- e.g., the jackknife -- are used to estimate these terms.

### The 1T-RRRC analysis model {#standalone-cad-radiologists-1TRRRC-anlaysis}

The difference from the approach in Study - 2, and the main contribution of this work, is to regard standalone CAD as a different reader, not as a different treatment. This section describes a single treatment method for analyzing readers and CAD, where CAD is regarded as an additional reader and artificially replicated CAD data becomes unnecessary. Accordingly the proposed method is termed **single-treatment random-reader random-case (1T-RRRC)** analysis. 

The starting point is the [@obuchowski1995hypothesis] model for a single treatment, which for the radiologists (i.e., *excluding* CAD) interpreting in a single-treatment reduces to the following model:

```{=tex}
\begin{equation}
\theta_{j\{c\}}=\mu+R_j+\epsilon_{j\{c\}}
(\#eq:standalone-or-model-single-treatment)
\end{equation}
```

$\theta_{j\{c\}}$ is the figure of merit for radiologist $j$ ($j = 1, 2, ..., J$) interpreting case-sample $\{c\}$; $R_j$ is the random effect of radiologist $j$ and $\epsilon_{j\{c\}}$ is the error term. For single-treatment multiple-reader interpretations the error term is distributed as:

```{=tex}
\begin{equation}
\epsilon_{j\{c\}}\sim N_{J}\left ( \vec{0} , \Sigma \right )
(\#eq:standalone-cad-1t-eps-sampling)
\end{equation}
```

The $J \times J$ covariance matrix $\Sigma$ is defined by two parameters, $\text{Var}$ and $\text{Cov}_2$, as follows:

```{=tex}
\begin{equation}
\Sigma_{jj'} = \text{Cov}\left ( \epsilon_{j\{c\}}, \epsilon_{j'\{c\}} \right )
=
\left\{\begin{matrix}
\text{Var} & j = j'\\ 
\text{Cov}_2 & j \neq j'
\end{matrix}\right.
(\#eq:standalone-cad-1t-var-cov2-sampling)
\end{equation}
```

In practice the terms $\text{Var}$ and $\text{Cov}_2$ are estimated using the jackknife method.

#### Single treatment analysis for radiologists

Hillis [@hillis2005comparison; @hillis2007comparison] has described how to use the single treatment model \@ref(eq:standalone-or-model-single-treatment) to compare a groups of radiologists' average performance to a fixed value, in effect the $\text{NH}: \mu = \mu_0$, where $\mu_0$ is a pre-specified constant. 

One might be tempted to set $\mu_0$ equal to the performance of CAD but that would not be accounting for the fact that the performance of CAD is itself a random variable whose case-sampling variability needs to be accounted for.

#### Adaptation of single treatment analysis to accommodate CAD

Instead, the following model is used for the figure of merit of the radiologists **and** CAD (note that $j = 0$ is used to denote the CAD algorithmic reader):

```{=tex}
\begin{equation}
\theta_{j\{c\}} = \theta_{0\{c\}} + \Delta \theta + R_j + \epsilon_{j\{c\}}\\
j=1,2,...J
(\#eq:standalone-cad-1t-thetaj)
\end{equation}
```

$\theta_{0\{c\}}$ is the CAD figure of merit for case-sample $\{c\}$ and $\Delta \theta$ is the average figure of merit increment of the radiologists over CAD. To reduce this model to one to which Hillis' formulae are directly applicable, one subtracts the CAD figure of merit from each radiologist's figure of merit for the same case-sample, and defines this as the difference figure of merit $\psi_{j\{c\}}$ , i.e.,

```{=tex}
\begin{equation}
\psi_{j\{c\}} = \theta_{j\{c\}} - \theta_{0\{c\}}
(\#eq:standalone-cad-diff-reader-def)
\end{equation}
```

Then Eqn. \@ref(eq:standalone-cad-1t-thetaj) reduces to:

```{=tex}
\begin{equation}
\psi_{j\{c\}} = \Delta \theta + R_j + \epsilon_{j\{c\}}
(\#eq:standalone-cad-1t-psi)
\end{equation}
```

Eqn. \@ref(eq:standalone-cad-1t-psi) is identical in form to Eqn. \@ref(eq:standalone-or-model-single-treatment) excepting that the figure of merit on the left hand side of Eqn. \@ref(eq:standalone-cad-1t-psi) is a *difference FOM*, that between the radiologist's and CAD, i.e., describing a model for $J$ radiologists interpreting a common case set, each of whose performances is measured *relative* to that of CAD. Under the NH the expected difference is zero: $\text{NH:} \Delta \theta = 0$. The method [@hillis2005comparison; @hillis2007comparison] for single-treatment multiple-reader analysis is now directly applicable to the model described by Eqn. \@ref(eq:standalone-cad-1t-psi).

Apart from fixed effects, the model in Eqn. \@ref(eq:standalone-cad-1t-psi) contains three parameters:

```{=tex}
\begin{equation}
\sigma_R^2, \text{Var}, \text{Cov}_2
(\#eq:standalone-cad-1t-parms)
\end{equation}
```

Setting $\text{Var} = 0, \text{Cov}_2 = 0$ yields the 1T-RRFC model which contains only one random parameter, namely $\sigma_R^2$. One expects an identical estimate of this parameter using 1T-RRRC analyses.

## Implementation {#standalone-cad-radiologists-computational-details}

The three analyses, namely random-reader fixed-case (1T-RRFC), dual-treatment random-reader random-case (2T-RRRC) and single-treatment random-reader random-case (1T-RRRC), are implemented in `RJafroc`. 

The following code shows usage of the software to generate the results. Note that `datasetCadLroc` is the LROC dataset and `dataset09` is the corresponding ROC dataset. 



```r
RRFC_1T_PCL_0_05 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.05, method = "1T-RRFC")
RRRC_2T_PCL_0_05 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.05, method = "2T-RRRC")
RRRC_1T_PCL_0_05 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.05, method = "1T-RRRC")

RRFC_1T_PCL_0_2 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.2, method = "1T-RRFC")
RRRC_2T_PCL_0_2 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.2, method = "2T-RRRC")
RRRC_1T_PCL_0_2 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 0.2, method = "1T-RRRC")

RRFC_1T_PCL_1 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 1, method = "1T-RRFC")
RRRC_2T_PCL_1 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 1, method = "2T-RRRC")
RRRC_1T_PCL_1 <- StSignificanceTestingCadVsRad (datasetCadLroc, 
FOM = "PCL", FPFValue = 1, method = "1T-RRRC")

RRFC_1T_AUC <- StSignificanceTestingCadVsRad (dataset09, 
FOM = "Wilcoxon", method = "1T-RRFC")
RRRC_2T_AUC <- StSignificanceTestingCadVsRad (dataset09, 
FOM = "Wilcoxon", method = "2T-RRRC")
RRRC_1T_AUC <- StSignificanceTestingCadVsRad (dataset09, 
FOM = "Wilcoxon", method = "1T-RRRC")
```


The results are organized as follows:


* `RRFC_1T_PCL_0_05` contains the results of 1T-RRFC analysis for figure of merit = $\text{PCL}_{0.05}$. 
* `RRRC_2T_PCL_0_05` contains the results of 2T-RRRC analysis for figure of merit = $\text{PCL}_{0.05}$.
* `RRRC_1T_PCL_0_05` contains the results of 1T-RRRC analysis for figure of merit = $\text{PCL}_{0.05}$.

* `RRFC_1T_PCL_0_2` contains the results of 1T-RRFC analysis for figure of merit = $\text{PCL}_{0.2}$.
* `RRRC_2T_PCL_0_2` contains the results of 2T-RRRC analysis for figure of merit = $\text{PCL}_{0.2}$.
* `RRRC_1T_PCL_0_2` contains the results of 1T-RRRC analysis for figure of merit = $\text{PCL}_{0.2}$.

* `RRFC_1T_AUC` contains the results of 1T-RRFC  analysis for the Wilcoxon figure of merit.
* `RRRC_2T_AUC` contains the results of 2T-RRRC  analysis for the Wilcoxon figure of merit.
* `RRRC_1T_AUC` contains the results of 1T-RRRC analysis for the Wilcoxon figure of merit.

The structures of these objects are illustrated with examples in the Appendix. 


















## Results {#standalone-cad-radiologists-results}

The three methods, 1T-RRFC, 2T-RRRC and 1T-RRRC, were applied to an LROC dataset similar to that used in Study -- 1 (I thank Prof. Karssemeijer for making this dataset available), Table \@ref(tab:standalone-cad-table2).


<table class="table table-striped table-hover table-condensed table-responsive" style="font-size: 10px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:standalone-cad-table2)Significance testing results for an LROC dataset. For each figure of merit (FOM) shown are results of RRRC, 2T-RRRC and 1T-RRRC analyses. Because it is accounting for an additional source of variability, each of the rows labeled RRRC yields a larger p-value and wider confidence interval than the corresponding row labeled RRFC. [$\theta_0$ = FOM CAD; $\theta_{\bullet}$ = average FOM of radiologists; $\psi_{\bullet}$ = average FOM of radiologists minus CAD; CI= 95 percent confidence interval of quantity indicated by the subscript, F = F-statistic; ddf = denominator degrees of freedom; p = p-value for rejecting the null hypothesis: $\psi_{\bullet} = 0$.]</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> FOM </th>
   <th style="text-align:left;"> Analysis </th>
   <th style="text-align:left;"> $\theta_0$ </th>
   <th style="text-align:left;"> $CI_{\theta_0}$ </th>
   <th style="text-align:left;"> $\theta_{\bullet}$ </th>
   <th style="text-align:left;"> $CI_{\theta_{\bullet}}$ </th>
   <th style="text-align:left;"> $\psi_{\bullet}$ </th>
   <th style="text-align:left;"> $CI_{\psi_{\bullet}}$ </th>
   <th style="text-align:left;"> F </th>
   <th style="text-align:left;"> ddf </th>
   <th style="text-align:left;"> p </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PCL\_0\_05 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.45 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.493 </td>
   <td style="text-align:left;"> (0.42,0.57) </td>
   <td style="text-align:left;"> 0.0433 </td>
   <td style="text-align:left;"> (-0.032,0.12) </td>
   <td style="text-align:left;"> 1.8 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0.22 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.26,0.64) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.38,0.61) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (-0.16,0.24) </td>
   <td style="text-align:left;"> 0.18 </td>
   <td style="text-align:left;"> 784 </td>
   <td style="text-align:left;"> 0.67 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.29,0.69) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (-0.16,0.24) </td>
   <td style="text-align:left;"> 0.18 </td>
   <td style="text-align:left;"> 784 </td>
   <td style="text-align:left;"> 0.67 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PCL\_0\_2 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.592 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.71 </td>
   <td style="text-align:left;"> (0.67,0.75) </td>
   <td style="text-align:left;"> 0.119 </td>
   <td style="text-align:left;"> (0.078,0.16) </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0.00015 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.48,0.71) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.63,0.79) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.0044,0.23) </td>
   <td style="text-align:left;"> 4.2 </td>
   <td style="text-align:left;"> 937 </td>
   <td style="text-align:left;"> 0.042 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.6,0.82) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.0044,0.23) </td>
   <td style="text-align:left;"> 4.2 </td>
   <td style="text-align:left;"> 937 </td>
   <td style="text-align:left;"> 0.042 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PCL\_1 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.675 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.783 </td>
   <td style="text-align:left;"> (0.74,0.83) </td>
   <td style="text-align:left;"> 0.108 </td>
   <td style="text-align:left;"> (0.065,0.15) </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0.00043 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.57,0.78) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.71,0.85) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.0045,0.21) </td>
   <td style="text-align:left;"> 4.2 </td>
   <td style="text-align:left;"> 493 </td>
   <td style="text-align:left;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.68,0.89) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.0045,0.21) </td>
   <td style="text-align:left;"> 4.2 </td>
   <td style="text-align:left;"> 493 </td>
   <td style="text-align:left;"> 0.041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wilcoxon </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.817 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.849 </td>
   <td style="text-align:left;"> (0.83,0.87) </td>
   <td style="text-align:left;"> 0.0317 </td>
   <td style="text-align:left;"> (0.009,0.055) </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0.012 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.75,0.88) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.81,0.89) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (-0.031,0.094) </td>
   <td style="text-align:left;"> 0.99 </td>
   <td style="text-align:left;"> 878 </td>
   <td style="text-align:left;"> 0.32 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (0.79,0.91) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> (-0.031,0.094) </td>
   <td style="text-align:left;"> 0.99 </td>
   <td style="text-align:left;"> 878 </td>
   <td style="text-align:left;"> 0.32 </td>
  </tr>
</tbody>
</table>


Results are shown for the following FOMs: $\text{PCL}_{0.05}$, $\text{PCL}_{0.2}$, $\text{PCL}_{1}$ and the empirical area (AUC) under the ROC curve estimated by the Wilcoxon statistic. The first two FOMs are identical to those used in Study -- 1. Columns 3 and 4 list the CAD FOM $\theta_0$ and its 95% confidence interval $CI_{\theta_0}$, columns 5 and 6 list the average radiologist FOM $\theta_{\bullet}$ (the dot symbol represents an average over the radiologist index) and its 95% confidence interval $CI_{\theta_{\bullet}}$, columns 7 and 8 list the average difference FOM $\psi_{\bullet}$, i.e., radiologist minus CAD, and its 95% confidence interval $CI_{\psi_{\bullet}}$, and the last three columns list the F-statistic, the denominator degrees of freedom (ddf) and the p-value for rejecting the null hypothesis. The numerator degree of freedom of the F-statistic, not listed, is unity.

The last three columns show that 2T-RRRC and 1T-RRRC analyses yield *identical F-statistics, ddf and p-values*. So the intuition of the authors of Study -- 2, that the unorthodox method of using DBM -- MRMC software to account for both reader and case-sampling variability, turns out to be correct. If interest is solely in these statistics one is justified in using the unorthodox method. Other results evident in Table \@ref(tab:standalone-cad-table2):

1. Where a direct comparison is possible, namely 1T-RRFC analysis using $\text{PCL}_{0.05}$ and $\text{PCL}_{0.2}$ as FOMs, the p-values in Table \@ref(tab:standalone-cad-table2) are very close to those reported in Study -- 1.
2. All FOMs (i.e., $\theta_0$, $\theta_{\bullet}$ and $\psi_{\bullet}$) in Table \@ref(tab:standalone-cad-table2) are independent of the method of analysis. However, the corresponding confidence intervals (i.e., $CI_{\theta_0}$, $CI_{\theta_{\bullet}}$ and $CI_{\psi_{\bullet}}$) depend on the analyses.
3. Since the CAD figure of merit is a constant no confidence interval is listed for it for either 1T-RRFC or 1T-RRRC analysis. Since 2T-RRRC analysis assumes CAD is a different treatment the analysis lists a confidence interval that is (appropriately) centered on the corresponding CAD value but is otherwise meaningless.
4. The LROC FOMs increase as the value of FPF (the subscript) increases, a general feature of any partial curve based figure of merit.
5. The area (AUC) under the ROC is larger than the largest PCL value, i.e., $AUC \geq \text{PCL}_1$. This too is obvious from the general features of the LROC [@swensson1996unified].
6. The p-value for either RRRC analyses (2T or 1T) is larger than the corresponding 1T-RRFC value. Accounting for case-sampling variability increases the p-value leading to less possibility of finding a significant difference.
7. Partial curve-based FOMs, such as $\text{PCL}_{FPF}$, lead, depending on the choice of $FPF$, to different conclusions. The p-values generally decrease as FPF increases. 
8. Ignoring localization information (i.e., using the AUC FOM) led to a not-significant difference between CAD and the radiologists ($p$ = 0.3210), while the corresponding FOM yielded a significant difference ($p$ = 0.0409). Accounting for localization leads to a less "noisy" measurement. This has been demonstrated for the LROC paradigm [@swensson1996unified] and I have demonstrated this for the FROC paradigm [@chakraborty2008validation].
9. For 1T-RRRC analysis, is listed as NA, for not applicable, since is not a model parameter, see Eqn. \@ref(eq:standalone-cad-1t-psi).

Shown next, Table \@ref(tab:standalone-cad-table3), are the model-parameters corresponding to the three analyses.

















<table class="table table-striped table-hover table-condensed table-responsive" style="font-size: 10px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:standalone-cad-table3)Significance testing results for an LROC dataset. For each figure of merit (FOM) shown are results of RRRC, 2T-RRRC and 1T-RRRC analyses. Because it is accounting for an additional source of variability, each of the rows labeled RRRC yields a larger p-value and wider confidence interval than the corresponding row labeled RRFC. [$\theta_0$ = FOM CAD; $\theta_{\bullet}$ = average FOM of radiologists; $\psi_{\bullet}$ = average FOM of radiologists minus CAD; CI= 95 percent confidence interval of quantity indicated by the subscript, F = F-statistic; ddf = denominator degrees of freedom; p = p-value for rejecting the null hypothesis: $\psi_{\bullet} = 0$.]</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> FOM </th>
   <th style="text-align:left;"> Analysis </th>
   <th style="text-align:left;"> $\sigma_R^2$ </th>
   <th style="text-align:left;"> $\sigma_{\tau R}^2$ </th>
   <th style="text-align:left;"> Cov1 </th>
   <th style="text-align:left;"> Cov2 </th>
   <th style="text-align:left;"> Cov3 </th>
   <th style="text-align:left;"> Var </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PCL\_0\_05 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.0095 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;"> 1.8e-18 </td>
   <td style="text-align:left;"> -0.00571 </td>
   <td style="text-align:left;"> 0.00131 </td>
   <td style="text-align:left;"> 0.00601 </td>
   <td style="text-align:left;"> 0.00131 </td>
   <td style="text-align:left;"> 0.0165 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;"> 0.0095 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0094 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PCL\_0\_2 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.00281 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;"> -7.6e-19 </td>
   <td style="text-align:left;"> 0.000265 </td>
   <td style="text-align:left;"> 0.000761 </td>
   <td style="text-align:left;"> 0.00229 </td>
   <td style="text-align:left;"> 0.000761 </td>
   <td style="text-align:left;"> 0.00343 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;"> 0.00281 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.00307 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.00534 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PCL\_1 </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.0032 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;"> 1.6e-18 </td>
   <td style="text-align:left;"> 0.001 </td>
   <td style="text-align:left;"> 0.000643 </td>
   <td style="text-align:left;"> 0.00186 </td>
   <td style="text-align:left;"> 0.000643 </td>
   <td style="text-align:left;"> 0.00246 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;"> 0.0032 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.00244 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.00364 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wilcoxon </td>
   <td style="text-align:left;"> 1T-RRFC </td>
   <td style="text-align:left;"> 0.000878 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2T-RRRC </td>
   <td style="text-align:left;"> 3e-19 </td>
   <td style="text-align:left;"> 0.000201 </td>
   <td style="text-align:left;"> 0.000262 </td>
   <td style="text-align:left;"> 0.000724 </td>
   <td style="text-align:left;"> 0.000262 </td>
   <td style="text-align:left;"> 0.000962 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1T-RRRC </td>
   <td style="text-align:left;"> 0.000878 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.000924 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 0.0014 </td>
  </tr>
</tbody>
</table>

From Table \@ref(tab:standalone-cad-table3) some inconsistencies are evident for 2T-RRRC analysis:

1. In fact, for 2T-RRRC analyses $\sigma_R^2 = 0$ since the listed values are smaller than machine accuracy, **clearly an incorrect result as the radiologists do not have identical performance**. In contrast, 1T-RRRC analyses yields values *identical to those obtained by 1T-RRFC analyses*, as expected -- see comment following Eqn. \@ref(eq:standalone-cad-1t-parms).
2. For the 2T_RRRC method the expected ordering of the inequalities, Eqn. \@ref(eq:standalone-cad-2t-rrrc-varcom-ordering) is not observed: one expects $\text{Cov}_1 \geq \text{Cov}_2 \geq \text{Cov}_3$ but instead one observes $\text{Cov}_1 = \text{Cov}_3$ and $\text{Cov}_2 > \text{Cov}_1$. 

The design of a ratings simulator to statistically match a given dataset is addressed in Chapter 23 of my print book [@chakraborty2017observer]. Using this simulator, the 1T-RRRC method had the expected null hypothesis behavior (Table 23.5, ibid).

## Discussion {#standalone-cad-radiologists-discussion}

The proposed 1T-RRRC analysis has 3 random parameters as compared to 6 parameters in 2T-RRRC and one parameter in 1T-RRFC. As expected, since one is including an additional source of variability, both RRRC analyses (1T and 2T) yielded larger p-values and wider confidence intervals as compared to 1T-RRFC. For the F-statistic, degrees of freedom and p-value, both 1T-RRRC and 2T-RRRC analyses yielded exactly the same results. However, 2T-RRRC model parameter estimates were unrealistic; for example, it yields zero between-reader variance, whereas 1T-RRRC yielded the expected non-zero value. All three methods are implemented in an open-source `R` package `RJafroc.


TBA TODOLAST The argument often made for not measuring standalone performance is that since CAD will be used only as a second reader, it is only necessary to measure performance of radiologists without and with CAD. It has been stated [@nishikawa2011fundamental]: 

>High stand-alone performance is neither a necessary nor a sufficient condition for CAD to be truly useful clinically. 

Assessing CAD utility this way, i.e, by  measuring performance with and without CAD, may have inadvertently set a low bar for CAD to be considered useful. As examples, CAD is not penalized for missing cancers as long as the radiologist finds them and CAD is not penalized for excessive false positives (FPs) as long as the radiologist ignores them. Moreover, since both such measurements include the variability of radiologists, there is additional noise introduces that presumably makes it harder to determine if the CAD system is optimal.

Described is an extension of the analysis used in Study -- 1 that accounts for case sampling variability. It extends [@hillis2005comparison] single-treatment analysis to a situation where one of the "readers" is a special reader, and the desire is to compare performance of this reader to the average of the remaining readers. The method, along with two other methods, was used to analyze an LROC data set using different figures of merit.

1T-RRRC analyses yielded identical overall results (specifically the F-statistic, degrees of freedom and p-value) to those yielded by the unorthodox application of DBM-MRMC software, termed 2T-RRRC analyses, where the CAD reader is regarded as a second treatment. However, the values of the model parameters of the dual-treatment analysis lacked clear physical meanings. In particular, the result $\sigma_R^2 = 0$ is clearly an artifact. One can only speculate as to what happens when software is used in a manner that it was not designed for: perhaps finding that all readers in the second treatment have identical FOMs led the software to yield $\sigma_R^2 = 0$. The single-treatment model has half as many parameters as the dual-treatment model and the parameters have clear physical meanings and the values are realistic.

The paradigm used to collect the observer performance data - e.g., receiver operating characteristic (ROC) [@metz1986rocmethodology], free-response ROC (FROC) [@Chakraborty1986DigitalVsConv], location ROC (LROC) [@starr1975visual] or region of interest (ROI) [@obuchowski2010data] - is irrelevant -- all that is needed is a scalar performance measure for the actual paradigm used. In addition to PCL and AUC, RJafroc currently implements the partial area under the LROC, from FPF = 0 to a specified value as well other FROC-paradigm based FOMs.

While there is consensus that CAD works for microcalcifications, for masses its performance is controversial27,28. Two large clinical studies TBA 29,30 (222,135 and 684,956 women, respectively) showed that CAD actually had a detrimental effect on patient outcome. A more recent large clinical study has confirmed the negative view of CAD31 and there has been a call for ending Medicare reimbursement for CAD interpretations32.

In my opinion standalone performance is the most direct measure of CAD performance. Lack of a clear-cut method to assess standalone CAD performance may have limited past CAD research. The current work hopoefully removes that impediment. Going forward, assessment of standalone performance of CAD vs. expert radiologists is strongly encouraged.


## Appendix 1 {#standalone-cad-radiologists-appendix1}

The structures of the` R` objects generated by the software are illustrated with three examples. 

### Example 1 

The first example shows the structure of `RRFC_1T_PCL_0_2`.





```r
print(fom_individual_rad)
#>         rdr1 rdr2    rdr3  rdr4       rdr5       rdr6   rdr7  rdr8  rdr9
#> 1 0.69453125 0.65 0.80625 0.725 0.65982143 0.76845238 0.7375 0.675 0.675
print(stats)
#>       fomCAD  avgRadFom avgDiffFom        varR     Tstat df          pval
#> 1 0.59166667 0.71017278 0.11850612 0.002808612 6.7083568  8 0.00015139664
print(ConfidenceIntervals)
#>       CIAvgRadFom CIAvgDiffFom
#> Lower  0.66943619  0.077769525
#> Upper  0.75090938  0.159242710
```

The results are displayed as three data frames. 

The first data frame :

* `fom_individual_rad` shows the figures of merit for the nine radiologists in the study.

The next data frame summarizes the statistics.

* `fomCAD` is the figure of merit for CAD.
* `avgRadFom` is the average figure of merit of the nine radiologists in the study.
* `avgDiffFom` is the average difference figure of merit, RAD - CAD.
* `varR` is the variance of the figures of merit for the nine radiologists in the study.
* `Tstat` is the t-statistic for testing the NH that the average difference FOM `avgDiffFom` is zero, whose square is the F-statistic.
* `df` is the degrees of freedom of the t-statistic.
* `pval` is the p-value for rejecting the NH. In the example shown below the value is highly signficant.

The last data frame summarizes the 95 percent confidence intervals.

* `CIAvgRadFom` is the 95 percent confidence interval, listed as pairs `Lower`, `Upper`, for `avgRadFom`.
* `CIAvgDiffFom` is the 95 percent confidence interval for `avgDiffFom`. 
* If the pair `CIAvgDiffFom` excludes zero, the difference is statistically significant. 
* In the example the interval excludes zero showing that the FOM difference is significant.


### Example 2 

The next example shows the structure of `RRRC_2T_PCL_0_2`.





```r

print(fom_individual_rad)
#>         rdr1 rdr2    rdr3  rdr4       rdr5       rdr6   rdr7  rdr8  rdr9
#> 1 0.69453125 0.65 0.80625 0.725 0.65982143 0.76845238 0.7375 0.675 0.675
print(stats1)
#>       fomCAD  avgRadFom avgDiffFom
#> 1 0.59166667 0.71017278 0.11850612
print(stats2)
#>             varR         varTR          cov1         cov2          cov3
#> 1 -7.5894152e-19 0.00026488983 0.00076136841 0.0022942211 0.00076136841
#>            Var     FStat        df        pval
#> 1 0.0034336373 4.1576797 937.24371 0.041726262
```



In addition to the quantities defined previously, the output contains the covariance matrix for the Obuchowski-Rockette model, summarized in Eqn. \@ref(eq:standalone-cad-model-2t-rrrc) -- Eqn. \@ref(eq:standalone-cad-2t-rrrc-cov).

* `varTR` is $\sigma_{\tau R}^2$.
* `cov1` is $\text{Cov}_1$.
* `cov2` is $\text{Cov}_2$.
* `cov3` is $\text{Cov}_3$.
* `Var` is $\text{Var}$.
* `FStat` is the F-statistic for testing the NH.
* `ndf` is the numerator degrees of freedom, equal to unity.
* `df` is denominator degrees of freedom of the F-statistic for testing the NH.
* `Tstat` is the t-statistic for testing the NH that the average difference FOM `avgDiffFom` is zero.
* `pval` is the p-value for rejecting the NH. In the example shown below the value is signficant.

Notice that including the variability of cases results in a higher p-value for 2T-RRRC as compared to 1T-RRFC. 

Shown next are the confidence interval statistics `x$ciAvgRdrEachTrt` for the two treatments ("trt1" = CAD, "trt2" = RAD):


```r

print(x$ciAvgRdrEachTrt)
#>        Estimate      StdErr        DF    CILower    CIUpper         Cov2
#> trt1 0.59166667 0.058028349       Inf 0.47793319 0.70540014 0.0033672893
#> trt2 0.71017278 0.039156365 193.10832 0.63294372 0.78740185 0.0012211529
```


* `Estimate` contains the difference FOM estimate.
* `StdErr` contains the standard estimate of the difference FOM estimate.
* `DF` contains the degrees of freedom of the t-statistic.
* `t` contains the value of the t-statistic.
* `PrGtt` contains the probability of exceeding the magnitude of the t-statistic.
* `CILower` is the lower confidence interval for the difference FOM.
* `CIUpper` is the upper confidence interval for the difference FOM.

Shown next are the confidence interval statistics `x$ciDiffFom` between the two treatments ("trt1-trt2" = CAD - RAD):



```r

print(x$ciDiffFom)
#>             Estimate      StdErr        DF         t       PrGTt     CILower
#> trt2-trt1 0.11850612 0.058118615 937.24371 2.0390389 0.041726262 0.004448434
#>             CIUpper
#> trt2-trt1 0.2325638
```



The difference figure of merit statistics are contained in a dataframe `x$ciDiffFom` with elements:

* `Estimate` contains the difference FOM estimate.
* `StdErr` contains the standard estimate of the difference FOM estimate.
* `DF` contains the degrees of freedom of the t-statistic.
* `t` contains the value of the t-statistic.
* `PrGtt` contains the probability of exceeding the magnitude of the t-statistic.
* `CILower` is the lower confidence interval for the difference FOM.
* `CIUpper` is the upper confidence interval for the difference FOM.


The figures of merit statistic for the two treatments, 1 is CAD and 2 is RAD.

* `trt1`: statistics for CAD. 
* `trt2`: statistics for RAD.
* `Cov2`: $\text{Cov}_2$ calculated over individual treatments.


### Example 3 

The last example shows the structure of `RRRC_1T_PCL_0_2`.



```r
RRRC_1T_PCL_0_2
#> $fomCAD
#> [1] 0.59166667
#> 
#> $fomRAD
#> [1] 0.69453125 0.65000000 0.80625000 0.72500000 0.65982143 0.76845238 0.73750000
#> [8] 0.67500000 0.67500000
#> 
#> $avgRadFom
#> [1] 0.71017278
#> 
#> $CIAvgRad
#> [1] 0.59611510 0.82423047
#> 
#> $avgDiffFom
#> [1] 0.11850612
#> 
#> $CIAvgDiffFom
#> [1] 0.004448434 0.232563801
#> 
#> $varR
#> [1] 0.002808612
#> 
#> $varError
#> [1] 0.0053445377
#> 
#> $cov2
#> [1] 0.0030657054
#> 
#> $Tstat
#>      rdr2 
#> 2.0390389 
#> 
#> $df
#>      rdr2 
#> 937.24371 
#> 
#> $pval
#>        rdr2 
#> 0.041726262
```



The differences from `RRFC_1T_PCL_0_2` are listed next:

* `varR` is $\sigma_R^2$ of the single treatment model for comparing CAD to RAD, Eqn. \@ref(eq:standalone-cad-1t-parms). 
* `cov2` is $\text{Cov}_2$ of the single treatment model for comparing CAD to RAD. 
* `varError` is $\text{Var}$ of the single treatment model for comparing CAD to RAD. 

Notice that the `RRRC_1T_PCL_0_2` p value, i.e., 0.04172626,  is identical to that of `RRRC_2T_PCL_0_2`, i.e., 0.04172626.  


## Appendix 2 {#standalone-cad-radiologists-appendix2}

TBA

```r
source(here("R/standalone-cad/DfReadLrocDataFile.R"))
lrocDataset <- DfReadLrocDataFile()
```



