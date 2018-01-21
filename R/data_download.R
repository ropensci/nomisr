

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
  
  if(nrow(df)==0) stop("API request did not return any results")
  
  df

}
