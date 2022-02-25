col_na <- function(x3p, perc_of_col, threshold_prop){
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





