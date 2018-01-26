



#' Variable codes
#' 
#' Retrieve all code options of all datasets, code options for a given 
#' dataset, or the all the options for a given code variable from a 
#' particular dataset.
#'
#' @param id The ID of the particular dataset. If both \code{id} and 
#' \code{code} are left empty, returns all available codes for all datasets.
#' @param code The variable name to return options for. If left empty, 
#' returns all options for the dataset specified by \code{id}. 
#' Codes are not case sensitive.
#'
#' @return A list of options.
#' @export
#'
#' @examples \dontrun{
#' 
#' z <- nomis_codes("NM_7_1", "geography")
#' 
#' }
#' 
nomis_codes <- function(id, code){
  
  if(missing(id)) stop("The dataset ID must be specified to return options for a given code.")
    
  if(missing(code)) {
    
    q <- nomis_data_info(id)
    
    df <- tibble::as_tibble(as.data.frame(q$components.dimension))
    
    df$isfrequencydimension[is.na(df$isfrequencydimension)] <- "false"

  } else {
    
  x <- as.data.frame(jsonlite::fromJSON(paste0("https://www.nomisweb.co.uk/api/v01/dataset/",id,"/",code,"/TYPE.def.sdmx.json?"), flatten=TRUE)$structure$codelists$codelist$code)
  
  df <- tibble::tibble(
    description=x$description.value,
    value=x$value
    )
  
  }
  
  df
  
}



