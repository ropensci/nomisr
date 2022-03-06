
#' Retrieve Nomis datasets
#'
#'
#' @description To find the code options for a given dataset, use
#' [nomis_get_metadata()] for specific codes, and
#' [nomis_codelist()] for code values.
#'
#' @description This can be a slow process if querying significant amounts of
#' data. Guest users are limited to 25,000 rows per query, although
#' `nomisr` identifies queries that will return more than 25,000 rows,
#' sending individual queries and combining the results of those queries into
#' a single tibble. In interactive sessions, `nomisr` will warn you if
#' guest users are requesting more than 350,000 rows of data, and if
#' registered users are requesting more than 1,500,000 rows.
#'
#' @description Note the difference between the `time` and `date`
#' parameters. The `time` and `date` parameters should not be used at the same
#' time. If they are, the function will retrieve data based on the the
#' `date` parameter. If given more than one query, `time` will
#' return all data available between those queries, inclusively, while
#' `date` will only return data for the exact queries specified. So
#' `time = c("first", "latest")` will return all data, while
#' `date = c("first", "latest")` will return only the earliest and latest
#' data published.
#'
#' @param id A string containing the ID of the dataset to retrieve,
#' in `"nm_***_*"` format. The `id` parameter is not case sensitive.
#'
#' @param time Parameter for selecting dates and date ranges. Accepts either a
#' single date value, or two date values and returns all data between the two
#' date values, There are two styles of values that can be used to query time.
#'
#' The first is one or two of `"latest"` (returns the latest available
#' data), `"previous"` (the date prior to `"latest"`), `"prevyear"`
#' (the date one year prior to `"latest"`) or `"first"`
#' (the oldest available data for the dataset).
#'
#' The second style is to use or a specific date or multiple dates, in the
#' style of the time variable codelist, which can be found using the
#' [nomis_get_metadata()] function.
#'
#' Values for the `time` and `date` parameters should not be used
#' at the same time. If they are, the function will retrieve data based
#' on the the `date` parameter.
#'
#' Defaults to `NULL`.
#'
#' @param date Parameter for selecting specific dates. Accepts one or more date
#' values. If given multiple values, only data for the given dates will be
#' returned, but there is no limit to the number of data values. For example,
#' `date=c("latest, latestMINUS3, latestMINUS6")` will return the latest
#' data, data from three months prior to the latest data and six months prior
#' to the latest data. There are two styles of values that can be used to
#' query time.
#'
#' The first is one or more of `"latest"` (returns the latest available
#' data), `"previous"` (the date prior to `"latest"`),
#' `"prevyear"` (the date one year prior to `"latest"`) or
#' `"first"` (the oldest available data for the dataset).
#'
#' The second style is to use or a specific date or multiple dates, in the
#' style of the time variable codelist, which can be found using the
#' [nomis_get_metadata()] function.
#'
#' Values for the `time` and `date` parameters should not be used at
#' the same time. If they are, the function will retrieve data based on the
#' the `date` parameter.
#'
#' Defaults to `NULL`.
#'
#' @param geography The code of the geographic area to return data for. If
#' `NULL`, returns data for all available geographic areas, subject to
#' other parameters. Defaults to `NULL`. In the rare instance that a
#' geographic variable does not exist, if not `NULL`, the function
#' will return an error.
#'
#' @param measures The code for the statistical measure(s) to include in the
#' data. Accepts a single string or number, or a list of strings or numbers.
#' If `NULL`, returns data for all available statistical measures subject
#' to other parameters. Defaults to `NULL`.
#'
#' @param sex The code for sexes/genders to include in the dataset.
#' Accepts a string or number, or a vector of strings or numbers.
#' `nomisr` automatically voids any queries for sex if it is not an
#' available code in the requested dataset. Defaults to `NULL` and returns
#' all available sex/gender data.
#'
#' There are two different codings used for sex, depending on the dataset. For
#' datasets using `"SEX"`, `7` will return results for males and females, `6`
#' only females and `5` only males. Defaults to `NULL`, equivalent to
#' `c(5,6,7)` for datasets where sex is an option. For datasets using
#' `"C_SEX"`, `0` will return results for males and females, `1` only males
#' and `2` only females. Some datasets use `"GENDER"` with the same values
#' as `"SEX"`, which works with both `sex = <code>` and `gender = <code>`
#' as a dot parameter.
#'
#' @param additional_queries Any other additional queries to pass to the API.
#' See \url{https://www.nomisweb.co.uk/api/v01/help} for instructions on
#' query structure. Defaults to `NULL`. Deprecated in package versions greater
#' than 0.2.0 and will eventually be removed in a future version.
#'
#' @param exclude_missing If `TRUE`, excludes all missing values.
#' Defaults to `FALSE`.
#'
#' @param select A character vector of one or more variables to include in
#' the returned data, excluding all others. `select` is not case sensitive.
#'
#' @param tidy Logical parameter. If `TRUE`, converts variable names to
#' `snake_case`, or another style as specified by the
#' `tidy_style` parameter. Defaults to `FALSE`. The default variable name style
#' from the API is SCREAMING_SNAKE_CASE.
#'
#' @param tidy_style The style to convert variable names to, if
#' `tidy = TRUE`. Accepts one of `"snake_case"`, `"camelCase"`
#' and `"period.case"`, or any of the `case` options accepted by
#'  [snakecase::to_any_case()]. Defaults to `"snake_case"`.
#'
#' @param query_id Results can be labelled as belonging to a certain query
#' made to the API. `query_id` accepts any value as a string, and will
#' be included in every row of the tibble returned by `nomis_get_data`
#' in a column labelled "QUERY_ID" in the default SCREAMING_SNAKE_CASE
#' used by the API. Defaults to `NULL`.
#'
#' @param ... Use to pass any other parameters to the API. Useful for passing
#' concepts that are not available through the default parameters. Only accepts
#' concepts identified in [nomis_get_metadata()] and concept values
#' identified in [nomis_codelist()]. Parameters can be quoted or
#' unquoted. Each parameter should have a name and a value. For example,
#' `CAUSE_OF_DEATH = 10300` when querying dataset `"NM_161_1"`.
#' Parameters are not case sensitive. Note that R using partial matching for
#' function variables, and so passing a parameter with the same opening
#' characters as one of the above-named parameters can cause an error unless
#' the value of the named parameter is specified, including as `NULL`.
#' See example below:
#'
#' @return A tibble containing the selected dataset. By default, all tibble
#' columns except for the `"OBS_VALUE"` column are parsed as characters.
#' @export
#' @seealso [nomis_data_info()]
#' @seealso [nomis_get_metadata()]
#' @seealso [nomis_codelist()]
#' @seealso [nomis_overview()]
#' @examples
#' \donttest{
#'
#' # Return data on Jobseekers Allowance for each country in the UK
#' jobseekers_country <- nomis_get_data(
#'   id = "NM_1_1", time = "latest",
#'   geography = "TYPE499",
#'   measures = c(20100, 20201), sex = 5
#' )
#'
#' # Return data on Jobseekers Allowance for Wigan
#' jobseekers_wigan <- nomis_get_data(
#'   id = "NM_1_1", time = "latest",
#'   geography = "1879048226",
#'   measures = c(20100, 20201), sex = "5"
#' )
#'
#' # annual population survey - regional - employment by occupation
#' emp_by_occupation <- nomis_get_data(
#'   id = "NM_168_1", time = "latest",
#'   geography = "2013265925", sex = "0",
#'   select = c(
#'     "geography_code",
#'     "C_OCCPUK11H_0_NAME", "obs_vAlUE"
#'   )
#' )
#'
#' # Deaths in 2016 and 2015 by three specified causes,
#' # identified with nomis_get_metadata()
#' death <- nomis_get_data("NM_161_1",
#'   date = c("2016", "2015"),
#'   geography = "TYPE480",
#'   cause_of_death = c(10300, 102088, 270)
#' )
#'
#' # All causes of death in London in 2016
#' london_death <- nomis_get_data("NM_161_1",
#'   date = c("2016"),
#'   geography = "2013265927", sex = 1, age = 0
#' )
#' }
#' \dontrun{
#' # Results in an error because `measure` is mistaken for `measures`
#' mort_data1 <- nomis_get_data(
#'   id = "NM_161_1", date = "2016",
#'   geography = "TYPE464", sex = 0, cause_of_death = "10381",
#'   age = 0, measure = 6
#' )
#'
#' # Does not error because `measures` is specified
#' mort_data2 <- nomis_get_data(
#'   id = "NM_161_1", date = "2016",
#'   geography = "TYPE464", sex = 0, measures = NULL,
#'   cause_of_death = "10381", age = 0, measure = 6
#' )
#' }
#'
nomis_get_data <- function(id, time = NULL, date = NULL, geography = NULL,
                           sex = NULL, measures = NULL,
                           additional_queries = NULL, exclude_missing = FALSE,
                           select = NULL, tidy = FALSE,
                           tidy_style = "snake_case", query_id = NULL, ...) {
  if (missing(id)) {
    stop("Dataset ID must be specified", call. = FALSE)
  }

  # check for use or time or data parameter
  if (is.null(date) == FALSE) {
    time_query <- paste0("&date=", paste0(date, collapse = ","))
  } else if (is.null(time) == FALSE) {
    time_query <- paste0("&time=", paste0(time, collapse = ","))
  } else {
    time_query <- ""
  }

  geography_query <- ifelse(!is.null(geography),
    paste0(
      "&geography=",
      paste0(geography, collapse = ",")
    ),
    ""
  )

  if (length(additional_queries) > 0) {
    additional_query <- additional_queries

    message("The `additional_query` parameter is
            deprecated, please use ... instead")
  } else {
    additional_query <- NULL
  }

  # Check for sex queries and return either sex or c_sex or gender
  if (length(sex) > 0) {
    sex_lookup <- nomis_data_info(id)$components.dimension[[1]]$conceptref

    if ("C_SEX" %in% sex_lookup) {
      sex_query <- paste0("&c_sex=", paste0(sex, collapse = ","))
    } else if ("SEX" %in% sex_lookup) {
      sex_query <- paste0("&sex=", paste0(sex, collapse = ","))
    } else if ("GENDER" %in% sex_lookup) {
      sex_query <- paste0("&gender=", paste0(sex, collapse = ","))
    } else {
      sex_query <- ""
    }
  } else {
    sex_query <- ""
  }

  exclude_query <- ifelse(exclude_missing == TRUE,
    "&ExcludeMissingValues=true",
    ""
  )

  select_query <- ifelse(!is.null(select),
    paste0(
      "&select=",
      paste0(
        unique(c(toupper(select), "RECORD_COUNT")),
        collapse = ","
      )
    ),
    ""
  )

  measures_query <- ifelse(!is.null(measures),
    paste0(
      "&MEASURES=",
      paste0(measures, collapse = ",")
    ),
    ""
  )

  query_id <- ifelse(!is.null(query_id), paste0("&queryid=", query_id), "")

  dots <- rlang::list2(...) ## eval the dots
  names(dots) <- toupper(names(dots))
  dots_vector <- c()

  for (i in seq_along(dots)) { # retrieve the dots
    dots_vector[i] <- ifelse(length(dots[[i]]) > 0,
      paste0(
        "&", toupper(names(dots[i])), "=",
        paste0(dots[[i]], collapse = ",")
      ),
      ""
    )
  }

  dots_query <- paste0(dots_vector, collapse = "")

  if (!is.null(getOption("nomisr.API.key"))) {
    api_query <- paste0("&uid=", getOption("nomisr.API.key"))
    max_length <- 1000000
  } else {
    api_query <- ""
    max_length <- 25000
  }

  query <- paste0(
    id, ".data.csv?", dots_query, time_query, geography_query, sex_query,
    exclude_query, select_query, api_query, additional_query, measures_query,
    query_id
  )

  first_df <- nomis_get_data_util(query)

  names(first_df) <- toupper(names(first_df))

  if (as.numeric(first_df$RECORD_COUNT)[1] >= max_length) {
    # if amount available is over the limit of 15 total calls at a time
    # downloads the extra data and binds it all together in a tibble

    if (interactive() &&
      as.numeric(first_df$RECORD_COUNT)[1] >= (15 * max_length)) {
      # For more than 15 total requests at one time.
      message(
        "Warning: You are trying to acess more than ",
        paste0((15 * max_length)), " rows of data."
      )
      message("This may cause timeout and/or automatic rate limiting.")

      if (menu(c("Yes", "No"),
        title = "Do you want to continue?"
      ) == 2) {
        stop(call. = FALSE)
      }
    }

    record_count <- first_df$RECORD_COUNT[1]

    seq_list <- seq(from = max_length, to = record_count, by = max_length)

    pages <- list()

    for (i in seq_along(seq_list)) {
      query2 <- paste0(
        query, "&recordOffset=",
        format(seq_list[i], scientific = FALSE)
      )
      # R can paste large numbers as scientific notation, which causes an error
      # format(seq_list[i], scientific = FALSE)) prevents that

      message("Retrieving additional pages ", i, " of ", length(seq_list))

      pages[[i]] <- nomis_get_data_util(query2)
    }

    df <- tibble::as_tibble(dplyr::bind_rows(first_df, pages))
  } else {
    df <- first_df
  }

  if (!is.null(select) & !("RECORD_COUNT" %in% toupper(select))) {
    df$RECORD_COUNT <- NULL
  }

  if (tidy == TRUE) {
    df <- nomis_tidy(df, tidy_style)
  }

  df
}
