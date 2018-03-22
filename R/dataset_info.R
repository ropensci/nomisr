
#' Nomis data structures
#'
#' Retrieve metadata on the structure and available variables for all available
#' data sets or the information available in a specific dataset based on its ID.
#'
#' @param id Dataset ID. If empty, returns data on all available datasets.
#' If the ID of a dataset, returns metadata for that particular dataset.
#'
#' @return A tibble with all available datasets and their metadata.
#' @export
#' @seealso \code{\link{nomis_get_data}}
#' @seealso \code{\link{nomis_get_metadata}}
#' @seealso \code{\link{nomis_overview}}
#'
#' @examples \donttest{
#'
#' # Get info on all datasets
#' x <- nomis_data_info()
#'
#' tibble::glimpse(x)
#'
#' # Get info on a particular dataset
#' y <- nomis_data_info('NM_1658_1')
#'
#' tibble::glimpse(y)
#'
#' }

nomis_data_info <- function(id) {
  if (missing(id)) {
    query <- "def.sdmx.json"
  } else {
    query <- paste0(id, "/def.sdmx.json")
  }

  df <- nomis_query_util(query)

  df
}
