

#' Retrieve nomis datasets
#' 
#' Retrieves specific datasets from nomis, based on their ID. To find dataset 
#' IDs, use \code{\link{nomis_data_info}}. Datasets are retrived in csv format
#'  and parsed with the \code{read_csv} function from the \code{readr} package.
#'
#' @param id The ID of the dataset to retrieve.
#' @param time Parameter for selecting common dates. Accepts one of 
#' \code{NULL} (returns all data),  \code{"latest"} (returns the latest 
#' available data), \code{"previous"} ( the date prior to "latest"), 
#' \code{"prevyear"} (the date one year prior to "latest") or \code{"first"} 
#' (the oldest available data for this dataset).
#' @param exclude_missing If \code{TRUE}, excludes all missing values. 
#' Defaults to \code{FALSE}.
#'
#' @return A tibble containing the selected dataset.
#' @export
#'
#' @examples \dontrun{
#' 
#' x <- nomis_get_data(id="NM_1_1")
#' 
#' y <- nomis_get_data(id="NM_1_1", time="latest")
#' 
#' }
nomis_get_data <- function(id, time=NULL, exclude_missing=FALSE){
  
  if(missing(id)) stop("Dataset ID must be specified")
  
  time_query <- dplyr::if_else(is.null(time)==TRUE,
                               "",
                               paste0("&time=", tolower(time)))
  
  exclude_query <- dplyr::if_else(exclude_missing==TRUE,
                                  "ExcludeMissingValues=true",
                                  "")
  
  query <- paste0("/",id,".data.csv?", time_query, exclude_query)
  
  df <- nomis_collect_util(query)
  
  if(nrow(df)==0) stop("API request did not return any results")
  
  df

}
