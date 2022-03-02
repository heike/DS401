#' Feature Extraction: Proportion of NA values in the middle of the scan.
#'
#' One of the main problems with 3d scans is NA values in the middle of the 3d scan.
#' Here we are quantifying this by chopping off a portion of the right and left sides of a 3d scan
#' and are then finding the proportion of missing values in the middle of the 3d scan.
#' 
#' @param x3p scan in x3p format
#' @param chopoff numeric value between 0 and .5 - The percentage of values to chop off of both sides of the scan
#' @return proportion of NA values in the middle of 3d scan
#' @export
#' @examples
#' data(fau277_bb_l2)
#' assess_middle_na_proportion(fau277_bb_l2)
assess_middle_na_proportion <- function(x3p, chopoff = 1/6) {
  
  stopifnot(class(x3p) == "x3p")
  
  SurfaceMatrix <- x3p$surface.matrix
  
  MaximumX <- x3p$header.info$sizeX*x3p$header.info$incrementX
  
  LowerXBound <- MaximumX * chopoff
  
  UpperXBound <- MaximumX - (MaximumX * chopoff)
  
  IndexLowerXBound <- floor(LowerXBound/x3p$header.info$incrementX)
  
  IndexUpperXBound <- ceiling(UpperXBound/x3p$header.info$incrementX)
  
  SurfaceMatrix <- SurfaceMatrix[IndexLowerXBound:IndexUpperXBound,]
  
  meanna <- mean(is.na(SurfaceMatrix))
  
  return(meanna)
  
}
