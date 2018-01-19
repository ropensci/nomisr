
## utility function to query - may need to expand as time goes on


nomis_query_util <- function(query){
  
  q <- jsonlite::fromJSON(paste0(query_root, query), flatten = TRUE)
  
  df <- tibble::as.tibble(q$structure$keyfamilies$keyfamily)
  
  df
  
}