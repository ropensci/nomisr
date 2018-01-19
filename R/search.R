### function for searching




nomis_search <- function(search, keyword=FALSE){
  
  query <- dplyr::if_else(keyword==FALSE,
                           paste0("/def.sdmx.json?search=*", search, "*"),
                           paste0("/def.sdmx.json?search=keywords-", search, "*")
  
  )
                          
  df <- nomis_query_util(query)
  
  
}