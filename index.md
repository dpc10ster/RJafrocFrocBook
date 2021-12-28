--- 
title: "The RJafroc Froc Book"
author: "Dev P. Chakraborty, PhD"
date: "2021-12-28"
site: bookdown::bookdown_site
output: 
   bookdown::pdf_document: default
documentclass: book
bibliography: [packages.bib, myRefs.bib]
biblio-style: apalike
link-citations: yes
github-repo: dpc10ster/RJafrocFrocBook
description: "Artificial intelligence and observer performance book based on RJafroc."
---





# Preface {-}

* It is intended as an online update to my print book [@chakraborty2017observer]. 
* Since its publication in 2017 the `RJafroc` package, on which the `R` code examples in the book depend, has evolved considerably, causing many of the examples to "break". 
* This also gives me the opportunity to improve on the book and include additional material.
* The online book is in 3 parts.
* This part is devoted to the FROC paradigm.



## TBA How much finished {-}

* HMF approximately 30%
* This book is currently (as of December 2021) in preparation. 
* Parts labeled TBA and TODOLAST need to be updated on final revision.
* Un-comment links like `\@ref(froc-paradigm-solar-analogy)` etc. Search for `\@ref



## The pdf file of the book {-}

Go [here](https://github.com/dpc10ster/RJafrocFrocBook/blob/gh-pages/RJafrocFrocBook.pdf) and then click on `Download` to get the `RJafrocFrocBook.pdf` file.


## The html version of the book {-}
Go [here](https://dpc10ster.github.io/RJafrocFrocBook/) to view the `html` version of the book.


## A note on the online distribution mechanism of the book {-}
* In the hard-copy version of my book [@chakraborty2017observer] the online distribution mechanism was `BitBucket`. 
* `BitBucket` allows code sharing within a _closed_ group of a few users (e.g., myself and a grad student). 
* Since the purpose of open-source code is to encourage collaborations, this was, in hindsight, an unfortunate choice. Moreover, as my experience with R-packages grew, it became apparent that the vast majority of R-packages are shared on `GitHub`, not `BitBucket`. 
* For these reasons I have switched to `GitHub`. All previous instructions pertaining to `BitBucket` are obsolete.
* In order to access `GitHub` material one needs to create a (free) `GitHub` account. 
* Go to [this link](https://github.com) and click on `Sign Up`.


## Structure of the book {-}
The book is divided into parts as follows:

* Part I: Quick Start: intended for existing Windows `JAFROC` users who are seeking a quick-and-easy transition from Windows `JAFROC` to `RJafroc`. 
* Part II: ROC paradigm: this covers the basics of the ROC paradigm 
* Part III: Significance Testing: The general procedure used to determine the significance level, and associated statistics, of the observed difference in figure of merit between pairs of treatments or readers
* Part IV: FROC paradigm: TBA


## Contributing to this book {-}

I appreciate constructive feedback on this document. To do this raise an `Issue` on the `GitHub` [interface](https://github.com/dpc10ster/RJafrocFrocBook). Click on the `Issues` tab under `dpc10ster/RJafrocFrocBook`, then click on `New issue`. When done this way, contributions from users automatically become part of the `GitHub` documentation/history of the book.



## Is this book relevant to you and what are the alternatives? {-}

* Diagnostic imaging system evaluation
* Detection
* Detection combined with localization
* Detection combined with localization and classification
* Optimization of Artificial Intelligence (AI) algorithms
* CV
* Alternatives




## Chapters needing heavy edits {-}

* 12-froc.
* 13-empirical.
* 13-empirical-examples.


## Shelved vs. removed vs. parked folders needing heavy edits {-}

* replace functions with \text{}; eg. erf and exp in all of document
* Also for TPF, FPF etc.
* Temporarily shelved 17c-rsm-evidence.Rmd in removed folder
* Now 17-b is breaking; possibly related to changes in RJafroc: had to do with recent changes to RJafroc code - RSM_xFROC etc requiring intrinsic parameters; fixed 17-b
* parked has dependence of ROC/FROC performance on threshold


## Coding aids (for me) {-}

* weird error with knitr not responding to changes in Rmd file: traced to upper case lower case confusion: 13A-empirical1.Rmd which should be 13a-empirical1.Rmd

### formatting
* sprintf("%.4f", proper formatting of numbers
* OpPtStr(, do:

### tables

* https://github.com/haozhu233/kableExtra/issues/624
* kbl(dfA, caption = "....", booktabs = TRUE, escape = FALSE) %>% collapse_rows(columns = c(1, 3), valign = "middle") %>% kable_styling(latex_options = c("basic", "scale_down", "HOLD_position"), row_label_position = "c") 
* ```{r, attr.source = ".numberLines"}
* kbl(x12, caption = "Summary of optimization results using wAFROC-AUC.", booktabs = TRUE, escape = FALSE) %>% collapse_rows(columns = c(1), valign = "middle") %>% kable_styling(latex_options = c("basic", "scale_down", "HOLD_position"), row_label_position = "c") 
* $\text{exp} \left ( -\lambda' \right )$ space before dollar sign generates a pdf error 
* FP errors generated by GitHub actions due to undefined labels:
Error: Error: pandoc version 1.12.3 or higher is required and was not found (see the help page ?rmarkdown::pandoc_available).
In addition: Warning message:
In verify_rstudio_version() :
Please install or upgrade Pandoc to at least version 1.17.2; or if you are using RStudio, you can just install RStudio 1.0+.
Execution halted

### tinytex problems

* dont update in response to messages; breaks everything
* DONT DO THIS: When tinytex::install_tinytex() hangs up try
* DONT DO THIS: tinytex::install_tinytex(repository = "http://mirrors.tuna.tsinghua.edu.cn/CTAN/", version = "latest")
* Getting very long builds: looping certain commands
* First uninstall tinytex then reinstall:

```r
#uninstall_tinytex(force = FALSE, dir = tinytex_root())
#tinytex::install_tinytex()
```
* get very long build first time with looping certain commands
* fixed on subsequent pdf builds
