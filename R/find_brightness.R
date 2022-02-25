library(tidyverse)
library(DS401)
library(x3ptools)

#' @param x3p is a scan in x3p format
#' @return the brightness of the file
find_brightness <- function(x3p)
{
  string <- x3p$general.info$Comment
  
  brightness <- case_when(str_detect(string, "x10") ~ "20% - x10",
                          T ~ "20%")
  
  return(brightness)
}