# The radiological search model {#rsm}





## TBA How much finished {#rsm-how-much-finished}
70%



## Introduction {#rsm-intro}

Brief accounts of the radiological search model (RSM) were presented earlier in connection with the simulator used to generate FROC data. This chapter describes the model in more detail. 

All models of ROC data *not incorporating search* involve two fundamental parameters (i.e, not including binning-related threshold parameters). For example, the unequal variance binormal model in Chapter \@ref(binormal-model) requires the $a,b$ parameters. Alternative ROC models described in TBA Chapter 20 also require two fundamental parameters. 

*It turns out that all that is needed to model as seemingly complex a process as visual search, at least to first order, is one additional fundamental parameter*. The RSM contains three fundamental parameters: $\mu$, $\lambda$ and $\nu$. However, it is easier to introduce the RSM via $\mu$ and intermediate primed parameters, $\lambda'$ and  $\nu'$. The model is then re-parameterized to take into account that $\lambda'$ and  $\nu'$ must depend on $\mu$ via un-primed parameters $\lambda$ and $\nu$ *which are intrinsic parameters*, i.e., independent of $\mu$.

The RSM is a model of the FROC paradigm. It accounts for all features characterizing the FROC paradigm, including localization and the random non-negative numbers of NLs and LLs per image.


## The radiological search model {#rsm-details}
The radiological search model (RSM) for the free-response paradigm is a statistical parameterization of the Nodine-Kundel model. It consists of:

* A *search stage* corresponding to the initial glance in the Nodine-Kundel model, in which suspicious regions, i.e., the latent marks, are flagged for subsequent foveal scanning. The total number of latent marks on a case is $\geq 0$; some cases may have zero latent marks, a fact that will turn out to have important consequences for the shapes of all RSM predicted operating characteristics.

* A *decision stage* during which each latent mark is closely examined (via foveal scanning), relevant features are extracted and analyzed and the observer calculates a decision variable or z-sample for each latent mark. The number of z-samples equals the number of latent marks. 

* If the z-sample exceeds a pre-selected minimum reporting threshold the location is marked, i.e., the latent mark is recorded as an actual mark. 

* Latent marks can be either latent NLs (corresponding to non-diseased regions) or latent LLs (corresponding to diseased regions). The number of latent NLs on a case is denoted $l_1$. The number of latent LLs on a diseased case is denoted $l_2$. Latent NLs can occur on non-diseased and diseased cases, but latent LLs can only occur on diseased cases. We will initially assume that every diseased case has $L$ actual lesions. Later this will be extended to arbitrary number of lesions per diseased case. Since the number of latent LLs cannot exceed the number of lesions, $0 \leq l_2 \leq L$ . The symbol $l_s$  denotes a location with site-level truth state $s$, where $s = 1$ for a NL and $s = 2$ for a LL. ^[In this chapter distributional assumptions are made for the numbers of latent NLs and LLs and the associated z-samples. Since the RSM is a parametric model one does not need the four subscript notation needed to account for case and location dependence, as necessary in the empirical description in Chapter \@ref(froc-empirical). This allows for a simpler notation, as the reader may have noticed, unencumbered by the 4 subscripts in Table \@ref(froc-empirical-notation).]

## RSM assumptions {#rsm-assumptions}

**Assumption 1:** The number of latent NLs, $l_1 \geq 0$, is sampled from the Poisson distribution $\text{Poi}$ with mean $\lambda'$:

\begin{equation} 
l_1 \sim \text{Poi}\left ( \lambda' \right ) 
(\#eq:rsm-poisson-sampling)
\end{equation}


The probability mass function (pmf) of the Poisson distribution is defined by:

\begin{equation} 
\text{pmf}_{Poi}\left ( l_1, \lambda' \right ) = exp\left ( -\lambda' \right ) \frac{{(\lambda')^{l_1}}}{(l_1')!}
(\#eq:rsm-poisson-pmf)
\end{equation}

**Assumption 2:** The number of latent LLs, $l_2$, where $0 \leq l_2 \leq L$, is sampled from the binomial distribution $\text{Bin}$ with success probability $\nu'$ and trial size $L$: 


\begin{equation} 
l_2 \sim \text{Bin}\left ( L, \nu' \right ) 
(\#eq:rsm-binomial-sampling)
\end{equation}

The pmf of the binomial distribution is defined by:

\begin{equation} 
\text{pmf}_{Bin}\left ( l_2, L, \nu' \right ) = \binom{L}{l_2} \left (\nu'  \right )^{l_2} \left (1-\nu'  \right )^{L-l_2}
(\#eq:rsm-binomial-pmf)
\end{equation}


**Assumption 3:** Each latent mark is associated with a z-sample. That for a latent NL is denoted $z_{l_1}$ while that for a latent LL is denoted $z_{l_2}$. Latent NLs can occur on non-diseased and diseased cases while latent LLs can only occur on diseased cases.

**Assumption 4:** For latent NLs the z-samples are obtained by sampling $N \left ( 0, 1 \right )$:

\begin{equation} 
z_{l_1} \sim N \left ( 0, 1 \right )
(\#eq:rsm-sampling-l1)
\end{equation}

**Assumption 5:** For latent LLs the z-samples are obtained by sampling $N \left ( \mu, 1 \right )$:

\begin{equation} 
z_{l_2} \sim N \left ( \mu, 1 \right )
(\#eq:rsm-sampling-l2)
\end{equation}


The probability density function $\phi\left ( z | \mu \right )$ of the normal distribution $N \left ( \mu, 1 \right )$ is defined by:


\begin{equation} 
\phi\left ( z | \mu \right )=\frac{1}{\sqrt{2\pi}}\exp\left ( -\frac{(z-\mu)^2}{2} \right )
(\#eq:rsm-pdf-phi-mu)
\end{equation}

**Binning rule:** In an FROC study with R ratings, the observer adopts $R$ ordered cutoffs $\zeta_r$, where $\left ( r = 1, 2, ..., R \right )$. Defining  $\zeta_0 = -\infty$ and $\zeta_{R+1} = \infty$, then if $\zeta_r \leq z_{l_s} < \zeta_{r+1}$ the corresponding latent site is marked and rated in bin $r$, and if $z_{l_s} \leq \zeta_1$ the site is not marked. 

**Mark location:** The location of the mark is assumed to be at the exact center of the latent site that exceeded a cutoff and an infinitely precise proximity criterion is adopted. Consequently, there is no confusing a mark made because of a latent LL z-sample exceeding the cutoff with one made because of a latent NL z-sample exceeding the cutoff. Therefore, any mark made because of a latent NL z-sample that satisfies $\zeta_r \leq z_{l_1} < \zeta_{r+1}$ will be scored as a non-lesion localization (NL) and rated $r$. Likewise, any mark made because of a latent LL z-sample that satisfies $\zeta_r \leq z_{l_2} < \zeta_{r+1}$ will be scored as a lesion-localization (LL) and rated $r$. 

**Rating assigned to unmarked sites:** Unmarked LLs are assigned the zero rating: even lesions that were not flagged by the search stage, and therefore do not qualify as latent LLs, are assigned the zero rating. This is because they represent observable events. In contrast, unmarked latent NLs are unobservable events (unlike lesions, there is no a-priori reader-independent list of non-lesion locations; in fact, what constitutes a NL is reader dependent).

By choosing $R$ large enough, the preceding discrete rating model is applicable to continuous z-samples.


## Physical interpretation of RSM parameters {#rsm-parameter-interpretations}
The parameters $\mu$, $\lambda'$ and $\nu'$ have the following meanings:

### The $\mu$ parameter {#rsm-mu-parameter}
The $\mu$ parameter is the lesion contrast-to-noise-ratio, or more accurately, the perceptual signal to noise ratio *pSNR* introduced in (book) Chapter 12, between latent NLs and latent LLs. It is not the pSNR of the latent LL relative to its immediate surround. For structured backgrounds - as opposed to homogeneous backgrounds - pSNR is determined by the competition for the observer's foveal attention from other regions, outside the immediate surround, that could be mistaken for lesions.  

The $\mu$ parameter is similar to detectability index $d'$, which is the separation parameter of two unit normal distributions required to achieve the observed probability of correct choice (PC) in a two alternative forced choice (2AFC) task between cued (i.e., pointed to by toggle-able arrows) NLs and cued LLs. Individually and for each reader one determines the locations of the latent marks using eye-tracking apparatus and then runs a 2AFC study as follows: pairs of images are shown, each with a cued location, one a latent NL and the other a latent LL, where all locations were recorded in prior eye-tracking sessions for the specific radiologist. The radiologist's task is to pick the image with the latent LL. The probability correct $\text{PC}$ in this task is related to the $d'$ parameter by:

\begin{equation} 
\mu = \sqrt{2} \Phi^{-1} \left ( \text{PC} \right )
(\#eq:rsm-mu-2afc)
\end{equation}

The radiologist on whom the eye-tracking measurements are performed and the one who performs the two alternative forced choice tasks must be the same, as two radiologists may not agree on latent NL marks. A complication in conducting such a study is that because of memory effects a lesion can only be shown once to each reader: clinical images are distinctive - once a radiologist has found a lesion in a clinical image, that event becomes imprinted in long-term memory; one cannot repeatedly compare this lesion to other NLs in the 2AFC task as the radiologist will always pick the remembered lesion. 

### The $\lambda'$ parameter {#rsm-summary-lambda-prime-parameter}

The $\lambda'$ parameter determines the tendency of the observer to generate latent NLs. The mean number of latent NLs per case is an estimate of $\lambda'$. ^[It can be measured via eye-tracking apparatus. This time it is only necessary to cluster the marks and classify each mark as a latent NL or latent LL according to the adopted acceptance radius. An eye-tracking based estimate would be the total number of latent NLs in the dataset divided by the total number of cases.]

Consider two observers, one with $\lambda' = 1$ and the other with $\lambda' = 2$. While one cannot predict the exact number of latent NLs on any specific case, one can predict the average number of latent NLs on a given case set. 

In the following examples the number of samples has been set to $K_1=100$ (the first argument to `rpois()`; the second argument is $\lambda'$). 

#### Example 1


```r
seed <- 1;set.seed(seed)
K1 <- 100
samples1 <- rpois(K1,1)
```



```
## mean(samples1) =  1.01
```

```
## samples1[1:10] =  0 1 1 2 0 2 3 1 1 0
```


For this observer, $\lambda' = 1$, the first case generated zero latent NLs, the 2nd and 3rd cases generated one NL each, the third case generated 2 NLs, etc. 

#### Example 2


```r
seed <- 1;set.seed(seed)
samples2 <- rpois(K1,2)
```



```
## mean(samples2) =  2.02
```

```
## samples2[1:10] =  1 1 2 4 1 4 4 2 2 0
```


For the second observer $\lambda' = 2$, the first and second case generated one latent NL each, the third generated two, etc. The average number of latent NL marks per case for the 1^st^ observer is 1.01 and that for the 2^nd^ one is 2.02.

#### Confidence intervals

The following code illustrates Poisson sampling and estimation of an exact confidence interval for the mean for 100 samples from two Poisson distributions. 



```r
K1 <- 100
lambdaP <- c(1,2)
seed <- 1;set.seed(seed);samples1 <- rpois(K1,lambda = lambdaP[1])
seed <- 1;set.seed(seed);samples2 <- rpois(K1,lambda = lambdaP[2])

ret11 <- poisson.exact(sum(samples1),K1)
ret21 <- poisson.exact(sum(samples2),K1)
```


```
## K1 =  100 , lambdaP 1st reader =  1 , lambdaP 2nd reader =  2
```

```
## obs. mean, reader 1 =  1.01
```

```
## obs. mean, reader 2 =  2.02
```

```
## Rdr. 1: 95% CI =  0.8226616 1.227242
```

```
## Rdr. 2: 95% CI =  1.751026 2.318599
```


For reader 1 the estimate of the Poisson parameter (the mean parameter of the Poisson distribution is frequently referred to as the Poisson parameter) is 1.01 with 95% confidence interval (0.823, 1.227); for reader 2 the corresponding estimates are 2.02 and (1.751, 2.319). As the number of cases increases, the confidence interval shrinks. For example, with 10000 cases, i.e., 100 times the value in the previous example:





```
## K1 =  10000 , lambdaP 1st reader =  1 , lambdaP 2nd reader =  2
```

```
## obs. mean, reader 1 =  1.0055
```

```
## obs. mean, reader 2 =  2.006
```

```
## Rdr. 1: 95% CI =  0.9859414 1.025349
```

```
## Rdr. 2: 95% CI =  1.978335 2.033955
```

This time for reader 1, the estimate of the Poisson parameter is 1.01 with 95% confidence interval (0.986, 1.025); for reader 2 the corresponding estimate is 2.01 with 95% confidence interval (1.978, 2.034). The width of the confidence interval is inversely proportional to the square root of the number of cases (the example below is for reader 1):



```r
ret11$conf.int[2] - ret11$conf.int[1]
```

```
## [1] 0.40458
```

```r
ret12$conf.int[2] - ret12$conf.int[1]
```

```
## [1] 0.03940756
```

Since the number of cases was increased by a factor of 100, the width decreased by a factor of 10, the square-root of the ratio of the numbers of cases.

### The $\nu'$ parameter {#rsm-summary-nu-parameter}
The $\nu'$ parameter determines the ability of the observer to find lesions. Assuming the same number of lesions per diseased case, the mean fraction of latent LLs per diseased case is an estimate of $\nu'$. ^[It too can be measured via eye-tracking apparatus performed on a radiologist. An eye-tracking based estimate would be the total number of latent LLs in the dataset divided by the total number of lesions.] Consider two observers, one with  $\nu' = 0.5$ and the other with $\nu' = 0.9$. Again, while one cannot predict the precise number of latent LLs on any specific diseased case, or which specific lesions will be correctly localized, one can predict the average number of latent LLs per diseased case. 

The following code also uses $K_2 = 100$ samples, the number of diseased cases, each with one lesion. 


```r
K2 <- 100
L <- 1
nuP1 <- 0.5;nuP2 <- 0.9;
seed <- 1;set.seed(seed);samples1 <- rbinom(K2,L,nuP1)
seed <- 1;set.seed(seed);samples2 <- rbinom(K2,L,nuP2)

ret1 <- binom.exact(sum(samples1),K2*L)
ret2 <- binom.exact(sum(samples2),K2*L)
```



```
## K2 =  100 , nuP 1st reader =  0.5 , nuP 2nd reader =  0.9
```

```
## mean, reader 1 =  0.48
```

```
## mean, reader 2 =  0.94
```

```
## Rdr. 1: 95% CI =  0.3790055 0.5822102
```

```
## Rdr. 2: 95% CI =  0.8739701 0.9776651
```

The result shows that for reader 1 the estimate of the binomial success rate parameter is 0.48 with 95% confidence interval (0.38, 0.58). For reader 2 the corresponding estimates are 0.94 and (0.87, 0.98). As the number of diseased cases increases, the confidence interval shrinks in inverse proportion to the square root of cases. 

As a more complicated but clinically realistic example, consider a dataset with 100 cases in all where 97 have one lesion per case, two have two lesions per case and one has three lesions per case (these are typical lesion distributions observed in screening mammography). The code follows:



```r
K2 <- c(97,2,1);Lk <- c(1,2,3);nuP1 <- 0.5;nuP2 <- 0.9;
samples1 <- array(dim = c(sum(K2),length(K2)))
seed <- 1;set.seed(seed)
for (l in 1:length(K2)) {
  samples1[1:K2[l],l] <- rbinom(K2[l],Lk[l],nuP1)
}

samples2 <- array(dim = c(sum(K2),length(K2)))
seed <- 1;set.seed(seed)
for (l in 1:length(K2)) {
  samples2[1:K2[l],l] <- rbinom(K2[l],Lk[l],nuP2)
}

ret1 <- binom.exact(sum(samples1[!is.na(samples1)]),sum(K2*Lk))
ret2 <- binom.exact(sum(samples2[!is.na(samples2)]),sum(K2*Lk))
```


```
## K2[1] = 97 , K2[2] = 2 , K2[3] = 1 , nuP1 = 0.5 , nuP2 = 0.9
```

```
## obsvd. mean, reader 1 =  0.4903846
```

```
## obsvd. mean, reader 2 =  0.9326923
```

```
## Rdr. 1: 95% CI =  0.3910217 0.5903092
```

```
## Rdr. 2: 95% CI =  0.8662286 0.9725125
```


For reader 1, the estimate of the binomial success probability is 0.490 with 95% confidence interval (0.391, 0.590); for reader 2 the corresponding estimates are 0.933 and (0.866, 0.973). 


## Model re-parameterization {#rsm-re-parameterization}
While the parameters $\mu$, $\lambda'$ and $\nu'$ are physically meaningful a little thought reveals that they cannot be varied independently of each other. Rather, $\mu$ is the *intrinsic* parameter whose value, together with two other intrinsic parameters $\lambda$ and $\nu$, determine $\lambda'$ and $\nu'$, respectively. The following is a convenient re-parameterization ^[The need for the first re-parameterization, involving $\nu'$, was foreseen in the original search model papers [@chakraborty2006search; @chakraborty2006roc] but the need for the second re-parameterization (involving $\lambda'$) was discovered more recently.]:


\begin{equation}
\left. 
\begin{aligned}
\nu' =& 1 - exp\left ( - \mu \nu \right ) \\
\lambda' =& \frac{\lambda}{\mu}
\end{aligned}
\right \}
(\#eq:rsm-transform)
\end{equation}


The inverse transformations are:


\begin{equation}
\left. 
\begin{aligned}
\nu =& - \frac{\ln \left ( 1-\nu' \right )}{\mu}\\
\lambda =& \mu \lambda' 
\end{aligned}
\right \}
(\#eq:rsm-inv-transform)
\end{equation}


The parameter limits are as follows: $0 \le \nu' \le 1$, $\lambda' \ge 0$, $\mu \ge 0$, $\lambda \ge 0$ and $\nu \ge 0$.  

Since it determines $\nu'$, the $\nu$ parameter can be considered as the intrinsic (i.e., $\mu$-independent) ability to find lesions; specifically, it is the rate of increase of $\nu'$  with $\mu$ at small $\mu$:


\begin{equation} 
\nu = \left (\frac{\partial \nu'}{\partial \mu}  \right )_{\mu = 0}
(\#eq:rsm-nup-limit)
\end{equation}


The colloquial term *find* is used as shorthand for *flagged for further inspection by the holistic 1st stage of the search mechanism, thus qualifying as a latent site*. In other words, *finding* a lesion means the lesion was perceived as a suspicious region, which makes it a latent site, independent of whether or not the region was actually marked. Finding refers to the search stage. Marking refers to the decision stage, where the region's z-sample is determined and compared to a marking threshold.

According to Eqn. \@ref(eq:rsm-transform), as $\mu \rightarrow \infty$, $\nu' \rightarrow 1$ and conversely, as $\mu \rightarrow 0$, $\nu' \rightarrow 0$. The dependence of $\nu'$ on $\mu$ is consistent with the fact that higher contrast lesions are easier to find. An observer without special expertise may find a high contrast lesion. Conversely, lower contrast lesions will be more difficult to find even by expert observers. 

The analogy to finding the sun \@ref(froc-paradigm-solar-analogy) is instructive: objects with very high perceptual SNR are certain to be found.

According to Eqn. \@ref(eq:rsm-transform) the value of $\mu$ also determines $\lambda'$: as $\mu \rightarrow \infty$, $\lambda' \rightarrow 0$, and conversely, as $\mu \rightarrow 0$, $\lambda' \rightarrow \infty$. Here too the sun analogy is instructive. Since the sun has very high contrast, there is no reason for the observer to searcch for other suspicious regions which have no possibility of resembling the sun. On the other hand, attempting to locate a faint star, possibly hidden by clouds, can generate latent NLs, because the expected small SNR from the faint real star could be comparable to that from a number of regions in the near background.

The re-parameterization used here is not unique, but is simple and has the right limiting behaviors.

## Discussion / Summary {#rsm-discussion-summary}
This chapter has described a statistical parameterization of the Nodine-Kundel model. The 3-parameter model of search in the context in the medical imaging accommodates key aspects of the process: search, the ability to find lesions while minimizing finding non-lesions, is described by two parameters, specifically, $\lambda'$ and $\nu'$ . The ability to correctly mark a found lesion (while not marking found non-lesions) is characterized by the third parameter of the model, $\mu$. While the primed parameters have relatively simple physical meaning, they depend on $\mu$. Consequently, it is necessary to define them in terms of intrinsic parameters. 

The next chapter explores the predictions of the radiological search model.

## References {#rsm-references}
1.	Chakraborty DP. Computer analysis of mammography phantom images (CAMPI): An application to the measurement of microcalcification image quality of directly acquired digital images. Medical Physics. 1997;24(8):1269-1277.
2.	Chakraborty DP, Eckert MP. Quantitative versus subjective evaluation of mammography accreditation phantom images. Medical Physics. 1995;22(2):133-143.
3.	Chakraborty DP, Yoon H-J, Mello-Thoms C. Application of threshold-bias independent analysis to eye-tracking and FROC data. Academic Radiology. 2012;In press.
4.	Chakraborty DP. ROC Curves predicted by a model of visual search. Phys Med Biol. 2006;51:3463–3482.
5.	Chakraborty DP. A search model and figure of merit for observer data acquired according to the free-response paradigm. Phys Med Biol. 2006;51:3449–3462.

