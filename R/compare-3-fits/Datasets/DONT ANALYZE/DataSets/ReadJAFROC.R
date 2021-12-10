ReadJAFROC <- function( filename) 
  
{
  wb     <- loadWorkbook(filename)
  sheets <- getSheets(wb)
  sheetNames <- toupper(names(sheets))
  
  TruthFileIndex <- which(!is.na(match(sheetNames, "TRUTH")))
  Truth_Table <-  readColumns(sheets[[TruthFileIndex]], startColumn=1, endColumn = 3, startRow=1, endRow=NULL)
  CaseID <- Truth_Table[[1]]# all 3 have same lenghts
  LesionID <- Truth_Table[[2]]
  Weights <- Truth_Table[[3]]
  
  NLFileIndex <- which(!is.na(match(sheetNames, "FP")))
  NL_Table   <- readColumns(sheets[[NLFileIndex]], startColumn=1, endColumn = 4, startRow=1, endRow=NULL)
  
  #NL_Table   <- read.xlsx(filename, 2, "FP", colIndex=c(1,2,3,4,5))
  NL_Reader_ID <- NL_Table[[1]]
  NL_Modality_ID <- as.character(NL_Table[[2]])
  NL_Case_ID <- NL_Table[[3]]
  NL_Rating <- NL_Table[[4]]
  
  LLFileIndex <- which(!is.na(match(sheetNames, "TP")))
  LL_Table   <- readColumns(sheets[[LLFileIndex]], startColumn=1, endColumn = 5, startRow=1, endRow=NULL)
  LL_Reader_ID <- LL_Table[[1]]
  LL_Modality_ID <- as.character(LL_Table[[2]])
  LL_Case_ID <- LL_Table[[3]]
  LL_Lesion_ID <- LL_Table[[4]]
  LL_Rating <- LL_Table[[5]]
  
  NormalCases <- unique(CaseID[LesionID == 0])
  AbnormalCases <- unique(CaseID[LesionID > 0])
  AllCases <- c(NormalCases, AbnormalCases)
  K1 <- length(NormalCases)
  K2 <- length(AbnormalCases)
  K <- (K1 + K2)
  
  Nk <- array(0, dim = length(AbnormalCases))
  for (k2 in 1:length(AbnormalCases)) {
    for (k in 1:length(CaseID)) {
      if (CaseID[k] != AbnormalCases[k2]) next
      if (LesionID[k] > 0) Nk[k2] <- Nk[k2] + 1
    }
  }
  
  Wk <- array(dim = c(length(AbnormalCases), max(max(Nk),2)))
  Lk <- array(dim = c(length(AbnormalCases), max(max(Nk),2)))
  for (k2 in 1:length(AbnormalCases)) {
    for (k in 1:length(CaseID)) {
      if (CaseID[k] != AbnormalCases[k2]) next      
      if (Weights[k] == 0) {
        Wk[k2,1:Nk[k2]] <- 1 / Nk[k2]
        Lk[k2,1:Nk[k2]] <- 1:Nk[k2]
      } else {
        for (el in 1:Nk[k2]) {
          if ((k + el -1) > length(Weights)) break
          Wk[k2,el] <- Weights[ k + el -1 ]
          Lk[k2,el] <- LesionID[ k + el -1 ]
        }
        break # done with this abnormal image; move on to prevent overwriting
      }
    }
  }
  
  ModalityIDs <- sort(unique(c(NL_Modality_ID, LL_Modality_ID)))  
  I <- length(unique(ModalityIDs))  
  
  ReaderIDs <- sort(unique(c(NL_Reader_ID, LL_Reader_ID)))
  J <- length(unique(ReaderIDs))
  
  NL <- array(dim=c(I,J,K,MAX_MARKS))  
  max_nNL <- 2
  for (k1 in 1:length(AllCases)) { 
    el <- array(1,c(I,J))
    for (k in 1:length(NL_Case_ID)) { 
      if (NL_Case_ID[k] != AllCases[k1]) next
      i <- which (ModalityIDs == NL_Modality_ID[k])  
      j <- which (ReaderIDs == NL_Reader_ID[k] )   
      if (el[i,j] > max_nNL) max_nNL <- el[i,j]
      NL[i,j,k1,el[i,j]] <- NL_Rating[ k ]
      el[i,j] <- el[i,j] + 1
      if (el[i,j] >= MAX_MARKS) stop("1") 
    }
  } 
  NL <- NL[,,,1:max_nNL]
  
  LL <- array(dim=c(I,J,K2,max(max(Nk),2))) 
  for (k2 in 1:length(AbnormalCases)) { 
    for (k in 1:length(LL_Case_ID)) { 
      if (LL_Case_ID[k] != AbnormalCases[k2]) next
      i <- which (ModalityIDs == LL_Modality_ID[k])  
      j <-  which (ReaderIDs == LL_Reader_ID[k]) 
      if (LL_Lesion_ID[k] %in% Lk[k2,]) {
        if (is.na(LL[i,j,k2,LL_Lesion_ID[k]])) LL[i,j,k2,LL_Lesion_ID[k]]<- LL_Rating[ k ] else {
          stop("2")
        }
      } else stop("3")
    }
  }
  
  Wk[is.na(Wk)] <- 0
  Lk[is.na(Lk)] <- 0
  NL[is.na(NL)] <- UNINITIALIZED
  LL[is.na(LL)] <- UNINITIALIZED
  
  return( list(
    Nk = Nk,
    NL = NL,
    LL = LL,
    Wk = Wk,
    ModalityIDs = ModalityIDs
  ) 
  )
  
}