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
usethis::use_data(training, internal = TRUE, overwrite = TRUE)

###############

library(randomForest)
library(ggplot2)
library(dplyr)

training <- training %>% mutate(
  label = quality,
  label = ifelse(quality_type %in% c("tiny hole", "speckles of missings"), "good", label)
)
training <- training %>% mutate(
  label = factor(label, levels = c("good", "bad"))
)

#data <- read.csv("lapd-training.csv")

set.seed(1000)

TrainIndex <- sample(nrow(training), size = 0.8*nrow(training), replace = FALSE)

randomforest <-randomForest(
  label ~ assess_bottomempty + assess_col_na + assess_median_na_proportion +
    assess_middle_na_proportion + extract_na + lighting,
  data = training, importance = TRUE, subset = TrainIndex)

RandomForestProbability <- predict(randomforest, newdata = training[TrainIndex,], type = "prob")[,2]
TrainHistogramData <- cbind(training[TrainIndex,], RandomForestProbability)

ggplot(data = TrainHistogramData, aes(x = RandomForestProbability, fill = quality)) +
  geom_histogram() +
  geom_vline(xintercept = 0.58, color = "grey50", size = 1) +
  ggtitle("Distribution of RandomForest Predicted Probabilities on Training Data") +
  theme(plot.title = element_text(hjust = 0.5, size = 25))

probrandomforest = predict(randomforest, newdata = training[-TrainIndex, ], type = "prob")[,2]

predictedrandomforest <- rep("bad", length(training[-TrainIndex,]$quality))

predictedrandomforest[probrandomforest < (1- 0.58)] <- "good"

##Confusion Matrix
table(predictedrandomforest, training[-TrainIndex,]$quality)

##Overall Misclassification Rate
1-mean(predictedrandomforest == training[-TrainIndex,]$quality)

##Variable Importance Plot
varImpPlot(randomforest)


##Show Examples of Good at 1.00 RandomForestProbability
TrainHistogramData[TrainHistogramData$RandomForestProbability == 1, ]$x3p_path[1]

##Show Examples of Bad at Lowest RandomForestProbability
head(TrainHistogramData %>% arrange(RandomForestProbability), 1)$x3p_path

##Show Example of Bad with the highest RandomForestProbability
tail(TrainHistogramData %>% filter(quality == "bad") %>% arrange(RandomForestProbability),1)$x3p_path

##Show Example of Good with the lowest RandomForestProbability
head(TrainHistogramData %>% filter(quality == "good") %>% arrange(RandomForestProbability),1)$x3p_path


##Show examples of missclassified "Bad" Scans that were predicted as good
TestData <- cbind(labeledsamples[-TrainIndex,], probrandomforest)
TestData %>% filter(quality == "bad", probrandomforest > 0.58) %>% arrange(probrandomforest) %>% select(x3p_path, probrandomforest)



