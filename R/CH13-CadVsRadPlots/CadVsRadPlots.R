CadVsRadPlots <- function(muCad, muRad, lambda, nu, zeta1_1, zeta1_2, K1, K2, Lk2, seed) {
  
  # simulate CAD ratings
  frocCad <- SimulateFrocDataset(
    mu = muCad,
    lambda = lambda,
    nu = nu,
    I = 1,
    J = 1,
    K1 = K1,
    K2 = K2,
    perCase = Lk2,
    zeta1 = zeta1_1,
    seed = seed)
  #frocCad$descriptions$readerID <- "CAD"
  wafroc1 <- UtilFigureOfMerit(frocCad, FOM = "wAFROC")
  roc1 <- UtilFigureOfMerit(DfFroc2Roc(frocCad), FOM = "Wilcoxon")

  # simulate RAD ratings
  frocRad <- SimulateFrocDataset(
    mu = muRad,
    lambda = lambda,
    nu = nu,
    I = 1,
    J = 1,
    K1 = K1,
    K2 = K2,
    perCase = Lk2,
    zeta1 = zeta1_2,
    seed = seed)
  
  #frocRad$descriptions$readerID <- "RAD"
  wafroc2 <- UtilFigureOfMerit(frocRad, FOM = "wAFROC")
  roc2 <- UtilFigureOfMerit(DfFroc2Roc(frocRad), FOM = "Wilcoxon")

  # following code merges the two single 
  # modality single reader datasets into 
  # a single modality two reader dataset
  numNLCad <- dim(frocCad$ratings$NL)[4]
  numNLRad <- dim(frocRad$ratings$NL)[4]
  # the max number of NLs per case in the combined dataset
  numNL <- max(numNLCad, numNLRad)
  if (numNLCad < numNL){
    # dataset CAD has smaller number of NLs
    # add more -Inf NLs to CAD to make
    # the number of NL in two datasets consistent
    NL1 <- abind(
      frocCad$ratings$NL,
      array(-Inf, dim = c(1, 1, K1 + K2, numNL - numNLCad)))
    # combine the two NLs
    NLComb <- abind(
      NL1,
      frocRad$ratings$NL, along = 2)
  } else if (numNLRad < numNL){
    # dataset RAD has smaller number of NLs
    # add more -Inf NLs to RAD to make
    # the number of NL in two datasets consistent
    NL1 <- abind(
      frocRad$ratings$NL,
      array(-Inf, dim = c(1, 1, K1 + K2, numNL - numNLRad)))
    NLComb <- abind(
      frocCad$ratings$NL,
      NL1, along = 2)
  } else {
    # the number of NLs in the two datasets
    # are same, combine them directly
    NLComb <- abind(
      frocCad$ratings$NL,
      frocRad$ratings$NL,
      along = 2)
  }
  
  # combine the two LLs
  LLComb <- abind(
    frocCad$ratings$LL,
    frocRad$ratings$LL,
    along = 2)
  
  # convert the combined NLs
  # and LLs to an RJafroc dataset
  frocComb <- Df2RJafrocDataset(
    NL = NLComb,
    LL = LLComb,
    InputIsCountsTable = FALSE,
    perCase = Lk2)
  #frocComb$descriptions$readerID <- c("CAD", "RAD")
  
  froc <- PlotEmpiricalOperatingCharacteristics(
    frocComb,
    trts= 1,
    rdrs = c(1, 2),
    opChType = "FROC", maxDiscrete = 25)
  #froc$descriptions$readerID <- c("CAD1", "RAD1")
  
  wafroc <- PlotEmpiricalOperatingCharacteristics(
    frocComb,
    trts= 1,
    rdrs = c(1, 2),
    opChType = "wAFROC", maxDiscrete = 25)
  #wafroc$descriptions$readerID <- c("CAD1", "RAD1")
  
  roc <- PlotEmpiricalOperatingCharacteristics(
    frocComb,
    trts= 1,
    rdrs = c(1, 2),
    opChType = "ROC", maxDiscrete = 25)
  #roc$descriptions$readerID <- c("C2", "R3")
  
  return(list(froc = froc,
              wafroc = wafroc,
              roc = roc,
              wafroc1 = wafroc1,
              wafroc2 = wafroc2,
              roc1 = roc1,
              roc2 = roc2
  ))
  
}


# 2 FROC plots one with finite threshold and the other with -infinity threshold
ZetaEffectPlots <- function(mu, lambda, nu, zeta1, K1, K2, Lk2, seed, label) {
  
  # simulate ratings using zeta1
  froc_zeta1 <- SimulateFrocDataset(
    mu = mu,
    lambda = lambda,
    nu = nu,
    I = 1,
    J = 1,
    K1 = K1,
    K2 = K2,
    perCase = Lk2,
    zeta1 = zeta1,
    seed = seed)
  
  froc_zeta1$descriptions$readerID <- paste0(label,"zeta1")
  fom_zeta1 <- UtilFigureOfMerit(froc_zeta1, FOM = "wAFROC")
  
  # simulate ratings using -Inf
  froc_negInf <- SimulateFrocDataset(
    mu = mu,
    lambda = lambda,
    nu = nu,
    I = 1,
    J = 1,
    K1 = K1,
    K2 = K2,
    perCase = Lk2,
    zeta1 = -Inf,
    seed = seed)
  
  froc_negInf$descriptions$readerID <- paste0(label,"negInf")
  fom_negInf <- UtilFigureOfMerit(froc_negInf, FOM = "wAFROC")
  
  # following code merges the two single 
  # modality single reader datasets into 
  # a single modality two reader dataset
  numNLCad <- dim(froc_zeta1$ratings$NL)[4]
  numNLRad <- dim(froc_negInf$ratings$NL)[4]
  # the max number of NLs per case in the combined dataset
  numNL <- max(numNLCad, numNLRad)
  if (numNLCad < numNL){
    # dataset CAD has smaller number of NLs
    # add more -Inf NLs to CAD to make
    # the number of NL in two datasets consistent
    NL1 <- abind(
      froc_zeta1$ratings$NL,
      array(-Inf, dim = c(1, 1, K1 + K2, numNL - numNLCad)))
    # combine the two NLs
    NLComb <- abind(
      NL1,
      froc_negInf$ratings$NL, along = 2)
  } else if (numNLRad < numNL){
    # dataset RAD has smaller number of NLs
    # add more -Inf NLs to RAD to make
    # the number of NL in two datasets consistent
    NL1 <- abind(
      froc_negInf$ratings$NL,
      array(-Inf, dim = c(1, 1, K1 + K2, numNL - numNLRad)))
    NLComb <- abind(
      froc_zeta1$ratings$NL,
      NL1, along = 2)
  } else {
    # the number of NLs in the two datasets
    # are same, combine them directly
    NLComb <- abind(
      froc_zeta1$ratings$NL,
      froc_negInf$ratings$NL,
      along = 2)
  }
  
  # combine the two LLs
  LLComb <- abind(
    froc_zeta1$ratings$LL,
    froc_negInf$ratings$LL,
    along = 2)
  
  # convert the the combined NLs
  # and LLs to an RJafroc dataset
  frocComb <- Df2RJafrocDataset(
    NL = NLComb,
    LL = LLComb,
    InputIsCountsTable = FALSE,
    perCase = Lk2)
  frocComb$descriptions$readerID <- c(paste0(label, "zeta1"), paste0(label, "negInf"))
  
  froc <- PlotEmpiricalOperatingCharacteristics(
    frocComb,
    trts= 1,
    rdrs = c(1, 2),
    opChType = "FROC", maxDiscrete = 25)
  
  wafroc <- PlotEmpiricalOperatingCharacteristics(
    frocComb,
    trts= 1,
    rdrs = c(1, 2),
    opChType = "wAFROC", maxDiscrete = 25)
  
  return(list(froc = froc,
              wafroc = wafroc,
              fom_zeta1 = fom_zeta1,
              fom_negInf = fom_negInf))
  
}
