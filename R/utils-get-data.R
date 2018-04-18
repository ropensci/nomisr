

## utility function to download data


nomis_get_data_util <- function(query) {
  ### Implement tryCatch
  # show_condition <- function(code) {
  #   tryCatch(

  api_get <- httr::GET(paste0(base_url, query))

  if (httr::http_type(api_get) != "text/csv") {
    stop("Nomis API did not return data in required CSV format", call. = FALSE)
  }

  if (httr::http_error(api_get)) {
    stop(
      paste0(
        "Nomis API request failed with status ",
        httr::status_code(api_get)
      ),
      call. = FALSE
    )
  }

  df <- tryCatch({
    readr::read_csv(
      api_get$url,
      col_types = readr::cols(.default = readr::col_character())
    )
  }, error = function(cond) {
    message(
      "It is likely that you have been automatically rate limited ",
      "by the Nomis API.\n",
      "You can make smaller data requests, or try again later.\n\n",
      "Here's the original error message:\n", cond
    )

    return(NA)
  })

  df
}
