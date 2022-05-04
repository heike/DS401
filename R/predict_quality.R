#' Predicts the probability that a x3p scan will be good and also predicts the reason why it is bad quality if it is predicted to be bad quality.
#'
#' @param x3p x3p scan of a bullet land
#' @param cutoff numeric value in [0,1] used as cut off between bad scans and good ones.
#' @return a dataframe with one row, containing all feature values and a prediction of the scan quality
#' @import randomForest
#' @importFrom utils data
#' @export
#' @examples
#' data(fau277_bb_l2)
#' predict_quality_one(fau277_bb_l2)
predict_quality_one <- function(x3p, cutoff = 0.57) {

  stopifnot("x3p" %in% class(x3p))


  data_assess_percentile_na_proportion <- assess_median_na_proportion(x3p)
  data_assess_bottomempty <- assess_bottomempty(x3p)
  data_assess_col_na <- assess_col_na(x3p)
  data_extract_na <- extract_na(x3p)
  data_assess_middle_na_proportion <- assess_middle_na_proportion(x3p)
  data_assess_rotation <- assess_rotation(x3p)
  data_lighting_protocol <- 1 # lighting_protocol(x3p)

  newdata <- data.frame(quality_pred=NA, quality_type=NA, data_assess_percentile_na_proportion, data_assess_col_na, data_extract_na, data_assess_middle_na_proportion, data_assess_rotation, data_assess_bottomempty, data_lighting_protocol)
  names(newdata) <- c("quality_pred", "quality_type",   "assess_percentile_na_proportion", "assess_col_na", "extract_na", "assess_middle_na_proportion", "assess_rotation", "assess_bottomempty", "lighting_protocol")
  newdata <- mutate(newdata,
    lighting_protocol = factor(lighting_protocol, levels=c(1,2))
  )

  data("randomforest", package="DS401")
  data("randomforest2", package="DS401")
  require(randomForest)
  newdata$quality_pred <- predict(randomforest, newdata = newdata, type = "prob")[,2]
  newdata$quality_type <- "good"
  if (newdata$quality_pred[1] <= cutoff) {
    newdata$quality_type <- predict(randomforest2, newdata = newdata, type = 'response')
  }

  return(newdata)
}

#' Predicts the probability that a x3p scan will be good and also predicts the reason why it is bad quality if it is predicted to be bad quality.
#'
#' @param x3plist list of x3p scans of a bullet land
#' @param x3pnamevector a vector of names of x3p files
#' @return a dataframe with one row, containing all feature values and a prediction of the scan quality
#' @import randomForest
#' @importFrom purrr map
#' @importFrom tibble tibble
#' @importFrom dplyr mutate
#' @importFrom utils data
#' @importFrom tidyr unnest
#' @export
#' @examples
#' data(fau277_bb_l2)
#' predict_quality(list(fau277_bb_l2, fau277_bb_l2), x3pnamevector=c(1,2))
predict_quality <- function(x3plist, x3pnamevector) {
#browser()
  x3p <- features <- NULL
  output <- tibble(x3p=I(x3plist), x3pname = x3pnamevector)
  output <- mutate(output,
    features = purrr::map(x3p, .f = predict_quality_one, cutoff=0.57)
  )
  output <- unnest(output, cols = features)
  return(output)
}

