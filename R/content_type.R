

#' Nomis dataset content types
#'
#' Nomis content type metadata is included in annotation tags, in the form of
#' \code{contenttype/<contenttype>} in the \code{annotationtitle} column in
#' the \code{annotations.annotation} list-column returned from
#' \code{\link{nomis_data_info}}. For example, the content types returned from
#' dataset "NM_1658_1", using \code{nomis_data_info("NM_1658_1")}, are
#' "geoglevel", "2001census" and "sources".
#'
#' @param content_type A string with the content type to return metadata on.
#' @param id A string with an optional \code{content_type} id.
#'
#' @return A tibble with metadata on a given content type.
#' @export
#' @seealso \code{\link{nomis_search}}
#' @seealso \code{\link{nomis_data_info}}
#'
#' @examples \donttest{
#'
#' a <- nomis_content_type("sources")
#'
#' tibble::glimpse(a)
#'
#' b <- nomis_content_type("sources", id = "census")
#'
#' tibble::glimpse(b)
#'
#' }


nomis_content_type <- function(content_type, id=NULL) {
  if (missing(content_type)) {
    stop("content_type must be specified", call. = FALSE)
  }

  if (is.null(id)) {
    id_query <- ""
  } else {
    id_query <- paste0("/id/", id)
  }

  query <- paste0(content_url, content_type, id_query, ".json")

  content_query <- jsonlite::fromJSON(query, flatten = TRUE)

  df <- tibble::as.tibble(data.frame(content_query$contenttype$item))

  df
}
