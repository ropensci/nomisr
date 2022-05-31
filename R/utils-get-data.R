

# utility function used in `nomis_get_data`


nomis_get_data_util <- function(query) {
  api_get <- httr::GET(paste0(base_url, query))
  if (httr::http_error(api_get)) {
    paste0(
      "Nomis API request failed with status ",
      httr::status_code(api_get)
    )
    return(invisible(NULL))
  }

  df <- tryCatch(
    {
      if (packageVersion("readr") >= "2.1.2") {
        httr::content(api_get, encoding = 'UTF-8', show_col_types = FALSE)
      } else {
        httr::content(api_get)
      }
    },
    error = function(cond) {
      err <- conditionMessage(cond)
      if (startsWith(err, "Cannot read file")) {
        message(
          "It is likely you have included a parameter that is ",
          "not available to query in this dataset.\n\n",
          "Here's the original error message:\n", cond
        )
      } else {
        message(
          "It is likely that you have been automatically rate limited ",
          "by the Nomis API.\n",
          "You can make smaller data requests, or try again later.\n\n",
          "Here's the original error message:\n", cond
        )
      }
      return(NA)
    },
    warning = function(cond) {
      stop("The API request did not return any results. ",
        "Please check your parameters.",
        call. = FALSE
      )
    }
  )

  if ("OBS_VALUE" %in% names(df)) {
    df$OBS_VALUE <- as.double(df$OBS_VALUE)
  }
  df
}
