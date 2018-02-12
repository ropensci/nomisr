

#' Search nomis datasets
#' 
#' A function to search for datasets on given topics. The search string by 
#' default looks in the names and descriptions of datasets.
#'
#' @param search A string to search for in the name and description of 
#' datasets.
#' @param keywords If \code{TRUE}, searches in dataset keywords instead of 
#' names and descriptions. Defaults to \code{FALSE}. 
#'
#' @return A tibble with details on all datasets matching the search query.
#' @export
#'
#' @examples \donttest{
#' 
#' x <- nomis_search('seekers')
#' 
#' y <- nomis_search('Claimants', keywords=TRUE)
#' 
#' }


nomis_search <- function(search, keywords = FALSE) {
    
    
    if (keywords == FALSE) {
        
        query <- paste0("/def.sdmx.json?search=*", search, "*")
        
    } else {
        
        query <- paste0("/def.sdmx.json?search=keywords-", search, "*")
        
    }
    
    df <- nomis_query_util(query)
    
    if (nrow(df) == 0) 
        stop("Search query did not return any results")
    
    df
    
    
}
