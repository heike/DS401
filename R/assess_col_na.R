#' Asssess percentage of missing values in columns
#'
#' @param x3p scan in x3p format
#' @param perc_of_col HH: what is the expected range for the parameter? defaults to 40
#' @param threshold_prop defaults to 0.2
#' @return logical value: is percentage of columns with more than XXX percent missing values below XXX?
#' HH: replace XXX by parameter names
#' @export
#' @importFrom x3ptools x3p_to_df
#' @examples
#' assess_col_na(fau001_ba_l1)
#' assess_col_na(fau277_bb_l2)
assess_col_na <- function(x3p, perc_of_col = 40, threshold_prop = 0.2){
  stopifnot(class(x3p) == 'x3p')
  df <- x3p_to_df(x3p)
  ncols <- length(unique(df$x))
  col_i <- unique(df$x)
  col_na_sum <- rep(0, length(col_i))
  for(i in 1:length(col_i)){
    col_na_sum[i] <- sum(is.na(df$value[df$x == col_i[i]]))
  }
  col_na_perc <- col_na_sum / length(unique(df$y)) * 100
  bad_cols <- sum(col_na_perc > perc_of_col)
  threshold <- length(unique(df$x)) * threshold_prop
  return(bad_cols < threshold)
}




