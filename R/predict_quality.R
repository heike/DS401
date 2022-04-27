#' Predicts the probability that a x3p scan will be good and also predicts the reason why it is bad quality if it is predicted to be bad quality.
#'
#' @param x3pobjectlist a list of x3p objects to be classified as good or bad quality scans
#' @param x3pnamevector a vector of names of x3p files
#' @return a dataframe containing a vector of predicted probabilities of a scan being good and its predicted quality_type
#' @import randomForest
#' @export
#' @examples
#' data(fau277_bb_l2)
#' predict_quality(list(fau277_bb_l2, fau277_bb_l2), x3ptools::x3p_show_xml(fau277_bb_l2,"Comment")$Comment)
predict_quality<- function(x3pobjectlist, x3pnamevector) {

  for(i in 1:((length(x3pobjectlist))))
  {
    stopifnot(class(x3pobjectlist[[i]]) == "x3p")
  }
  
  data_assess_percentile_na_proportion <- c(rep(0, times = length(x3pobjectlist)))
  data_assess_bottomempty <- c(rep(0, times = length(x3pobjectlist)))
  data_assess_col_na <- c(rep(0,times = length(x3pobjectlist)))
  data_extract_na <- c(rep(0,times = length(x3pobjectlist)))
  data_assess_middle_na_proportion <- c(rep(0, times = length(x3pobjectlist)))
  data_assess_rotation <- c(rep(0, times = length(x3pobjectlist)))
  data_lighting_protocol <- c(rep(0, times = length(x3pobjectlist)))
  
  newdata <- data.frame(data_assess_percentile_na_proportion, data_assess_col_na, data_extract_na, data_assess_middle_na_proportion, data_assess_rotation, data_lighting_protocol)
  names(newdata) <- c("assess_percentile_na_proportion", "assess_col_na", "extract_na", "assess_middle_na_proportion", "assess_rotation", "lighting_protocol")
  
  
  for(i in 1:dim(newdata)[1]){
    newdata$assess_percentile_na_proportion[i] <- assess_median_na_proportion(x3pobjectlist[[i]])
    newdata$assess_bottomempty[i] <- assess_bottomempty(x3pobjectlist[[i]])
    newdata$assess_col_na[i] <- assess_col_na(x3pobjectlist[[i]])
    newdata$extract_na[i] <- extract_na(x3pobjectlist[[i]])
    newdata$assess_middle_na_proportion[i] <- assess_middle_na_proportion(x3pobjectlist[[i]])
    newdata$assess_rotation[i] <- assess_rotation(x3pobjectlist[[i]])
    newdata$lighting_protocol[i] <- lighting_protocol(x3pnamevector[i])
  }
  
  data(randomForest)
  Quality <- predict(randomforest, newdata = newdata, type = prob[,2])
  
  Quality_Type <- c(rep("", times = length(x3pobjectlist)))
  
  for(i in 1:dim(newdata)){
    if(Quality[i] <= 0.57){
      Quality_Type[i] <- predict(randomForest2, newdata = newdata[i], type = 'response')
    } else{
      Quality_Type[i] <- "good"
    }
    
  }
  
  output <- data.frame(Quality, Quality_Type)
  
  return(output)
}

