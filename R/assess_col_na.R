#' Asssess percentage of missing values in columns
#'
#' The function takes an x3p object, a percentage to be used as the number acceptable percentage of missing values in a column,
#' and the proportion that bad columns that is the threshold for a good scan.
#' @param x3p scan in x3p format
#' @param perc_of_col Percentage (0 to 100) used as the acceptable percentage of missing values in a column. Defaults to 40
#' @param threshold_prop Proportion (0 to 1, defaults to 0.2) of columns with more than the acceptable percentage of missing values as defined by `perc_of_col`.
#' @return logical value: is percentage of columns with more than XXX percent missing values below XXX?
#' HH: replace XXX by parameter names
#' @export
#' @importFrom x3ptools x3p_to_df
#' @examples
#' assess_col_na(fau001_ba_l1)
#' assess_col_na(fau277_bb_l2)
assess_col_na <- function(x3p, perc_of_col = 40, threshold_prop = 0.2){
  stopifnot(class(x3p) == 'x3p')
  dims <- dim(x3p$surface.matrix)
  # df <- x3p_to_df(x3p)
  # ncols <- length(unique(df$x))
  # col_i <- unique(df$x)
  # col_na_sum <- rep(0, length(col_i))
  # for(i in 1:length(col_i)){
  #   col_na_sum[i] <- sum(is.na(df$value[df$x == col_i[i]]))
  # }
  # col_na_perc <- col_na_sum / length(unique(df$y)) * 100 # HH: col_na_perc is identical to extract_na_column
  col_na_perc <- extract_na_column(x3p)
  bad_cols <- sum(col_na_perc > perc_of_col)
  threshold <- dims[1] * threshold_prop

  return(bad_cols < threshold)
}




