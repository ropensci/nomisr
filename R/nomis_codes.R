

#' Variable codes
#' 
#' Retrieve all code options of all datasets, code options for a given 
#' dataset, or the all the options for a given code variable from a 
#' particular dataset.
#' 
#' Specifying `code` will return all the options for a given variable.
#'
#' @param id The ID of the particular dataset. If both \code{id} and 
#' \code{code} are left empty, returns all available codes for all datasets.
#' @param code A string with the variable code to return options for. If left 
#' empty, returns all the variables for the dataset specified by `id`. 
#' Codes are not case sensitive. Defaults to `null`.
#' @param type A string with options for a particular code value, to return 
#' types of variables available for a given code. Defaults to `null`.
#' @return A list of options.
#' @export
#'
#' @examples \dontrun{
#' 
#' a <- nomis_codes("NM_1_1")
#' 
#' b <- nomis_codes("NM_1_1", "geography")
#' 
#' c <- nomis_codes("NM_1_1", "geography", "TYPE")
#' #returns all types of geography
#' 
#' d <- nomis_codes("NM_1_1", "geography", "1879048226")
#' # returns geography types available within Wigan
#' 
#' }
#' 
nomis_codes <- function(id, code=NULL, type=NULL){
  
  if(missing(id)) stop("The dataset ID must be specified.")
    
  if(missing(code)) {
    
    q <- nomis_data_info(id)
    
    df <- tibble::as_tibble(as.data.frame(q$components.dimension))
    
    df$isfrequencydimension[is.na(df$isfrequencydimension)] <- "false"

  } else {
    
  type_query <- dplyr::if_else(is.null(type)==FALSE, paste0("/",type), "")
    
  a <- jsonlite::fromJSON(paste0("https://www.nomisweb.co.uk/api/v01/dataset/",
                                 id,"/",code, type_query, "/def.sdmx.json?"), flatten=TRUE)
                     
  x <- as.data.frame(a$structure$codelists$codelist$code)
  
  df <- tibble::tibble(
    description=x$description.value,
    value=x$value
    )
  
  }
  
  df
  
}



