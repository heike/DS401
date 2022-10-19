#' Assess rotational imbalance of a scan
#'
#' A good quality of 3d scans is crucial for an assessment of similarity of
#' striation marks between different bullets.
#' Here, we assess rotational imbalance - we measure this as the ratio between
#' the difference in the number of missing values on the left and the right of a scan at two different heights.
#' A ratio of 1 would indicate a balance in the proportion of missing values between the left hand side and the right hand side of a scan.
#' Large deviations of 1 indicate an imbalance to the left or right. A log transform of the ratio akes the result symmetric around 0. Large deviations from 0 indicate a stronger deviation.
#' @param x3p scan in x3p format
#' @param width how wide are the bands that we want to compare on the left and the right?
#' @return absolute value of the log of the ratio of the number of missing values on the left compared to the right side at the bottom and the middle of the scan.
#' @export
#' @examples
#' data(fau277_bb_l2)
#' assess_rotation(fau277_bb_l2) # this scan has a particularly high percentage of missing values
#' assess_rotation(fau001_ba_l1) # good scan
assess_rotation <- function(x3p, width=0.2) {
  stopifnot(class(x3p) == "x3p")
  stopifnot(width > 0, width < 0.5)

  dims <- dim(x3p$surface.matrix)
  band <- max(floor(width*dims[1]),1) # round down, but make sure we have at least one column of values
  half <- round(dims[2]/2)

  middle <- rowMeans(x3p$surface.matrix[,half+(-5:5)], na.rm=TRUE)
  bottom <- rowMeans(x3p$surface.matrix[,dims[2]-0:10], na.rm=TRUE)


  na_left <- sum(is.na(middle[1:band]))
  #na_right <- sum(is.na(middle[dims[2]+1-band:1]))
  na_right <- sum(is.na(middle[dims[1]+1-band:dims[1]]))

#browser()
  na_left_bottom <- sum(is.na(bottom[1:band]))
  #na_right_bottom <- sum(is.na(bottom[dims[2]+1-band:1]))
  na_right_bottom <- sum(is.na(bottom[dims[1]+1-band:dims[1]]))

  return(abs(log((na_left+1)/(na_left_bottom+1)/((na_right+1)/(na_right_bottom+1)) )))
}
