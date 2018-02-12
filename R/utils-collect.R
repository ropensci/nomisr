

## utility function to download data


nomis_collect_util <- function(query) {
    
    df <- readr::read_csv(
      paste0(base_url, query), 
      col_types = readr::cols(.default = readr::col_character())
      )
    
    df
    
}




