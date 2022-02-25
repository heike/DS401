devtools::install_github('heike/x3ptools', build_vignettes = TRUE)
install_bitbucket("imagemetrics", "persican")
knitr::include_graphics("man/figures/fau277_bb_l2.png")
devtools::install_github('heike/x3ptools', build_vignettes = TRUE)
knitr::include_graphics("man/figures/fau001_ba_l1.png")
devtools::install_github("heike/DS401")

#library
library(x3ptools)
library(Rcmdr)
library(imager)
library(DS401)
library(ggplot2)
library(dplyr)
library(devtools)
library(imagemetrics)



#read the x3p and load the the image.
x3ps <- dir(pattern = "x3p", recursive = TRUE, full.names = TRUE)
x3p_image(fau277_bb_l2, file = "man/figures/fau277_bb_l2.png")
x3p_image(fau001_ba_l1, file = "man/figures/fau001_ba_l1.png")

extract_na(fau277_bb_l2)

#' ideal:
#' we guess the .png have some missing data but we are not sure about 
#' how many missing and what probability in the NA prability
#' Also, we are guess that we the right of the .png and bottom of .png  have the missing value are overlapping.
#' we mat need to confused about the overlapping the missing data.
#' we can be caseful the botton of the missing data and adjust them and calculate their probabilities.

#' In this function, my idea is that get the bootom missing data and get the probality of the bottom
#' step:
#' the missing value in the bottom size
#' find the NA value and sum of that
#' sum of the bottom data 
#' calculator the probability



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


#' this part is find the probabiliy of bottom
prob <-function(x3p){
    stopifnot(class(x3p) == "x3p")

 dims <- dim(x3p$surface.matrix)
 # ordered from top of scan to bottom
 rows <- extract_na_row(x3p)*dims[1]/100



  #the file mean the png of .x3p file
  file <-  x3p_to_df(x3p)
 

# calculating the product of dimensions of dataframe 
totalcells = prod(dim(file))
 
  #sum of calculator missing data in each column
 sum_col <- apply(file, 2, sum, na. rm = TRUE )
 
 
 
 #get the bottom  NA pixel
 # get <- getImagePixels(file, side = 72)
 # str(get)
  #sum_get<-sum(get)

  #calculator the max missing value
#  suggestMaximumBins(file)
#  file.prob = calculateHisto(reference_vector = file$reference_vector,
 #                            neighbour_vector = file$neighbour_vector,
  #                           nbins = 72)
 #
percentage = (sum_col * 100 )/(totalcells)
 
  return(percentage)
  }
       


#max probability in each column
max_prob <-function(x3p){
    stopifnot(class(x3p) == "x3p")

 dims <- dim(x3p$surface.matrix)
 # ordered from top of scan to bottom
 rows <- extract_na_row(x3p)*dims[1]/100



  #the file mean the png of .x3p file
  file <-  x3p_to_df(x3p)
 
#Find the max value NA  data in each column
  is.na(file)
  max_value <- apply(file,max,na.rm=TRUE)
 # calculating the product of dimensions of dataframe 
totalcells = prod(dim(file))
 
 percentage = (max_value * 100)/(totalcells)
 return(percentage)
 
  }

