#' Feature extraction: percentage of missing values in the bottom 30% of the scan
#'
#' Missing values to the bottom right of a scan are expected and may not be that impactful. However,
#' if there are missing values consistently along the bottom of a scan, it indicates a bad scan, probably due to poor lighting.
#' This function returns the percentage of the bottom 30% of values that are missing.
#' The cutoff for what is considered "bottom" can be adjusted.
#'
#' @param somex3p scan in x3p format
#' @return percentage of missing values in the bottom 30%.
#' @export
#' @examples
#' data(fau277_bb_l2)
#' assess_bottomempty(fau277_bb_l2) # bad scan
#' assess_bottomempty(fau001_ba_l1) # good scan
assess_bottomempty <- function(somex3p){
  stopifnot(class(somex3p) == "x3p")


  # total_missing <- extract_na(somex3p)
  #
  #
  # #convert x3p to df in order to manipulate and count data
  # df_file <-  x3p_to_df(somex3p)
  #
  #
  # #new df which indicates whether a value is in the bottom 30%
  # prop <- df_file %>% mutate(inthirty = (y < round(.3*(max(df_file$y)))))
  #
  # #number of values in the bottom 30%
  # amountinthirty <- length(which(prop$inthirty==TRUE))  # HH: identical to prod(dims)*.3
  #
  # #subset df with just the bottom 30%
  # thirtypercentdf <- subset(prop, inthirty == TRUE)
  #
  # #new df which shows whether a value is missing in the thirty percent
  # missinginthirtydf <- thirtypercentdf %>% mutate(noval = (is.nan(value)))
  # missinginthirtydf <- missinginthirtydf %>% mutate(noval2 = (is.na(value)))
  #
  # #amount of values missing in the bottom 30%
  # amountmissinginthirty <-length(which(missinginthirtydf$noval == TRUE))
  #
  # #Three different ways to measure. Easiest to understand is percentagemissinginthirty. For now, if this value is greater than
  # #80%, it indicates that most of the bottom 30% is missing and therefore a rescan should be taken.
  #


  dims <- dim(somex3p$surface.matrix)
  rows <- extract_na_row(somex3p)*dims[1]/100 # ordered from top of scan to bottom
  #browser()
  bottom <- rev(rows)[1:floor(.3 * length(rows))] # take bottom thirty percent

  amountmissinginthirty <- sum(bottom)
  amountinthirty <- (prod(dims)*.3)

  percentageofmissinginthirty <- (amountmissinginthirty/amountinthirty)* 100

  #
  # percentmissingbottomscan <- percentageofmissinginthirty*.3
  #
  # percentmissingbottomscan/total_missing


  return(percentageofmissinginthirty)
}

