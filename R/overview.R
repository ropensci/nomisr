

#' Nomis dataset overview
#'
#' Returns an overview of available metadata for a given dataset.
#'
#' @param id The ID of the particular dataset. Returns no data if not specified.
#'
#' @param select A string or character vector of one or more overview parts to
#' select, excluding all others. `select` is not case sensitive. The
#' options for `select` are described below, and are taken from the
#' \href{https://www.nomisweb.co.uk/api/v01/help}{Nomis API help page}.
#'
#' @return A tibble with two columns, one a character vector with the name of
#' the metadata category, and the other a list column of values for each
#' category.
#'
#' @section Overview part options:
#'
#' \describe{
#' \item{DatasetInfo}{General dataset information such as name, description,
#' sub-description, mnemonic, restricted access and status}
#' \item{Coverage}{Shows the geographic coverage of the main geography
#' dimension in this dataset (e.g. United Kingdom, England and Wales etc.)}
#' \item{Keywords}{The keywords allocated to the dataset}
#' \item{Units}{The units of measure supported by the dataset}
#' \item{ContentTypes}{The classifications allocated to this dataset}
#' \item{DateMetadata}{Information about the first release, last update and
#' next update}
#' \item{Contact}{Details for the point of contact for this dataset}
#' \item{Analyses}{Show the available analysis breakdowns of this dataset}
#' \item{Dimensions}{Individual dimension information (e.g. sex, geography,
#' date, etc.)}
#' \item{Dimension-concept}{Allows a specific dimension to be selected (e.g.
#' dimension-geography would allow information about geography dimension). This
#' is not used if "Dimensions" is specified too.}
#' \item{Codes}{Full list of selectable codes, excluding Geography, which as a
#' list of Types instead. (Requires "Dimensions" to be selected too)}
#' \item{Codes-concept}{Full list of selectable codes for a specific dimension,
#' excluding Geography, which as a list of Types instead. This is not used if
#' "Codes" is specified too (Requires "Dimensions" or equivalent to be
#' selected too)}
#' \item{DimensionMetadata}{Any available metadata attached at the dimensional
#' level (Requires "Dimensions" or equivalent to be selected too)}
#' \item{Make}{Information about whether user defined codes can be created with
#' the MAKE parameter when querying data (Requires "Dimensions" or equivalent
#' to be selected too)}
#' \item{DatasetMetadata}{Metadata attached at the dataset level}
#' }
#'
#' @export
#'
#' @seealso [nomis_data_info()]
#' @seealso [nomis_get_metadata()]
#'
#' @examples
#' \donttest{
#' library(dplyr)
#'
#' q <- nomis_overview("NM_1650_1")
#'
#' q %>%
#'   tidyr::unnest(name) %>%
#'   glimpse()
#'
#' s <- nomis_overview("NM_1650_1", select = c("Units", "Keywords"))
#'
#' s %>%
#'   tidyr::unnest(name) %>%
#'   glimpse()
#' }
#'
nomis_overview <- function(id, select = NULL) {
  if (missing(id)) {
    stop("The dataset ID must be specified.", call. = FALSE)
  }

  select_query <- ifelse(is.null(select), "",
    paste0(
      "?select=",
      paste0(select, collapse = ",")
    )
  )

  query <- paste0(base_url, id, ".overview.json", select_query)

  s <- jsonlite::fromJSON(query, flatten = TRUE)

  df <- tibble::enframe(s$overview)

  df
}
