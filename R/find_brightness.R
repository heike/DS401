#' Get the lighting from an x3p object
#'
#' @param x3p is a scan in x3p format
#' @export
#' @return the brightness of the file from the Comment attribute of the x3p object
find_brightness <- function(x3p)
{
  string <- x3p$general.info$Comment

  brightness <- trimws(str_extract(x3p$general.info$Comment, "(?<=lighting: )(.*)(?= threshold)"))

  return(brightness)
}


