# ROC curve implications of the RSM {#rsm-pred}





## TBA How much finished {#rsm-pred-how-much-finished}
90%



## TBA Introduction {#rsm-pred-intro}

The preceding chapter described the radiological search model (RSM) for FROC data. This chapter describes predictions of the RSM. 
The starting point is a general characteristic of all RSM prediced operating characteristics, namely they have the constrained end-point property. Derived next is the predicted *inferred ROC* curve followed by the predicted FROC and AFROC curves. 

Shown next is how *search performance* and *lesion-classification* performance can be measured from the inferred ROC curve. Search performance is the ability to find lesions while avoiding finding non-lesions, and lesion-classification performance is the ability, having found a suspicious region, to correctly classify it. Lesion-classification is different from (case) classification performance, i.e., distinguishing between diseased and non-diseased cases, which is measured by the area AUC under the ROC curve. 

TBA Based on the ROC/FROC/AFROC curve predictions of the RSM, a comparison is presented between area measures that can be calculated from FROC data, leading to an important and perhaps surprising conclusion, *the FROC curve is a poor descriptor of search performance and that the AFROC/wAFROC curves are preferred*. Most applications of FROC methods, particularly in CAD, have relied on the FROC curve to measure performance.

In this chapter formulae for RSM quantities are given in terms of the physical search parameters $\lambda'$ and $\nu'$. The formulae can be transformed to intrinsic RSM parameters $\lambda$ and $\nu$ using Eqn. \@ref(eq:rsm-inv-transform). 

## Inferred ROC ratings {#rsm-pred-inferred-roc}

Consider a $R_{\text{FROC}} \geq 1$ rating FROC study with allowed ratings $r = 1, 2, ..., R_{\text{FROC}}$. To be clearer one precedes the rating with the applicable paradigm: e.g., the ratings of marks range from FROC:1 to FROC:$R_{\text{FROC}}$. **The inferred-ROC z-sample (continuous rating) of a case is defined as the z-sample of the highest rated mark on the case or $-\infty$ if the case has no marks.** The inferred-ROC rating ROC:1 is reserved for cases with no marks. Since the ratings are ordered labels no ordering information is lost provided every other ROC rating is also "bumped up" by unity. The ROC ratings scale therefore extends from $1$ to $R_{\text{FROC}} + 1$. Thus, a $R_{\text{FROC}}$ rating FROC study corresponds to a $R_{\text{FROC}} + 1$ rating ROC study. The symbol $h_{k_t t}$ is used to denote the rating of the highest rated z-sample on case $k_t t$ with truth state $t$. Thus $h_{k_1 1}$ refers to the highest rating on a non-diseased case $k_1 1$ and $h_{k_2 2}$ refers to the highest rating on diseased case $k_2 2$. For non-diseased cases, the maximum is over all latent NLs on the case. For diseased cases, the maximum is over all latent NLs *and* latent LLs on the case. Define the set of ordered thresholds $\zeta_r < \zeta_{r+1}$ and dummy thresholds $\zeta_0 = -\infty,  \zeta_{R_{\text{FROC}}+1} = \infty$. Then, if $\zeta_r \leq h_{k_t t} < \zeta_{r+1}$, where $r = 1, 2, ..., R_{\text{FROC}}$, the case is rated ROC:$(r+1)$ and if $h_{k_t t} < \zeta_{1}$ the case is rated ROC:1. The lowest possible ROC rating on a case with at least one mark is ROC:2. A case with no latent sites *or* if the highest rated latent site satisfies $h_{k_t t} < \zeta_{1}$ is rated ROC:1. Note that one cannot distinguish between whether the ROC:1 rating was the result of the case not having any latent sites or the case had at least one latent site, but none of the z-samples exceeded $\zeta_{1}$.


## End-point of the ROC {#rsm-pred-end-point}

A consequence of the possibility that some cases have no marks is that the ROC curve has the *constrained end-point property*, namely the full range of ROC space, i.e., $0 \leq \text{FPF} \leq 1$ and $0 \leq \text{TPF} \leq 1$, is not continuously accessible to the observer. In fact, $0 \leq \text{FPF} \leq \text{FPF}_{max}$ and $0 \leq \text{TPF} \leq \text{TPF}_{max}$ where $\text{FPF}_{max}$ and $\text{TPF}_{max}$ are generally less than unity.   

Starting from a finite value as $\zeta_1$ is lowered to $-\infty$ some of the previously ROC:1 rated cases that had at least one latent site but whose z-sample did not exceed $\zeta_1$ will now generate marks and therefore the case will be "bumped-up" to the ROC:2 bin, until eventually *only cases with no latent sites* remain in the ROC:1 bin - these cases will never be rated ROC:2. An observer who finds no suspicious regions, literally nothing to report, will assign the lowest available bin to the case, which happens to be ROC:1. The finite number of cases in the ROC:1 bin at infinitely low threshold has the consequence that the uppermost non-trivial continuously accessible operating point – that obtained by cumulating ratings ROC:2 and above - is below-left of (1,1). The (1,1) point is "trivially" reached when one cumulates the counts in all bins, i.e., ROC:1 and above. This behavior is distinct from traditional ROC models where the entire curve, extending from (0, 0) to (1, 1), is continuously accessible to the observer. This is because in conventional ROC models every case yields a finite decision variable, no matter how small. Lowering the lowest threshold to $-\infty$ eventually moves all cases in the previously ROC:1 bin to the ROC:2 bin, and one is eventually left with zero counts in the ROC:1 bin and the operating point, obtained by cumulating bins ROC:2 and above, is (1,1). 

As another way of describing this unusual behavior, as the observer is encouraged to be more "aggressive in reporting lesions", the ROC point moves continuously upwards and to the right from (0, 0) to the end-point, $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$, and no further. The ROC curve cannot just “hang there” since cumulating all cases always yields the (1,1) operating point. **Therefore, the complete ROC curve is obtained by extending the end-point using a dashed line that connects it to (1,1).** The observer cannot operate along the dashed line. In the language of "moving up the ROC curve" there is a discontinuous jump from the end-point to (1,1). At the end-point the shape of the ROC curve changes from concave-down to a dashed straight line. It can be shown TBA that the limiting slope of the continuous ROC at the end-point is equal to the slope of the dashed straight line connecting the end-point to (1,1). 
 
How closely the operating point approaches the limiting point $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$ is unrelated to the number of bins; rather, it depends on $\zeta_1$. As the latter is lowered the observed end-point approaches $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$ from below-left. As will be shown below, how closely $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$ approaches (1,1) depends on the $\lambda'$ and $\nu'$ RSM parameters: namely, as $\lambda'$ and $\nu'$ increase, $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$  approaches (1,1) from below-left. 


### The abscissa of the ROC end-point {#rsm-pred-constrained-end-point-abscissa}

Consider the probability that a non-diseased case has at least one latent NL. Such a case will generate a finite value of $h_{k_1 1}$ and with an appropriately low $\zeta_1$ it will be rated ROC:2 or higher. The probability of *zero* latent NLs, see Eqn. \@ref(eq:rsm-poisson-pmf), is:  

$$\text{pmf}_{Poi} \left (0,\lambda' \right ) = \text{exp} \left ( -\lambda' \right )$$.

Therefore the probability that the case has *at least one* latent NL is the complement of the above probability. At sufficiently low $\zeta_1$ each of these cases yields a FP. Therefore, the maximum continuously accessible abscissa of the ROC, i.e., $\text{FPF}_{max}$, is: 

\begin{equation} 
\text{FPF}_{max} = 1 - \text{exp} \left ( -\lambda' \right )
(\#eq:rsm-pred-fpf-max)
\end{equation}



### The ordinate of the ROC end-point {#rsm-pred-constrained-end-point-ordinate}
A diseased case has no marks, even for very low $\zeta_1$, if it has zero latent NLs, the probability of which is $\text{exp}(-\lambda')$, and it has zero latent LLs, the probability of which is, see Eqn. \@ref(eq:rsm-binomial-pmf), $\text{pmf}_{Bin} \left ( 0, L, \nu' \right )= (1 - \nu')^L$. 

Here $L$ is the number of lesions in each diseased case, assumed constant. 

* Assumption 1: occurrences of latent LLs are independent of each other, i.e., the probability that a lesion is found is independent of whether other lesions are found on the same case. 

* Assumption 2: occurrences of latent NLs are independent of each other; i.e., the probability of a NL is independent of whether other NLs are found on the same case.

* Assumption 3: occurrence of a latent NL is independent of the occurrence of a latent LL on the same case.

By these assumptions the probability of zero latent NLs *and* zero latent LLs on a diseased case is the product of the two probabilities, namely 

$$\text{exp}(-\lambda') (1 - \nu')^L$$. 

Therefore, the probability that there exists *at least one* latent site is the complement of the above expression, which equals $\text{TPF}_{max}$, i.e., 

\begin{equation}
\text{TPF}_{max} \left ( \mu, \lambda', \nu', L \right ) = 1 - \text{exp} \left ( - \lambda' \right ) \left ( 1 - \nu' \right )^L
(\#eq:rsm-pred-tpf-max)
\end{equation}



### Variable number of lesions per case {#rsm-pred-end-point-variable-number-lesions}
Defining $f_L$  the fraction of diseased cases with $L$ lesions and $L_{max}$ the maximum number of lesions per diseased case in the dataset, then:

\begin{equation}
\sum_{L=1}^{{L_{max}}}  f_L = 1
(\#eq:rsm-pred-fl-sum)
\end{equation}


By restricting attention to the set of diseased cases with $L$ lesions each, Eqn. \@ref(eq:rsm-pred-tpf-max) for $\text{TPF}_{max}$ applies. Since TPF is a probability and probabilities of independent processes add it follows that:

\begin{equation}
\text{TPF}_{max} \left ( \mu, \lambda', \nu', \overrightarrow{f_L} \right ) = \sum_{L=1}^{L{max}}  f_L \text{TPF}_{max} \left ( \mu, \lambda', \nu', L \right )
(\#eq:rsm-pred-tpf-max-fl1)
\end{equation}


In other words the ordinate of the end-point is a weighted summation of $\text{TPF}_{max} \left ( \mu, \lambda', \nu', L \right )$ over the lesion distribution vector $\overrightarrow{f_L}$. 

The expression for $\text{FPF}_{max}$ is unaffected.


## ROC curve {#rsm-pred-roc-curve}

On the continuous ROC curve each case has at least one mark and therefore the inferred ROC decision variable is the rating of the highest rated mark $h_{k_t t}$ on the case. Therefore, FPF is the probability that $h_{k_t t}$ on a non-diseased case exceeds $\zeta$ and TPF is the probability that $h_{k_t t}$ on a diseased case exceeds $\zeta$:
		
\begin{equation}
\left. 
\begin{aligned}
\text{FPF}\left (\zeta  \right ) =& P\left ( h_{k_1 1} \geq \zeta \right )\\
\text{TPF}\left (\zeta  \right ) =& P\left ( h_{k_2 2} \geq \zeta \right )
\end{aligned}
\right \}
(\#eq:rsm-pred-tpf-fpf-zeta)
\end{equation}


Varying the threshold parameter $\zeta$ from $\infty$ to $-\infty$ sweeps out the continuous section of the predicted ROC curve from (0,0) to $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$. 


### Derivation of FPF {#rsm-pred-roc-curve-fpf}

* Assumption 4: the z-samples of NLs on the same case are independent of each other.

Consider the set of non-diseased cases with $n$ latent NLs each, where $n > 0$. According to \@ref(rsm-assumptions) each latent NL yields a z sample from $N(0,1)$. The probability that a z-sample from a latent NL is smaller than $\zeta$ is $\Phi(\zeta)$. By the independence assumption the probability that all $n$ samples are smaller than $\zeta$ is $(\Phi(\zeta))^n$. If all z-samples are smaller than $\zeta$, then the highest z-sample $h_{k_1 1}$  must be smaller than $\zeta$. Therefore, the probability that $h_{k_1 1}$ exceeds $\zeta$ is: 

\begin{equation}
\left. 
\begin{aligned}
\text{FPF}\left (\zeta \mid n \right ) =& P\left ( h_{k_1 1} \geq  \zeta \mid n\right ) \\
=& 1 - \left [ \Phi\left ( \zeta \right )  \right ]^n
\end{aligned}
\right \}
(\#eq:rsm-pred-fpf-zeta-n)
\end{equation}


The conditioning notation in Eqn. \@ref(eq:rsm-pred-fpf-zeta-n) reflects the fact that this expression applies specifically to non-diseased cases with $n$ latent NLs each. To obtain $\text{FPF}_{max}$ one performs a Poisson-weighted summation of $\text{FPF}\left (\zeta \mid n \right )$ over $n$ from 0 to $\infty$ (the inclusion of the $n = 0$ term is explained below):    

\begin{equation}
\text{FPF}\left (\zeta, \lambda' \right ) = \sum_{n=0}^{\infty} \text{pmf}_{Poi} \left ( n, \lambda' \right )\text{FPF}\left (\zeta \mid n \right )
(\#eq:rsm-pred-fpf-zeta-before-maple)
\end{equation}


The infinite summations, see below, are easier performed using symbolic algebra software such as $\text{Maple}^{TM}$. Inclusion in the summation of $n = 0$, which term evaluates to zero, is done to make it easier for Maple to evaluate the summation in closed form. Otherwise one may need to simplify the Maple-generated result. The `Maple` code is shown below (Maple 17, Waterloo Maple Inc.), where `lambda` and `nu` refer to the primed quantities. 

```
# Maple Code
restart;
phi := proc (t, mu) exp(-(1/2)*(t-mu)^2)/sqrt(2*Pi) end: 
PHI := proc (c, mu) local t; int(phi(t, mu), t = -infinity .. c) end: 
Poisson := proc (n, lambda) lambda^n*exp(-lambda)/factorial(n) end: 
Bin := proc (l, L, nu) binomial(L, l)*nu^l*(1-nu)^(L-l) end:
FPF := proc(zeta,lambda) sum(Poisson(n,lambda)*(1 - PHI(zeta,0)^n), n=0..infinity);end:
FPF(zeta, lambda);   
```

The above code yields:

\begin{equation}
\text{FPF}\left (\zeta , \lambda'\right ) = 1 - \text{exp}\left ( -\frac{\lambda'}{2} \left [ 1-\text{erf}\left ( \frac{\zeta}{\sqrt{2}} \right ) \right ]  \right ) 
(\#eq:rsm-pred-fpf-erf)
\end{equation}


The error function in Eqn. \@ref(eq:rsm-pred-fpf-erf) is related to the unit normal CDF function $\Phi(x)$ by:


\begin{equation}
\text{erf} \left (x \right ) =  2\Phi \left ( \sqrt{2} x\right ) - 1
(\#eq:rsm-pred-erf-phi-relation)
\end{equation}


Using this transformation yields the following simpler expression for FPF:


\begin{equation}
\text{FPF}\left (\zeta , \lambda'\right ) = 1 - \text{exp}\left ( -\lambda' \Phi\left ( -\zeta \right )  \right ) 
(\#eq:rsm-pred-fpf)
\end{equation}


The software implementation follows:


```r
# lambdaP is the physical lambda' parameter
FPF <- function (zeta, lambdaP) {
  x = 1 - exp(-lambdaP * pnorm(-zeta))
  return(x)
}
```



Because $\Phi$ ranges from 0 to 1, $\text{FPF}\left (\zeta , \lambda'\right )$ ranges from 0 to $\text{exp} \left ( -\lambda' \right )$.



### Derivation of TPF {#rsm-pred-roc-curve-tpf}
The derivation of the true positive fraction $\text{TPF}(\zeta)$ follows a similar line of reasoning except this time one needs to consider the highest of the latent NLs and latent LL z-samples. Consider a diseased case with L lesions, $n$ latent NLs and $l$ latent LLs. Each latent NL yields a decision variable sample from $N(0,1)$ and each latent LL yields a sample from $N(\mu,1)$. The probability that all $n$  latent NLs have z-samples less than $\zeta$ is $[\Phi(\zeta)]^n$. The probability that all $l$ latent LLs have z-samples less than  $\zeta$ is $[\Phi(\zeta - \mu)]^l$. Using the independence assumptions, the probability that all latent marks have z-samples less than $\zeta$ is the product of these two probabilities. The probability that $h_{k_2 2}$  (the highest z-sample on diseased case $k_2 2$) is larger than $\zeta$  is the complement of the product probabilities, i.e.,

$$\text{TPF}_{n,l}\left ( \zeta, \mu, n, l, L \right ) = P\left ( h_{k_2 2} \geq \zeta \mid \mu, n, l, L \right ) = 1 - \left [ \Phi\left ( \zeta \right ) \right ]^n \left [ \Phi\left ( \zeta - \mu\right ) \right ]^l$$

One averages over the distributions of $n$ and $l$ to obtain the desired ROC-ordinate:

\begin{equation}
\left.
\begin{aligned}
& \text{TPF}\left ( \zeta, \mu, \lambda', \nu' \right ) \times \\
&= \sum_{n=0}^{\infty} \text{pmf}_{Poi}(n,\lambda') \times \\
& \sum_{l=0}^{L} \text{pmf}_{Bin}(l,\nu',L) \text{TPF}_{n,l}\left ( \zeta, \mu, n, l \right )
\end{aligned}
\right \}
(\#eq:rsm-pred-tpf-varyl)
\end{equation}


This can be evaluated using Maple yielding: 



\begin{equation}
\left.
\begin{aligned}
& \text{TPF}\left (\zeta , \mu, \lambda', \nu', L \right ) \\
&= 1 - \text{exp}\left ( - \lambda' \Phi \left ( - \zeta \right )\right )
\left ( 1 - \nu' \Phi \left ( \mu - \zeta \right ) \right )^L
\end{aligned}
\right \}
(\#eq:rsm-pred-tpf-l)
\end{equation}





### Variable number of lesions per case {#rsm-pred-tpf-varying-lesions}
To extend the results to varying numbers of lesions per diseased case, one averages the right hand side of \@ref(eq:rsm-pred-tpf-l) over the fraction of diseased cases with $L$ lesions:


\begin{equation}
\left.
\begin{aligned}
& \text{TPF}\left (\zeta , \mu, \lambda', \nu', \overrightarrow{f_L} \right ) =  \\
& 1 - \text{exp}\left ( -\lambda' \Phi \left ( -\zeta \right )\right ) 
\sum_{L=1}^{L_{max}} f_L  \left ( 1 - \nu' \Phi \left ( \mu -\zeta \right ) \right )^L 
\end{aligned}
\right \}
(\#eq:rsm-pred-tpf)
\end{equation}

The expression for FPF, Eqn. \@ref(eq:rsm-pred-fpf), is unaffected.


The software implementation follows:




```r
# lambdaP is the physical lambda' parameter
# nuP is the physical nu' parameter
# lesDistr is the lesion distributin vector f_L
TPF <- function (zeta, mu, lambdaP, nuP, lesDistr){
  Lmax <- length(lesDistr)
  x <- 1
  for (L in 1:Lmax ) {
    x <- x - exp(-lambdaP * pnorm(-zeta)) * lesDistr[L] * (1 - nuP * pnorm(mu - zeta))^L
  }
  return(x)
}
```



## Proper ROC curve {#rsm-pred-roc-curve-proper}

A proper ROC curve has the property that it never crosses the chance diagonal and its slope never increases as the operating point moves up the ROC curve [@metz1999proper; @macmillan2004detection]. *It is shown next that the RSM predicted ROC curve, including the dashed straight line extension, is proper* ^[The statement in the physical book that the proper property only applies to the continuous section is incorrect.]. We considered first the continuous section which is below-left of the end-point. In \@ref(rsm-pred-appendix1) a proof is presented that the slope is continuous at the end-point transition from a continuous curve to the dashed straight line. In \@ref(rsm-pred-appendix2) the slope near the end-point is examined numerically to resolve an apparent paradox, namely the ROC plot can appear discontinuous at the end-point when in fact no discontinuity exists. 


For convenience one abbreviates FPF and TPF to $x$ and $y$, respectively, and suppresses the dependence on model parameters. From Eqn. \@ref(eq:rsm-pred-fpf) and Eqn. \@ref(eq:rsm-pred-tpf) one can express the ROC coordinates as: 

\begin{equation}
\left. 
\begin{aligned}
x\left ( \zeta \right ) =& 1 - G\left ( \zeta \right )\\
y\left ( \zeta \right ) =& 1 - F\left ( \zeta \right ) G\left ( \zeta \right ) 
\end{aligned}
\right \}
(\#eq:rsm-pred-f-g)
\end{equation}

where:

\begin{equation}
\left. 
\begin{aligned}
G\left ( \zeta \right ) =& \text{exp}\left ( -\lambda' \Phi \left ( -\zeta \right )\right )\\
F\left ( \zeta \right ) =& \sum_{L=1}^{L_{max}} f_L  \left ( 1 - \nu' \Phi \left ( \mu -\zeta \right ) \right )^L 
\end{aligned}
\right \}
(\#eq:rsm-pred-fg-defs)
\end{equation}


These equations have exactly the same structure as [@swensson1996unified] Eqns. 1 and 2 and the logic used there to demonstrate that ROC curves predicted by Swensson's LROC model was proper also applies to the present situation. Specifically, since the $\Phi$ function ranges between 0 and 1 and $0 \leq \nu' \leq 1$, it follows that $F\left ( \zeta \right ) \leq 1$. Therefore $y\left ( \zeta \right ) \geq x\left ( \zeta \right )$ and the ROC curve is constrained to the upper half of the ROC space, namely the portion above the chance diagonal. Additionally, the more general constraint shown by Swensson applies, namely the slope of the ROC curve at any operating point (x, y) cannot be less than the slope of the dashed straight line connecting (x, y) and $\left (\text{FPF}_{max}, \text{TPF}_{max} \right )$, the coordinates of the RSM end-point. This implies that the slope decreases monotonically and also rules out curves with "hooks". 



## ROC decision variable pdfs {#rsm-pred-roc-curve-pdfs}

In \@ref(binormal-model-pdf-curves-appendix-1) the pdf functions were derived for non-diseased and diseased cases for the unequal variance binormal ROC model. The procedure was to take the derivative of the appropriate cumulative distribution function (CDF) with respect to $\zeta$. An identical procedure is used for the RSM. 

The CDF for non-diseased cases is the complement of FPF. The pdf for non-diseased cases is given by:	

\begin{equation}
\text{pdf}_N\left ( \zeta \right ) = \frac{\partial }{\partial \zeta} \left ( 1-\text{FPF}\left (\zeta , \lambda'\right ) \right ) 
(\#eq:rsm-pred-pdf-n)
\end{equation}


Similarly, for diseased cases,

\begin{equation}
\text{pdf}_D\left ( \zeta \right ) = \frac{\partial }{\partial \zeta} \left ( 1-\text{TPF}\left (\zeta , \mu, \lambda', \nu', \overrightarrow{f_L} \right ) \right ) 
(\#eq:rsm-pred-pdf-d)
\end{equation}


Both expressions can be evaluated using Maple. The pdfs are implemented in the `RJafroc` function `PlotRsmOperatingCharacteristics()`. 

The integrals of the pdfs (non-diseased followed by diseased) over the entire allowed range are given by (note the vertical bar notation, meaning the difference of two limiting values):

\begin{equation}
\left. 
\begin{aligned}
\int_{-\infty}^{\infty}\text{pdf}_N \left ( \zeta \right )d \zeta =& \left ( 1-\text{FPF}\left (\zeta , \lambda'\right ) \right ) \bigg \rvert_{-\infty}^{\infty}\\
=& \text{FPF}_{max}
\end{aligned}
\right \}
(\#eq:rsm-pred-int-pdf-n)
\end{equation}



\begin{equation}
\left. 
\begin{aligned}
\int_{-\infty}^{\infty}\text{pdf}_D \left ( \zeta \right )d \zeta =& \left ( 1-\text{TPF}\left (\zeta , \mu, \lambda', \nu', \overrightarrow{f_L} \right ) \right ) \bigg \rvert_{-\infty}^{\infty}\\
=& \text{TPF}_{max}
\end{aligned}
\right \}
(\#eq:rsm-pred-int-pdf-d)
\end{equation}


In other words, they evaluate to the coordinates of the predicted end-point, *each of which is less than unity*. The reason is that the integration is along the *continuous* section of the ROC curve and does not include the contribution along the dashed straight line extension from $\left ( \text{FPF}_{max}, \text{TPF}_{max} \right )$ to (1,1). The latter contributions correspond to cases with no marks, i.e., $1 - \text{FPF}_{max}$ for non-diseased cases and $1 - \text{TPF}_{max}$ for diseased cases. Adding these contributions to the integrals along the continuous section yields unity for both types of cases. ^[The original RSM publications [@chakraborty2006search; @chakraborty2006roc] unnecessarily introduced Dirac delta functions to force the integrals to be unity. The explanation given here should clarify the issue.]


## ROC AUC {#rsm-pred-roc-curve-auc}
It is possible to numerically perform the integration under the RSM-ROC curve to get AUC:


\begin{equation}
AUC_{RSM}^{ROC}\left ( \mu, \lambda, \nu,  \zeta_1, \overrightarrow{f_L} \right ) = \sum_{L=0}^{L_{max}} f_L \int_{0}^{1} \text{TPF}\left (\zeta,  \mu, \lambda, \nu, L \right ) d\left ( \text{FPF}\left (\zeta, \lambda \right ) \right )
(\#eq:rsm-pred-auc)
\end{equation}


The superscript $ROC$ is needed to keep track of the operating characteristic that is being predicted (for RSM other possibilities are AFROC, wAFROC, FROC) and the subscript $RSM$ keeps track of the predictive model that is being used (for ROC models - binormal, CBM or PROPROC - the superscript is always ROC). 

The right hand side of Eqn. \@ref(eq:rsm-pred-auc) can be evaluated using a numerical integration function implemented in `R`, which is used in the `RJafroc` function `UtilAnalyticalAucsRSM()` whose help page follows: 


<div class="figure" style="text-align: center">
<img src="images/rsm-pred/util-analytical-aucs-rsm.png" alt="Help page for `RJafroc` function `UtilAnalyticalAucsRSM`."  />
<p class="caption">(\#fig:rsm-pred-help)Help page for `RJafroc` function `UtilAnalyticalAucsRSM`.</p>
</div>
 
The arguments to `UtilAnalyticalAucsRSM()` are the intrinsic RSM parameters $\mu$, $\lambda$, $\nu$ and $\zeta_1$. The default value of $\zeta_1$ is $\zeta_1 = -\infty$. The remaining arguments `lesDistr` and `relWeights` are not RSM parameters per se, rather they specify the lesion-richness of the diseased cases and the relative lesion weights (not needed for computing ROC AUC). The dimensions of `lesDistr` and `relWeights` are each equal to the maximum number of lesions per case $L_{max}$. In the following code $L_{max} = 3$ and `lesDistr <- c(0.5, 0.3, 0.2)`, meaning 50 percent of diseased cases have one lesion per case, 30 percent have two lesions and 20 percent have three lesions.  

The function returns a list containing the AUCs under the ROC and other operating characteristics.  


```r
mu <- 1; lambda <- 1; nu <- 1
lesDistr <- c(0.5, 0.3, 0.2) # implies L_max = 3
aucs <- UtilAnalyticalAucsRSM(mu = mu, 
                              lambda = lambda, 
                              nu = nu, 
                              lesDistr = lesDistr)
cat("mu = ", mu, 
", lambda = ", lambda, 
", nu = ", nu,  
", AUC ROC = ", aucs$aucROC, "\n")
```

```
## mu =  1 , lambda =  1 , nu =  1 , AUC ROC =  0.7802109
```


Experimenting with different parameter combinations reveals the following behavior for ROC AUC.

* AUC is an increasing functions of $\mu$. Increasing perceptual signal-to-noise-ratio leads to improved performance: for background on this important dependence see \@ref(froc-paradigm-solar-analogy). Increasing $\mu$ increases the separation between the two pdfs defining the ROC curve, which increases AUC. Furthermore, the number of NLs decreases because $\lambda' = \lambda / \mu$ decreases, which increases performance. Finally, $\nu'$ increases approaching unity, which leads to more LLs and increased performance. *Because all three effects reinforce each other, a change in $\mu$ results in a large effect on performance.* 

* AUC increases as $\lambda$ decreases. Decreasing $\lambda$ results in fewer NLs which results in increased performance. This is a relatively weak effect.
	
* AUC increases as $\nu$ increases. Increasing $\nu$ results in more LLs being marked, which increases performance. This is a relatively strong effect. 

* AUC decreases as $\zeta_1$ increases. This important effect is discussed in the next section. 

* ROC AUC increases with $L_{max}$. With more lesions per case, there is increased probability that that at least one of them will result in a LL, and the diseased case pdf moves to the right, both of which result in increased performance.

* ROC AUC increases as `lesDistr` is weighted towards more lesions per case. For example, `lesDistr <- c(0, 0, 1)` (all cases have 3 lesions per case) will yield higher performance than `lesDistr <- c(1, 0, 0)` (all cases have one lesion per case). 



## $\zeta_1$ dependence of ROC AUC {#rsm-pred-roc-curve-aucs-zeta1}

When it comes to predicted ROC AUC there is an important difference between conventional ROC models and the RSM. The former has no dependence on $\zeta_1$. This is because in the ROC model every case yields a rating, no matter how low the z-sample, implying that effectively $\zeta_1 = -\infty$. The lack of $\zeta_1$ dependence is demonstrated by the help page for function `UtilAucBinormal`, shown below, which depends on only two parameters, $a$ and $b$ (the two-parameter dependence is also true for other ROC models implemented in `RJafroc`, e.g., `UtilAucCBM` and `UtilAucPROPROC`). 


<div class="figure" style="text-align: center">
<img src="images/rsm-pred/util-aucs-binormal.png" alt="Help page for `RJafroc` function `UtilAucBinormal`."  />
<p class="caption">(\#fig:rsm-pred-binorml-help)Help page for `RJafroc` function `UtilAucBinormal`.</p>
</div>


In contrast, in addition to the basic RSM parameters, i.e., $\mu$, $\lambda$ and $\nu$, the rsm-pred have an additional dependence on $\zeta_1$. This is because the value of $\zeta_1$ determines the location of the end-point. The $\zeta_1$ dependence is demonstrated next for the ROC plots, but it is true for all RSM predictions.



<div class="figure" style="text-align: center">
<img src="images/rsm-pred/PlotRsmOperatingCharacteristics.png" alt="Help page for `RJafroc` function `PlotRsmOperatingCharacteristics`."  />
<p class="caption">(\#fig:rsm-pred-operating-characteristics-help)Help page for `RJafroc` function `PlotRsmOperatingCharacteristics`.</p>
</div>


The dependence is demonstrated next for two values: $zeta_1 = -10$ and $zeta_1 = 1$. The common parameter values are $\mu = 2$, $\lambda = 1$,  $\nu = 1$, as shown in the following code-chunk. 



```r
roc <- PlotRsmOperatingCharacteristics(
     mu = c(2,2),
     lambda = c(1,1),
     nu = c(1,1),
     zeta1 = c(-10, 1),
     lesDistr = c(0.5, 0.5),
     relWeights = c(0.5, 0.5),
     OpChType = "ROC",
     legendPosition = "null"
)
```


Clearly the red curve has higher AUC. The specific values are 0.9386603 for the red curve and 0.9031788 for the green curve.


<div class="figure">
<img src="17a-rsm-predictions_files/figure-html/rsm-pred-roc-zeta1-1.png" alt="ROC curves for two values of $\zeta_1$: both curves correspond to $\mu = 2$, $\nu = 1$ and $\lambda = 1$. The red curve corresponds to $\zeta_1 = -10$ and the blue curve to $\zeta_1 = 1$." width="672" />
<p class="caption">(\#fig:rsm-pred-roc-zeta1)ROC curves for two values of $\zeta_1$: both curves correspond to $\mu = 2$, $\nu = 1$ and $\lambda = 1$. The red curve corresponds to $\zeta_1 = -10$ and the blue curve to $\zeta_1 = 1$.</p>
</div>



A consequence of the $\zeta_1$ dependence is that if one uses ROC AUC as the measure of performance, the optimal threshold is $\zeta_1 = -\infty$. In particular, a CAD algorithm that generates FROC data should show all generated marks to the radiologist. This is not the strategy adopted by any CAD designer that I am aware of. I will address this issue, i.e., what is the optimal value of the reporting threshold, in Chapter \@ref(optim-op-point).



## Example ROC curves {#rsm-pred-roc-curves}





<div class="figure">
<img src="17a-rsm-predictions_files/figure-html/rsm-pred-fig-auc-mu-plots-1.png" alt="ROC curves for indicated values of the $\mu$ parameter. Notice the transition, as $\mu$ increases, from near chance level performance to almost perfect performancea as the end-point moves from near (1,1) to near (0,1)." width="672" />
<p class="caption">(\#fig:rsm-pred-fig-auc-mu-plots)ROC curves for indicated values of the $\mu$ parameter. Notice the transition, as $\mu$ increases, from near chance level performance to almost perfect performancea as the end-point moves from near (1,1) to near (0,1).</p>
</div>


Fig. \@ref(fig:rsm-pred-fig-auc-mu-plots) displays ROC curves for indicated values of $\mu$. The remaining RSM model parameters are $\lambda = 1$, $\nu = 1$ and $\zeta_1 = -\infty$ and there is one lesion per diseased case. 


The following are evident from these figures:

1. As $\mu$ increases the ROC curve more closely approaches the upper-left corner of the ROC plot. This signifies increasing performance and the area under the ROC and AFROC curves approach unity. The end-point abscissa decreases, meaning increasing numbers of unmarked non-diseased cases, i.e., more perfect decisions on non-diseased cases. The end-point ordinate increases, meaning decreasing numbers of unmarked lesions, i.e., more good decisions on diseased cases. 
2. For $\mu$ close to zero the operating characteristic approaches the chance diagonal and the area under the ROC curve approaches 0.5.
3. The area under the ROC increases monotonically from 0.5 to 1 as $\mu$ increases from zero to infinity.
4. For large $\mu$ the accessible portion of the operating characteristic approaches the vertical line connecting (0,0) to (0,1), the area under which is zero. The complete ROC curve is obtained by connecting this point to (1,1) by the dashed line and in this limit the area under the complete ROC curve approaches unity. Omitting the area under the dashed portion of the curve will result in a severe underestimate of true performance. 
5. As $L_{max}$ increases (allowed values are 1, 2, 3, etc.) the area under the ROC curve increases, approaching unity and  $\text{TPF}_{max}$ approaches unity. With more lesions per diseased case, the chances are higher that at least one of them will be found and marked. However, $\text{FPF}_{max}$ remains constant as determined by the constant value of $\lambda' = \frac{\lambda}{\mu}$, Eqn. \@ref(eq:rsm-pred-fpf-max)
6. As $\lambda$ decreases $\text{FPF}_{max}$ decreases to zero and $\text{TPF}_{max}$ decreases. The decrease in $\text{TPF}_{max}$  is consistent with the fact that, with fewer NLs, there is less chance of a NL being rated higher than a LL, and one is completely dependent on at least one lesion being found.
7. As $\nu$ increases $\text{FPF}_{max}$ stays constant at the value determined by $\lambda$  and  $\mu$, while $\text{TPF}_{max}$ approaches unity. The corresponding physical parameter $\nu'$ increases approaching unity, guaranteeing every lesion will be found. 


## Example RSM pdf curves {#rsm-pred-pdf-curves}






<div class="figure">
<img src="17a-rsm-predictions_files/figure-html/rsm-pred-fig-pdf-mu-plots-1.png" alt="RSM pdf curves for indicated values of the $\mu$ parameter. The solid curve corresponds to diseased cases and the dotted curve corresponds to non-diseased cases." width="672" />
<p class="caption">(\#fig:rsm-pred-fig-pdf-mu-plots)RSM pdf curves for indicated values of the $\mu$ parameter. The solid curve corresponds to diseased cases and the dotted curve corresponds to non-diseased cases.</p>
</div>


Fig. \@ref(fig:rsm-pred-fig-pdf-mu-plots) shows pdf plots for the same values of parameters as in Fig. \@ref(fig:rsm-pred-fig-auc-mu-plots). 

Consider the plot of the pdfs for $\mu = 1$. Since the integral of a pdf function over an interval amounts to counting the fraction of events occurring in the interval, it should be evident that the area under the non-diseased pdf equals $\text{FPF}_{max}$ and that under the diseased pdf equals $\text{TPF}_{max}$. For the chosen value $\lambda = 1$ one has $\text{FPF}_{max} = 1 - e^{-\lambda} = 0.632$. The area under the non-diseased pdf is less than unity because it is missing the contribution of non-diseased cases with no marks, the probability of which is $e^{-\lambda} = e^{-1} = 0.368$. Equivalently, it is missing the area under the dashed straight line segment of the ROC curve. Likewise, the area under the diseased pdf equals $\text{TPF}_{max}$, Eqn. \@ref(eq:rsm-pred-tpf-max), which is also less than unity. For the chosen values of $\mu = \lambda = \nu = L = 1$ it equals $\text{TPF}_{max} = 1 - e^{-\lambda} e^{-\nu} = 0.865$. This area is somewhat larger than that under the non-diseased pdf, as is evident from visual examination of the plot. A greater fraction of diseased cases generate marks than do non-diseased cases, consistent with the presence of lesions in diseased cases. The complement of 0.865 is due to diseased cases with no marks, which account for a fraction 0.135 of diseased cases. To summarize, the pdf's do not integrate to unity for the reason that the integrals account only for the continuous section of the ROC curve and do not include cases with zero latent marks that do not generate z-samples. The effect becomes more exaggerated for higher values of $\mu$ as this causes $\text{FPF}_{max}$ to further decrease. 

The plot in Fig. \@ref(fig:rsm-pred-fig-pdf-mu-plots) labeled $\mu = 0.05$ may be surprising. Since it corresponds to a small value of $\mu$, one may expect both pdfs to overlap and be centered at zero. Instead, while they do overlap, the shape is distinctly non-Gaussian and centered at approximately 1.8. This is because the small value of $\mu$ results in a large value of the $\lambda'$ parameter, since $\lambda' = \lambda / \mu = 20$. The highest of a large number of samples from the unit normal distribution is not normal and is peaked at a value above zero [@fisher1928limiting].



## TBA Discussion / Summary {#rsm-pred-discussion-summary}
This chapter has detailed ROC, FROC and AFROC curves predicted by the radiological search model (RSM). All RSM curves share the constrained end-point property that is qualitatively different from previous ROC models. In my experience, it is a property that most researchers in this field have difficulty accepting. There is too much history going back to the early 1940s, of the ROC curve extending from (0,0) to (1,1) that one has to let go of, and this can be difficult. 

I am not aware of any direct evidence that radiologists can move the operating point continuously in the range (0,0) to (1,1) in search tasks, so the existence of such an ROC is tantamount to an assumption. Algorithmic observers that do not involve the element of search can extend continuously to (1,1). An example of an algorithmic observer not involving search is a diagnostic test that rates the results of a laboratory measurement, e.g., the A1C measure of blood glucose  for presence of a disease. If A1C ≥ 6.5% the patient is diagnosed as diabetic. By moving the threshold from infinity to –infinity, and assuming a large population of patients, one can trace out the entire ROC curve from the origin to (1,1). This is because every patient yields an A1C value. Now imagine that some finite fraction of the test results are "lost in the mail"; then the ROC curve, calculated over all patients, would have the constrained end-point property, albeit due to an unreasonable cause.

The situation in medical imaging involving search tasks is qualitatively different. Not every case yields a decision variable. There is a reasonable cause for this – to render a decision variable sample the radiologist must find something suspicious to report, and if none is found, there is no decision variable to report. The ROC curve calculated over all patients would exhibit the constrained end-point property, even in the limit of an infinite number of patients. If calculated over only those patients that yielded at least one mark, the ROC curve would extend from (0,0) to (1,1) but then one would be ignoring the cases with no marks, which represent valuable information: unmarked non-diseased cases represent perfect decisions and unmarked diseased cases represent worst-case decisions.

ROC, FROC and AFROC curves were derived (wAFROC is implemented in the Rjafroc). These were used to demonstrate that the FROC is a poor descriptor of performance. Since almost all work to date, including some by me TBA 47,48, has used FROC curves to measure performance, this is going to be difficulty for some to accept. The examples in Fig. 17.6 (A- F) and Fig. 17.7 (A-B) should convince one that the FROC curve is indeed a poor measure of performance. The only situation where one can safely use the FROC curve is if the two modalities produce curves extending over the same NLF range. This can happen with two variants of a CAD algorithm, but rarely with radiologist observers.

A unique feature is that the RSM provides measures of search and lesion-classification performance. It bears repeating that search performance is the ability to find lesions while avoiding finding non-lesions. Search performance can be determined from the position of the ROC end-point (which in turn is determined by RSM-based fitting of ROC data, Chapter 19). The perpendicular distance between the end-point and the chance diagonal is, apart from a factor of 1.414, a measure of search performance. All ROC models that predict continuous curves extending to (1,1), imply zero search performance. 

Lesion-classification performance is measured by the AUC value corresponding to the   parameter. Lesion-classification performance is the ability to discriminate between LLs and NLs, not between diseased and non-diseased cases: the latter is measured by RSM-AUC. There is a close analogy between the two ways of measuring lesion-classification performance and CAD used to find lesions in screening mammography vs. CAD used in the diagnostic context to determine if a lesion found at screening is actually malignant. The former is termed CADe, for CAD detection, which in my opinion, is slightly misleading as at screening lesions are found not detected ("detection" is "discover or identify the presence or existence of something ", correct localization is not necessarily implied; the more precise term is "localize"). In the diagnostic context one has CADx, for CAD diagnostic, i.e., given a specific region of the image, is the region malignant? 

Search and lesion-classification performance can be used as "diagnostic aids" to optimize performance of a reader. For example, is search performance is low, then training using mainly non-diseased cases is called for, so the resident learns the different variants of non-diseased tissues that can appear to be true lesions. If lesion-classification performance is low then training with diseased cases only is called for, so the resident learns the distinguishing features characterizing true lesions from non-diseased tissues that fake true lesions.

Finally, evidence for the RSM is summarized. Its correspondence to the empirical Kundel-Nodine model of visual search that is grounded in eye-tracking measurements. It reduces in the limit of large  , which guarantees that every case will yield a decision variable sample, to the binormal model; the predicted pdfs in this limit are not strictly normal, but deviations from normality would require very large sample size to demonstrate. Examples were given where even with 1200 cases the binormal model provides statistically good fits, as judged by the chi-square goodness of fit statistic, Table 17.2. Since the binormal model has proven quite successful in describing a large body of data, it satisfying that the RSM can mimic it in the limit of large  . The RSM explains most empirical results regarding binormal model fits: the common finding that b < 1; that b decreases with increasing lesion pSNR (large   and / or  ); and the finding that the difference in means divided by the difference in standard deviations is fairly constant for a fixed experimental situation, Table 17.3. The RSM explains data degeneracy, especially for radiologists with high expertise.

The contaminated binormal model2-4 (CBM), Chapter 20, which models the diseased distribution as having two peaks, one at zero and the other at a constrained value, also explains the empirical observation that b-parameter < 1 and data degeneracy. Because it allows the ROC curve to go continuously to (1,1), CBM does not completely account for search performance – it accounts for search when it comes to finding lesions, but not for avoiding finding non-lesions.

I do not want to leave the impression that RSM is the ultimate model. The current model does not predict satisfaction of search (SOS) effects27-29. Attempts to incorporate SOS effects in the RSM are in the early research stage. As stated earlier, the RSM is a first-order model: a lot of interesting science remains to be uncovered.

### The Wagner review

The two RSM papers12,13 were honored by being included in a list of 25 papers the "Highlights of 2006" in Physics in Medicine and Biology. As stated by the publisher: "I am delighted to present a special collection of articles that highlight the very best research published in Physics in Medicine and Biology in 2006. Articles were selected for their presentation of outstanding new research, receipt of the highest praise from our international referees, and the highest number of downloads from the journal website.

One of the reviewers was the late Dr. Robert ("Bob") Wagner – he had an open-minded approach to imaging science that is lacking these days, and a unique writing style. I reproduces one of his comments with minor edits, as it pertains to the most interesting and misunderstood prediction of the RSM, namely its constrained end-point property.

I'm thinking here about the straight-line piece of the ROC curve from the max to (1, 1). 
1.	This can be thought of as resulting from two overlapping uniform distributions (thus guessing) far to the left in decision space (rather than delta functions). Please think some more about this point--because it might make better contact with the classical literature. 
2.	BTW -- it just occurs to me (based on the classical early ROC work of Swets & co.) -- that there is a test that can resolve the issue that I struggled with in my earlier remarks. The experimenter can try to force the reader to provide further data that will fill in the space above the max point. If the results are a dashed straight line, then the reader would just be guessing -- as implied by the present model. If the results are concave downward, then further information has been extracted from the data. This could require a great amount of data to sort out--but it's an interesting point (at least to me).


Dr. Wagner made two interesting points. With his passing, I have been deprived of the penetrating and incisive evaluation of his ongoing work, which I deeply miss. Here is my response (ca. 2006):

The need for delta functions at negative infinity can be seen from the following argument. Let us postulate two constrained width pdfs with the same shapes but different areas, centered at a common value far to the left in decision space, but not at negative infinity. These pdfs would also yield a straight-line portion to the ROC curve. However, they would be inconsistent with the search model assumption that some images yield no decision variable samples and therefore cannot be rated in bin ROC:2 or higher. Therefore, if the distributions are as postulated above then choice of a cutoff in the neighborhood of the overlap would result in some of these images being rated 2 or higher, contradicting the RSM assumption.  The delta function pdfs at negative infinity are seen to be a consequence of the search model. 

One could argue that when the observer sees nothing to report then he starts guessing and indeed this would enable the observer to move along the dashed portion of the curve. This argument implies that the observer knows when the threshold is at negative infinity, at which point the observer turns on the guessing mechanism (the observer who always guesses would move along the chance diagonal). In my judgment, this is unreasonable. The existence of two thresholds, one for moving along the non-guessing portion and one for switching to the guessing mode would require abandoning the concept of a single decision rule. To preserve this concept one needs the delta functions at negative infinity.

Regarding Dr. Wagner's second point, it would require a great amount of data to sort out whether forcing the observer to guess would fill in the dashed portion of the curve, but I doubt it is worth the effort. Given the bad consequences of guessing (incorrect recalls) I believe that in the clinical situation, the radiologist will not knowingly guess. If the radiologist sees nothing to report, nothing will be reported. In addition, I believe that forcing the observer, to prove some research point, is not a good idea. 












## Appendix 1: Proof of continuity of slope at the end-point{#rsm-pred-appendix1}

The following proof is adapted from a document supplied by Dr. Xuetong Zhai, then ( ca. 2017) a graduate student working under the supervision of the author.

The end point coordinates of the continuous part of ROC curve was derived above, Eqn. \@ref(eq:rsm-pred-fpf-max) for $\text{FPF}_{max}$ and Eqn. \@ref(eq:rsm-pred-tpf-max) for $\text{TPF}_{max}$. Therefore, the slope $m_{st}$ of the dashed dashed straight line is:

\begin{equation}
\left. 
\begin{aligned}
m_{st} =& \frac{1-\text{TPF}_{max}}{1-\text{FPF}_{max}}\\
=&\frac{\sum_{L=1}^{L_{max}} f_L \left ( 1 - \nu' \right )^L
 \text{exp} \left ( - \lambda' \right )} {\text{exp} \left ( - \lambda' \right )} \\
=& \sum_{L=1}^{L_{max}} f_L \left ( 1 - \nu' \right )^L  \\
\end{aligned}
\right \}
(\#eq:rsm-slope-st-line)
\end{equation}


On the continuous section, $g\equiv\text{FPF}$ and $h\equiv\text{TPF}$ are defined by \@ref(eq:rsm-pred-fpf) and \@ref(eq:rsm-pred-tpf), respectively. Therefore,


\begin{equation}
\left. 
\begin{aligned}
g =& 1-\text{exp} \left ( -\lambda' \Phi\left ( -\zeta \right ) \right ) \\
h =& 1-\sum_{L=1}^{L_{max}}f_L \text{exp} \left ( -\lambda' \Phi\left ( -\zeta \right ) \right ) \left ( 1-\nu'\Phi\left ( \mu - \zeta \right ) \right )^{L}
\end{aligned}
\right \}
(\#eq:rsm-pred-slope-eq3)
\end{equation}


Taking the differentials of these functions with respect to $\zeta$ it follows that the slope of the ROC is given by:


\begin{equation}
\left. 
\begin{aligned}
\frac{dh}{dg} =& \sum_{L=1}^{L_{max}}  f_L \left ( 1-\nu'\Phi\left ( \mu-\zeta \right ) \right )^{L-1}  \times \\
& \left [ \frac{L\nu'\phi\left ( \mu-\zeta \right )}{\lambda'\phi\left ( -\zeta \right )} + \left ( 1-\nu'\Phi \left ( \mu-\zeta \right )\right ) \right ]\\ 
\end{aligned}
\right \} 
(\#eq:rsm-pred-slope-eq4)
\end{equation}


Using the following result:


\begin{equation}
\left. 
\begin{aligned}
& \lim_{\zeta \rightarrow -\infty} \frac{\phi\left ( \mu-\zeta \right )}{\phi\left ( -\zeta \right )} \\ 
=&\lim_{\zeta \rightarrow -\infty} \frac{\frac{1}{\sqrt{2\pi}}\text{exp}\left ( \frac{\left (\mu-\zeta  \right )^2}{2} \right )}{\frac{1}{\sqrt{2\pi}}\text{exp}\left ( \frac{-\zeta^2}{2} \right )} \\
=& \lim_{\zeta \rightarrow -\infty} \text{exp}\left ( \frac{\mu\zeta-\mu^2}{2}  \right ) \\
=& 0
\end{aligned}
\right \} 
(\#eq:rsm-pred-slope-eq5)
\end{equation}

it follows that:


\begin{equation}
\left. 
\begin{aligned}
& \lim_{\zeta \rightarrow -\infty} \frac{dh}{dg} \\ 
=& \sum_{L=1}^{L_{max}} f_L \left ( 1-\nu' \right )^{L-1} \left ( 1-\nu' \right )\\
=& \sum_{L=1}^{L_{max}} f_L \left ( 1-\nu' \right )^{L} \\
=& m_{st}
\end{aligned}
\right \} 
(\#eq:rsm-pred-slope-eq6)
\end{equation}

This proves that the limiting slope of the continuous section of the ROC curve equals that of the dashed straight line connecting the end-point to (1,1).



## Appendix 2: Numerical illustration of continuity{#rsm-pred-appendix2}

The code in this section examines the slope of the ROC curve as one approaches the end-point $\zeta_1 = -\infty$. The RSM parameter values are $\mu = 0.5$, $\lambda = 0.1$ and $\nu = 0.8$, and twenty percent of the diseased cases have one lesion and 80 percent have 2 lesions, i.e. `lesDistr` -> c(0.2, 0.8). 



```r
mu <- 0.5
lambda <- 0.1
nu <- 0.8
lambdaP <- lambda / mu
nuP <- 1 - exp(-mu * nu)
lesDistr <- c(0.2, 0.8)
```


One calculates the coordinates of the end-point and the slope of the line connecting it to (1,1). 



```r
maxFPF <- FPF (-Inf, lambdaP)
maxTPF <- TPF (-Inf, mu, lambdaP, nuP, lesDistr)
mStLine <- (1 - maxTPF) / (1 - maxFPF)
```


The end-point coordinates are (0.1812692, 0.5959341) and the slope is 0.4935272. Next one calculates and displays the ROC curve. 



```r
ret <- PlotRsmOperatingCharacteristics(
  mu,
  lambda,
  nu,
  zeta1 = -Inf, # fixed: this function used to break for -Inf
  OpChType = "ROC",
  lesDistr = lesDistr
)
```



<div class="figure">
<img src="17a-rsm-predictions_files/figure-html/rsm-pred-roc-plot-1.png" alt="ROC curve for selected RSM parameters. The slope of the dashed line is 0.4935272. " width="672" />
<p class="caption">(\#fig:rsm-pred-roc-plot)ROC curve for selected RSM parameters. The slope of the dashed line is 0.4935272. </p>
</div>



At first sight the slope appeared to me to be discontinuous at the end-point ^[Others have stated a different visual impression.] but this is not true. In fact the slope decreases as one approaches the end-point, and in the limit equals that of the dashed line. This is demonstrated by the next code section which creates a finely-spaced $\zeta$ array ranging from -3 to -20. These are the points at which the slope is numerically calculated. Two types of calculations were performed - one using standard `R` double precision arithmetic and one using multiple precision arithmetic. The R-package `Rmpfr` was used for the latter. For example, the line `zeta_mpr -> mpfr(zeta, 2000)` generates a 2000-bit representation of $\zeta$. All subsequent computations using `zeta_mpr` uses multiple precision arithmetic. The computed slopes are saved in two arrays, `y1`, the standard precision arithmetic slope and `y2`, the multiple precision arithmetic slope.   




```r
zeta_arr <- c(seq(-3, -5, -0.2), seq(-5, -20, -0.5))
y1 <- array(0, length(zeta_arr))
y2 <- array(0, length(zeta_arr))
i <- 0
for (zeta in zeta_arr) {
  i <- i + 1
  # normal precision arithmetic
  zeta2 <- zeta + 1e-6
  delta_FPF <- FPF (zeta, lambdaP) - FPF (zeta2, lambdaP)
  delta_TPF <- TPF (zeta, mu, lambdaP, nuP, lesDistr) - 
    TPF (zeta2, mu, lambdaP, nuP, lesDistr)
  mAnal <- delta_TPF / delta_FPF
  y1[i] <- mAnal
  # end normal precision arithmetic
  
  # multiple precision arithmetic
  zeta_mpr <- mpfr(zeta, 2000) # 2000 digit precision
  zeta2_mpr <- zeta_mpr + 1e-12 # small increment
  delta_FPF <- FPF (zeta_mpr, lambdaP) - FPF (zeta2_mpr, lambdaP)
  delta_TPF <- TPF (zeta_mpr, mu, lambdaP, nuP, lesDistr) - 
    TPF (zeta2_mpr, mu, lambdaP, nuP, lesDistr)
  mAnalRmpfr <- delta_TPF / delta_FPF
  temp <- as.numeric(mAnalRmpfr)
  if (is.nan(temp)){
    y2[i] <- NA
  } else y2[i] <- temp 
  # end multiple precision arithmetic
}
```


The next code section displays 3 plots. 



```r
m1 <- data.frame(z = zeta_arr, m = y1)
m2 <- data.frame(z = zeta_arr, m = y2)
plots <- ggplot(
  mapping = aes(x = z, y = m)) + 
  geom_line(data = m1, linetype = "dashed", color = "blue") + 
  geom_line(data = m2) +
  ylim(0, 1) + xlim(-15, -3) + 
  geom_hline(yintercept = mStLine, color = "red",linetype = "dashed") + 
  xlab(label = "zeta") + ylab(label = "slopes")
suppressWarnings(print(plots))
```

<div class="figure">
<img src="17a-rsm-predictions_files/figure-html/rsm-pred-plots1-1.png" alt="Horizontal dashed red line: the value of `mStLine`, the slope of the straight line connecting the ROC end-point to (1,1). Dashed blue line: slope using double precision arithmetic. Solid black line: slope using multiple precision arithmetic - this curve approaches the limiting value `mStLine`." width="672" />
<p class="caption">(\#fig:rsm-pred-plots1)Horizontal dashed red line: the value of `mStLine`, the slope of the straight line connecting the ROC end-point to (1,1). Dashed blue line: slope using double precision arithmetic. Solid black line: slope using multiple precision arithmetic - this curve approaches the limiting value `mStLine`.</p>
</div>


The solid black line is the plot, using multiple precision arithmetic, of slope of the ROC curve vs. $\zeta$. The dashed blue line is the slope using standard precision arithmetic. The horizontal dashed red line is the slope of the straight line connecting the end-point to (1,1), i.e., 0.4935272. Standard precision arithmetic breaks down below $\zeta \approx -6$ rapidly falling to illegal values `Nan` (above $\zeta \approx -5$ there is little difference between standard and multiple precision). The multiple precision curve approaches the slope of the straight line as $\zeta$ approaches -20. This confirms numerically the continuity of the slope of the ROC at the end-point.  

## References {#rsm-pred-references}
1.	Chakraborty DP. Computer analysis of mammography phantom images (CAMPI): An application to the measurement of microcalcification image quality of directly acquired digital images. Medical Physics. 1997;24(8):1269-1277.
2.	Chakraborty DP, Eckert MP. Quantitative versus subjective evaluation of mammography accreditation phantom images. Medical Physics. 1995;22(2):133-143.
3.	Chakraborty DP, Yoon H-J, Mello-Thoms C. Application of threshold-bias independent analysis to eye-tracking and FROC data. Academic Radiology. 2012;In press.
4.	Chakraborty DP. ROC Curves predicted by a model of visual search. Phys Med Biol. 2006;51:3463–3482.
5.	Chakraborty DP. A search model and figure of merit for observer data acquired according to the free-response paradigm. Phys Med Biol. 2006;51:3449–3462.
