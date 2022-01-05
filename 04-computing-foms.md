# Computing FROC paradigm AUCs {#computing-aucs}

---
output:
  rmarkdown::pdf_document:
    fig_caption: yes        
    includes:  
      in_header: R/learn/my_header.tex
---





## TBA How much finished {#computing-aucs-how-much-finished}
50%



## TBA Introduction {#computing-aucs-intro}

Chapter `\@ref(empirical)` introduced several empirical operating characteristic plots from FROC data. Expressions were given for computing *operating points* for each such plot from z-samples. The areas or AUCs under these plots were also defined. 

Calculating areas from operating points using planimetry or geometry is tedious at best. This chapter defines formulae for calculating the AUCs directly from the z-samples or ratings. These expressions are analogous to computing the Wilcoxon statistic for ROC ratings data since it is known [@RN2174] that this statistic equals the AUC under the empirical ROC plot.

Here is the organization of the chapter.

-   Expressions for the empirical AFROC FOM-statistic $\text{A}_{AFROC}$ and the empirical weighted-AFROC FOM-statistic $\text{A}_{wAFROC}$ are presented and their limiting values for chance-level and perfect performances are explored.

-   Two theorems are stated, whose proofs are in [TBA Online Appendix 14.A].

-   TBA The first theorem proves the equality between the empirical wAFROC FOM-statistic $\text{A}_{wAFROC}$ and the area $\text{A}_{wAFROC}$ under the empirical wAFROC plot. [A similar equality applies to the empirical AFROC FOM-statistic $\text{A}_{wAFROC}$ and the area $\text{A}_{wAFROC}$ under the empirical AFROC plot.]

-   The second theorem derives an expression for the area under the straight-line extension of the wAFROC from the observed end-point to (1,1), and explains why it is essential to include this area.

-   A physical interpretation of the AUC or FOM-statistics is given. It shows explicitly how the ratings comparisons implied in FOM-statistic properly credit and penalize the observer for correct and incorrect decisions, respectively. The probabilistic meanings of the AFROC and wAFROC AUCs are given.

-   TBA Detailed derivations of FOM-statistics, applicable to the areas under the empirical FROC plot, the AFROC1 and wAFROC1 plots are not given. Instead, the results for all plots are summarized in [TBA Online Appendix 14.C], which shows that the definitions "work", i.e., the FOM-statistics yield the correct areas as determined by numerical integration of the relevant curves.

## Computing empirical AFROC AUC {#computing-aucs-afroc}

$\text{A}_{AFROC}$ is the area under the empirical AFROC. It can be computed from the z-samples as follows.


The highest rating $\text{FP}_{k_1 1}$ on non-diseased case $k_1 1$ was defined in Section \@ref(eq:empirical-FP). The function $\psi\left ( x,  y \right )$ was defined (see chapter TBA on empirical AUC in `RJafrocRocBook`) by:


\begin{equation}
\left.
\begin{aligned}
\psi(x,y)&=1  \qquad & x<y \\
\psi(x,y)&=0.5  & x=y \\
\psi(x,y)&=0  & x>y
\end{aligned}
\right \}
(\#eq:empirical-auc-psi)
\end{equation}


It can be shown that AUC $\text{A}_{AFROC}$ is given by:


\begin{equation}
\begin{aligned} 
\text{A}_{AFROC} =& \frac{1}{K_1 L_T}\sum_{k_1=1}^{K_1}\sum_{k_2=1}^{K_2}\sum_{l_2=1}^{L_{k_2}}\psi\left ( \text{FP}_{k_1 1}, z_{k_2 2 l_2 2} \right )\\
\end {aligned}
(\#eq:computing-aucs-theta-afroc)
\end{equation}




### Range of AFROC AUC statistic

The FOM-statistic $\text{A}_{AFROC}$ achieves its highest value, unity, if and only if every lesion is rated higher than any mark on non-diseased cases, for then the $\psi$ function always yields unity, and the summations yield unity. If, on the other hand, every lesion is rated lower than every mark on every non-diseased case, the $\psi$ function always yields zero, and the FOM-statistic is zero. Therefore, $0 \leq \text{A}_{AFROC} \leq 1$.
This shows that $\text{A}_{AFROC}$ behaves like a probability but its range is *twice* that of $\text{A}_{ROC}$; recall that $0.5 \leq \text{A}_{ROC} \leq 1$ (assuming the observer has equal or better than random performance and the observer does not have the direction of the rating scale accidentally reversed). This has the consequence that treatment related differences between $\text{A}_{AFROC}$ (i.e., effect sizes) are larger relative to the corresponding ROC effect sizes (just as temperature differences in the Fahrenheit scale are larger than the same differences expressed in the Celsius scale). This has important implications for FROC sample size estimation, Chapter TBA.


The range $0 \leq \text{A}_{AFROC} \leq 1$ is one reason why the "chance diagonal" of the AFROC, corresponding to $\text{A}_{AFROC} = 0.5$, does not reflect chance-level performance. $\text{A}_{AFROC} = 0.5$ is actually reasonable performance, being exactly in the middle of the allowed range. An example of this was given in TBA §13.4.2.2 for the case of an expert radiologist who does not mark any cases.

## Computing empirical wAFROC AUC {#computing-aucs-wafroc}

The empirical weighted-AFROC plot and lesion weights were defined in Section TBA `\@ref(empirical-wAFROC)`. The corresponding AUC can be computed [@RN1385] by including the lesion weights $W_{k_2 l_2}$ inside the summations (but outside the kernel function):

\begin{equation}
\begin{aligned} 
\text{A}_{\text{wAFROC}} =& \frac{1}{K_1 K_2}\sum_{k_1=1}^{K_1}\sum_{k_2=1}^{K_2}\sum_{l_2=1}^{L_{k_2}}W_{k_2 l_2}\psi\left ( \text{FP}_{k_1 1}, z_{k_2 2 l_2 2} \right )\\
\end {aligned}
(\#eq:computing-aucs-theta-wafroc)
\end{equation}


The weights obey the constraint:


\begin{equation} 
\sum_{l_2=1}^{L_{k_2}}W_{k_2 l_2} = 1
(\#eq:computing-aucs-theta-constraint-weights)
\end{equation}




## Discussion {#computing-aucs-Discussion}

TBA

The primary aim of this chapter was to develop expressions for AUCs as functions of ratings. Unlike the ROC, the AFROC and wAFROC figures of merit are represented by quasi-Wilcoxon like constructs, not the well-known Wilcoxon statistic.


## References {#computing-aucs-references}