library(randomForest)
library(ggplot2)
library(dplyr)

data <- read.csv("lapd-training.csv")

##Dataset of just the labeled samples(results depend on which version of training.csv you are using)
labeledsamples <- data[is.na(data$quality) == FALSE,]

set.seed(1000)

labeledsamples[labeledsamples$quality_type == "tiny hole",]$quality <- "good"
labeledsamples[labeledsamples$quality_type == "speckles of missings",]$quality <- "good"

labeledsamples$quality <- factor(labeledsamples$quality, levels = c("bad", "good"))
labeledsamples$lighting <- factor(labeledsamples$lighting, levels = c("auto light left image + 20%", "auto light left image + 20% & x10"))

TrainIndex <- sample(1:length(labeledsamples$quality), size = (length(labeledsamples$quality)/5)*4, replace = FALSE)

randomforest <-randomForest(quality ~ assess_bottomempty + assess_col_na + assess_median_na_proportion + assess_middle_na_proportion + extract_na + lighting, data = labeledsamples, importance = TRUE, subset = TrainIndex)

RandomForestProbability <- predict(randomforest, newdata = labeledsamples[TrainIndex,], type = "prob")[,2]
TrainHistogramData <- cbind(labeledsamples[TrainIndex,], RandomForestProbability)

ggplot(data = TrainHistogramData, aes(x = RandomForestProbability, color = quality)) + geom_histogram() + geom_vline(xintercept = 0.58, color = "red", size = 1) + ggtitle("Distribution of RandomForest Predicted Probabilities on Training Data") + theme(plot.title = element_text(hjust = 0.5, size = 25))

probrandomforest = predict(randomforest, newdata = labeledsamples[-TrainIndex, ], type = "prob")[,2]

predictedrandomforest <- rep("bad", length(labeledsamples[-TrainIndex,]$quality))

predictedrandomforest[probrandomforest > 0.58] <- "good"

##Confusion Matrix
table(predictedrandomforest, labeledsamples[-TrainIndex,]$quality)

##Overall Misclassification Rate
1-mean(predictedrandomforest == labeledsamples[-TrainIndex,]$quality) 

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

