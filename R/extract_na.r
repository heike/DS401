#' Feature extraction: percentage of missing values
#'
#' A good quality of 3d scans is crucial for an assessment of similarity of
#' striation marks between different bullets.
#' Here, we measure the percentage of missing values in the scan. Generally,
#' a higher percentage of missing values is associated with a lower scan quality.
#' @param x3p scan in x3p format
#' @return percentage of missing values in the surface matrix of the scan
#' @importFrom x3ptools x3p_read
#' @examples
#' x3p <- x3p_read("data-raw/fau277-bb-l2.x3p")
#' extract_na(x3p) # this scan has a particularly high percentage of missing values
extract_na <- function(x3p) {
  stopifnot(class(x3p) == "x3p")

  dims <- dim(x3p$surface.matrix)
  nas <- sum(is.na(x3p$surface.matrix))

  return(nas/prod(dims)*100)
}
