

#' nomisr: Access UK labour market statistics from nomis with R
#' 
#' Full API documentation available at 
#' \url{https://www.nomisweb.co.uk/api/v01/help}
#' 
#' The `nomisr` package uses the `rjstat` package to convert API responses to 
#' data frames. As a consequence, some metadata is not included. To access
#' metadata, use the `nomis_data_info()` function.
#' 
#' @docType package
#' @name nmisr
#' @import jsonlite
#' @import tibble
#' @import rjstat
#' @import dplyr
# @useDynLib nomisr
NULL