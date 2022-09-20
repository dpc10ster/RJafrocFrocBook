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
&\text{FPF}_{\text{max}} = 1 - exp\left (\lambda' \right ) \\
&\text{TPF}_{\text{max}} \left ( \mu, \lambda', \nu', L \right ) = 1 - \sum_{L=1}^{L_{max}}f_L\text{exp} \left ( - \lambda' \right ) \left ( 1 - \nu' \right )^L
\end{aligned}
\right \}
(\#eq:rsm-sc-FPF-TPF-max)
\end{equation}




## Quantifying search performance {#rsm-sc-quantifying}

Qualitatively, search performance is the ability to find lesions while not finding non-lesions. To arrive at a quantitative definition of search performance consider the location of the ROC end-point. 

In Fig. \@ref(fig:rsm-sc-performance-from-roc-curve), plot (a) is a typical ROC curve predicted by models that do not account for search. The end-point is at (1,1), the filled circle, i.e., by adopting a sufficiently low reporting threshold the observer can continuously move the operating point to (1,1). 




