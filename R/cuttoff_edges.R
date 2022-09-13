# This is a helper function to return a SurfaceMatrix without the specified bands on the left and right side.
#' @param x3p scan in x3p format
#' @param chopoff numeric value between 0 and .5 - standard we have been using is 1/6
#' @return median percentage of missing values # HH: percentage or proportion?
cutoff_edges <- function(x3p, chopoff = 1/6) {

  stopifnot(class(x3p) == "x3p")

  SurfaceMatrix <- x3p$surface.matrix

  MaximumX <- x3p$header.info$sizeX*x3p$header.info$incrementX

  LowerXBound <- MaximumX * chopoff

  UpperXBound <- MaximumX - (MaximumX * chopoff)

  IndexLowerXBound <- floor(LowerXBound/x3p$header.info$incrementX)

  IndexUpperXBound <- ceiling(UpperXBound/x3p$header.info$incrementX)

  SurfaceMatrix <- SurfaceMatrix[IndexLowerXBound:IndexUpperXBound,]

  return(SurfaceMatrix)
}
