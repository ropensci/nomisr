
nomis_tidy <- function(df, tidy_style) {
  if (nrow(df) > 0) {
    names(df) <- tolower(names(df))

    if (tidy_style == "camelCase") {
      names(df) <- gsub("(^|[^[:alnum:]])([[:alnum:]])", "\\U\\2",
        names(df),
        perl = TRUE
      )

      substr(names(df), 1, 1) <- tolower(substr(names(df), 1, 1))
    } else if (tidy_style == "period.case") {
      names(df) <- gsub("_", "\\.", names(df), perl = TRUE)
    }
  }

  df
}
