
#' Nomis API Key
#' 
#' @description The Nomis API has an optional key. Using the key means that 
#' 100,000 rows can be returned per call, which can speed up larger data 
#' requests and reduce the chances of being rate limited or having requests 
#' timing out.
#' 
#' @description You can sign up for an API key 
#' \href{https://www.nomisweb.co.uk/myaccount/userjoin.asp}{here}.
#' 
#' @param force If TRUE, resets the API key and requires a 
#' new key to be provided.
#'
#' @export
nomis_api_key <- function(force = FALSE) {
  
  env <- Sys.getenv('NOMIS_API_KEY')
  if (!identical(env, "") && !force) return(env)
  
  if (!interactive()) {
    stop("Please set environment variable NOMIS_API_KEY to your Nomis API key",
         call. = FALSE)
    message("Use `Sys.setenv(NOMIS_API_KEY = <key>)`")
  }
  
  message("Couldn't find environment variable NOMIS_API_KEY") 
  message("Please enter your API key and press enter:")
  key <- readline(": ")
  
  if (identical(key, "")) {
    Sys.unsetenv('NOMIS_API_KEY')
    stop("Nomis API key entry failed", call. = FALSE)
  }
  
  message("Updating NOMIS_API_KEY")
  Sys.setenv(NOMIS_API_KEY = key)
  
  key
  
}