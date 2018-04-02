
#' Nomis metadata concepts and types
#'
#' @description Retrieve all concept code options of all Nomis datasets, concept
#' code options for a given dataset, or the all the options for a given
#' concept variable from a particular dataset. Specifying \code{concept} will
#' return all the options for a given variable in a particular dataset.
#'
#' @description If looking for a more detailed overview of all available
#' metadata for a given dataset, see \code{\link{nomis_overview}}.
#'
#' @param id The ID of the particular dataset. Returns no data if not specified.
#'
#' @param concept A string with the variable concept to return options for. If
#' left empty, returns all the variables for the dataset specified by \code{id}.
#' Codes are not case sensitive. Defaults to \code{NULL}.
#'
#' @param type A string with options for a particular code value, to return
#' types of variables available for a given code. Defaults to \code{NULL}. If
#' \code{concept == NULL}, \code{type} will be ignored.
#'
#' @param search  A string or character vector of strings to search for in the
#' metadata. Defaults to \code{NULL}. As in \code{\link{nomis_search}}, the
#' wildcard character * can be added to the beginning and/or end of each
#' search string.
#'
#' @param additional_queries Any other additional queries to pass to the API.
#' See \url{https://www.nomisweb.co.uk/api/v01/help} for instructions on
#' query structure. Defaults to \code{NULL}.
#'
#' @seealso \code{\link{nomis_data_info}}
#' @seealso \code{\link{nomis_get_data}}
#' @seealso \code{\link{nomis_overview}}
#'
#' @return A tibble with options.
#' @export
#'
#' @examples \donttest{
#'
#' a <- nomis_get_metadata('NM_1_1')
#'
#' tibble::glimpse(a)
#'
#' b <- nomis_get_metadata('NM_1_1', 'geography')
#'
#' tibble::glimpse(b)
#'
#' # returns all types of geography
#' c <- nomis_get_metadata('NM_1_1', 'geography', 'TYPE')
#'
#' tibble::glimpse(c)
#'
#' # returns geography types available within Wigan
#' d <- nomis_get_metadata('NM_1_1', 'geography', '1879048226')
#'
#' tibble::glimpse(d)
#'
#' e <- nomis_get_metadata('NM_1_1', 'item',
#'                         additional_queries = "?geography=1879048226&sex=5")
#'
#' tibble::glimpse(e)
#'
#' f <- nomis_get_metadata('NM_1_1', 'item', search = "*married*")
#'
#' tibble::glimpse(f)
#'
#'
#' }

nomis_get_metadata <- function(id, concept = NULL,
                               type = NULL, search = NULL,
                               additional_queries = NULL) {
  if (missing(id)) {
    stop("The dataset ID must be specified.", call. = FALSE)
  }

  if (is.null(concept)) {
    no_code_q <- nomis_data_info(id)

    df <- tibble::as_tibble(
      as.data.frame(no_code_q$components.dimension)
    )

    df$isfrequencydimension[is.na(df$isfrequencydimension)] <- "false"
  } else {
    type_query <- ifelse(is.null(type), "", paste0("/", type))

    search_query <- ifelse(is.null(search), "",
      paste0(
        "&search=",
        paste0(search, collapse = ",")
      )
    )

    with_code_q <- jsonlite::fromJSON(
      paste0(
        base_url, id, "/", concept,
        type_query, "/def.sdmx.json?",
        search_query,
        additional_queries
      ),
      flatten = TRUE
    )

    if (is.null(with_code_q$structure$codelists$codelist$code)) {
      df <- tibble::as_tibble(with_code_q$structure$codelists$codelist)
    } else {
      code_df <- as.data.frame(with_code_q$structure$codelists$codelist$code)

      df <- tibble::tibble(
        description = code_df$description.value,
        value = code_df$value
      )
    }
  }

  df
}
