
#' Nomis API Key
#'
#' @description Assign or reassign API key for Nomis.
#'
#' @details The Nomis API has an optional key. Using the key means that 100,000
#'   rows can be returned per call, which can speed up larger data requests and
#'   reduce the chances of being rate limited or having requests timing out.
#'
#' @details By default, `nomisr` will look for the environment variable
#'   `NOMIS_API_KEY` when the package is loaded. If found, the API key will
#'   be stored in the session option `nomisr.API.key`. If you would like to
#'   reload the API key or would like to manually enter one in, this function
#'   may be used.
#'
#' @details You can sign up for an API key 
#' [here](https://www.nomisweb.co.uk/myaccount/userjoin.asp).
#'
#' @param check_env If TRUE, will check the environment variable
#'   `NOMIS_API_KEY` first before asking for user input.
#'
#' @export
nomis_api_key <- function(check_env = FALSE) {
  if (check_env) {
    key <- Sys.getenv("NOMIS_API_KEY")
    if (key != "") {
      message("Updating NOMIS_API_KEY environment variable...")
      options("nomisr.API.key" = key)
      return(invisible())
    } else {
      warning("Couldn't find environment variable 'NOMIS_API_KEY'")
    }
  }

  if (interactive()) {
    key <- readline("Please enter your API key and press enter: ")
  } else {
    cat("Please enter your API key and press enter: ")
    key <- readLines(con = "stdin", n = 1)
  }

  if (identical(key, "")) {
    stop("Nomis API key entry failed", call. = FALSE)
  }

  message("Updating NOMIS_API_KEY environment variable...")
  options("nomisr.API.key" = key)
  invisible()
}
