

## utility function to download data - may need to expand as time goes on

nomis_collect_util <- function(query){
  
  q <- jsonlite::fromJSON(paste0(collect_root, query), flatten = TRUE)
  
  #df <- tibble::as.tibble(q$structure$keyfamilies$keyfamily)
  
  #df
  
}