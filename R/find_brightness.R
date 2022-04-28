#' Get the lighting from an x3p object
#'
#' @param x3p is a scan in x3p format
#' @export
#' @return the brightness of the file from the Comment attribute of the x3p object
#' @importFrom stringr str_extract
find_brightness <- function(x3p)
{
  string <- x3p$general.info$Comment

  brightness <- trimws(str_extract(x3p$general.info$Comment, "(?<=lighting: )(.*)(?= threshold)"))

  return(brightness)
}


#' Get lighting protocol from the name of an x3p object
#'
#' @param name name of an x3p object
#' @export
#' @importFrom stringr str_locate str_sub
#' @return 1 for 20% autolight, and 2 for 20% x 10 autolight ('flooding')
lighting_protocol <- function(name)
{
  light_start <- str_locate(name, "auto")
  light_end <- str_locate(name, "threshold")
  lighting <- str_sub(name, light_start[,1], light_end[,1]-1)
  lighting=gsub(" -","",lighting)
  lighting = trimws(lighting)

  lighting = gsub(" ","", lighting)
  lighting = ifelse(lighting=="autolightleftimage+20%", 1, 2)


  return(lighting)
}
