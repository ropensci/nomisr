
## utility function to query - may need to expand as time goes on

# the basic url for all data queries


nomis_query_util <- function(query){
  
  q <- jsonlite::fromJSON(paste0("https://www.nomisweb.co.uk/api/v01/dataset", query), flatten = TRUE)
  
  df <- tibble::as_tibble(q$structure$keyfamilies$keyfamily)
  
  df
  
}