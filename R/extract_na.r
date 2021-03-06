#' Feature extraction: percentage of missing values
#'
#' A good quality of 3d scans is crucial for an assessment of similarity of
#' striation marks between different bullets.
#' Here, we measure the percentage of missing values in the scan. Generally,
#' a higher percentage of missing values is associated with a lower scan quality.
#' @param x3p scan in x3p format
#' @return percentage of missing values in the surface matrix of the scan
#' @export
#' @examples
#' data(fau277_bb_l2)
#' extract_na(fau277_bb_l2) # this scan has a particularly high percentage of missing values
#' extract_na(fau001_ba_l1) # good scan
extract_na <- function(x3p) {
  stopifnot(class(x3p) == "x3p")

  dims <- dim(x3p$surface.matrix)
  nas <- sum(is.na(x3p$surface.matrix))

  return(nas/prod(dims)*100)
}
