## code to prepare `DATASET` dataset goes here

# need to think about how best to add some data to the package

library(x3ptools)
library(magrittr)
fau277_bb_l2 <- read_x3p("data-raw/fau277-bb-l2.x3p")
usethis::use_data(fau277_bb_l2, overwrite = TRUE)

#usethis::use_data(DATASET, overwrite = TRUE)

fau001_ba_l1 <- read_x3p("data-raw/fau001-ba-l1.x3p")
fau001_ba_l1 <- fau001_ba_l1 %>% x3p_sample(m=3)
usethis::use_data(fau001_ba_l1, overwrite = TRUE)
