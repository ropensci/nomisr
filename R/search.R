

#' Search nomis
#' 
#' Function for searching for datasets on given topics
#'
#' @param search The term to search for.
#' @param keywords If \code{TRUE}, searches only in dataset keywords. Defaults 
#' to \code{FALSE}. 
#'
#' @return A tibble with the search results.
#' @export
#'
#' @examples \donotrun{
#' 
#' }
nomis_search <- function(search, keywords=FALSE){
  
  query <- dplyr::if_else(keyword==FALSE,
                           paste0("/def.sdmx.json?search=*", search, "*"),
                           paste0("/def.sdmx.json?search=keywords-", search, "*")
  
  )
                          
  df <- nomis_query_util(query)
  
  
}