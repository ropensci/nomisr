
## utility function to query - may need to expand as time goes on


nomis_query_util <- function(query, query_root){
  
  q <- jsonlite::fromJSON(paste0(query_root, query), flatten = TRUE)
  
  df <- tibble::as_tibble(q$structure$keyfamilies$keyfamily)
  
  df
  
}