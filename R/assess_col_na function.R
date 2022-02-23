#' Asssess percentage of missing values in columns
#'
#' @param x3p scan in x3p format
#' @return logical value: is percentage of columns with more than XXX percent missing values below XXX?
#' HH: replace XXX by parameter names
#' @export
#' @examples
#' assess_col_na(fau001_ba_l1)
#' assess_col_na(fau277_bb_l2)
assess_col_na <- function(x3p) {
  stopifnot(class(x3p) == 'x3p')
  df <- x3p_to_df(x3p)
  ncols <- length(unique(df$x))
  col_i <- unique(df$x)
  col_na_sum <- rep(0, length(col_i))
  for(i in 1:length(col_i)){
    col_na_sum[i] <- sum(is.na(df$value[df$x == col_i[i]]))
  }
  col_na_perc <- col_na_sum / length(unique(df$y)) * 100
  bad_cols <- sum(col_na_perc > 40)
  threshold <- length(unique(df$x)) * 0.2
  return(bad_cols < threshold)
}




