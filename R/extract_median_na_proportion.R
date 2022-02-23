#' Feature Extraction: Median of the proportion of NA values present in the middle of a 3d scan,
#' from 20 different y values.
#'
#' One of the main problems with 3d scans are the feathering that occurs within the middle of the scan.
#' Here, we quantify this feathering by taking samples at 20 specific y values in the surface matrix
#' that are in the middle 2/3 of the image. Then with these rows of the surface matrix we measure
#' the proportion of missing values in each of those 20 rows. We then take the median proportion of missing values
#' of those rows, which will give us
#' a good measure to quantify the amount of feathering in a 3d scan.
#' @param x3p scan in x3p format
#' @return median percentage of missing values
#' @importFrom stats median
#' @export
#' @examples
#' data(fau277_bb_l2)
#' extract_median_na_proportion(fau277_bb_l2)
extract_median_na_proportion <- function(x3p) {

SurfaceMatrix <- x3p$surface.matrix

NumberOfLines <- 18

NumberofYIncrements <- x3p$header.info$sizeY

NumberOfIncrementsBetweenLines <- floor(NumberofYIncrements/NumberOfLines)

MaximumX <- x3p$header.info$sizeX*x3p$header.info$incrementX

LowerXBound <- MaximumX/6

UpperXBound <- MaximumX - (MaximumX/6)

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

Median <- median(ProportionNA)

return(Median)

}
