WriteJAFROC <- function( filename, NL, LL, Nk, Wk ) 
  
{
  if (length(dim(NL)) != 4) stop("Err")
   
  I <- length( NL[ , 1, 1, 1 ] )
  J <- length( NL[ 1, , 1, 1 ] )
  K <- length( NL[ 1, 1, , 1 ] )
  K2 <- length( LL[ 1, 1, , 1 ] )
  K1 <- K - K2
  MAX_NL <- length( NL[ 1, 1, 1, ] )
  MAX_LL <- length( LL[ 1, 1, 1, ] )
  
  Truth_Table <- array( 0, 0 )
  
  len <- 1
  for( k1 in 1 : K1 ) {
    elem <- array( 0, 3 )
    elem[ 1 ] <- k1
    Truth_Table <- array( c( Truth_Table, elem ), c( 3, len ) )
    len <- len + 1
  }
  
  for( k2 in 1 : K2 ) {
    if (Nk[ k2 ] > 0) {
      for( el in 1 : Nk[ k2 ] ) {
        elem <- array( 0, 3 )
        elem[ 1 ] <- k2 + K1 #case ID
        elem[ 2 ] <- el              #lesion ID
        elem[ 3 ] <- Wk[k2, el] # weight
        Truth_Table <- array( c( Truth_Table, elem ), c( 3, len ) )
        len <- len + 1
      }
    }
  }
  
  Truth_Table <- data.frame("CaseID" = Truth_Table[1,], "LesionID" = Truth_Table[2,], "Weights" = Truth_Table[3,])
  write.xlsx(Truth_Table, file = filename, sheetName = "Truth", col.names = TRUE, row.names = FALSE, showNA=FALSE )
  
  FP_Table <- array( 0, 0 )
  len <- 1
  for (i in 1:I) {
    for (j in 1:J) {          
      for( k in 1 : K ) {
        for( el in 1 : MAX_NL ) {
          if( !(is.na(NL[ i, j, k, el ]) || (NL[ i, j, k, el ] == UNINITIALIZED)))  {
            elem <- array( 0, 4 )
            elem[ 1 ] <- j
            elem[ 2 ] <- i
            elem[ 3 ] <- k
            elem[ 4 ] <- signif(NL[ i , j, k, el ])
            FP_Table <- array( c( FP_Table, elem ), c( 4, len ) )
            len <- len + 1
          }
        }
      }
    }
  }
  
  FP_Table <- data.frame("ReaderID" = FP_Table[1,], "ModalityID" = FP_Table[2,], "CaseID" = as.numeric(FP_Table[3,]), 
                         "FP_Rating" = as.numeric(FP_Table[4,]))  
  write.xlsx( FP_Table, file = filename, sheetName = "FP", col.names = TRUE, row.names = FALSE , append = TRUE, showNA=FALSE)
  
  TP_Table <- array( 0, 0 )
  len <- 1
  for (i in 1:I) { 
    for (j in 1:J) {      
      for( k2 in 1 : K2 ) {
        for( el in 1 : MAX_LL ) {
          if( !(is.na(LL[ i , j, k2, el ]) || (LL[ i, j, k2, el ] == UNINITIALIZED)) ) {
            elem <- array( 0, 5 )
            elem[ 1 ] <- j
            elem[ 2 ] <- i
            elem[ 3 ] <- k2 + K1
            elem[ 4 ] <- el
            elem[ 5 ] <- signif(LL[ i , j, k2, el ])
            TP_Table <- array( c( TP_Table, elem ), c( 5, len ) )
            len <- len + 1
          }
        }
      }
    }
  }
  
  TP_Table <- data.frame("ReaderID" = TP_Table[1,], "ModalityID" = TP_Table[2,], "CaseID" = as.numeric(TP_Table[3,]), 
                         "LesionID" = as.numeric(TP_Table[4,]), "TP_Rating" = as.numeric(TP_Table[5,]))  
  write.xlsx( TP_Table, file = filename, sheetName = "TP", col.names = TRUE, row.names = FALSE , append = TRUE, showNA=FALSE)
}