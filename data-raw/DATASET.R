## code to prepare `DATASET` dataset goes here

# need to think about how best to add some data to the package

library(x3ptools)
fau277_bb_l2 <- read_x3p("data-raw/fau277-bb-l2.x3p")
usethis::use_data(fau277_bb_l2, overwrite = TRUE)

#usethis::use_data(DATASET, overwrite = TRUE)
