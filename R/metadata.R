
#' Nomis metadata concepts and types
#'
#' @description Retrieve all concept code options of all Nomis datasets,
#' concept code options for a given dataset, or the all the options for a given
#' concept variable from a particular dataset. Specifying `concept` will
#' return all the options for a given variable in a particular dataset.
#'
#' @description If looking for a more detailed overview of all available
#' metadata for a given dataset, see [nomis_overview()].
#'
#' @param id The ID of the particular dataset. Returns no data if not specified.
#'
#' @param concept A string with the variable concept to return options for. If
#' left empty, returns all the variables for the dataset specified by `id`.
#' Codes are not case sensitive. Defaults to `NULL`.
#'
#' @param type A string with options for a particular code value, to return
#' types of variables available for a given code. Defaults to `NULL`. If
#' `concept == NULL`, `type` will be ignored.
#'
#' @param search  A string or character vector of strings to search for in the
#' metadata. Defaults to `NULL`. As in [nomis_search()], the
#' wildcard character `*` can be added to the beginning and/or end of each
#' search string.
#'
#' @param additional_queries Any other additional queries to pass to the API.
#' See \url{https://www.nomisweb.co.uk/api/v01/help} for instructions on
#' query structure. Defaults to `NULL`. Deprecated in package
#' versions greater than 0.2.0 and will eventually be removed.
#'
#' @param ... Use to pass any other parameters to the API.
#'
#' @seealso [nomis_data_info()]
#' @seealso [nomis_get_data()]
#' @seealso [nomis_overview()]
#'
#' @return A tibble with metadata options for queries using
#' [nomis_get_data()].
#' @export
#'
#' @examples \donttest{
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
#' e <- nomis_get_metadata('NM_1_1', 'item', geography = 1879048226, sex = 5)
#'
#' print(e)
#'
#' f <- nomis_get_metadata('NM_1_1', 'item', search = "*married*")
#'
#' tibble::glimpse(f)
#' }

nomis_get_metadata <- function(id, concept = NULL,
                               type = NULL, search = NULL,
                               additional_queries = NULL, ...) {
  if (missing(id)) {
    stop("The dataset ID must be specified.", call. = FALSE)
  }

  # Warning message for additional queries
  if (length(additional_queries) > 0) {
    additional_query <- additional_queries

    message("The `additional_query` parameter is
            deprecated, please use ... instead")
  } else {
    additional_query <- NULL
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

    dots <- rlang::list2(...) ## eval the dots

    dots_list <- c()

    for (i in seq_along(dots)) { # retrieve the dots
      dots_list[i] <- ifelse(length(dots[[i]]) > 0,
        paste0(
          "&", names(dots[i]), "=",
          paste0(dots[[i]], collapse = ",")
        ),
        ""
      )
    }

    dots_query <- paste0(dots_list, collapse = "")

    df <- tibble::as.tibble(rsdmx::readSDMX(
      paste0(
        base_url, id, "/", concept,
        type_query, "/def.sdmx.xml?",
        search_query,
        additional_queries, dots_query
      )
    ))
  }

  df
}
