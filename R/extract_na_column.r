#' Feature extraction: percentage of missing values by column
#'
#' A good quality of 3d scans is crucial for an assessment of similarity of
#' striation marks between different bullets.
#' Here, we measure the percentage of missing values in the scan. Generally,
#' a higher percentage of missing values is associated with a lower scan quality.
#' @param x3p scan in x3p format
#' @return percentage of missing values in each column of the scan's surface matrix
#' @export
#' @examples
#' data(fau277_bb_l2)
#' nas_bad <- extract_na_column(fau277_bb_l2)
#' plot(nas_bad) # the 'feathering' becomes obvious in the spikes of the missing values
#'
#' nas_good <- extract_na_column(fau001_ba_l1) # good scan
#' plot((1:length(nas_good))*3, nas_good, col =2)
#' points(nas_bad, col=4)
extract_na_column <- function(x3p) {
  stopifnot(class(x3p) == "x3p")

  dims <- dim(x3p$surface.matrix)
  # row sum will provide a summary of each column in the scan matrix (transposed values)
  nas <- rowSums(is.na(x3p$surface.matrix))

  return(nas/dims[2]*100)
}


#' Feature extraction: percentage of missing values by row
#'
#' A good quality of 3d scans is crucial for an assessment of similarity of
#' striation marks between different bullets.
#' Here, we measure the percentage of missing values in the scan. Generally,
#' a higher percentage of missing values is associated with a lower scan quality.
#' @param x3p scan in x3p format
#' @return percentage of missing values in each row of the scan's surface matrix
#' @export
#' @examples
#' data(fau277_bb_l2) # bad scan
#' nas_bad <- extract_na_row(fau277_bb_l2)
#' plot(nas_bad)
#' # interesting pattern: we would expect a similar pattern for all scans
#' # (going from very low percentage of missing values at the top of a scan to a
#' # fairly high percentage along the bottom)
#'
#' nas_good <- extract_na_row(fau001_ba_l1) # excellent scan
#' plot(nas_good) # similar pattern to above, but low values for most of the scan
extract_na_row <- function(x3p) {
  stopifnot(class(x3p) == "x3p")

    dims <- dim(x3p$surface.matrix)
  # row sum will provide a summary of each column in the scan matrix (transposed values)
  nas <- colSums(is.na(x3p$surface.matrix))

  return(nas/dims[1]*100)
}
