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
#' @param chopoff numeric value between 0 and .5 - how many values do we need to chop off from either side of the scan?
#' @return median percentage of missing values # HH: percentage or proportion?
#' HH: I believe, that what you are calculating is actually a lot more complicated than an overall median of missing values.
#' @importFrom stats median
#' @export
#' @examples
#' data(fau277_bb_l2)
#' extract_median_na_proportion(fau277_bb_l2)
extract_median_na_proportion <- function(x3p, chopoff = 1/6) {

  SurfaceMatrix <- cutoff_edges(x3p, chopoff)

  NumberofYIncrements <- x3p$header.info$sizeY

  NumberOfLines <- 18 # HH: where does the 18 come from? ## from the bottom up, + 2 lines

  NumberOfIncrementsBetweenLines <- floor(NumberofYIncrements/NumberOfLines)

  ProportionNA <- vector(mode = "numeric",length = NumberOfLines+1)

  ProportionNA[1] <- mean(is.na(SurfaceMatrix[,1]))

  for(i in 1:(NumberOfLines-1)){
    ProportionNA[i+1] <- mean(is.na(SurfaceMatrix[,i*NumberOfIncrementsBetweenLines]))
  }

  ProportionNA[NumberOfLines + 1] <- mean(is.na(SurfaceMatrix[,x3p$header.info$sizeY]))

  Median <- median(ProportionNA)
  return(Median)

}
