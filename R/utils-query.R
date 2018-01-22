
## utility function to query - may need to expand as time goes on

# the basic url for all data queries
query_root <- "https://www.nomisweb.co.uk/api/v01/dataset"

nomis_query_util <- function(query, query_root){
  
  q <- jsonlite::fromJSON(paste0(query_root, query), flatten = TRUE)
  
  df <- tibble::as_tibble(q$structure$keyfamilies$keyfamily)
  
  df
  
}