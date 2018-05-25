




#' Title
#'
#' @param id The ID of the particular dataset. Returns no data if not specified.
#' @param concept A string with the variable concept to return options for. If
#' left empty, returns all the variables for the dataset specified by \code{id}.
#' Codes are not case sensitive.
#'
#' @return
#' @export
#'
#' @examples
#' 

#need to complete this function, use sdmx to call data

nomis_codelist <- function(id, concept, partial_code = NULL, search = NULL) {
  if (missing(id)) {
    stop("id must be specified", call. = FALSE)
  }
  
  id <- gsub("NM", "CL", id)
  
  partial_code_query <- ifelse(is.null(partial_code), "",
                               paste0("/", partial_code)
                               )
  
  query <- paste0(codelist_url, id, concept, partial_code_query,
                  ".def.sdmx.xml", search_query)
  
}