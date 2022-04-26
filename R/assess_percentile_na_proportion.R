#' Feature Extraction: A specified percentile of the proportion of NA values present in the middle of a 3d scan,
#' from a specific number of different y values.
#'
#' One of the main problems with 3d scans are the feathering that occurs within the middle of the scan.
#' Here, we quantify this feathering by taking samples at specific number of y values in the surface matrix
#' that are in a certain percentage of the middle of the 3d scan. Then with these rows of the surface matrix we measure
#' the proportion of missing values in each of those rows. We then take the specified percentile proportion of missing values
#' of those rows, which will give us a good measure to quantify the amount of feathering in a 3d scan.
#' @param x3p scan in x3p format
#' @param chopoff numeric value between 0 and .5 - The percentage of values to chop off of both sides of the scan
#' @param numlines Number of horizontal lines across the scan to find the median proportion of na values from
#' @param percentile Specific percentile to choose from the number of horizontal lines
#' @return median proportion of missing values
#' @import
#' @export
#' @examples
#' data(fau277_bb_l2)
#' assess_percentile_na_proportion(fau277_bb_l2)
assess_percentile_na_proportion<- function(x3p, chopoff = 1/7, numlines = 200, percentile = 0.8) {

  stopifnot(class(x3p) == "x3p")

  SurfaceMatrix <- x3p$surface.matrix

  NumberOfLines <- numlines - 2

  NumberofYIncrements <- x3p$header.info$sizeY

  NumberOfIncrementsBetweenLines <- floor(NumberofYIncrements/NumberOfLines)

  MaximumX <- x3p$header.info$sizeX*x3p$header.info$incrementX

  LowerXBound <- MaximumX * chopoff

  UpperXBound <- MaximumX - (MaximumX * chopoff)

  LowerYBound <- 0

  UpperYBound <- x3p$header.info$sizeY*x3p$header.info$incrementY

  IndexLowerXBound <- floor(LowerXBound/x3p$header.info$incrementX)

  IndexUpperXBound <- ceiling(UpperXBound/x3p$header.info$incrementX)

  SurfaceMatrix <- SurfaceMatrix[IndexLowerXBound:IndexUpperXBound,]

  ProportionNA <- vector(mode = "numeric",length = NumberOfLines+1)

  ProportionNA[1] <- mean(is.na(SurfaceMatrix[,1]))

  for(i in 1:(NumberOfLines-1)){
    ProportionNA[i+1] <- mean(is.na(SurfaceMatrix[,i*NumberOfIncrementsBetweenLines]))
  }

  ProportionNA[NumberOfLines + 1] <- mean(is.na(SurfaceMatrix[,x3p$header.info$sizeY]))

  percentile <- quantile(ProportionNA, probs = percentile)

  return(as.numeric(percentile))

}

