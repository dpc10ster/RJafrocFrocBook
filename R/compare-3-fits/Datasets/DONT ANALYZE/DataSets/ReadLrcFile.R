ReadLrcFile  <- function(filename)
{
  
  if (filename == "Franken1.lrc") WhiteSpace  <- "\t" else WhiteSpace  <- " " 
#   WhiteSpace  <- "\t"
  lines <- readLines(filename)
  CurrentLine <- 4#skip first four lines
  RatingsOrder  <- toupper(gsub(WhiteSpace,"", lines[4]))
  
  z1 <- array(dim = c(2,10,100))
  z2 <- array(dim = c(2,10,100))
  
  for (j in 1:10) {
    temp <- lines[CurrentLine]
    temp1  <- gsub(WhiteSpace,"", temp)
    if (temp1 == "#") break
    
    k <- 1
    while (1) {
      CurrentLine <- CurrentLine + 1
      temp <- lines[CurrentLine];temp1  <- gsub(WhiteSpace,"", temp);if (temp1 == "*") break
      z1[1:2,j,k] <- as.integer(unlist(strsplit(temp, WhiteSpace)))[1:2]
      k  <- k + 1
    }
    
    k <- 1
    while (1) {
      CurrentLine <- CurrentLine + 1
      temp <- lines[CurrentLine]
      temp <- lines[CurrentLine];temp1  <- gsub(WhiteSpace,"", temp);if (temp1 == "*") break
      z2[1:2,j,k] <- as.integer(unlist(strsplit(temp, WhiteSpace)))[1:2]
      k  <- k + 1
    }
    CurrentLine <- CurrentLine + 1 #skip the readers name
  }
  
  K1 <- length(z1[1,1,!is.na(z1[1,1,])])
  K2 <- length(z2[1,1,!is.na(z2[1,1,])])
  J <- length(z2[1,!is.na(z2[1,,1]),1])
  
  z1  <- z1[,1:J,1:K1];z2  <- z2[,1:J,1:K2]

  if (RatingsOrder == "SS") {
    z1 <- max(z1,z2)+1-z1
    z2 <- max(z1,z2)+1-z2
  } else if (RatingsOrder == "SL") {
    z1 <- max(z1,z2)+1-z1  
  } else if (RatingsOrder == "LS") {
    z2 <- max(z1,z2)+1-z2    
  }
    
  return (list(
    z1 = z1,
    z2 = z2))
}

