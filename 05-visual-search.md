# Visual Search {#visual-search}





## TBA How much finished {#visual-search-how-much-finished}
10%



## Introduction {#visual-search-intro}

To understand free-response data, specifically how radiologists interpret images, one must come to grips with visual search. Casual usage of everyday terms like "search", "recognition" and "detection" in specific scientific contexts can lead to confusion. 
*Visual search is defined in a broad sense as grouping and labeling parts of an image.*

A schema of how radiologists find perform the search task, termed the Kundel-Nodine search model is described. The importance of this major conceptual model is not widely appreciated by researchers. It is the basis of the radiological search model (RSM) described in a later chapter TBA. 

The following sections draw heavily on work by Nodine and Kundel [@nodine1987using; @kundel2007holistic; @kundel2004modeling; @kundel1983visual; @kundel1978visual]. The author acknowledges critical insights gained through conversations with Dr. Claudia Mello-Thoms.



## Grouping and labeling ROIs {#visual-search-grouping-labeling-rois}

Looking at and understanding an image involves grouping and assigning labels to different regions of interest (ROIs) in the image, where the labels correspond to entities that exist (or have existed in the examples to follow) in the real world. As an example, if one looks at Fig. \@ref(fig:visual-search-us-presidents), one would label them (from left to right and top to bottom, in raster fashion): Franklin Roosevelt, Harry Truman, Lyndon Johnson, Richard Nixon, Jimmy Carter, Ronald Reagan, George H. W. Bush, and the presidential seal. The accuracy of the labeling depends on prior-knowledge, i.e., expertise, of the observer. If one were ignorant about US presidents one would be unable to correctly label them. 

<div class="figure" style="text-align: center">
<img src="images/15-visual-search/usPresidents.png" alt="This image consists of 8 sub-images or ROIs. Understanding an image involves grouping and assigning labels to different ROIs, where the labels correspond to entities that exist in the real world. One familiar with US history would label them, from left to right and top to bottom, in raster fashion, Franklin Roosevelt, Harry Truman, Lyndon Johnson, Richard Nixon, Jimmy Carter, Ronald Reagan, George H. Bush and the presidential seal. Labeling accuracy depends on expertise of the observer. The row and column index of each ROI identifies its location."  />
<p class="caption">(\#fig:visual-search-us-presidents)This image consists of 8 sub-images or ROIs. Understanding an image involves grouping and assigning labels to different ROIs, where the labels correspond to entities that exist in the real world. One familiar with US history would label them, from left to right and top to bottom, in raster fashion, Franklin Roosevelt, Harry Truman, Lyndon Johnson, Richard Nixon, Jimmy Carter, Ronald Reagan, George H. Bush and the presidential seal. Labeling accuracy depends on expertise of the observer. The row and column index of each ROI identifies its location.</p>
</div>


Image interpretation in radiology is not fundamentally different. It involves assigning labels to an image by grouping and recognizing areas of the image that have correspondences to the radiologist’s knowledge of the underlying anatomy, and, most importantly, deviations from the underlying anatomy. Most doctors, who need not be radiologists, can look at a chest x-ray and say, "this is the heart", "this is a rib", "this is a clavicle", "this is the aortic arch", etc., the top image in Fig. \@ref(fig:visual-search-chest-images). This is because they know the underlying anatomy, the bottom image in Fig. \@ref(fig:visual-search-chest-images) and have a basic understanding of the x-ray image formation physics that relates the anatomy to the image.


<div class="figure" style="text-align: center">
<img src="images/15-visual-search/chest-imageA.png" alt="Image interpretation in radiology involves assigning labels to an image by grouping and recognizing areas of the image that have correspondences to the radiologist’s knowledge of the underlying anatomy. (TOP) Most doctors can look at a chest x-ray and say, &quot;this is the heart&quot;, &quot;this is a rib&quot;, &quot;this is the clavicle&quot;, &quot;this is the aortic arch&quot;, etc. (BOTTOM) This is because they know the underlying anatomy and have a basic understanding of x-ray image formation physics that relates anatomy to the image."  /><img src="images/15-visual-search/chest-imageB.png" alt="Image interpretation in radiology involves assigning labels to an image by grouping and recognizing areas of the image that have correspondences to the radiologist’s knowledge of the underlying anatomy. (TOP) Most doctors can look at a chest x-ray and say, &quot;this is the heart&quot;, &quot;this is a rib&quot;, &quot;this is the clavicle&quot;, &quot;this is the aortic arch&quot;, etc. (BOTTOM) This is because they know the underlying anatomy and have a basic understanding of x-ray image formation physics that relates anatomy to the image."  />
<p class="caption">(\#fig:visual-search-chest-images)Image interpretation in radiology involves assigning labels to an image by grouping and recognizing areas of the image that have correspondences to the radiologist’s knowledge of the underlying anatomy. (TOP) Most doctors can look at a chest x-ray and say, "this is the heart", "this is a rib", "this is the clavicle", "this is the aortic arch", etc. (BOTTOM) This is because they know the underlying anatomy and have a basic understanding of x-ray image formation physics that relates anatomy to the image.</p>
</div>


## Recognition vs. detection {#visual-search-recognition-detection}

The process of grouping and labeling parts of an image is termed recognition. This was illustrated with the pictures of the US presidents, Fig. \@ref(fig:visual-search-us-presidents). Recognition is distinct from detection, which is deciding about the presence of something that is unexpected or the absence of something that is expected, in other words, a deviation, in either direction, from what is expected. An example of detecting the presence of something that is unexpected would be a lung nodule and an example of detecting the absence of something that is expected would be an image of a patient with a missing rib (yes, it does occur, even excluding the biblical Adam). 

The terms "expected" and "unexpected" are important: they imply expertise dependent expectations regarding the true structure of the non-diseased image, which I term a non-diseased template, and therefore an ability to recognize  clinically relevant deviations or perturbations, in either direction, from this template; e.g., a lung nodule that could be cancer. By "clinically relevant" I mean perturbations related to the patient's health outcome – recognizing scratches, dead pixels, artifacts of know origin, and lead patient ID markers, do not count. There is a location associated with recognition, but not with detection. Detection is the presence or absence of something, i.e., the perturbation, which could be anywhere. For example, in Fig. \@ref(fig:visual-search-us-presidents), recognizing a face is equivalent to assigning a row and column index in the image. Specifically, recognizing of George H.W. Bush implies pointing to row = two and column = three. Detecting George H.W. Bush implies stating that George H.W. Bush is present in the image, but the location could be in any of the eight locations. Recognition is an FROC paradigm task, while detection is an ROC paradigm task. Instead of recognition, I prefer the more clinical term "finding", as in "finding" a lesion.


## TBA Search vs. classification {#visual-search-search-classification}

Since template perturbations can occur at different locations in the images, the ability to selectively recognize them is related to search expertise. The term "selectively" is important: a non-expert can trivially recognize all perturbations by claiming all regions in the image are perturbed. Search expertise is the selective ability to find clinically relevant perturbations that are actually present while minimizing finding what appear to be clinically relevant perturbations but which are actually not present. In FROC terminology, search expertise is the ability to find latent LLs while minimizing the numbers of found latent NLs. Lesion-classification expertise is the ability to correctly classify a found suspicious region as malignant or benign. 

The skills required to recognize a nodule in a chest x-ray are different from that required to recognize a low-contrast circular or Gaussian shaped artificial nodule against a background of random noise. In the former instance the skills of the radiologist are relevant: e.g., the skilled radiologist knows not to confuse a blood vessel viewed "end on" for a nodule, especially since the radiologist knows where to expect these vessels, e.g., the aorta. In the latter instance, (i.e., viewing artificial nodules superposed on random noise) there are no expected anatomic structures, so the skills possessed by the radiologist are nullified. This is the reason why having radiologists interpret random noise images and pretending that this somehow makes it “clinically relevant” is a waste of reader resources and represent bad science. One might as well used undergraduates with good eyesight, motivation and training. To quote [@nodine1987using] 

> Detecting an object that is hidden in a natural scene is not the same as detecting an object displayed against a background of random noise.

This paragraph also argues against usage of phantoms as stand-ins for clinical images for "clinical" performance assessment. Phantoms are fine in the quality control context, but they do not allow radiologists the opportunity to exercise their professional skills.
 

## The Kundel - Nodine search model {#visual-search-kundel-nodine-model}

The Kundel-Nodine model [@kundel2007holistic; @kundel2004modeling] is a schema of events that occur from the radiologist's first glance to the decision about the image.  

Assuming the task has been defined prior to viewing, based on eye-tracking recordings obtained on radiologists while they interpreted images, Kundel and Nodine proposed the following schema for the diagnostic interpretation process, consisting of two major components: (1) glancing or global impression and (2) scanning or feature analysis:


<div class="figure" style="text-align: center">
<img src="images/15-visual-search/kundel-nodine.png" alt="The Kundel-Nodine model of radiological search. The glancing/global stage identifies perturbations from the template of a generic non-diseased case. The scanning stage analyzes the each perturbation and calculates the probability it is a true lesion. Only perturbations with sufficiently high probability are marked."  />
<p class="caption">(\#fig:visual-search-kundel-nodine)The Kundel-Nodine model of radiological search. The glancing/global stage identifies perturbations from the template of a generic non-diseased case. The scanning stage analyzes the each perturbation and calculates the probability it is a true lesion. Only perturbations with sufficiently high probability are marked.</p>
</div>



### Glancing / Global impression {#visual-search-glancing-global-impression}

The colloquial term "glancing" is meant literally. The glance is brief, typically lasting about 100 - 300 ms, too short for detailed foveal examination and interpretation. Instead, during this brief interval peripheral vision and reader expertise are the primary mechanisms responsible for the identification of the perturbations. The glance results in a global impression, or gestalt, that identifies perturbations from the template. Object recognition occurs at a holistic level, i.e., in the context of the whole image, as there is insufficient time for detailed viewing and all of this is going on using peripheral vision. It is remarkable that radiologists can make reasonably accurate interpretations from information obtained in a brief glance, see Fig. 6 in [@nodine1987using]. Perturbations are flagged for subsequent detailed viewing, i.e., the initial glance tells the visual system where to look more closely. 

### Scanning / Local feature analysis {#visual-search-scanning-local-feature-analysis}

The global impression identifies perturbations for detailed foveal viewing by the central vision. During this process - termed scanning or feature analysis - the observer scrutinizes  and analyzes the suspicious regions for evidence of possible disease.  In principle, they calculate the probability of malignancy. For those readers of this book familiar with how CAD works, this corresponds to the feature analysis stage of CAD where regions found by the global search, termed *initial detections* in the CAD literature, are analyzed for probability of malignancy. 

The essential point that emerges is that decisions are made at a finite, relatively small, number of regions. Attention units are not uniformly distributed through the image in raster-scan fashion; rather the global impression identifies a smaller set of regions that require detailed scanning.

Eye-tracker recordings for a two-view digital mammogram for two observers are shown in Fig. \@ref(fig:visual-search-eye-tracking), for an inexperienced observer (upper two panels) and an expert mammographer (lower two panels). The small circles indicate individual fixations (dwell time ~ 100 ms). The larger high-contrast circles indicate clustered fixations (cumulative dwell time ~ 1 s). The larger low-contrast circles indicate a mass visible on both views. The inexperienced observer finds many more suspicious regions than does the expert mammographer but misses the lesion in the MLO view. In other words, the inexperienced observer generates many latent NLs but only one latent LL. The mammographer finds the lesion in the MLO view, which qualifies as a latent LL, without finding suspicious regions in the non-diseased parenchyma, i.e., the expert generated zero latent NLs on this case and one latent LL. It is possible the observer was so confident in the malignancy found in the MLO view that there was no need to fixate the visible lesion in the other view - the decision had already been made to recall the patient for further imaging.

<div class="figure" style="text-align: center">
<img src="images/15-visual-search/eye-tracking-4-images.png" alt="Eye-tracking recordings for a two-view digital mammogram: see details."  />
<p class="caption">(\#fig:visual-search-eye-tracking)Eye-tracking recordings for a two-view digital mammogram: see details.</p>
</div>


**Details:** Eye-tracking recordings for a two-view digital mammogram display for two observers, an inexperienced observer (upper two panels) and an expert mammographer (lower two panels). The small circles indicate individual fixations (dwell time ~ 100 ms).  The larger high-contrast circles indicate clustered fixations (cumulative dwell time ~ 1 sec). The latter correspond to the latent marks in the search-model. The larger low-contrast circles indicate a mass visible on both views. The inexperienced observer finds many more suspicious regions than does the expert mammographer but misses the lesion in the MLO view. In other words the inexperienced observer generates many latent NLs but only one latent LL. The mammographer finds the lesion in the MLO view, which qualifies as a latent LL, without finding suspicious regions in the non-diseased parenchyma, i.e., the expert generated zero latent NLs on this case and one latent LL. It is possible the observer was so confident in the malignancy found in the MLO view that there was no need to fixate the visible lesion in the other view - the decision had already been made to recall the patient for further imaging, which confirmed the finding.


## Kundel-Nodine model and CAD algorithms {#visual-search-Kundel-Nodine-model-CAD}

It turns out that the designers of CAD algorithms independently arrived at a two-stage process remarkably similar to that described by Kundel-Nodine for radiologist observers. CAD algorithms are designed to emulate expert radiologists, and while this goal is not yet met, these algorithms are reasonable approximations to radiologists, and include the critical elements of search and localization that are central to clinical tasks. CAD algorithms involve two steps analogous to the holistic and cognitive stages of the Kundel-Nodine visual search model [@nodine1987using; @kundel2004modeling; @kundel1983visual].  In other words, CAD has a perceptual correspondence to human observers that to my knowledge is not shared by other method of predicting what radiologists will call on clinical images.

In the first stage of CAD, termed initial detections [@edwards2002maximum], the algorithm finds "all reasonable" regions that could possibly be a malignancy. The term "all reasonable" is used because an irrational observer could trivially "find" every malignancy by marking all regions of the image. Most of these regions would be unreasonable to a rational observer, who would prefentially marks lesions while minimizing marking other regions. Therefore, the idea of CAD's initial detection stage is to find as many of the malignancies as possible while not finding too many non-diseased regions. This corresponds to the search stage of the Kundel-Nodine model. Unfortunately, CAD is rather poor at this task compared to expert radiologists. Progress in this area has been stymied by lack of understanding of search and how to measure performance in the FROC task. Indeed a widely held misconception is that CAD is perfect (!) at search, because it "looks at" everything (Dr. Ron Summers, NIH, private communication, Dublin, ca. 2010). In giving equal attention units to all parts of the image, CAD will trivially find all cancers, but it will also find a large number of NLs.

CAD researchers are, in my opinion, at the forefront of those presuming to understand how radiologists interpret cases. They work with real images and real lesions and the manufacturer's reputation is on the line, just like a radiologist's, and Medicare even reimburses CAD interpretations. While their current track record is not that good for breast masses compared to expert radiologists, with proper understanding of what is limiting CAD, namely the search process, there is no doubt in my opinion, that future generations CAD algorithms will approach and even surpass expert radiologists. 

## TBA Discussion / Summary {#visual-search-discussion-summary}

This chapter has introduced the terminology associated with a search task: recognition/finding, classification, and detection. Search involves finding lesions and correctly classifying them, so two types of expertise are relevant: search expertise is the ability to find (true) lesions without finding non-lesions, while classification accuracy is concerned with correct classification (benign vs. malignant) of a suspicious region that has already been found. Quantification of these abilities is described in the next chapter. Two paradigms are used to measure search, one in the non-medical context and the other, the focus of this book, in the medical context. The second method is based on the eye tracking measurements performed while radiologists perform quasi-clinical tasks (performing eye-tracking measurements in a true clinical setting is difficult). A method for analyzing eye-tracking data using methods developed for FROC analysis has been described. It has the advantage of taking into account information present in eye-tracking data, such as dwell time and approach rate, in a quantitative manner, essentially by treating them as eye-tracking ratings to which modern FROC methods can be applied. The Kundel-Nodine model of visual search in diagnostic imaging was described. The next chapter describes a statistical parameterization of this model, termed the radiological search model (RSM).

## References {#visual-search-references}

Nodine CF, Kundel HL. Using eye movements to study visual search and to improve tumor detection. RadioGraphics. 1987;7(2):1241-1250.
2.	Kundel HL, Nodine CF, Conant EF, Weinstein SP. Holistic Component of Image Perception in Mammogram Interpretation: Gaze-tracking Study. Radiology. 2007;242(2):396-402.
3.	Kundel HL, Nodine CF. Modeling visual search during mammogram viewing. Proc SPIE. 2004;5372:110-115.
4.	Kundel HL, Nodine CF. A visual concept shapes image perception. Radiology. 1983;146:363-368.
5.	Kundel HL, Nodine CF, Carmody D. Visual scanning, pattern recognition and decision-making in pulmonary nodule detection. Invest Radiol. 1978;13:175-181.
6.	Horowitz TS, Wolfe JM. Visual search has no memory. Nature. 1998;394(6693):575-577.
7.	Wolfe JM. Guided Search 2.0: A revised model of visual search. Psychonomic Bulletin & Review. 1994;1(2):202-238.
8.	Wolfe JM, Cave KR, Franzel SL. Guided search: an alternative to the feature integration model for visual search. Journal of Experimental Psychology: Human perception and performance. 1989;15(3):419.
9.	Carmody DP, Kundel HL, Nodine CF. Performance of a computer system for recording eye fixations using limbus reflection. Behavior Research Methods & Instrumentation. 1980;12(1):63-66.
10.	Duchowski AT. Eye Tracking Methodology: Theory and Practice. Clemson, SC: Clemson University; 2002.
11.	Nodine C, Mello-Thoms C, Kundel H, Weinstein S. Time course of perception and decision making during mammographic interpretation. AJR. 2002;179:917-923.
12.	Nodine CF, Kundel HL, Mello-Thoms C, et al. How experience and training influence mammography expertise. Acad Radiol. 1999;6(10):575-585.
13.	Chakraborty DP, Yoon H-J, Mello-Thoms C. Application of threshold-bias independent analysis to eye-tracking and FROC data. Academic radiology. 2012;19(12):1474-1483.
14.	Burgess AE. Comparison of receiver operating characteristic and forced choice observer performance measurement methods. Med Phys. 1995;22(5):643-655.
15.	Bunch PC, Hamilton JF, Sanderson GK, Simmons AH. A Free-Response Approach to the Measurement and Characterization of Radiographic-Observer Performance. J of Appl Photogr Eng. 1978;4:166-171.
16.	Kundel HL, Nodine CF, Krupinski EA. Searching for lung nodules: visual dwell indicates locations of false-positive and false-negative decisions. Investigative Radiology. 1989;24:472-478.
17.	Chakraborty DP, Yoon H-J, Mello-Thoms C. Application of threshold-bias independent analysis to eye-tracking and FROC data. Academic Radiology. 2012;In press.
18.	Wolfe JM. Visual Search. In: Pashler H, ed. Attention. London, UK: University College London Press; 1998.
19.	Larson AM, Loschky LC. The contributions of central versus peripheral vision to scene gist recognition. Journal of Vision. 2009;9(10):6-6.
20.	Pritchard RM, Heron W, Hebb DO. Visual perception approached by the method of stabilized images. Canadian Journal of Psychology/Revue canadienne de psychologie. 1960;14(2):67.
21.	Edwards DC, Kupinski MA, Metz CE, Nishikawa RM. Maximum likelihood fitting of FROC curves under an initial-detection-and-candidate-analysis model. Med Phys. 2002;29(12):2861-2870.
22.	Kundel HL, Nodine CF, Krupinski EA, Mello-Thoms C. Using Gaze-tracking Data and Mixture Distribution Analysis to Support a Holistic Model for the Detection of Cancers on Mammograms. Academic Radiology. 2008;15(7):881-886.
23.	Mello-Thoms C, Hardesty LA, Sumkin JH, et al. Effects of lesion conspicuity on visual search in mammogram reading. Acad Radiol. 2005;12:830-840.

