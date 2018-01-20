

#' Retrieve nomis datasets
#'
#' @param id The ID of the dataset to retrieve.
#'
#' @return A data frame
#' @export
#'
#' @examples \donotrun{
#' 
#' x <- nomis_get_data()
#' 
#' }
nomis_get_data <- function(id){
  
  if(missing(id)) stop("Dataset ID must be specified")

  query <- paste0("/",id,".jsonstat.json?")
  
  df <- nomis_collect_util(query)

}


#results <- fromJSONstat("https://www.nomisweb.co.uk/api/v01/dataset/NM_1_1.jsonstat.json?")
##investigate this JSONstat package further - currently 2 years since anything has been done to it, it is still the best way forward?