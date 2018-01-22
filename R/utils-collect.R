

## utility function to download data - may need to expand as time goes on

# the basic url for all data downloads
collect_root <- "https://www.nomisweb.co.uk/api/v01/dataset"

nomis_collect_util <- function(query, collect_root){
  
  #q <- jsonlite::fromJSON(paste0(collect_root, query), flatten = TRUE)
  
  df <- tibble::as_tibble(rjstat::fromJSONstat(paste0(collect_root, query), use_factors = T))
  
  df
  
}