# TBA this function can be eliminated
loadDataFile <- function(path, fileName)
{
  if (fileName == "FED"){
    frocData <- DfReadDataFile(paste0(path, "Datasets/FZ/FedericaAll.xlsx"))  
  } else if (fileName == "TONY") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/ALMLCWBZSZ_Finale_20100402.xlsx"))  
  } else if (fileName == "VD") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/VanDykeData.xlsx"))  
  } else if (fileName == "JT") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/JohnThompsonDatafile.xlsx"))  
  } else if (fileName == "FR") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/franken1.xlsx"))  
  } else if (fileName == "MAG") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Magnus.xlsx"))
  } else if (fileName == "OPT") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/OPTIMAM2.xlsx"))
  } else if (fileName == "RUS") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Ruschin.xlsx"))
  } else if (fileName == "PEN") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Penedo.xlsx"))
  } else if (fileName == "DOB1") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Vortex/PrimaryAnalysis/3mm_to_20mm.xlsx"))
  } else if (fileName == "DOB2") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Vortex/PrimaryAnalysis/ActionabilityROC.xlsx"))
  } else if (fileName == "DOB3") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/Vortex/SecondaryAnalysis/CXRinvisible3-20mm.xlsx"))
  } else if (fileName == "FZR") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/FZ/FZ_REAL.xlsx"))
  } else if (fileName == "NICO") {
    frocData <- DfReadDataFile(paste0(path, "Datasets/NICO/NicoRadRoc.xlsx"))
    frocData <- DfBinDataset(frocData, opChType = "ROC")
  } else stop("Incorrect data file name", "\n")
  
  return(frocData)
}