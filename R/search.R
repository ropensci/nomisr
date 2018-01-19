### function for searching




nomis_search <- function(search, keyword=FALSE){
  
  mydata <- dplyr::if_else(keyword==FALSE,
                           jsonlite::fromJSON(paste0("https://www.nomisweb.co.uk/api/v01/dataset/def.sdmx.json?search=*", search, "*"), flatten = TRUE),
                           jsonlite::fromJSON(paste0("https://www.nomisweb.co.uk/api/v01/dataset/def.sdmx.json?search=keywords-", search, "*"), flatten = TRUE))
  
  df <- mydata$structure$keyfamilies$keyfamily
  
  
}