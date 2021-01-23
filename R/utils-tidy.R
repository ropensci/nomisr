
nomis_tidy <- function(df, tidy_style) {
  if (nrow(df) > 0) {
    names(df) <- tolower(names(df)) # NOMIS defaults to screaming snake case

    if (tidy_style == "snake_case") {
      case <- "snake"
    } else if (tidy_style == "camelCase") {
      case <- "small_camel"
    } else if (tidy_style == "period.case") {
      case <- "snake"
    } else {
      case <- tidy_style
    }
    names(df) <- snakecase::to_any_case(names(df), case)
    if (tidy_style == "period.case") {
      names(df) <- gsub("_", "\\.", names(df), perl = TRUE)
    }
  }
  df
}
