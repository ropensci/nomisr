
## retrieve all available data sets or the information available in a specific dataset based on its ID


#' Title
#'
#' @param id Dataset ID
#'
# @return
#' @export
#'
# @examples
nomis_data <- function(id){
  
  if(missing(id)){
    
  query <- "/def.sdmx.json"

  } else {
    
  query <- paste0("/",id,"/def.sdmx.json")
   
  }
  
  df <- nomis_query_util(query)
  
}




