

#' Search Nomis datasets
#'
#' A function to search for datasets on given topics. In the case of multiple
#' search parameters, returns metadata on all datasets matching  one or more of
#' the parameters. The wildcard character \code{*} can be added to the beginning
#' and/or end of each search string.
#'
#' @param name A string or character vector of strings to search for in
#' available dataset names. Defaults to \code{NULL}.
#'
#' @param description A string or character vector of strings to search for in
#' available dataset descriptions. Note that \code{description} looks for
#' complete matches, so wildcards should be used at the start and end of
#' each string. Defaults to \code{NULL}.
#'
#' @param keywords A string or character vector of strings to search for in
#' available dataset keywords. Defaults to \code{NULL}.
#'
#' @param content_type A string or character vector of strings to search for
#' in available dataset content types. \code{content_type} can include an
#' optional ID for that content type. Defaults to \code{NULL}.
#'
#' @param units A string or character vector of strings to search for in
#' available dataset units. Defaults to \code{NULL}.
#'
#' @return A tibble with details on all datasets matching the search query.
#' @export
#' @seealso \code{\link{nomis_content_type}}
#'
#' @examples \donttest{
#'
#' x <- nomis_search(name = '*seekers*')
#'
#' y <- nomis_search(keywords = 'Claimants')
#'
#' # Return metadata of all datasets with content_type "sources".
#' a <- nomis_search(content_type = "sources")
#'
#'
#' # Return metadata of all datasets with content_type "sources" and
#' # source ID "acses"
#' b <- nomis_search(content_type = "sources-acses")
#'
#' }


nomis_search <- function(name = NULL, description = NULL,
                         keywords = NULL, content_type = NULL, units = NULL) {
  if (length(name) > 0) {
    name_query <- paste0(
      "&search=name-",
      paste0(name, collapse = ",")
    )
  } else {
    name_query <- ""
  }

  if (length(description) > 0) {
    description_query <- paste0(
      "&search=description-",
      paste0(description, collapse = ",")
    )
  } else {
    description_query <- ""
  }

  if (length(keywords) > 0) {
    keywords_query <- paste0(
      "&search=keywords-",
      paste0(keywords, collapse = ",")
    )
  } else {
    keywords_query <- ""
  }

  if (length(content_type) > 0) {
    content_type_query <- paste0(
      "&search=contenttype-",
      paste0(content_type, collapse = ",")
    )
  } else {
    content_type_query <- ""
  }

  if (length(units) > 0) {
    units_query <- paste0(
      "&search=units-",
      paste0(units, collapse = ",")
    )
  } else {
    units_query <- ""
  }

  query <- paste0(
    "def.sdmx.json?", name_query, description_query,
    keywords_query, content_type_query, units_query
  )

  df <- nomis_query_util(query)

  df
}
