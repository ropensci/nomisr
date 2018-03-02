
#' Nomis metadata concepts and types
#'
#' Retrieve all code options of all Nomis datasets, code options for a given
#' dataset, or the all the options for a given code variable from a
#' particular dataset. Specifying \code{code} will return all the options for a 
#' given variable in a particular dataset.
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
#' @param additional_queries Any other additional queries to pass to the API.
#' See \url{https://www.nomisweb.co.uk/api/v01/help} for instructions on
#' query structure. Defaults to \code{NULL}.
#' 
#' @return A tibble with options.
#' @export
#'
#' @examples \donttest{
#'
#' a <- nomis_get_metadata('NM_1_1')
#'
#' b <- nomis_get_metadata('NM_1_1', 'geography')
#'
#' c <- nomis_get_metadata('NM_1_1', 'geography', 'TYPE')
#' #returns all types of geography
#'
#' d <- nomis_get_metadata('NM_1_1', 'geography', '1879048226')
#' # returns geography types available within Wigan
#'
#' }

nomis_get_metadata <- function(id, concept = NULL, 
                               type = NULL, additional_queries = NULL) {
  
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

    with_code_q <- jsonlite::fromJSON(paste0(base_url, id, "/", concept,
                                             type_query, "/def.sdmx.json?",
                                             additional_queries),
                                      flatten = TRUE)

    if(is.null(with_code_q$structure$codelists$codelist$code)){
      
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
