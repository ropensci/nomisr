
#' API Key
#' @param force 
#'
#' @export
nomis_api_key <- function(force = FALSE) {
  
  env <- Sys.getenv('NOMIS_API_KEY')
  if (!identical(env, "") && !force) return(env)
  
  if (!interactive()) {
    stop("Please set environment variable NOMIS_API_KEY to your Nomis API key",
         call. = FALSE)
  }
  
  message("Couldn't find environment variable NOMIS_API_KEY") 
  message("See ?nomis_api_key for more details.")
  message("Please enter your API key and press enter:")
  key <- readline(": ")
  
  if (identical(key, "")) {
    stop("Nomis API key entry failed", call. = FALSE)
  }
  
  message("Updating NOMIS_API_KEY")
  Sys.setenv(NOMIS_API_KEY = key)
  
  key
  
}