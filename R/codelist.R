
#' Nomis codelists
#'
#' Nomis uses its own internal coding for query concepts. \code{nomis_codelist}
#' returns the codes for a given concept in a \code{tibble}, given a dataset
#' ID and a concept name.
#' Note that some codelists, particularly geography, can be very large.
#'
#'
#' @param id A string with the ID of the particular dataset. Must be specified.
#'
#' @param concept A string with the variable concept to return options for. If
#' left empty, returns all the variables for the dataset specified by \code{id}.
#' Codes are not case sensitive and must be specified.
#'
#' @param search Search for codes that contain a given string. The wildcard
#' character \code{*} can be added to the beginning and/or end of each
#' search string. Search strings are not case sensitive.
#' Defaults to \code{NULL}. Note that the search function is not very powerful
#' for some datasets.
#'
#' @return A tibble with the codes used to query specific concepts.
#' @export
#' @seealso \code{\link{nomis_data_info}}
#' @seealso \code{\link{nomis_get_metadata}}
#' @seealso \code{\link{nomis_overview}}
#'
#' @examples \donttest{
#' x <- nomis_codelist("NM_1_1", "item")
#'
#'
#' # Searching for codes ending with "london"
#' y <- nomis_codelist("NM_1_1", "geography", search = "*london")
#'
#'
#' z <- nomis_codelist("NM_161_1", "cause_of_death")
#' }

nomis_codelist <- function(id, concept, search = NULL) {
  if (missing(id)) {
    stop("id must be specified", call. = FALSE)
  }

  id_query <- paste0(gsub("NM", "CL", id), "_")

  search_query <- ifelse(is.null(search), "",
    paste0("?search=", search)
  )

  code_query <- paste0(
    codelist_url, id_query, concept,
    ".def.sdmx.xml", search_query
  )

  df <- tibble::as.tibble(as.data.frame(rsdmx::readSDMX(code_query)))

  df
}
