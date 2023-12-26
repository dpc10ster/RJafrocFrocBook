# Search and classification performances {#rsm-sc}






## TBA How much finished {#rsm-sc-how-much-finished}
10%




## TBA Introduction {#rsm-sc-intro}

The preceding two chapters described the ROC and other predictions of the radiological search model (RSM). 

This chapter describes two key performance metrics that can be derived from the predicted ROC curve and related to RSM parameters. These are search and classification performances. 

## Location of ROC end-point {#rsm-sc-end-point}

From the previous chapter the coordinates of the end-point are given by:

\begin{equation}
\left. 
\begin{aligned}
&\text{FPF}_{\text{max}} = 1 - \text{exp}\left (\lambda \right ) \\
&\text{TPF}_{\text{max}} = 1 - \text{exp} \left ( - \lambda \right )\sum_{L=1}^{L_{max}}f_L \left ( 1 - \nu \right )^L
\end{aligned}
\right \}
(\#eq:rsm-sc-FPF-TPF-max)
\end{equation}




## Quantifying search performance {#rsm-sc-quantifying}

Qualitatively, search performance is the ability to find lesions while not finding non-lesions. To arrive at a quantitative definition of search performance consider the location of the ROC end-point defined above. 

In Fig. \@ref(fig:rsm-sc-performance-from-roc-curve), plot (a) is a typical ROC curve predicted by models that do not account for search, specifically the biormal model. The end-point is at (1,1), the filled circle, i.e., by adopting a sufficiently low reporting threshold the observer can continuously move the operating point to (1,1). The curve labeled (b) is a typical RSM-predicted ROC curve. The end-point, the filled square, is downwards and left shifted relative to (1,1). The chance diagonal is labeled c. 

The specific parameter values are shown next:



```r
a <- 2; b <- 1 # binormal model
mu <- 2; lambda_i <- 2; nu_i <- 1 # rsm
lesDistr <- c(1) # one lesion per dis. case
```




<div class="figure">
<img src="10-rsm-search_files/figure-html/rsm-sc-performance-from-roc-curve-1.png" alt="Relation of search performance to the end-point of the ROC curve. Plot (a) is using the binormal model while plot (b) is using a RSM predicted curve. The chance diagonal is labeled c. The filled square is the end-point of the RSM predicted curve while the filled dot is the end-point of the binormal predicted curve. The distance of the filled square from the chance diagonal, labeled $d_S$, is a measure of search performance." width="672" />
<p class="caption">(\#fig:rsm-sc-performance-from-roc-curve)Relation of search performance to the end-point of the ROC curve. Plot (a) is using the binormal model while plot (b) is using a RSM predicted curve. The chance diagonal is labeled c. The filled square is the end-point of the RSM predicted curve while the filled dot is the end-point of the binormal predicted curve. The distance of the filled square from the chance diagonal, labeled $d_S$, is a measure of search performance.</p>
</div>


*The location of the end-point, in particular how far it is from (1,1), is a measure of search performance.* Higher search performance is characterized by the end-point moving upwards and to the left, in the limit to (0,1), corresponding to perfect search performance. It is more convenient to use a distance measure as defined next:


**Definition**: The perpendicular distance, $d_S$, from the end-point to the chance diagonal, plot (c), multiplied by $\sqrt{2}$, is a quantitative measure of search performance $S$.  


Using [geometry](https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line#Line_defined_by_an_equation) and Eqn. \@ref(eq:rsm-sc-FPF-TPF-max), it follows that: 


\begin{equation} 
S=\sqrt{2}d_S=\text{TPF}_{\text{max}}-\text{FPF}_{\text{max}}
(\#eq:rsm-sc-perp-distance)
\end{equation}


Therefore, search performance $S$ is given by:


\begin{equation} 
S=\exp\left ( -\lambda \right )\left (1-\sum_{L=1}^{L_{max}}f_L\left ( 1-\nu  \right )^L  \right )
(\#eq:rsm-sc-search-performance)
\end{equation}

Eqn. \@ref(eq:rsm-sc-search-performance) shows search performance is the product of two terms: the probability $\left (1-\sum_{L=1}^{L_{max}}f_L\left ( 1-\nu  \right )^L  \right )$ of finding at least one lesion times the probability $\exp\left ( -\lambda \right )$ of not finding non-lesions. This puts into mathematical form the qualitative definition of search performance as the ability to find lesions while avoiding finding non-lesions. 


Example: consider $\lambda = 0$ and $\nu = 1$. (In terms of intrinsic parameters this occurs when $\mu = \infty$.) The end-point is (0,1). The perpendicular distance from (0,1) to the chance diagonal is $\frac{1}{\sqrt{2}}$, which multiplied by $\sqrt{2}$ yields $S = 1$. The same value is obtained using Eqn. \@ref(eq:rsm-sc-search-performance). Since no NLs are found and all lesions are found, the observer never makes a mistake. One cannot improve over perfect performance and the observer does not need to use the z-sample information: he simply marks all suspicious regions found by search regardless of their z-samples. 

Search performance ranges from zero to one: $0 \le S \le 1$. The lower limit is reached if $\lambda = \infty$ or $\nu = 0$. (In terms of intrinsic parameters this occurs when $\mu = 0$.)


## Quantifying lesion-classification performance {#rsm-sc-performance}

Lesion-classification performance $C$ measures the ability, having found a suspicious region, to correctly classify it as a lesion, i.e., mark the location of the lesion resulting in a LL event. It is distinct from *case-classification* performance, ROC AUC, which measures the ability to distinguish between diseased and non-diseased cases. In contrast *lesion-classification* performance is a measure of the ability to distinguish between diseased and non-diseased regions, i.e., between latent NLs and latent LLs. Lesion-classification performance $C$ is determined by the $\mu$ parameter of the RSM and is defined by the implied ROC-area of two unit variance normal distributions separated by $\mu$. 


\begin{equation}
C=\Phi\left ( \frac{\mu}{\sqrt{2}} \right )
(\#eq:rsm-sc-classification-performance)
\end{equation}


Since $\mu \ge 0$ it follows that $C$ ranges from 0.5 to 1: $0.5 \le C \le 1$. The lower limit occurs when $\mu = 0$ and the upper limit occurs when $\mu = \infty$.


## TBA Lesion-classification performance and the 2AFC LKE task  {#rsm-sc-search-classification-2afc-lke}

It should be obvious that lesion-classification performance is similar to what is measured using the location-known-exactly (LKE) paradigm. In this paradigm, one uses 2AFC methods as in TBA Fig. 4.3, but one could use the ratings method as long as the lesion is cued (i.e., pointed to). On diseased cases, the lesion is cued, but to control for false positives, one must also cue a similar region on non-diseased cases, as in TBA Fig. 4.3. In that figure, the lesion, present in one of the two images, is always in the center of one of the two fields. Sometimes cross hairs are used to indicate where the observer should be looking. The probability of a correct choice in the 2AFC task is  , i.e., AUC conditioned on the (possible) position of the lesion being cued. Since the lesion is cued, search performance of the observer is irrelevant, and one expects  . The reason for the inequality is that on a non-diseased case, the location being cued, in all likelihood, does not correspond to a latent NL found by the observer's search mechanism. Latent NLs are more suspicious for disease than other locations in the case.   measures the separation parameter between latent NLs and LLs. The separation parameter between latent LLs and a researcher chosen location is likely to be larger. This is because latent NLs are more suspicious for disease than a researcher chosen location. It is known that performance under this condition exceeds that in a free-search 2AFC or ROC study, denoted AUC, where the lesion is not cued and it could be anywhere. This should be obvious – pointing to the possible location of the lesion takes out the need for searching the rest of the image, which introduces the possibility of not finding the lesion and / or finding non-lesions. One expects the following ordering:  .   is expected to be the least, as there is uncertainty about possible lesion location.   is expected to be next in order, as now uncertainty has been reduced, and the observer's task is to pick between two cued locations, one a latent NL and the other a latent LL.   is expected to be highest, as now the observer's task is to pick between two cued locations, one a latent LL and the other a researcher chosen location, most likely not a latent NL. Data supporting the expected inequality   is presented in §19.5.4.6.


## Significance {#rsm-sc-search-classification-significance}

The ability to quantify search and lesion-classification performance from a single paradigm (ROC) study is highly significant, going well-beyond modeling the ROC curve. ROC-AUC measures how well an observer is able to separate two groups of patients, a group of diseased patients from a group of non-diseased patients. While important, it does not inform us about how the observer goes about doing this and what is limiting the observer's performance.

In contrast, the search and lesion-classification measures described above can be used as an optimization-aid in determining what is limiting performance. If search performance $S$ is poor it indicates that the observer needs to be trained on more *non-diseased* cases to learn the variants of non-diseased anatomy so as not to confuse them for lesions. On the other hand, if lesion-classification performance $C$ is poor, then one needs to train the observer using images where the location of a possible lesion is cued, and the observer's task is to determine if the cued location is a real lesion. In breast CAD since the designer level ROC curve goes almost all the way to (1,1) implying poor search performance. Therefore more research is needed on improving CAD's search performance. In contrast lCAD's esion-classification performance could actually be quite good, because CAD has access to the pixel values and the ability to apply complex algorithms to properly classify lesions as benign or malignant.

To realize these benefits one needs a way of estimating the ROC end-point shown. TBA Chapter 19 describes RSM based curve fitting which determines all parameters of the RSM, thereby determining the location of the end-point TBA. 

## Discussion / Summary {#rsm-sc-discussion-summary}

TBA This chapter has detailed ROC, FROC and AFROC curves predicted by the radiological search model (RSM). All RSM-predicted curves share the constrained end-point property that is qualitatively different from previous ROC models. In my experience, it is a property that most researchers in this field have difficulty accepting. There is too much history going back to the early 1940s, of the ROC curve extending from (0,0) to (1,1) that one has to let go of, and this can be difficult. 

TBA I am not aware of any direct evidence that radiologists can move the operating point continuously in the range (0,0) to (1,1) in search tasks, so the existence of such an ROC is tantamount to an assumption. Algorithmic observers that do not involve the element of search can extend continuously to (1,1). An example of an algorithmic observer not involving search is a diagnostic test that rates the results of a laboratory measurement, e.g., the A1C measure of blood glucose  for presence of a disease. If A1C ≥ 6.5% the patient is diagnosed as diabetic. By moving the threshold from infinity to –infinity, and assuming a large population of patients, one can trace out the entire ROC curve from the origin to (1,1). This is because every patient yields an A1C value. Now imagine that some finite fraction of the test results are "lost in the mail"; then the ROC curve, calculated over all patients, would have the constrained end-point property, albeit due to an unreasonable cause.

The situation in medical imaging involving search tasks is qualitatively different. Not every case yields a decision variable. There is a reasonable cause for this – to render a decision variable sample the radiologist must find something suspicious to report, and if none is found, there is no decision variable to report. The ROC curve calculated over all patients would exhibit the constrained end-point property, even in the limit of an infinite number of patients. If calculated over only those patients that yielded at least one mark, the ROC curve would extend from (0,0) to (1,1) but then one would be ignoring the cases with no marks, which represent valuable information: unmarked non-diseased cases represent perfect decisions and unmarked diseased cases represent worst-case decisions.

RSM-predicted ROC, FROC and AFROC curves were derived (wAFROC is implemented in the Rjafroc). These were used to demonstrate that the FROC is a poor descriptor of performance. Since almost all work to date, including some by me 47,48, has used FROC curves to measure performance, this is going to be difficulty for some to accept. The examples in Fig. 17.6 (A- F) and Fig. 17.7 (A-B) should convince one that the FROC curve is indeed a poor measure of performance. The only situation where one can safely use the FROC curve is if the two modalities produce curves extending over the same NLF range. This can happen with two variants of a CAD algorithm, but rarely with radiologist observers.

A unique feature is that the RSM provides measures of search and lesion-classification performance. It bears repeating that search performance is the ability to find lesions while avoiding finding non-lesions. Search performance can be determined from the position of the ROC end-point (which in turn is determined by RSM-based fitting of ROC data, Chapter 19). The perpendicular distance between the end-point and the chance diagonal is, apart from a factor of 1.414, a measure of search performance. All ROC models that predict continuous curves extending to (1,1), imply zero search performance. 

Lesion-classification performance is measured by the AUC value corresponding to the   parameter. Lesion-classification performance is the ability to discriminate between LLs and NLs, not between diseased and non-diseased cases: the latter is measured by RSM-AUC. There is a close analogy between the two ways of measuring lesion-classification performance and CAD used to find lesions in screening mammography vs. CAD used in the diagnostic context to determine if a lesion found at screening is actually malignant. The former is termed CADe, for CAD detection, which in my opinion, is slightly misleading as at screening lesions are found not detected ("detection" is "discover or identify the presence or existence of something ", correct localization is not necessarily implied; the more precise term is "localize"). In the diagnostic context one has CADx, for CAD diagnostic, i.e., given a specific region of the image, is the region malignant? 

Search and lesion-classification performance can be used as "diagnostic aids" to optimize performance of a reader. For example, is search performance is low, then training using mainly non-diseased cases is called for, so the resident learns the different variants of non-diseased tissues that can appear to be true lesions. If lesion-classification performance is low then training with diseased cases only is called for, so the resident learns the distinguishing features characterizing true lesions from non-diseased tissues that fake true lesions.

Finally, evidence for the RSM is summarized. Its correspondence to the empirical Kundel-Nodine model of visual search that is grounded in eye-tracking measurements. It reduces in the limit of large  , which guarantees that every case will yield a decision variable sample, to the binormal model; the predicted pdfs in this limit are not strictly normal, but deviations from normality would require very large sample size to demonstrate. Examples were given where even with 1200 cases the binormal model provides statistically good fits, as judged by the chi-square goodness of fit statistic, Table 17.2. Since the binormal model has proven quite successful in describing a large body of data, it satisfying that the RSM can mimic it in the limit of large  . The RSM explains most empirical results regarding binormal model fits: the common finding that b < 1; that b decreases with increasing lesion pSNR (large   and / or  ); and the finding that the difference in means divided by the difference in standard deviations is fairly constant for a fixed experimental situation, Table 17.3. The RSM explains data degeneracy, especially for radiologists with high expertise.

The contaminated binormal model2-4 (CBM), Chapter 20, which models the diseased distribution as having two peaks, one at zero and the other at a constrained value, also explains the empirical observation that b-parameter < 1 and data degeneracy. Because it allows the ROC curve to go continuously to (1,1), CBM does not completely account for search performance – it accounts for search when it comes to finding lesions, but not for avoiding finding non-lesions.

