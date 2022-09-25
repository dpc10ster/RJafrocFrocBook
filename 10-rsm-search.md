# Search and classification performances {#rsm-sc}






## TBA How much finished {#rsm-sc-how-much-finished}
10%




## TBA Introduction {#rsm-sc-intro}

The preceding chapter described the radiological search model (RSM) for FROC data. This chapter describes predictions of the RSM and how they compare with evidence. The starting point is the inferred ROC curve. While mathematically rather complicated, the results are important because they are needed to derive the ROC-likelihood function, which is used to estimate RSM parameters from ROC data in TBA Chapter 19. The preceding sentence should lead the inquisitive reader to the question: *since the ROC paradigm ignores search, how is it possible to derive parameters of a model of search from the ROC curve?* The answer is that the *shape* of the ROC curve contains information about the RSM parameters. It is fundamentally different from predictions of all conventional ROC models: binormal [@RN1081], contaminated binormal model [@RN1501], bigamma [@RN100] and proper ROC [@metz1999proper], namely it has a *constrained end-point property*, while all other models predict that the *end-point*, namely the uppermost non-trivial point on the ROC, reached at infinitely low reporting threshold, is (1,1), while the RSM predicts it does not reach (1,1). The nature of search is such that the limiting end-point is constrained to be below and to the left of (1,1). This key difference, allows one to estimate search parameters from ROC data. Next, the RSM is used to predict FROC and AFROC curves. Two following sections show how search performance and lesion-classification performance can be quantified from the location of the ROC end-point. Search performance is the ability to find lesions while avoiding finding non-lesions, and lesion-classification performance is the ability, having found a suspicious region, to correctly classify it; if classified as a NL it would not be marked (in the mind of the observer every mark is a potential LL, albeit at different confidence levels). Note that lesion-classification is different from classification between diseased and non-diseased cases, which is measured by the ROC-AUC. Based on the ROC/FROC/AFROC curve predictions of the RSM, a comparison is presented between area measures that can be calculated from FROC data, and this leads to an important conclusion, namely the FROC curve is a poor descriptor of search performance and that the AFROC/wAFROC are preferred. This will come as a surprise (shock?) to most researchers somewhat familiar with this field, since the overwhelming majority of users of FROC methods, particularly in CAD, have relied on the FROC curve. Finally, evidence for the validity of the RSM is presented. 

## Location of ROC end-point {#rsm-sc-end-point}

From the previous chapter the coordinates of the end-point are given by:

\begin{equation}
\left. 
\begin{aligned}
&\text{FPF}_{\text{max}} = 1 - exp\left (\lambda \right ) \\
&\text{TPF}_{\text{max}} \left ( \mu, \lambda, \nu, L \right ) = 1 - \sum_{L=1}^{L_{max}}f_L\text{exp} \left ( - \lambda \right ) \left ( 1 - \nu \right )^L
\end{aligned}
\right \}
(\#eq:rsm-sc-FPF-TPF-max)
\end{equation}




## Quantifying search performance {#rsm-sc-quantifying}

Qualitatively, search performance is the ability to find lesions while not finding non-lesions. To arrive at a quantitative definition of search performance consider the location of the ROC end-point. 

In Fig. \@ref(fig:rsm-sc-performance-from-roc-curve), plot (a) is a typical ROC curve predicted by models that do not account for search. The end-point is at (1,1), the filled circle, i.e., by adopting a sufficiently low reporting threshold the observer can continuously move the operating point to (1,1). 


<div class="figure">
<img src="10-rsm-search_files/figure-html/rsm-sc-performance-from-roc-curve-1.png" alt="Relation of search performance to the end-point of the ROC curve. Plot (a) is for conventional ROC models while plot (b) is for the RSM." width="672" />
<p class="caption">(\#fig:rsm-sc-performance-from-roc-curve)Relation of search performance to the end-point of the ROC curve. Plot (a) is for conventional ROC models while plot (b) is for the RSM.</p>
</div>


The curve labeled (b) is a typical RSM-predicted ROC curve. The end-point is down-left shifted relative to (1,1), the filled square. The observer cannot move the operating point continuously to (1,1). *The location of the end-point, in particular how far it is from (1,1), measures search performance.* Higher search performance is characterized by the end-point moving upwards and to the left, in the limit to (0,1), corresponding to perfect search performance. 


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


Example: consider $\lambda = 0$ and $\nu = 1$. The end-point is (0,1). The perpendicular distance from (0,1) to the chance diagonal is $\frac{1}{\sqrt{2}}$, which multiplied by $\sqrt{2}$ yields $S = 1$. The same value is obtained using Eqn. \@ref(eq:rsm-sc-search-performance). Since no NLs are found and all lesions are found, the observer never makes a mistake. One cannot improve over perfect performance: the observer simply marks all suspiciuos regions found by search regardless of their z-samples. 


## Quantifying lesion-classification performance {#rsm-sc-performance}

Lesion-classification performance $C$ measures the ability, having found a suspicious region, to correctly classify it as a lesion, i.e., mark the location of the lesion resulting in a LL event. It is distinct from *case-classification* performance, ROC AUC, which measures the ability to distinguish between diseased and non-diseased cases. In contrast *lesion-classification* performance is a measure of the ability to distinguish between diseased and non-diseased regions, i.e., between latent NLs and latent LLs. Lesion-classification performance $C$ is determined by the $\mu$ parameter of the RSM and is defined by the implied ROC-area of two unit variance normal distributions separated by $\mu$. 


\begin{equation}
C=\Phi\left ( \frac{\mu}{\sqrt{2}} \right )
(\#eq:rsm-sc-classification-performance)
\end{equation}


Since $\mu \ge 0$ it follows that $C$ ranges from 0.5 to 1.


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


