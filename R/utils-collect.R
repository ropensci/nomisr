

## utility function to download data


nomis_collect_util <- function(query){
  
  df <- suppressMessages(readr::read_csv(
    paste0("https://www.nomisweb.co.uk/api/v01/dataset", query)
    ))
  
  df
  
}




