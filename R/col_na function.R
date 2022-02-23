library(DS401)
library(x3ptools)
library(ggplot2)
devtools::install_github('heike/x3ptools', build_vignettes = TRUE)

col_na <- function(x3p){
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

# some test cases I tried
setwd('/Users/jacobtownsley/Downloads/all-good/FAU 1/Bullet A')
good1 <- read_x3p('LAPD - 1 - Bullet A - Land 1 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
good2 <- read_x3p('LAPD - 1 - Bullet A - Land 2 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
good3 <- read_x3p('LAPD - 1 - Bullet A - Land 3 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
good4 <- read_x3p('LAPD - 1 - Bullet A - Land 4 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
good5 <- read_x3p('LAPD - 1 - Bullet A - Land 5 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
good6 <- read_x3p('LAPD - 1 - Bullet A - Land 6 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Carley McConnell.x3p')
col_na(good1)
col_na(good2)
col_na(good3)
col_na(good4)
col_na(good5)
col_na(good6)

setwd('/Users/jacobtownsley/Downloads/some-bad/FAU 277/Bullet D')
maybe1 <- read_x3p('LAPD - 277 - Bullet D - Land 1 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
maybe2 <- read_x3p('LAPD - 277 - Bullet D - Land 2 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
maybe3 <- read_x3p('LAPD - 277 - Bullet D - Land 3 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
maybe4 <- read_x3p('LAPD - 277 - Bullet D - Land 4 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
maybe5 <- read_x3p('LAPD - 277 - Bullet D - Land 5 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
maybe6 <- read_x3p('LAPD - 277 - Bullet D - Land 6 - Sneox2 - 20x - auto light left image + 20% - threshold 2 - resolution 4 - Connor Hergenreter.x3p')
col_na(maybe1)
col_na(maybe2)
col_na(maybe3)
col_na(maybe4)
col_na(maybe5)
col_na(maybe6)





