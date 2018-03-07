

## utility function to download data


nomis_get_data_util <- function(query) {
  ### Implement tryCatch
  # show_condition <- function(code) {
  #   tryCatch(
  df <- tryCatch(
    {
      readr::read_csv(
        paste0(base_url, query),
        col_types = readr::cols(.default = readr::col_character())
      )
    }, error = function(cond) {
      message(paste("It is likely that you have been automatically rate limited
                    by the Nomis API. You can make smaller data requests, or 
                    try again later."))
      message("Here's the original error message:")
      message(cond)

      return(NA)
    }
  )

  df
}
