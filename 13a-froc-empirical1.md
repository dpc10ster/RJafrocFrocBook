# Empirical plots {#froc-empirical}

---
output:
  rmarkdown::pdf_document:
    fig_caption: yes        
    includes:  
      in_header: R/learn/my_header.tex
---





## TBA How much finished {#froc-empirical-how-much-finished}
70%



## Introduction {#froc-empirical-intro}

Operating characteristics are visual depicters of performance. If properly defined, scalar quantities derived from operating characteristics can serve as quantitative measures of performance, termed figures of merit (FOMs). The previous chapter defined the FROC curve and suggested the area under this curve as a possible FOM. This chapter introduces mathematical expressions for empirical operating characteristics (FROC and others) possible with FROC data and associated FOMs.

A distinction between latent and actual marks is made followed by a summary of FROC notation applicable to a single modality single reader dataset. This is a key table, which will be used in later chapters. Following this, different empirical operating characteristics proposed for FROC data are described. Formulae are given for calculating each empirical operating characteristic.

The observed end-point of an operating characteristic is defined as that operating point achieved by cumulating all the ratings. For the FROC plot it is demonstrated that the observed FROC curve is not contained in the unit square, unlike the other operating characteristics, which are contained in the unit square.

## Mark rating pairs {#froc-empirical-mark-rating-pairs}

*FROC data consists of mark-rating pairs*. Each mark indicates the location of a region suspicious enough to warrant reporting and the rating is the associated confidence level. A mark is recorded as *lesion localization* (LL) if it is sufficiently close to a true lesion, according to the adopted proximity criterion, and otherwise it is recorded as *non-lesion localization* (NL).

*In an FROC study the number of marks on an image is an a-priori unknown modality-reader-case dependent non-negative random integer.* It is incorrect to estimate it by dividing the image area by the lesion area because not all regions of the image are equally likely to have lesions, lesions do not have the same size, and perhaps most important, clinicians don't assign equal attention units to all areas of the image. The best insight into the number of marks per case is obtained from eye-tracking studies [@RN1490], but even here the information is incomplete, as eye-tracking studies can only measure foveal gaze and not lesions found by peripheral vision, not to mention that such studies are very difficult to conduct in a clinical setting.

Experts tend to have smaller numbers of NL marks per case than non-experts while maintaining equal or more LL marks per case. As an example, in screening mammography, the number of marks per case (a case is defined as 4-views, two of each breast) that an expert will consider for marking to typically less than three. About 80% on non-diseased cases have no marks. The reason is that because of the low disease prevalence marking too many cases would result in unacceptably high recall rates.

### Latent vs. actual marks

To distinguish between suspicious regions that were considered for marking and regions that were actually marked, it is necessary to introduce the distinction between *latent* marks and *actual* marks.

-   A *latent* mark is defined as a suspicious region, regardless of whether or not it was marked. A latent mark becomes an *actual* mark if it is marked.
-   A latent mark is a latent LL if it is close to a true lesion and otherwise it is a latent NL.
-   A non-diseased case can only have latent NLs. A diseased case can have latent NLs and latent LLs.
-   If marked, a latent NL is recorded as an actual NL.
-   If not marked, a latent NL is an *unobservable event*.
-   In contrast, unmarked lesions are observable events -- one knows (trivially) which lesions were not marked.

### Binning rule

Recall from Section TBA (binary-task-model-z-sample-model) that ROC data modeling requires the existence of a *case-dependent* decision variable, or z-sample $z$, and case-independent decision thresholds $\zeta_r$, where $r = 0, 1, ..., R_{ROC}-1$ and $R_{ROC}$ is the number of ROC study bins, and the rule that if $\zeta_r \leq z < \zeta_{r+1}$ the case is rated $r + 1$. Dummy cutoffs are defined as $\zeta_0 = -\infty$ and $\zeta_{R_{ROC}} = \infty$. The z-sample applies to the whole case. To summarize:

```{=tex}
\begin{equation}
\left.
\begin{aligned}  
if \left (\zeta_r \le z < \zeta_{r+1}  \right )\Rightarrow \text {rating} = r+1\\
r = 0, 2, ..., R_{ROC}-1\\
\zeta_0 = -\infty\\
\zeta_{R_{ROC}} = \infty\\
\end{aligned}
\right \}
(\#eq:froc-empirical-binning-rule-roc)
\end{equation}
```
Analogously, FROC data modeling requires the existence of a *case and location-dependent* z-sample for each latent mark and *case and location-independent* reporting thresholds $\zeta_r$, where $r = 1, ..., R_{FROC}$ and $R_{FROC}$ is the number of FROC study bins, and the rule that a latent mark is marked and rated $r$ if $\zeta_r \leq z < \zeta_{r+1}$. Dummy cutoffs are defined as $\zeta_0 = -\infty$ and $\zeta_{R_{FROC}+1} = \infty$. For the same numbers of non-dummy cutoffs, the number of FROC bins is one less than the number of ROC bins. For example, 4 non-dummy cutoffs $\zeta_1, \zeta_2, \zeta_3, \zeta_4$ can correspond to a 5-rating ROC study or to a 4-rating FROC study. To summarize:

```{=tex}
\begin{equation}
\left.
\begin{aligned}  
if \left (\zeta_r \le z < \zeta_{r+1}  \right )\Rightarrow \text {rating} = r\\
r = 1, 2, ..., R_{FROC}\\
\zeta_0 = -\infty\\
\zeta_{R_{FROC}+1} = \infty\\
\end{aligned}
\right \}
(\#eq:froc-empirical-binning-rule-froc)
\end{equation}
```
## FROC notation {#froc-empirical-notation}

*Clear notation is vital to understanding this paradigm.* The notation needs to account for case and location dependencies of ratings and the distinction between case-level and location-level ground truth. For example, a diseased case can have several regions that are non-diseased and a few diseased regions (the lesions). The notation also has to account for cases with no marks.

FROC notation is summarized in Table \@ref(tab:froc-empirical-notation), in which **all marks are latent marks**. The table is organized into three columns, the first column is the row number, the second column has the symbol(s), and the third column has the meaning(s) of the symbol(s).

<table>
<caption>(\#tab:froc-empirical-notation)FROC notation; all marks refer to latent marks; see comments</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Row </th>
   <th style="text-align:left;"> Symbol </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> t </td>
   <td style="text-align:left;"> Case-level truth: 1 for non-diseased and 2 for diseased </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> $K_t$ </td>
   <td style="text-align:left;"> Number of cases with case-level truth t </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> $k_t t$ </td>
   <td style="text-align:left;"> Case $k_t$ in case-level truth t </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> s </td>
   <td style="text-align:left;"> Mark-level truth: 1 for NL and 2 for LL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> $l_s s$ </td>
   <td style="text-align:left;"> Mark $l_s$ in mark-level truth s </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> $z_{k_t t l_1 1}$ </td>
   <td style="text-align:left;"> z-sample for case $k_t t$ and mark $l_1 1$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> $z_{k_2 2 l_2 2}$ </td>
   <td style="text-align:left;"> z-sample for case $k_2 2$ and mark $l_2 2$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> $R_{FROC}$ </td>
   <td style="text-align:left;"> Number of FROC bins </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> $\zeta_1$ </td>
   <td style="text-align:left;"> Lowest reporting threshold </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> $\zeta_r$ </td>
   <td style="text-align:left;"> Other non-dummy reporting thresholds </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> $\zeta_0, \zeta_{R_{FROC}+1}$ </td>
   <td style="text-align:left;"> Dummy thresholds </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> $N_{k_t t}$ </td>
   <td style="text-align:left;"> Number of NLs on case $k_t t$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> $L_{k_2 2}$ </td>
   <td style="text-align:left;"> Number of lesions on case $k_2 2$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> $W_{k_2 l_2}$ </td>
   <td style="text-align:left;"> Weight of lesion $l_2 2$ on case $k_2 2$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> $L_{max}$ </td>
   <td style="text-align:left;"> Maximum number of lesions per case in dataset </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> $L_T$ </td>
   <td style="text-align:left;"> Total number of lesions in dataset </td>
  </tr>
</tbody>
</table>

### Comments on Table \@ref(tab:froc-empirical-notation)

-   Row 1: The case-truth index $t$ refers to the case (or patient), with $t = 1$ for non-diseased and $t = 2$ for diseased cases. As a useful mnemonic, $t$ is for *truth*.

-   Row 2: $K_t$ is the number of cases with truth state $t$; specifically, $K_1$ is the number of non-diseased cases and $K_2$ the number of diseased cases.

-   Row 3: Two indices $k_t t$ are needed to select case $k_t$ in truth state $t$. As a useful mnemonic, $k$ is for *case*.

-   Rows 4 and 5: For a similar reason, two indices $l_s s$ are needed to select latent mark $l_s$ in location level truth state $s$, where $s = 1$ corresponds to a latent NL and $s = 2$ corresponds to a latent LL. One can think of $l_s$ as indexing the locations of different latent marks with location-level truth state $s$. As a useful mnemonic, $l$ is for *location*.

    -   $l_1 = \{1, 2, ..., N_{k_t t}\}$ indexes latent NL marks, provided the case has at least one NL mark, and otherwise $N_{k_t t} = 0$ and $l_1 = \varnothing$, the null set.

    -   The possible values of $l_1$ are $l_1 = \left \{ \varnothing \right \}\oplus \left \{ 1,2,...N_{k_t t} \right \}$. The null set applies when the case has no latent NL marks and $\oplus$ is the "exclusive-or" symbol ("exclusive-or" is used in the English sense: "one or the other, but not neither nor both"). In other words, $l_1$ can *either* be the null set or take on values $1,2,...N_{k_t t}$.

    -   Likewise, $l_2 = \left \{ 1,2,...,L_{k_2 2} \right \}$ indexes latent LL marks. Unmarked LLs are assigned negative infinity ratings. The null set notation is not needed for latent LLs.

-   Row 6: The z-sample for case $k_t t$ and **latent NL mark** $l_1 1$ is denoted $z_{k_t t l_1 1}$. Latent NL marks are possible on non-diseased and diseased cases (both values of $t$ are allowed). The range of a z-sample is $-\infty < z_{k_t t l_1 1} < \infty$, provided $l_1 \neq \varnothing$; otherwise, it is an *unobservable event*.

-   Row 7: The z-sample of a **latent LL** is $z_{k_2 2 l_2 2}$. Unmarked lesions are assigned negative infinity ratings and are observable events. The null-set notation is unnecessary for them.

-   Row 8: $R_{FROC}$ is the number of bins in the FROC study.

-   Rows 9, 10 and 11: The cutoffs in the FROC study. The lowest threshold is $\zeta_1$. The other non-dummy thresholds are $\zeta_r$ where $r=2,3,...,R_{FROC}$. The dummy thresholds are $\zeta_0 = -\infty$ and $\zeta_{R_{FROC}+1} = \infty$.

-   Row 12: $N_{k_t t}$ is the total number of latent NL marks on case $k_t t$.

-   Row 13: $L_{k_2 2}$ is the number of lesions in diseased case $k_2 2$.

-   Row 14: $W_{k_2 l_2}$ is the weight (i.e., clinical importance) of lesion $l_2 2$ in diseased case $k_2 2$. The weights of lesions on a case sum to one: $\sum_{l_2 = 1}^{L_{k_2 2}}W_{k_2 l_2} = 1$.

-   Row 15: $L_{max}$ is the maximum number of lesions per case in the dataset.

-   Row 16: $L_T$ is the total number of lesions in the dataset.

### Discussion: cases with zero latent NL marks

An aspect of FROC data, **that there could be cases with no NL marks, no matter how low the reporting threshold**, has created problems both from conceptual and notational viewpoints. Taking the conceptual issue first, my thinking (prior to 2004) was that as the reporting threshold $\zeta_1$ is lowered, the number of NL marks per case increases almost indefinitely. I visualized this process as each case "filling up" with NL marks [^froc-empirical1-1]. In fact the first modeling of FROC data [@chakraborty1989maximum] predicts that, as the reporting threshold is lowered to $\zeta_1 = -\infty$, the number of NL marks per case approaches $\infty$. However, observed FROC curves end with a finite value of NLs per case. This mismatch between observation and theory is one reason I introduced the radiological search model (RSM) [@chakraborty2006search]. I will have much more to say about this in a subsequent chapter, but for now I state one prediction (actually an assumption) of the RSM: the number of latent NL marks is a Poisson distributed random integer with a finite value for the mean parameter of the Poisson distribution. This means that the actual number of latent NL marks per case can be 0, 1, 2, .., whose average (over cases) is a finite number. With this background, let us return to the conceptual issue: why does the observer not keep "filling-up" the image with NL marks? The answer is that **the observer can only mark regions that have a non-zero chance of being a lesion**. For example, if the actual number of latent NLs on a particular case is 2, then, as the reporting threshold is lowered, the observer will make at most two NL marks. Having exhausted these two regions the observer will not mark any more regions because there are no more regions to be marked - *all other regions in the image have, in the perception of the observer, zero chance of being a lesion*.

[^froc-empirical1-1]: I expected the number of NL marks per image to be limited only by the ratio of image size to lesion size, i.e., larger values for smaller lesions.

The notational issue is how to handle images with no latent NL marks. Basically it involves restricting summations over cases $k_ t t$ to those cases which have at least one latent NL mark, i.e., $N_{k_t t} \neq 0$. This is illustrated in the next section.

## The empirical FROC {#froc-empirical-froc-plot}

The FROC was defined, Chapter \@ref(froc-paradigm), as the plot of LLF (along the ordinate) vs. NLF (along the abscissa).

Using the notation of Table \@ref(tab:froc-empirical-notation) and assuming binned data[^froc-empirical1-2], then, corresponding to the operating point determined by threshold $\zeta_r$, the FROC abscissa is $\text{NLF}_r \equiv \text{NLF}\left ( \zeta_r \right )$, the total number of NLs rated $\geq$ threshold $\zeta_r$ divided by the total number of cases, and the corresponding ordinate is $\text{LLF}_r \equiv \text{LLF}\left ( \zeta_r \right )$, the total number of LLs rated $\geq$ threshold $\zeta_r$ divided by the total number of lesions:

[^froc-empirical1-2]: This is not a limiting assumption: if the data is continuous, for finite numbers of cases, no ordering information is lost if the number of ratings is chosen large enough. This is analogous to Bamber's theorem in Chapter 05, where a proof, although given for binned data, is applicable to continuous data.

```{=tex}
\begin{equation}
\text{NLF}_r  = \frac{n\left ( \text{NLs rated} \geq \zeta_r\right )}{n\left ( \text{cases} \right )}
(\#eq:froc-empirical-NLF1)
\end{equation}
```
and

```{=tex}
\begin{equation}
\text{LLF}_r  = \frac{n\left ( \text{LLs rated} \geq \zeta_r\right )}{n\left ( \text{lesions} \right )}
(\#eq:froc-empirical-LLF1)
\end{equation}
```
The observed operating points correspond to the following values of $r$:

```{=tex}
\begin{equation}
r = 1, 2, ...,R_{FROC} 
(\#eq:froc-empirical-range-r)
\end{equation}
```
Due to the ordering of the thresholds, i.e., $\zeta_1 < \zeta_2 ... < \zeta_{R_{FROC}}$, higher values of $r$ correspond to lower operating points. The uppermost operating point, i.e., that defined by $r = 1$, is referred to the as the *observed end-point*.

Equations \@ref(eq:froc-empirical-NLF1) and \@ref(eq:froc-empirical-LLF1) is are equivalent to:

```{=tex}
\begin{equation}
\text{NLF}_r  = \frac{1}{K_1+K_2} \sum_{t=1}^{2} \sum_{k_t=1}^{K_t} \mathbb{I} \left ( N_{k_t t} \neq 0 \right )\sum_{l_1=1}^{N_{k_t t}} \mathbb{I} \left ( z_{k_t t l_1 1} \geq \zeta_r \right ) 
(\#eq:froc-empirical-NLFr)
\end{equation}
```
and

```{=tex}
\begin{equation}
\text{LLF}_r  = \frac{1}{L_T} \sum_{k_2=1}^{K_2} \sum_{l_2=1}^{L_{k_2 2}} \mathbb{I} \left ( z_{k_2 2 l_2 2} \geq \zeta_r  \right ) 
(\#eq:froc-empirical-LLFr)
\end{equation}
```
Each indicator function, $\mathbb{I}()$, yields unity if the argument is true and zero otherwise.

In Eqn. \@ref(eq:froc-empirical-NLFr) $\mathbb{I} \left ( N_{k_t t} \neq 0 \right )$ ensures that **only cases with at least one latent NL** are counted. Recall that $N_{k_t t}$ is the total number of latent NLs in case $k_t t$. Not including this term would cause the summation over $l_1$ to be undefined for cases with zero latent NLs. The term $\mathbb{I} \left ( z_{k_t t l_1 1} \geq \zeta_r \right )$ counts over all NL marks with ratings $\geq \zeta_r$. The three summations yield the total number of NLs in the dataset with z-samples $\geq \zeta_r$ and dividing by the total number of cases yields $\text{NLF}_r$. This equation also shows explicitly that NLs on both non-diseased ($t=1$) and diseased ($t=2$) cases contribute to NLF.

In Eqn. \@ref(eq:froc-empirical-LLFr) a summation over $t$ is not needed as only diseased cases contribute to LLF. Analogous to the first indicator function term in Eqn. \@ref(eq:froc-empirical-NLFr), a term like $\mathbb{I} \left ( L_{k_2 2} \neq 0 \right )$ would be superfluous since $L_{k_2 2} > 0$, as each diseased case must have at least one lesion. The term $\mathbb{I} \left ( z_{k_2 2 l_2 2} \geq \zeta_r \right )$ counts over all LL marks with ratings $\geq \zeta_r$. Dividing by $L_T$, the total number of lesions in the dataset, yields $\text{LLF}_r$.

### Definition {#froc-empirical-definition-auc-FROC}

The empirical FROC plot connects adjacent operating points $\left (\text{NLF}_r, \text{LLF}_r \right )$, including the origin (0,0) and the observed end-point, with straight lines. The area under this plot is the empirical FROC AUC, denoted $A_{\text{FROC}}$.

### The origin, a trivial point {#froc-empirical-origin-trivial-point}

Since $\zeta_{R_{FROC}+1} = \infty$ according to Eqn. \@ref(eq:froc-empirical-NLFr) and Eqn. \@ref(eq:froc-empirical-LLFr), $r = R_{FROC}+1$ yields the trivial operating point (0,0).

### The observed end-point and its semi-constrained property {#froc-empirical-end-point}

The abscissa of the observed end-point $NLF_1$, is defined by:

```{=tex}
\begin{equation}
\text{NLF}_1 = \frac{1}{K_1+K_2} \sum_{t=1}^{2} \sum_{k_t=1}^{K_t} \mathbb{I} \left ( N_{k_t t} \neq 0 \right ) \sum_{l_1=1}^{N_{k_t t}} \mathbb{I} \left ( z_{k_t t l_1 1} \geq \zeta_1 \right ) 
(\#eq:froc-empirical-NLF11)
\end{equation}
```
Since each case could have an arbitrary number of NLs, $NLF_1$ need not equal unity, except fortuitously.

The ordinate of the observed end-point $LLF_1$, is defined by:

```{=tex}
\begin{equation}
\left.
\begin{aligned}
\text{LLF}_1 =& \frac{ \sum_{k_2=1}^{K_2} \sum_{l_2=1}^{L_{k_2 2}} \mathbb{I} \left ( z_{k_2 2 l_2 2} \geq  \zeta_1  \right ) }{L_T}\\
\leq& 1
\end{aligned}
\right \}
(\#eq:froc-empirical-LLF1a)
\end{equation}
```
The numerator is the total number of lesions that were actually marked. The ratio is the fraction of lesions that are marked, which is $\leq 1$.

This is the **semi-constrained property of the observed end-point**, namely, while the observed end-point *ordinate* is constrained to the range (0,1) the corresponding *abscissa* is not so constrained.

### Futility of extrapolation outside the observed end-point {#froc-empirical-froc-plot-futility-extrapolation}

To understand this consider the expression for $NLF_0$, i.e., using Eqn. \@ref(eq:froc-empirical-NLFr) with $r = 0$:

```{=tex}
\begin{equation}
\text{NLF}_0 = \frac{1}{K_1+K_2} \sum_{t=1}^{2} \sum_{k_t=1}^{K_t} \mathbb{I} \left ( N_{k_t t} \neq 0 \right ) \sum_{l_1=1}^{N_{k_t t}} \mathbb{I} \left ( z_{k_t t l_1 1} \geq -\infty \right ) 
\end{equation}
```
The right hand side of this equation can be separated into two terms, the contribution of latent NLs with z-samples in the range $z \geq \zeta_1$ and those in the range $-\infty \leq z < \zeta_1$. The first term yields the abscissa of the observed end-point, Eqn. \@ref(eq:froc-empirical-NLF11). The 2nd term is:

```{=tex}
\begin{equation}
\left. 
\begin{aligned} 
\text{2nd term}=&\left (\frac{1}{K_1+K_2} \right )\sum_{t=1}^{2} \sum_{k_t=1}^{K_t} \mathbb{I} \left ( N_{k_t t} \neq 0 \right ) \sum_{l_1=1}^{N_{k_t t}} \mathbb{I} \left ( -\infty \leq z_{k_t t l_1 1} < \zeta_1 \right )\\
=&\frac{\text{unknown number}}{K_1+K_2}
\end{aligned}
\right \} 
(\#eq:froc-empirical-NLF0a)
\end{equation}
```
It represents the contribution of unmarked NLs, i.e., latent NLs whose z-samples were below $\zeta_1$. It determines how much further to the right the observer's NLF would have moved, relative to $NLF_1$, if one could get the observer to lower the reporting criterion to $-\infty$. **Since the observer may not oblige, this term cannot, in general, be evaluated.** Therefore $NLF_0$ cannot be evaluated. The basic problem is that **unmarked latent NLs represent unobservable events**.

Turning our attention to $LLF_0$:

```{=tex}
\begin{equation}
\left.
\begin{aligned}
\text{LLF}_0 =& \frac{ \sum_{k_2=1}^{K_2} \sum_{l_2=1}^{L_{k_2 2}} \mathbb{I} \left ( z_{k_2 2 l_2 2} \geq  -\infty  \right ) }{L_T}\\
=& 1
\end{aligned}
\right \}
(\#eq:froc-empirical-LLF0)
\end{equation}
```
Unlike unmarked latent NLs, **unmarked lesions can safely be assigned the** $-\infty$ **rating, because an unmarked lesion is an observable event**. The right hand side of Eqn. \@ref(eq:froc-empirical-LLF0) evaluates to unity. However, since the corresponding abscissa $NLF_0$ is undefined, one cannot plot this point. It follows that one cannot extrapolate outside the observed end-point.

The formalism should not obscure the fact that the futility of extrapolation outside the observed end-point of the FROC is a fairly obvious property: one does not know how far to the right the abscissa of the observed end-point might extend if one could get the observer to report every latent NL, no matter how low its z-sample.

## The inferred ROC plot {#froc-empirical-ROC}

By adopting a sensible rule for converting the zero or more mark-rating data per case to a single rating per case, and commonly the highest rating rule is used [^froc-empirical1-3], it is possible to infer ROC data from FROC mark-rating data.

[^froc-empirical1-3]: The highest rating method was used in early FROC modeling in [@bunch1977free] and in [@swensson1996unified], the latter in the context of LROC paradigm modeling.

### Inferred-ROC rating

**The rating of the highest rated mark on a case, or** $-\infty$ if the case has no marks, is defined as the inferred-ROC rating for the case. Inferred-ROC ratings on non-diseased cases are referred to as inferred-FP ratings and those on diseased cases as inferred-TP ratings.

When there is little possibility for confusion, the prefix "inferred" is suppressed. Using the by now familiar cumulation procedure, FP counts are cumulated to calculate FPF and likewise, TP counts are cumulated to calculate TPF.

Definitions:

-   $FPF(\zeta)$ = cumulated inferred FP counts with z-sample $\geq$ threshold $\zeta$ divided by total number of non-diseased cases.
-   $TPF(\zeta)$ = cumulated inferred TP counts with z-sample $\geq$ threshold $\zeta$ divided by total number of diseased cases

Definition of ROC plot:

-   The ROC is the plot of inferred $TPF(\zeta)$ vs. inferred $FPF(\zeta)$.
-   The plot includes a **straight line extension from the observed end-point to (1,1)**.

The mathematical definition of the ROC follows.

### Inferred FPF

The highest z-sample ROC false positive (FP) rating for non-diseased case $k_1 1$ is defined by:

```{=tex}
\begin{equation}
\left.
\begin{aligned}
FP_{k_1 1}=&\max_{l1} \left ( z_{k_1 1 l_1 1 } \mid l_1 \neq \varnothing \right ) \\
=& -\infty \mid l_1 = \varnothing  
 \end{aligned}
\right \}
(\#eq:froc-empirical-FP)
\end{equation}
```
If the case has at least one latent NL mark, then $l_1 \neq \varnothing$, where $\varnothing$ is the null set, and the first definition applies. If the case has no latent NL marks, then $l_1 = \varnothing$, and the second definition applies. $FP_{k_1 1}$ is the maximum z-sample over all latent marks occurring on non-diseased case $k_1 1$, or $-\infty$ if the case has no latent marks. The corresponding false positive fraction is defined by:

```{=tex}
\begin{equation}
\text{FPF}_r \equiv \text{FPF} \left ( \zeta_r \right ) = \frac{1}{K_1} \sum_{k_1=1}^{K_1} \mathbb{I} \left ( FP_{k_1 1} \geq \zeta_r\right )
(\#eq:froc-empirical-FPF)
\end{equation}
```
### Inferred TPF

The inferred true positive (TP) z-sample for diseased case $k_2 2$ is defined by:

```{=tex}
\begin{equation}
TP_{k_2 2} = \textstyle\max_{l_1 l_2}\left ( \left (z_{k_2 2 l_1 2} ,z_{k_2 2 l_2 2}  \right ) \mid l_1 \neq \varnothing \right )
(\#eq:froc-empirical-TP1)
\end{equation}
```
or

```{=tex}
\begin{equation}
TP_{k_2 2} = \textstyle\max_{l_2}  \left ( z_{k_2 2 l_2 2}  \right )  \mid\left ( l_1 = \varnothing \land \left (\textstyle\max_{l_2}{\left (z_{k_2 2 l_2 2}  \right )} \neq -\infty  \right )  \right )
(\#eq:froc-empirical-TP2)
\end{equation}
```
or

```{=tex}
\begin{equation}
TP_{k_2 2} = = -\infty \mid \left ( l_1 = \varnothing \land\left ( \textstyle\max_{l_2}{\left (z_{k_2 2 l_2 2}  \right )} = -\infty  \right )  \right )
(\#eq:froc-empirical-TP3)
\end{equation}
```
Here $\land$ is the logical AND operator.

-   If $l_1 \neq \varnothing$ then Eqn. \@ref(eq:froc-empirical-TP1) applies, i.e., one takes the maximum over all ratings, NLs and LLs, whichever is higher, occurring on the diseased case.

-   If $l_1 = \varnothing$ and at least one lesion is marked, then Eqn. \@ref(eq:froc-empirical-TP2) applies, i.e., one takes the maximum over all marked LLs.

-   If $l_1 = \varnothing$ and no lesions are marked, then Eqn. \@ref(eq:froc-empirical-TP3) applies; this represents an unmarked diseased case; the $-\infty$ rating assignment is justified because an unmarked diseased case is an observable event.

The inferred true positive fraction $\text{TPF}_r$ is defined by:

```{=tex}
\begin{equation}
\text{TPF}_r \equiv \text{TPF}(\zeta_r) = \frac{1}{K_2}\sum_{k_2=1}^{K_2} \mathbb{I}\left ( TP_{k_2 2} \geq \zeta_r \right )
(\#eq:froc-empirical-TPF)
\end{equation}
```
### Definition {#froc-empirical-definition-auc-ROC}

The inferred empirical ROC plot connects adjacent points $\left( \text{FPF}_r, \text{TPF}_r \right )$, including the origin (0,0), with straight lines plus a straight-line segment connecting the observed end-point to (1,1). Like a real ROC, this plot is constrained to lie within the unit square. The area under this plot is the empirical inferred ROC AUC, denoted $A_{\text{ROC}}$.

## The alternative FROC (AFROC) plot {#froc-empirical-AFROC}

-   Fig. 4 in [@bunch1977free] anticipated another way of visualizing FROC data. I subsequently termed[^froc-empirical1-4] this the *alternative FROC (AFROC)* plot [@chakraborty1989maximum].
-   The empirical AFROC is defined as the plot of $\text{LLF}(\zeta_r)$ along the ordinate vs. $\text{FPF}(\zeta_r)$ along the abscissa.
-   $\text{LLF}_r \equiv \text{LLF}(\zeta_r)$ was defined in Eqn. \@ref(eq:froc-empirical-LLFr).
-   $\text{FPF}_r \equiv \text{FPF}(\zeta_r)$ was defined in Eqn. \@ref(eq:froc-empirical-FPF).

[^froc-empirical1-4]: The late Prof. Richard Swensson did not like my choice of the word "alternative" in naming this operating characteristic. I had no idea in 1989 how important this operating characteristic would later turn out to be, otherwise a more meaningful name might have been proposed.

### Definition {#froc-empirical-definition-auc-AFROC}

The empirical AFROC plot connects adjacent operating points $\left( \text{FPF}_r, \text{LLF}_r \right )$, including the origin (0,0) and (1,1), with straight lines. The area under this plot is the empirical inferred AFROC AUC, denoted $A_{\text{AFROC}}$.

Key points:

-   The ordinates LLF of the FROC and AFROC are identical.
-   The abscissa FPF of the ROC and AFROC are identical.
-   The AFROC is, in this sense, a hybrid plot, incorporating aspects of both ROC and FROC plots.
-   Unlike the empirical FROC, whose observed end-point has the semi-constrained property, **the AFROC end-point is constrained to within the unit square**.

### The constrained observed end-point of the AFROC {#froc-empirical-AFROC-constrained}

Since $\zeta_{R_{FROC}+1} = \infty$, according to Eqn. \@ref(eq:froc-empirical-LLFr) and Eqn. \@ref(eq:froc-empirical-FPF), $r = R_{FROC}+1$ yields the trivial operating point (0,0). Likewise, since $\zeta_0 = -\infty$, $r = 0$ yields the trivial point (1,1):

```{=tex}
\begin{equation}
\left.
\begin{aligned} 
\text{FPF}_{R_{FROC}+1} =& \frac{1}{K_1} \sum_{k_1=1}^{K_1} \mathbb{I} \left ( FP_{k_1 1} \geq \infty \right )\\
=& 0\\
\text{LLF}_{R_{FROC}+1} =& \frac{1}{L_T} \sum_{k_2=1}^{K_2} \sum_{l_2=1}^{L_{k_2 2}}\mathbb{I} \left ( LL_{k_2 2 l_2 2} \geq \infty \right )\\
=& 0
\end{aligned}
\right \}
(\#eq:froc-empirical-FPF-LLF-last)
\end{equation}
```
and

```{=tex}
\begin{equation}
\left.
\begin{aligned} 
\text{FPF}_0 =& \frac{1}{K_1} \sum_{k_1=1}^{K_1} \mathbb{I} \left ( FP_{k_1 1} \geq -\infty \right )\\
=& 1\\
\text{LLF}_0 =& \frac{1}{L_T} \sum_{k_2=1}^{K_2} \sum_{l_2=1}^{L_{k_2 2}}\mathbb{I} \left ( LL_{k_2 2 l_2 2} \geq -\infty \right )\\
=& 1
\end{aligned}
\right \}
(\#eq:froc-empirical-FPF0-LLF0)
\end{equation}
```
Because every non-diseased case is assigned a rating, and is therefore counted, the right hand side of the first equation in \@ref(eq:froc-empirical-FPF0-LLF0) evaluates to unity. This is obvious for marked cases. Since each unmarked case also gets a rating, albeit a $-\infty$ rating, it is also counted (the argument of the indicator function in Eqn. \@ref(eq:froc-empirical-FPF0-LLF0) is true even when the inferred FP rating is $-\infty$).

## The weighted-AFROC (wAFROC) plot {#froc-empirical-wAFROC}

The AFROC ordinate defined in Eqn. \@ref(eq:froc-empirical-LLFr) gives equal importance to every lesion on a case. Therefore, a case with more lesions will have more influence on the AFROC (see TBA Chapter 14 for an explicit demonstration of this fact). This is undesirable since each case (i.e., patient) should get equal importance in the analysis. As with ROC analysis, one wishes to draw conclusions about the population of cases and each case is regarded as an equally valid sample from the population. In particular, one does not want the analysis to be skewed towards cases with greater than the average number of lesions. [^froc-empirical1-5]

[^froc-empirical1-5]: Historical note: I became aware of how serious this issue could be when a researcher contacted him about using FROC methodology for nuclear medicine bone scan images, where the number of lesions on diseased cases can vary from a few to a hundred!

Another issue is that the AFROC assigns equal clinical importance to each lesion in a case. Lesion weights were introduced [@RN1385] to allow for the possibility that the clinical importance of finding a lesion might be lesion-dependent [@RN1966]. For example, it is possible that a diseased cases has lesions of two types with differing clinical importance; the figure-of-merit should give more credit to finding the more clinically important one. Clinical importance could be defined as the mortality associated with the specific lesion type; these can be obtained from epidemiological studies [@desantis2011breast].

Let $W_{k_2 l_2} \geq 0$ denote the **weight** (i.e., clinical importance) of lesion $l_2$ in diseased case $k_2$ (since weights are only applicable to diseased cases, one can, without ambiguity, drop the case-level and location-level truth subscripts, i.e., the notation $W_{k_2 2 l_2 2}$ would be superfluous). For each diseased case $k_2 2$ the weights are subject to the constraint:

```{=tex}
\begin{equation}
\sum_{l_2 =1 }^{L_{k_2 2}} W_{k_2 l_2} = 1
(\#eq:froc-empirical-weights-constraint)
\end{equation}
```
The constraint assures that the each diseased case exerts equal importance in determining the weighted-AFROC (wAFROC) operating characteristic, regardless of the number of lesions in it (see TBA Chapter 14 for a demonstration of this fact).

The weighted lesion localization fraction $\text{wLLF}_r$ is defined by [@RN2484]:

```{=tex}
\begin{equation}
\text{wLLF}_r \equiv \text{wLLF}\left ( \zeta_r \right ) = \frac{1}{K_2}\sum_{k_2=1}^{K_2}\sum_{l_2=1}^{L_{k_2 2}}W_{k_2 l_2} \mathbb{I}\left ( z_{k_2 l_2 2} \geq \zeta_r \right )
(\#eq:froc-empirical-wLLFr)
\end{equation}
```
### Definition {#froc-empirical-definition-auc-wAFROC}

The empirical wAFROC plot connects adjacent operating points $\left ( \text{FPF}_r, \text{wLLF}_r \right )$, including the origin (0,0), with straight lines plus a straight-line segment connecting the observed end-point to (1,1). The area under this plot is the empirical weighted-AFROC AUC, denoted $A_{\text{wAFROC}}$.

## The AFROC1 plot {#froc-empirical-AFROC1}

Historically the AFROC originally used a different definition of FPF, which is retrospectively termed the AFROC1 plot. Since NLs can occur on diseased cases, it is possible to define an inferred "FP" rating on a *diseased case* as the maximum of all NL ratings on the case, or $-\infty$ if the case has no NLs. The quotes emphasize that this is non-standard usage of ROC terminology: in an ROC study, a FP can only occur on a *non-diseased case*. Since both case-level truth states are allowed, the highest false positive (FP) z-sample for case $k_t t$ is [the "1" superscript below is necessary to distinguish it from Eqn. \@ref(eq:froc-empirical-FP)]:

```{=tex}
\begin{equation}
\left.
\begin{aligned}
FP_{k_t t}^1 =& \max_{l_1} \left ( z_{k_t t l_1 1 } \mid  l_1 \neq \varnothing \right )\\
=& -\infty \mid l_1 = \varnothing
\end{aligned}
\right \}
(\#eq:froc-empirical-FP1)
\end{equation}
```
$FP_{k_t t}^1$ is the maximum over all latent NL marks, labeled by the location index $l_1$, occurring on case $k_t t$, or $-\infty$ if $l_1 = \varnothing$. The corresponding false positive fraction $FPF_r^1$ is defined by [the "1" superscript is necessary to distinguish it from Eqn. \@ref(eq:froc-empirical-FPF)]:

```{=tex}
\begin{equation}
FPF_r^1 \equiv FPF_r^1\left ( \zeta_r \right ) = \frac{1}{K_1+K_2}\sum_{t=1}^{2}\sum_{k_t=1}^{K_t} \mathbb{I}\left ( FP_{k_t t}^1 \geq \zeta_r \right )
(\#eq:froc-empirical-FPF1)
\end{equation}
```
Note the subtle differences between Eqn. \@ref(eq:froc-empirical-FPF) and Eqn. \@ref(eq:froc-empirical-FPF1). The latter counts "FPs" on non-diseased and diseased cases while Eqn. \@ref(eq:froc-empirical-FPF) counts FPs on non-diseased cases only, and for that reason the denominators in the two equations are different. The advisability of allowing a diseased case to be both a TP and a FP is questionable from both clinical and statistical considerations. However, this operating characteristic can be useful in applications where all cases contain lesions, for example lesion localization plus classification tasks (See Chapter TBA).

### Definition {#froc-empirical-definition-auc-AFROC1}

The empirical AFROC1 plot connects adjacent operating points $\left ( FPF_r^1, \text{LLF}_r \right )$, including the origin (0,0) and (1,1), with straight lines. The only difference between AFROC1 and the AFROC plot is in the x-axis. The area under this plot is the empirical AFROC1 AUC, denoted $A_{\text{AFROC1}}$.

## The weighted-AFROC1 (wAFROC1) plot {#froc-empirical-wAFROC1}

### Definition {#froc-empirical-definition-auc-wAFROC1}

The empirical weighted-AFROC1 (wAFROC1) plot connects adjacent operating points $\left ( FPF_r^1, \text{wLLF}_r \right )$, including the origin (0,0) and (1,1), with straight lines. The only difference between it and the wAFROC plot is in the x-axis. The area under this plot is the empirical weighted-AFROC AUC, denoted $A_{\text{wAFROC1}}$.

## The EFROC plot {#froc-empirical-EFROC}

An *exponentially transformed FROC* (EFROC) plot has been proposed [@RN2366] that, like the AFROC, is contained within the unit square. The EFROC inferred FPF is defined by (this represents another way of inferring ROC data, albeit only FPF, from FROC data):

```{=tex}
\begin{equation}
FPF_r= 1 - \exp\left ( NLF\left ( \zeta_r \right ) \right )
(\#eq:froc-empirical-EFROC)
\end{equation}
```
In other words, one computes $NLF_r$ using NLs rated $\geq \zeta_r$ on all cases and then transforms it to $FPF_r$ using the exponential transformation shown. Note that $FPF_r$ so defined is in the range (0,1).

### Definition {#froc-empirical-definition-auc-EFROC}

The empirical EFROC plot connects adjacent operating points $\left ( FPF_r^1, \text{LLF}_r \right )$, including the origin (0,0) and (1,1), with straight lines. The only difference between it and the AFROC plot is in the x-axis. The area under this plot is the empirical EFROC AUC, denoted $A_{\text{EFROC}}$.

$A_{\text{EFROC}}$ has the advantage, compared to $A_{\text{FROC}}$, of being defined by points contained within the unit square. It has the advantage over the AFROC of using all NL ratings, not just the highest rated ones. In my opinion this is a mixed blessing. The effect on statistical power compared to $A_{\text{AFROC}}$ has not been studied, but I expect the advantage to be minimal (because the highest rated NL contains more information than a randomly selected NL mark). A disadvantage is that cases with more LLs get more importance in the analysis; this can be corrected by replacing LLF with wLLF, essentially yielding a weighted version of the EFROC AUC. Another disadvantage is that inclusion of NLs on diseased cases causes the EFROC AUC to depend on diseased prevalence. *The EFROC represents the first recognition by someone other than me, of significant limitations of the FROC curve, and that an operating characteristic for FROC data that is completely contained within the unit square is highly desirable.*

## Discussion {#froc-empirical-Discussion}

TBA This chapter started with the difference between latent and actual marks and the notation to describe FROC data. The notation is used in deriving formulae for FROC, inferred ROC, AFROC, wAFROC, AFROC1, wAFROC1 and EFROC operating characteristics. In each case an area measure was defined. With the exception of the FROC plot, all operating characteristics defined in this chapter are contained in the unit square. Discussion of the preferred operating characteristic is deferred to a subsequent chapter TBA.

## References {#froc-empirical-references}
