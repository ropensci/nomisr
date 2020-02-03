
#' Nomis data structures
#'
#' Retrieve metadata on the structure and available variables for all available
#' data sets or the information available in a specific dataset based on its ID.
#'
#' @param id Dataset ID. If empty, returns data on all available datasets.
#' If the ID of a dataset, returns metadata for that particular dataset.
#'
#' @param tidy If `TRUE`, converts tibble names to snakecase.
#'
#' @return A tibble with all available datasets and their metadata.
#' @export
#' @seealso [nomis_get_data()]
#' @seealso [nomis_get_metadata()]
#' @seealso [nomis_overview()]
#' @seealso [nomis_codelist()]
#'
#' @examples
#' \donttest{
#'
#' # Get info on all datasets
#' x <- nomis_data_info()
#'
#' tibble::glimpse(x)
#'
#' # Get info on a particular dataset
#' y <- nomis_data_info("NM_1658_1")
#'
#' tibble::glimpse(y)
#' }
#'
nomis_data_info <- function(id, tidy = FALSE) {
  if (missing(id)) {
    data_info_query <- "def.sdmx.json"
  } else {
    data_info_query <- paste0(id, "/def.sdmx.json")
  }

  df <- nomis_query_util(data_info_query, tidy)

  df
}
