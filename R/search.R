

#' Search nomis datasets
#' 
#' A function to search for datasets on given topics. The search string by 
#' default looks in the names and descriptions of datasets.
#'
#' @param search A string to search for in the name and description of 
#' datasets.
#' @param keywords If \code{TRUE}, searches in dataset keywords. Defaults to 
#' \code{FALSE}. 
#'
#' @return A tibble with the search results.
#' @export
#'
#' @examples \dontrun{
#' 
#' x <- nomis_search("")
#' 
#' }


nomis_search <- function(search, keywords=FALSE){
  
  query <- dplyr::if_else(keywords==FALSE,
                           paste0("/def.sdmx.json?search=*", search, "*"),
                           paste0("/def.sdmx.json?search=keywords-", search, "*")
  
  )
                          
  df <- nomis_query_util(query)
  
  if(nrow(df)==0) stop("Search query did not return any results")
  
  df
  
  
}