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

training <- read.csv("data-raw/randomforestdata.csv")
training$quality <- factor(training$quality, levels = c("bad", "good"))
training$lighting_protocol <- as.factor(training$lighting_protocol)

usethis::use_data(training, internal = TRUE, overwrite = TRUE)

##########

set.seed(1000)



##80 percent train 20 percent test
TrainIndex <- sample(nrow(training), size = 0.8*nrow(training), replace = FALSE)

randomforest <-randomForest(quality ~extract_na + assess_percentile_na_proportion +
                              assess_middle_na_proportion + assess_rotation +
                              assess_col_na + assess_bottomempty +
                              lighting_protocol,
                            data = training, importance = TRUE, subset = TrainIndex)

usethis::use_data(randomforest, overwrite=TRUE)
#############




##Create Random Forest for quality_type
set.seed(1000)


##Take out samples which are good quality type

data_quality_type <- data %>% filter(quality == "bad")

##Take out damage variable as there are only 2
data_quality_type$quality_type[data_quality_type$quality_type == "damage"] <- "hole"


data_quality_type$quality_type <- as.factor(data_quality_type$quality_type)
levels(data_quality_type$quality_type)

##80-20 train-test split
TrainIndex_quality_type <- sample(1:length(data_quality_type$quality_type), size = (length(data_quality_type$quality_type)/5)*4, replace = FALSE)

randomforest2 <- randomForest(quality_type ~ extract_na + assess_percentile_na_proportion + assess_rotation + assess_col_na + assess_bottomempty + lighting_protocol, data = data_quality_type, importance = TRUE, subset = TrainIndex_quality_type)

RandomForest2Prediction <- predict(randomforest2, newdata = data_quality_type[-TrainIndex_quality_type,], type = "response")

##Confusion Matrix
table(RandomForest2Prediction, data_quality_type[-TrainIndex_quality_type,]$quality_type)

##Overall Misclassificaiton Rate
1-mean(RandomForest2Prediction == data_quality_type[-TrainIndex_quality_type,]$quality_type)

##Variable Importance Plot
varImpPlot(randomforest2)
