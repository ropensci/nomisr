
#' Discovering data availability
#' 
#' Retrieve all available data sets or the information available in a specific 
#' dataset based on its ID.
#'
#' @param id Dataset ID. If empty, returns data on all available datasets.
#'
# @return
#' @export
#'
#' @examples \donotrun{
#' x <- nomis_data_info()
#' }
nomis_data_info <- function(id){
  
  if(missing(id)){
    
  query <- "/def.sdmx.json"

  } else {
    
  query <- paste0("/",id,"/def.sdmx.json")
   
  }
  
  df <- nomis_query_util(query)
  
  if(nrow(df)==0) stop("API request did not return any results")
  
  df
  
}
