#library
library(x3ptools)
library(Rcmdr)
library(imager)
library(DS401)
library(ggplot2)
library(dplyr)
#down the data
#devtools::install_github('heike/x3ptools', build_vignettes = TRUE)

#place:
#setwd("~/Desktop/Learning/isu/spring2022/DS401/DS401/man")
#png name:
#LAPD-FAU227-BD-L2.png

#try to read
x3ps <- dir(pattern = "x3p", recursive = TRUE, full.names = TRUE)
knitr::include_graphics("man/figures/fau277_bb_l2.png")
x3p_image(fau277_bb_l2, file = "man/figures/fau277_bb_l2.png")

extract_na(fau277_bb_l2)
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
#' nas_bad <- extract_na_column(fau277_bb_l2) # this scan has a particularly high percentage of missing values
#' plot(nas_bad) # the 'feathering' becomes obvious in the spikes of the missing values
#'
#' nas_good <- extract_na_column(fau001_ba_l1) # good scan
#' plot(nas_good) # similar pattern to above, but low values for most of the scan
#'

#make a function
extract_na_column <- function(x3p) {
  stopifnot(class(x3p) == "x3p")

 dims <- dim(x3p$surface.matrix)
 rows <- extract_na_row(x3p)*dims[1]/100

 # return(nas/prod(dims)*100)


  #the file mean the png of .x3p file
  file <-  x3p_to_df(x3p)


  #.png  - missing value in the the 20%
  right <- file %>% mutate(place= (y < round(.2*(max(file$x)))))

  #sum of the missing data 
  missing <- sum(right)
  
  #number of value in the right of the png
  value <- length(which(right$place=prod(dims)*.2))
  
  #present
  present < (missing/value) * 100
  
  return(present)

}

x3p_image(fau277_bb_l2, file = "man/figures/fau277_bb_l2.png")


