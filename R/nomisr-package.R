

#' nomisr: Access Nomis UK Labour Market Data with R
#'
#' Access UK official statistics from the Nomis database. Nomis
#' includes data from the Census, the Labour Force Survey, DWP benefit
#' statistics and other economic and demographic data from the Office for
#' National Statistics.
#'
#' The package provides functions to find what data is available, metadata,
#' including the variables and query options for different datasets and
#' a function for downloading data.
#'
#' The full API documentation and optional registration for an API key is
#' available at \url{https://www.nomisweb.co.uk/api/v01/help}.
#'
#' @docType package
#' @name nomisr
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble enframe
#' @importFrom httr http_type GET http_error status_code content
#' @importFrom readr read_csv col_double col_character
#' @importFrom dplyr bind_rows
#' @importFrom utils menu
#' @importFrom rsdmx readSDMX
#' @importFrom rlang list2
#' @importFrom snakecase to_snake_case to_any_case
#' @aliases NULL nomisr-package
NULL

# Checking for API key on package load
.onLoad <- function(libname, pkgname) {
  if (is.null(getOption("nomisr.API.key"))) {
    key <- Sys.getenv("NOMIS_API_KEY")
    if (key != "") options("nomisr.API.key" = key)
  }

  invisible()
}
