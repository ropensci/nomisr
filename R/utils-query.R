
## utility function for queries on available data


nomis_query_util <- function(query, tidy) {
  api_resp <- httr::GET(paste0(base_url, query))
  if (http_type(api_resp) != "application/json") {
    stop("Nomis API did not return data in required json format", call. = FALSE)
  }

  if (httr::http_error(api_resp)) {
    stop(
      paste0(
        "Nomis API request failed with status ",
        httr::status_code(api_resp)
      ),
      call. = FALSE
    )
  }

  avail_response <- jsonlite::fromJSON(api_resp$url, flatten = TRUE)

  df <- tibble::as_tibble(avail_response$structure$keyfamilies$keyfamily)

  if (nrow(df) == 0) {
    stop("API request did not return any results", call. = FALSE)
  }
  
  if (tidy) {
    names(df) <- snakecase::to_snake_case(names(df))
  }

  df
}
