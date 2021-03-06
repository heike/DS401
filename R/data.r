#' Example x3p scan
#'
#' This is an x3p file containing an example of a very bad scan
#' @examples
#' library(x3ptools)
#' data(fau277_bb_l2)
#' x3p_image(fau277_bb_l2)
"fau277_bb_l2"

#' Example x3p scan
#'
#' This is an x3p file containing an example of an excellent scan (sub-sampled)
#' @examples
#' library(x3ptools)
#' data(fau001_ba_l1)
#' x3p_image(fau001_ba_l1)
"fau001_ba_l1"


#' Training data and results
#'
#' @examples
#' data(training)
#' library(ggplot2)
#' library(magrittr)
#' training %>%
#'   ggplot(aes(x = quality_pred, fill = quality)) +
#'     geom_histogram(binwidth = 0.025)
"training"


#' Randomforest predicting overall scan quality
#'
#' some more text
#' @import randomForest
#' @name randomforest
#' @export

#' Randomforest predicting reason for lack of quality
#'
#' some more text
#' @import randomForest
#' @name randomforest2
#' @export
