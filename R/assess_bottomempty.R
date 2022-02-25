#' Feature extraction: percentage of missing values in the bottom n0% of the scan
#'
#' Missing values to the bottom right of a scan are expected and may not be that impactful. However,
#' if there are missing values consistently along the bottom of a scan, it indicates a bad scan, probably due to poor lighting.
#' This function returns the percentage of the bottom n0% of values that are missing.
#' The cutoff for what is considered "bottom" can be adjusted.
#'
#' @param x3p scan in x3p format
#' @param n_cutoff limit for where the 'bottom' ends. In the form of a decimal such as '.n'
#' @return percentage of missing values in the bottom n0%.
#' @export
#' @examples
#' data(fau277_bb_l2)
#' assess_bottomempty(fau277_bb_l2) # bad scan
#' assess_bottomempty(fau001_ba_l1) # good scan
assess_bottomempty <- function(x3p, n_cutoff){
  stopifnot(class(x3p) == "x3p")


  # total_missing <- extract_na(x3p)
  #
  #
  # #convert x3p to df in order to manipulate and count data
  # df_file <-  x3p_to_df(x3p)
  #
  #
  # #new df which indicates whether a value is in the bottom n0%
  # prop <- df_file %>% mutate(inthirty = (y < round(n_cutoff*(max(df_file$y)))))
  #
  # #number of values in the bottom n0%
  # amountinthirty <- length(which(prop$inthirty==TRUE))  # HH: identical to prod(dims)*n_cutoff
  #
  # #subset df with just the bottom n0%
  # thirtypercentdf <- subset(prop, inthirty == TRUE)
  #
  # #new df which shows whether a value is missing in the thirty percent
  # missinginthirtydf <- thirtypercentdf %>% mutate(noval = (is.nan(value)))
  # missinginthirtydf <- missinginthirtydf %>% mutate(noval2 = (is.na(value)))
  #
  # #amount of values missing in the bottom n0%
  # amountmissinginthirty <-length(which(missinginthirtydf$noval == TRUE))
  #
  # #Three different ways to measure. Easiest to understand is percentagemissinginthirty. For now, if this value is greater than
  # #80%, it indicates that most of the bottom n0% is missing and therefore a rescan should be taken.
  #


  dims <- dim(x3p$surface.matrix)
  rows <- extract_na_row(x3p)*dims[1]/100 # ordered from top of scan to bottom
  #browser()
  bottom <- rev(rows)[1:floor(n_cutoff* length(rows))] # take bottom thirty percent

  amountmissinginthirty <- sum(bottom)
  amountinthirty <- (prod(dims)*n_cutoff)

  percentageofmissinginthirty <- (amountmissinginthirty/amountinthirty)* 100

  #
  # percentmissingbottomscan <- percentageofmissinginthirty*n_cutoff
  #
  # percentmissingbottomscan/total_missing


  return(percentageofmissinginthirty)
}

