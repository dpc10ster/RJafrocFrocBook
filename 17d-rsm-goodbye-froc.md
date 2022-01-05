# The FROC should not be used to measure performance {#rsm-goodbye-froc}





## TBA How much finished {#rsm-goodbye-how-much-finished}
10%



## Introduction {#rsm-goodbye-froc-intro}

The preceding chapter described the radiological search model (RSM) for FROC data. This chapter describes predictions of the RSM and how they compare with evidence. The starting point is the inferred ROC curve. While mathematically rather complicated, the results are important because they are needed to derive the ROC-likelihood function, which is used to estimate RSM parameters from ROC data in TBA Chapter 19. The preceding sentence should lead the inquisitive reader to the question: *since the ROC paradigm ignores search, how is it possible to derive parameters of a model of search from the ROC curve?* The answer is that the *shape* of the ROC curve contains information about the RSM parameters. It is fundamentally different from predictions of all conventional ROC models: binormal [@RN1081], contaminated binormal model [@RN1501], bigamma [@RN100] and proper ROC [@metz1999proper], namely it has a *constrained end-point property*, while all other models predict that the *end-point*, namely the uppermost non-trivial point on the ROC, reached at infinitely low reporting threshold, is (1,1), while the RSM predicts it does not reach (1,1). The nature of search is such that the limiting end-point is constrained to be below and to the left of (1,1). This key difference, allows one to estimate search parameters from ROC data. Next, the RSM is used to predict FROC and AFROC curves. Two following sections show how search performance and lesion-classification performance can be quantified from the location of the ROC end-point. Search performance is the ability to find lesions while avoiding finding non-lesions, and lesion-classification performance is the ability, having found a suspicious region, to correctly classify it; if classified as a NL it would not be marked (in the mind of the observer every mark is a potential LL, albeit at different confidence levels). Note that lesion-classification is different from classification between diseased and non-diseased cases, which is measured by the ROC-AUC. Based on the ROC/FROC/AFROC curve predictions of the RSM, a comparison is presented between area measures that can be calculated from FROC data, and this leads to an important conclusion, namely the FROC curve is a poor descriptor of search performance and that the AFROC/wAFROC are preferred. This will come as a surprise (shock?) to most researchers somewhat familiar with this field, since the overwhelming majority of users of FROC methods, particularly in CAD, have relied on the FROC curve. Finally, evidence for the validity of the RSM is presented. 

## The FROC curve is a poor descriptor of search performance {#rsm-goodbye-froc-froc-poor}
Why is the FROC curve is a bad descriptor of performance? The basic reason is that it is unconstrained in the x-direction26. Experts do not "move" as much along the positive x-direction as non-experts and partial area measures lose their meaning. Another reason is that it depends on the marks; unmarked non-diseased cases – representing perfect decisions - are not taken into account. The only meaningful comparison between two FROC curves occurs when they have a common NLF range, but this is rarely the case. As predicted by the RSM, a common range of NLF occurs when the two curves differ only in the   parameter: if   and   are the same, then Eqn. (17.30) predicts the two curves will have identical  . As shown below with numerical integration, this is the only situation where the area under the FROC tracks the area under the ROC, where the latter is regarded as the gold standard.

The code in file mainIsFrocGood.R, Online Appendix 17.E, calculates, by numerical integration, the areas under the full FROC, ROC and AFROC curves. Each full curve consists of the continuously accessible part plus any straight-line extension to (1,1), if applicable. 

Fig. 7 here

The code is divided into 3 parts: 
* Part I, lines 15 – 64, calculates  ,   and   for varying  , with  ; 
* Part II, lines 66 – 115, calculates the same AUCs for varying  , with  ; and
* Part III, lines 117 – 159, calculates the same AUCs for varying  , with  . 

This code takes a few minutes to complete running. The plots generated by this code are shown in Fig. 17.7 (A - F). The first column indicates which RSM parameter is being varied, ROC-AUC =  is plotted along the x-axis, while   is plotted along the y-axis in the left plot and   is plotted along the y-axis in the right plot. The idea is that   is the gold standard as it measures basic classification ability between diseased and non-diseased cases. So, for a valid figure of merit, the quantity plotted along the y-axis should monotonically increase with the gold standard, i.e., the slope should be positive. This is always true for   but is not always true for  ; it is only true when   is varied, which, as was noted above, is the only situation when the range of integration along the NLF axis is constant.


Fig. 17.7 (A- F): Plots of plots   along the x-axis, while   is plotted along the y-axis in the left plot and   is plotted along the y-axis in the right plot. Plots (A) and (B) correspond to varying  , with   and  ; approximate slope AFROC vs. ROC = 2.00; plots (C) and (D) correspond to varying  , with   and  ; approximate slope AFROC vs. ROC = 1.84; and plots (E) and (F) correspond to varying  , with   and  ; approximate slope AFROC vs. ROC = 1.42. Regarding   as the gold standard, the quantity plotted along the y-axis should be monotonic with the gold standard. This is always true for   but is not always true for  : it is only true for the varying  . FROC-AUC is not constrained to unity; see plot (C); the AFROC-AUC is always in the range 0 to 1; see plots (B), (D) and (F). These plots were generated by mainIsFrocGood.R.


The plots of the FROC-AUC in (A) and (C) are non-linear and have negative slope. In contrast, the AFROC-AUCs have a quasi linear dependence on ROC-AUC. [The empirically determined slopes are printed by the code. For plot B the slope is 2.00, for plot D the slope is 1.84 and for plot F the slope is 1.42. These slopes indicate how much an ROC-AUC effect-size is amplified in the AFROC FOM. If only   is different between two modalities, the amplification is almost exactly a factor of two. In the worst-case scenario, if only   is different, the amplification is a factor of 1.42. In general, all three quantities could be different; one expects an intermediate amplification of the effect-size, in the range 1.4 to 2.]

One could argue that the above comparison is unfair to FROC as it considers the whole area under the FROC, while most users would use a point measure or a partial area measure, e.g., LLF @ selected NLF. The problem then is that some readers (especially the really good ones) cannot be analyzed as all of their operating points could to the left of the selected NLF value, and one would need to extrapolate outside the range of observed values in order to get the desired LLF @ selected NLF. For other readers, the data lying to the right of the selected NLF value does not contribute to the measure, resulting in loss of measurement accuracy

It is instructive to consider the extreme cases of a perfect observer and the worst observer to see how the two methods of plotting would deal with defining the average observer. To make the comparison easier, consider that the lesions are small compared to the image area, so that the chance of a random LL is very small.

Fig. 17.8: (A) FROC curves for expert observer: vertical line extending from (0,0) to (0,1) and worst observer: horizontal line over the indicated NLF range. It is not possible to define an average FROC curve, as a common NLF range for the two observers does not exist. (B) Corresponding AFROC curves. AFROC-AUC for a perfect observer is unity (the area includes that under the dashed section extending from (0,1) to (1,1)). The corresponding area for the worst observer is zero, and the average AFROC curve is a straight line parallel to the x-axis at ordinate of 0.5, so the area under the average AFROC-AUC is 0.5 (unlike the ROC-AUC, AFROC-AUC = 0.5 does not denote worst possible performance). This plot was generated by the code in mainBestWorstObserver.R. 

The perfect observer (LLF = 1 @ NLF = 0) and the worst observer (LLF = 0 @ NLF < some constrained value) both yield identical areas (zero) under the FROC curves.  and it is not possible to define an average FROC curve, Fig. 17.7 (A). Because the two plots do not share a common range of abscissa values one cannot define an average FROC curve. In contrast, the AFROC is contained to the unit square and the area under the AFROC curve, Fig. 17.7 (B), is unity for the perfect observer (the area includes that under the dashed section extending from (0,1) to (1,1)). The corresponding area for the worst observer is zero, and the average AFROC curve is a straight line parallel to the x-axis at ordinate of 0.5, so the area under the average AFROC is 0.5 (as already noted, unlike the ROC area, AFROC area = 0.5 does not denote worst possible performance). 

The FROC curve depends only on the marks. A valid FOM should reward correct decisions and penalize incorrect ones on all cases (in my judgment, the use of partial area measures, widespread in the literature, needs to reconsidered). Unmarked non-diseased cases are perfect decisions, but these are not accounted for in the FROC curve (they indirectly affect the curve by the leftward movement of the uppermost point, all the way to NLF = 0 for a perfect observer, but these decisions are not accounted for in FROC curve based partial area measures). The area under the horizontal dashed curve in the AFROC curve shown in Fig. 17.7 (B) is due to unmarked images. See §14.4.2 for further discussion of the meaning of the area under the dashed portion of the AFROC plot. 

Finally, FP marks on diseased cases don't have the same negative connotation as those on non-diseased cases, since, following diagnostic workup, it is possible that the cancer will be found on the recalled cases, but, unlike the AFROC, both contribute to the FROC x-axis.

The RSM is a first-order model: a lot of interesting science remains to be uncovered. It does not account for the satisfaction of search (SOS) effects27-29 observed in medical imaging. It is as if the radiologist senses that an image is possibly diseased, without being able to pinpoint the specific reason, and therefore adopts a more cautious reporting style. They are more reluctant to mark NLs on diseased than on non-diseased cases. This means the probability the a LL rating exceeds the rating of a NL on diseased cases is not equal to the probability that a LL rating exceeds the rating of a NL on non-diseased cases:

  	.	(17.40)

Therefore, inclusion of inter-comparisons between LLs and NLs on diseased cases would make the figure of merit depend on disease prevalence, thereby destroying a desirable property of a valid figure of merit. This is another reason for excluding such comparisons on diseased cases in the AFROC/wAFROC figures of merit. 


### Clinically relevant portion of an operating characteristic #rsm-goodbye-froc-clinically-relevant}

The reason for the quotes is that in my experience this term is used rather loosely in the literature. There is a serious misconception that the "clinically relevant" part of an operating characteristic is the steep portion emanating from the origin. The purpose of this section is to clarify this notion. One needs to go back the definition of the FROC, particularly the linear plot, Fig. 14.2, showing how the raw plot is generated as a virtual threshold is moved from the far right to the far left. While this plot applies to the AFROC, the essential idea is the same. One orders the LL marks (red dots) from left to right in increasing order according to their z-samples. Likewise, the NL marks (green dots) are also ordered from left to right in increasing order according to their z-samples. As the virtual threshold is moved to the left, starting from  , mostly red dots and occasional green dots are crossed; each time a red dot is crossed the operating point moves up by 1/(total number of lesions) and each time a greed dot is crossed the operating point moves to the right by 1/(total number of cases). This causes the operating point to rise, starting from the origin and move upward and to the right. The steep portion of the plot corresponds to crossings by LL and NL marks with high z-samples: it is the contribution of mostly easily visible lesions and the occasional NL. All observers are expected to localize the easy lesions, and there is nothing "clinically significant" about this. This argument applies to all operating characteristics. The clinical significance arises from the application. In a screening application, it is important to maintain high sensitivity at a reasonable specificity. In fact Jiang, Metz and Nishikawa30 had it right when they proposed the area above a preselected high sensitivity threshold   divided by  . Such a measure would emphasize the upper right corner of the ROC curve, not the steep portion near the origin. In the screening context, most of the z-samples (99.5% to be more precise) are from non-diseased cases, and only 0.5% is from diseased cases. This implies the "clinically relevant" part of the plot is near the upper right corner of the ROC plot. With the FROC a normalized area above a preselected   cannot be defined. On the other hand, the AFROC is amenable to such a partial area measure as is, of course, the ROC. 

To do it right, one needs to include the costs and benefits of correct and incorrect decisions on diseased and non-diseased cases, the prevalence of disease and the actual population distribution of the z-samples for non-diseased and diseased cases, and perform a weighted average over the entire ROC or AFROC curve. In the screening context, this would tend to weight the upper end of the curve. This is not an easy problem but it can be solved. 

## Discussion / Summary {#rsm-goodbye-froc-discussion-summary}
This chapter has detailed ROC, FROC and AFROC curves predicted by the radiological search model (RSM). All RSM-predicted curves share the constrained end-point property that is qualitatively different from previous ROC models. In my experience, it is a property that most researchers in this field have difficulty accepting. There is too much history going back to the early 1940s, of the ROC curve extending from (0,0) to (1,1) that one has to let go of, and this can be difficult. 

I am not aware of any direct evidence that radiologists can move the operating point continuously in the range (0,0) to (1,1) in search tasks, so the existence of such an ROC is tantamount to an assumption. Algorithmic observers that do not involve the element of search can extend continuously to (1,1). An example of an algorithmic observer not involving search is a diagnostic test that rates the results of a laboratory measurement, e.g., the A1C measure of blood glucose  for presence of a disease. If A1C ≥ 6.5% the patient is diagnosed as diabetic. By moving the threshold from infinity to –infinity, and assuming a large population of patients, one can trace out the entire ROC curve from the origin to (1,1). This is because every patient yields an A1C value. Now imagine that some finite fraction of the test results are "lost in the mail"; then the ROC curve, calculated over all patients, would have the constrained end-point property, albeit due to an unreasonable cause.

The situation in medical imaging involving search tasks is qualitatively different. Not every case yields a decision variable. There is a reasonable cause for this – to render a decision variable sample the radiologist must find something suspicious to report, and if none is found, there is no decision variable to report. The ROC curve calculated over all patients would exhibit the constrained end-point property, even in the limit of an infinite number of patients. If calculated over only those patients that yielded at least one mark, the ROC curve would extend from (0,0) to (1,1) but then one would be ignoring the cases with no marks, which represent valuable information: unmarked non-diseased cases represent perfect decisions and unmarked diseased cases represent worst-case decisions.

RSM-predicted ROC, FROC and AFROC curves were derived (wAFROC is implemented in the Rjafroc). These were used to demonstrate that the FROC is a poor descriptor of performance. Since almost all work to date, including some by me 47,48, has used FROC curves to measure performance, this is going to be difficulty for some to accept. The examples in Fig. 17.6 (A- F) and Fig. 17.7 (A-B) should convince one that the FROC curve is indeed a poor measure of performance. The only situation where one can safely use the FROC curve is if the two modalities produce curves extending over the same NLF range. This can happen with two variants of a CAD algorithm, but rarely with radiologist observers.

A unique feature is that the RSM provides measures of search and lesion-classification performance. It bears repeating that search performance is the ability to find lesions while avoiding finding non-lesions. Search performance can be determined from the position of the ROC end-point (which in turn is determined by RSM-based fitting of ROC data, Chapter 19). The perpendicular distance between the end-point and the chance diagonal is, apart from a factor of 1.414, a measure of search performance. All ROC models that predict continuous curves extending to (1,1), imply zero search performance. 

Lesion-classification performance is measured by the AUC value corresponding to the   parameter. Lesion-classification performance is the ability to discriminate between LLs and NLs, not between diseased and non-diseased cases: the latter is measured by RSM-AUC. There is a close analogy between the two ways of measuring lesion-classification performance and CAD used to find lesions in screening mammography vs. CAD used in the diagnostic context to determine if a lesion found at screening is actually malignant. The former is termed CADe, for CAD detection, which, in my opinion, is slightly misleading as at screening lesions are found not detected ("detection" is "discover or identify the presence or existence of something ", correct localization is not necessarily implied; the more precise term is "localize"). In the diagnostic context one has CADx, for CAD diagnostic, i.e., given a specific region of the image, is the region malignant? 

Search and lesion-classification performance can be used as "diagnostic aids" to optimize performance of a reader. For example, is search performance is low, then training using mainly non-diseased cases is called for, so the resident learns the different variants of non-diseased tissues that can appear to be true lesions. If lesion-classification performance is low then training with diseased cases only is called for, so the resident learns the distinguishing features characterizing true lesions from non-diseased tissues that fake true lesions.

Finally, evidence for the RSM is summarized. Its correspondence to the empirical Kundel-Nodine model of visual search that is grounded in eye-tracking measurements. It reduces in the limit of large  , which guarantees that every case will yield a decision variable sample, to the binormal model; the predicted pdfs in this limit are not strictly normal, but deviations from normality would require very large sample size to demonstrate. Examples were given where even with 1200 cases the binormal model provides statistically good fits, as judged by the chi-square goodness of fit statistic, Table 17.2. Since the binormal model has proven quite successful in describing a large body of data, it satisfying that the RSM can mimic it in the limit of large  . The RSM explains most empirical results regarding binormal model fits: the common finding that b < 1; that b decreases with increasing lesion pSNR (large   and / or  ); and the finding that the difference in means divided by the difference in standard deviations is fairly constant for a fixed experimental situation, Table 17.3. The RSM explains data degeneracy, especially for radiologists with high expertise.

The contaminated binormal model2-4 (CBM), Chapter 20, which models the diseased distribution as having two peaks, one at zero and the other at a constrained value, also explains the empirical observation that b-parameter < 1 and data degeneracy. Because it allows the ROC curve to go continuously to (1,1), CBM does not completely account for search performance – it accounts for search when it comes to finding lesions, but not for avoiding finding non-lesions.

I do not want to leave the impression that RSM is the ultimate model. The current model does not predict satisfaction of search (SOS) effects27-29. Attempts to incorporate SOS effects in the RSM are in the early research stage. As stated earlier, the RSM is a first-order model: a lot of interesting science remains to be uncovered.

### The Wagner review

The two RSM papers12,13 were honored by being included in a list of 25 papers the "Highlights of 2006" in Physics in Medicine and Biology. As stated by the publisher: "I am delighted to present a special collection of articles that highlight the very best research published in Physics in Medicine and Biology in 2006. Articles were selected for their presentation of outstanding new research, receipt of the highest praise from our international referees, and the highest number of downloads from the journal website.

One of the reviewers was the late Dr. Robert ("Bob") Wagner – he had an open-minded approach to imaging science that is lacking these days, and a unique writing style. I reproduce one of his comments with minor edits, as it pertains to the most interesting and misunderstood prediction of the RSM, namely its constrained end-point property.

I'm thinking here about the straight-line piece of the ROC curve from the max to (1, 1). 
1.	This can be thought of as resulting from two overlapping uniform distributions (thus guessing) far to the left in decision space (rather than delta functions). Please think some more about this point--because it might make better contact with the classical literature. 
2.	BTW -- it just occurs to me (based on the classical early ROC work of Swets & co.) -- that there is a test that can resolve the issue that I struggled with in my earlier remarks. The experimenter can try to force the reader to provide further data that will fill in the space above the max point. If the results are a straight line, then the reader would just be guessing -- as implied by the present model. If the results are concave downward, then further information has been extracted from the data. This could require a great amount of data to sort out--but it's an interesting point (at least to me).


Dr. Wagner made two interesting points. With his passing, I have been deprived of the penetrating and incisive evaluation of his ongoing work, which I deeply miss. Here is my response (ca. 2006):

The need for delta functions at negative infinity can be seen from the following argument. Let us postulate two constrained width pdfs with the same shapes but different areas, centered at a common value far to the left in decision space, but not at negative infinity. These pdfs would also yield a straight-line portion to the ROC curve. However, they would be inconsistent with the search model assumption that some images yield no decision variable samples and therefore cannot be rated in bin ROC:2 or higher. Therefore, if the distributions are as postulated above then choice of a cutoff in the neighborhood of the overlap would result in some of these images being rated 2 or higher, contradicting the RSM assumption.  The delta function pdfs at negative infinity are seen to be a consequence of the search model. 

One could argue that when the observer sees nothing to report then he starts guessing and indeed this would enable the observer to move along the dashed portion of the curve. This argument implies that the observer knows when the threshold is at negative infinity, at which point the observer turns on the guessing mechanism (the observer who always guesses would move along the chance diagonal). In my judgment, this is unreasonable. The existence of two thresholds, one for moving along the non-guessing portion and one for switching to the guessing mode would require abandoning the concept of a single decision rule. To preserve this concept one needs the delta functions at negative infinity.

Regarding Dr. Wagner's second point, it would require a great amount of data to sort out whether forcing the observer to guess would fill in the dashed portion of the curve, but I doubt it is worth the effort. Given the bad consequences of guessing (incorrect recalls) I believe that in the clinical situation, the radiologist will not knowingly guess. If the radiologist sees nothing to report, nothing will be reported. In addition, I believe that forcing the observer, to prove some research point, is not a good idea. 












## References {#rsm-goodbye-froc-references}
1.	Chakraborty DP. Computer analysis of mammography phantom images (CAMPI): An application to the measurement of microcalcification image quality of directly acquired digital images. Medical Physics. 1997;24(8):1269-1277.
2.	Chakraborty DP, Eckert MP. Quantitative versus subjective evaluation of mammography accreditation phantom images. Medical Physics. 1995;22(2):133-143.
3.	Chakraborty DP, Yoon H-J, Mello-Thoms C. Application of threshold-bias independent analysis to eye-tracking and FROC data. Academic Radiology. 2012;In press.
4.	Chakraborty DP. ROC Curves predicted by a model of visual search. Phys Med Biol. 2006;51:3463–3482.
5.	Chakraborty DP. A search model and figure of merit for observer data acquired according to the free-response paradigm. Phys Med Biol. 2006;51:3449–3462.
