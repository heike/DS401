#' Predicts the quality of a vector of x3p scan's by outputing the random forest predicted probability that a scan's quality is good.
#' 
#' @param x3pvector a vector of x3p objects to be classified as good or bad quality scans
#' @return a vector of random forest probability scores
#' @importFrom randomForest predict
#' @export
#' @examples
predict_quality<- function(x3pvector) {
  
  for(i in 1:(length(x3pvector)))
  {
    stopifnot(class(x3pvector[i]) == "x3p")
  }
  
  data_assess_percentile_na_proportion <- c(rep(0, times = length(x3pvector)))
  data_assess_bottomempty <- c(rep(0, times = length(x3pvector)))
  data_assess_col_na <- c(rep(0,times = length(x3pvector)))
  data_extract_na <- c(rep(0,times = length(x3pvector)))
  data_assess_middle_na_proportion <- c(rep(0, times = length(x3pvector)))
  
  newdata <- data.frame(data_assess_percentile_na_proportion, data_assess_col_na, data_extract_na, data_assess_middle_na_proportion)

  
  for(i in 1:dim(Data)[1]){
    newdata$data_assess_percentile_na_proportion[i] <- assess_median_na_proportion(x3pvector[i])
    newdata$data_assess_bottomempty[i] <- assess_bottomempty(x3pvector[i])
    newdata$data_assess_col_na[i] <- assess_col_na(x3pvector[i])
    newdata$data_extract_na[i] <- extract_na(x3pvector[i])
    newdata$data_assess_middle_na_proportion[i] <- assess_middle_na_proportion(x3p)
  }
  
  return(predict(randomForest, newdata = newdata, type = prob[,2]))
  
  
}

