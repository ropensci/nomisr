

#' Retrieve nomis datasets
#' 
#' Retrieves specific datasets from nomis, based on their ID. To find dataset 
#' IDs, use \code{\link{nomis_data_info}}. Datasets are retrived in csv format 
#' and parsed with the \code{read_csv} function from the \code{readr} package. 
#' 
#' To find the code options for a given dataset, use \code{\link{nomis_codes}}.
#' 
#' This can be a very slow process if calling significant amounts of data.
#'
#' @param id The ID of the dataset to retrieve.
#' @param time Parameter for selecting common dates. Accepts one of 
#' \code{NULL} (returns all data),  \code{"latest"} (returns the latest 
#' available data), \code{"previous"} (the date prior to \code{"latest"}), 
#' \code{"prevyear"} (the date one year prior to \code{"latest"}) or 
#' \code{"first"} (the oldest available data for the dataset). 
#' Defaults to \code{NULL}.
#' @param geography The code of the geographic area to return data for. If 
#' \code{NULL}, returns data for all available geographic areas, subject to 
#' other parameters. Defaults to \code{NULL}.
#' @param measures The code for the statistical measure(s) to include in the 
#' data. Accepts a single string or number, or a list of strings or numbers. 
#' If \code{NULL}, returns data for all available statistical measures subject 
#' to other parameters. Defaults to \code{NULL}.
#' @param sex The code for sexes included in the dataset. Accepts a string or 
#' number, or a vector of strings or numbers. \code{7} will return results for 
#' males and females, \code{6} only females and \code{5} only males. 
#' Defaults to \code{NULL}, equivalent to \code{c(5,6,7)} for datasets where 
#' sex is an option.
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
#' z <- nomis_get_data(id="NM_1_1", time="latest", geography="TYPE499", measures=c(20100, 20201), sex=5)
#' 
#' }
nomis_get_data <- function(id, time=NULL, geography=NULL, measures=NULL, sex=NULL, exclude_missing=FALSE){
  
  if(missing(id)){
    stop("Dataset ID must be specified")
  }
 
  time_query <- dplyr::if_else(is.null(time)==FALSE,
                               paste0("&time=", paste0(time, collapse=",")),
                               "")
  
  geography_query <- dplyr::if_else(is.null(geography)==FALSE,
                                    paste0("&geography=", geography),
                                    "")
  
  measures_query <- dplyr::if_else(length(measures)>0,
                                   paste0("&measures=", paste0(measures, collapse=",")),
                                   "")
  
  sex_query <- dplyr::if_else(length(sex)>0,
                              paste0("&sex=", paste0(sex, collapse=",")),
                              "")
  
  exclude_query <- dplyr::if_else(exclude_missing==TRUE,
                                  "&ExcludeMissingValues=true",
                                  "")
  
  query <- paste0("/",id,".data.csv?", time_query, geography_query, measures_query, sex_query, exclude_query)
  
  df <- nomis_collect_util(query)
  
  if(df$RECORD_COUNT[1]>25000) {# test for length and retrieve all data if amount available is over the limit of 25000
    
    record_count <- df$RECORD_COUNT[1]
    
    seq_list <- seq(from=25000, to=record_count, by=25000)
    
    pages <- list()
    
    for(i in 1:length(seq_list)){
      
      query <- paste0(query, "&recordOffset=", seq_list[i])
      
      message("Retrieving additional pages ", i, " of ", length(seq_list))
      
      pages[[i]] <- nomis_collect_util(query)
      
    }
    
    df <- tibble::as_tibble(dplyr::bind_rows(pages, df))

  } 
  
  if(nrow(df)==0) stop("The API request did not return any results. Please check your parameters.")
  
  df

}
