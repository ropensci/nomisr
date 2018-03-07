
## utility function for queries on available data


nomis_query_util <- function(query) {
  avail_response <- jsonlite::fromJSON(paste0(base_url, query), flatten = TRUE)

  df <- tibble::as_tibble(avail_response$structure$keyfamilies$keyfamily)

  if (nrow(df) == 0) {
    stop("API request did not return any results", call. = FALSE)
  }

  df
}
