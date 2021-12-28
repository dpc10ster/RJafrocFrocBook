# (PART\*) DATASETS {-}


# Datasets {#datasets}





## Datasets {#datasets-datasets}

The datasets are embedded in the `RJafroc` package. They can be viewed in the help file of the package, a partial screen-shot of which is shown next. 


<div class="figure" style="text-align: center">
<img src="images/compare-3-fits/datasets.png" alt="Partial screen shot of `RJafroc` help file showing the datasets included with the current distribution (v2.0.1)."  />
<p class="caption">(\#fig:datasets-datasets)Partial screen shot of `RJafroc` help file showing the datasets included with the current distribution (v2.0.1).</p>
</div>


The datasets are identified in the code by dataset`dd` (where `dd` is an integer in the range `01` to `14`) as follows:

* `dataset01` "TONY" FROC dataset [@RN2125]


```
## List of 3
##  $ NL   : num [1:2, 1:5, 1:185, 1:3] 3 -Inf 3 -Inf 4 ...
##  $ LL   : num [1:2, 1:5, 1:89, 1:2] 4 4 3 -Inf 3.5 ...
##  $ LL_IL: logi NA
```


* `dataset02` "VAN-DYKE" Van Dyke ROC dataset [@RN1993]


```
## List of 3
##  $ NL   : num [1:2, 1:5, 1:114, 1] 1 3 2 3 2 2 1 2 3 2 ...
##  $ LL   : num [1:2, 1:5, 1:45, 1] 5 5 5 5 5 5 5 5 5 5 ...
##  $ LL_IL: logi NA
```


* `dataset03` "FRANKEN" Franken ROC dataset [@RN1995]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:100, 1] 3 3 4 3 3 3 4 1 1 3 ...
##  $ LL   : num [1:2, 1:4, 1:67, 1] 5 5 4 4 5 4 4 5 2 2 ...
##  $ LL_IL: logi NA
```


* `dataset04` "FEDERICA" Federica Zanca FROC dataset [@zanca2009evaluation]


```
## List of 3
##  $ NL   : num [1:5, 1:4, 1:200, 1:7] -Inf -Inf 1 -Inf -Inf ...
##  $ LL   : num [1:5, 1:4, 1:100, 1:3] 4 5 4 5 4 3 5 4 4 3 ...
##  $ LL_IL: logi NA
```


* `dataset05` "THOMPSON" John Thompson FROC dataset [@RN2368]


```
## List of 3
##  $ NL   : num [1:2, 1:9, 1:92, 1:7] 4 5 -Inf -Inf 8 ...
##  $ LL   : num [1:2, 1:9, 1:47, 1:3] 5 9 -Inf 10 8 ...
##  $ LL_IL: logi NA
```



* `dataset06` "MAGNUS" Magnus Bath FROC dataset [@RN1929]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:89, 1:17] 1 -Inf -Inf -Inf 1 ...
##  $ LL   : num [1:2, 1:4, 1:42, 1:15] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset07` "LUCY-WARREN" Lucy Warren FROC dataset [@RN2507]


```
## List of 3
##  $ NL   : num [1:5, 1:7, 1:162, 1:4] 1 2 1 2 -Inf ...
##  $ LL   : num [1:5, 1:7, 1:81, 1:3] 2 -Inf 2 -Inf 1 ...
##  $ LL_IL: logi NA
```


* `dataset08` "PENEDO" Monica Penedo FROC dataset [@RN1520]


```
## List of 3
##  $ NL   : num [1:5, 1:5, 1:112, 1] 3 2 3 2 3 0 0 4 0 2 ...
##  $ LL   : num [1:5, 1:5, 1:64, 1] 3 2 4 3 3 3 3 4 4 3 ...
##  $ LL_IL: logi NA
```


* `dataset09` "NICO-CAD-ROC" Nico Karssemeijer ROC dataset [@hupse2013standalone]


```
## List of 3
##  $ NL   : num [1, 1:10, 1:200, 1] 28 0 14 0 16 0 31 0 0 0 ...
##  $ LL   : num [1, 1:10, 1:80, 1] 29 12 13 10 41 67 61 51 67 0 ...
##  $ LL_IL: logi NA
```


* `dataset10` "RUSCHIN" Mark Ruschin ROC dataset [@RN1646]


```
## List of 3
##  $ NL   : num [1:3, 1:8, 1:90, 1] 1 0 0 0 0 0 1 0 0 0 ...
##  $ LL   : num [1:3, 1:8, 1:40, 1] 2 1 1 2 0 0 0 0 0 3 ...
##  $ LL_IL: logi NA
```


* `dataset11` "DOBBINS-1" Dobbins I FROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:158, 1:4] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL   : num [1:4, 1:5, 1:115, 1:20] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset12`  "DOBBINS-2" Dobbins II ROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:152, 1] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL   : num [1:4, 1:5, 1:88, 1] 3 4 4 -Inf -Inf ...
##  $ LL_IL: logi NA
```



* `dataset13` "DOBBINS-3" Dobbins III FROC dataset [@Dobbins2016MultiInstitutional]


```
## List of 3
##  $ NL   : num [1:4, 1:5, 1:158, 1:4] -Inf 3 -Inf 4 5 ...
##  $ LL   : num [1:4, 1:5, 1:106, 1:15] -Inf -Inf -Inf -Inf -Inf ...
##  $ LL_IL: logi NA
```


* `dataset14` "FEDERICA-REAL-ROC" Federica Zanca *real* ROC dataset [@RN2318]


```
## List of 3
##  $ NL   : num [1:2, 1:4, 1:200, 1] 2 2 2 2 1 3 2 2 3 1 ...
##  $ LL   : num [1:2, 1:4, 1:100, 1] 6 5 6 4 5 5 5 5 5 4 ...
##  $ LL_IL: logi NA
```



## References {#datasets-references}


