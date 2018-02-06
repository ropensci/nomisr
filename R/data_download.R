

#' Retrieve Nomis datasets
#' 
#' Retrieves specific datasets from nomis, based on their ID. To find dataset 
#' IDs, use \code{\link{nomis_data_info}}. Datasets are retrived in csv format 
#' and parsed with the \code{read_csv} function from the \code{readr} package. 
#' 
#' To find the code options for a given dataset, use \code{\link{nomis_codes}}.
#' 
#' This can be a very slow process if calling significant amounts of data.
#' 
#' Note the difference between the \code{time} and \code{date} parameters. 
#' The \code{time} and \code{date} parameters should not be used at the same 
#' time. If they are, the function will retrieve data based on the the 
#' \code{date} parameter. If given more than one query, \code{time} will 
#' return all data available between those queries, inclusively, while 
#' \code{date} will only return data for the exact queries specified. So 
#' \code{time=c("first","latest")} will return all data, while 
#' \code{date=c("first","latest")} will return only the first and latest 
#' data published.
#' 
#'
#' @param id The ID of the dataset to retrieve.
#' @param time Parameter for selecting dates and date ranges. There are two 
#' styles of values that can be used to query time. 
#' 
#' The first is one or more of \code{"latest"} (returns the latest available 
#' data), \code{"previous"} (the date prior to \code{"latest"}), 
#' \code{"prevyear"} (the date one year prior to \code{"latest"}) or 
#' \code{"first"} (the oldest available data for the dataset). 
#' 
#' The second style is to use or a specific date or multiple dates, in the 
#' style of the time variable codelist, which can be found using the 
#' \code{\link{nomis_codes}} function.
#' 
#' Values for the \code{time} and \code{date} parameters should not be used 
#' at the same time. If they are, the function will retrieve data based 
#' on the the \code{date} parameter.
#' 
#' Defaults to \code{NULL}.
#' 
#' @param date Parameter for selecting specific dates. There are two styles 
#' of values that can be used to query time. 
#' 
#' The first is one or more of \code{"latest"} (returns the latest available 
#' data), \code{"previous"} (the date prior to \code{"latest"}), 
#' \code{"prevyear"} (the date one year prior to \code{"latest"}) or 
#' \code{"first"} (the oldest available data for the dataset). 
#' 
#' The second style is to use or a specific date or multiple dates, in the 
#' style of the time variable codelist, which can be found using the 
#' \code{\link{nomis_codes}} function.
#' 
#' Values for the \code{time} and \code{date} parameters should not be used at 
#' the same time. If they are, the function will retrieve data based on the 
#' the \code{date} parameter.
#' 
#' Defaults to \code{NULL}.
#' 
#' @param geography The code of the geographic area to return data for. If 
#' \code{NULL}, returns data for all available geographic areas, subject to 
#' other parameters. Defaults to \code{NULL}.
#' @param measures The code for the statistical measure(s) to include in the 
#' data. Accepts a single string or number, or a list of strings or numbers. 
#' If \code{NULL}, returns data for all available statistical measures subject 
#' to other parameters. Defaults to \code{NULL}.
#' @param sex The code for sexes included in the dataset. Accepts a string or 
#' number, or a vector of strings or numbers. \code{7} will return results for 
#' males and females, \code{6 }only females and \code{5} only males. 
#' Defaults to \code{NULL}, equivalent to \code{c(5,6,7)} for datasets where 
#' sex is an option.
#' @param exclude_missing If \code{TRUE}, excludes all missing values. 
#' Defaults to \code{FALSE}.
#' @param additional_queries Any other additional queries to pass to the API.
#' See \url{https://www.nomisweb.co.uk/api/v01/help} for instructions on 
#' query structure. Defaults to \code{NULL}.
#'
#' @return A tibble containing the selected dataset.
#' @export
#' @seealso nomis_data_info
#' @seealso nomis_codes
#' 
#' @examples \dontrun{
#' 
#' x <- nomis_get_data(id="NM_1_1")
#' 
#' y <- nomis_get_data(id="NM_1_1", time="latest")
#' 
#' # Return data for each country
#' z <- nomis_get_data(id="NM_1_1", time="latest", geography="TYPE499", 
#'                     measures=c(20100, 20201), sex=5)
#' 
#' # Return data for Wigan
#' a <- nomis_get_data(id="NM_1_1", time="latest", geography="1879048226", 
#'                     measures=c(20100, 20201), sex=5)
#' 
#' }


nomis_get_data <- function(id, time=NULL, date=NULL, geography=NULL, 
                           measures=NULL, sex=NULL, exclude_missing=FALSE, 
                           additional_queries=NULL){
  
  if(missing(id)){
    stop("Dataset ID must be specified")
  }
  
  time_query <- dplyr::case_when(is.null(date)==FALSE ~
                                  paste0("&date=", paste0(date, collapse=",")),
                                 is.null(time)==FALSE~
                                   paste0("&time=", paste0(time, collapse=",")),
                                 TRUE ~ ""
  )
  
  geography_query <- dplyr::if_else(is.null(geography)==FALSE,
                                    paste0("&geography=", geography),
                                    "")
  
  measures_query <- dplyr::if_else(length(measures)>0,
                                   paste0("&measures=", 
                                          paste0(measures, collapse=",")
                                          ),
                                   "")
  
  sex_query <- dplyr::if_else(length(sex)>0,
                              paste0("&sex=", paste0(sex, collapse=",")),
                              "")
  
  exclude_query <- dplyr::if_else(exclude_missing==TRUE,
                                  "&ExcludeMissingValues=true",
                                  "")
  
  query <- paste0("/",id,".data.csv?", time_query, geography_query, 
                  measures_query, sex_query, additional_queries,
                  exclude_query)
  
  df <- nomis_collect_util(query)
  
  if(df$RECORD_COUNT[1]>25000) { 
  # if amount available is over the limit of 25000 observations/single call
  # downloads the extra data and binds it all together in a tibble
    
    record_count <- df$RECORD_COUNT[1]
    
    seq_list <- seq(from=25000, to=record_count, by=25000)
    
    pages <- list()
    
    for(i in seq_along(seq_list)){
      
      query <- paste0(query, "&recordOffset=", seq_list[i])
      
      message("Retrieving additional pages ", i, " of ", length(seq_list))
      
      pages[[i]] <- nomis_collect_util(query)
      
    }
    
    df <- tibble::as_tibble(dplyr::bind_rows(pages, df))

  } 
  
  if(nrow(df)==0) stop("The API request did not return any results.
                       Please check your parameters.")
  
  df

}

