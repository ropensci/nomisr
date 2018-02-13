
## utility function for queries on available data


nomis_query_util <- function(query){
  
  q <- jsonlite::fromJSON(paste0(base_url, query), flatten = TRUE)
  
  df <- tibble::as_tibble(q$structure$keyfamilies$keyfamily)
  
  df
  
} 	
