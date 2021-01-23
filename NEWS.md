
# nomisr 0.4.4

* replaced `as.tibble` with `as_tibble`

* Includes second vignette "Work and Health Indicators with nomisr"

# nomisr 0.4.3

* Fix readme links

# nomisr 0.4.2

* Error handling improvements when using non-existent parameters, and clarifies
  error messages when no data is available for a given query.
  
* Removes redundant call to API (#19), thanks @Chrisjb

* New `tidy` parameter in `nomis_get_metadata()` to convert names to snake_case.

* Now using the `snakecase` package to implement name cleaning, 
  providing a broader range of naming styles.
  
* `nomis_get_metadata()` now makes existence of time concept explicit in the 
  tibble returned by `nomis_get_metadata({id})`.


# nomisr 0.4.1

* Adding `query_id` parameter to `nomis_get_data()`

* Changed documentation to use `roxygen` markdown

## Bug fixes

* Fixed bug where the `select` parameter in `nomis_get_data()` didn't work if 
  "OBS_VALUE" was not one of the variables. (@JimShady, #12)


# nomisr 0.4.0

* Version bump for CRAN

* Citation now refers to JOSS paper

* Some minor changes to internal code for easier maintenance

* Documentation updates to clarify difference between `time` and `date` 
parameters in `nomis_get_data()`


# nomisr 0.3.2 (non-CRAN release)

## New features and function changes

* The `tidy` parameter in `nomis_get_data()` now defaults to `FALSE` in order
to preserve existing workflows.

# nomisr 0.3.1 (non-CRAN release)

## New features and function changes

* `nomis_get_data()` now includes `tidy` and `tidy_style` parameters. 
`nomis_get_data()` now defaults to converting all variable names to 
"snake_case". `tidy_style` also accepts "camelCase" and "period.case" as name
style options.

## Bug fixes

* Dot queries to `nomis_get_data()` work with case-insensitive measurements 
more persistently. 

## Other updates

* Clarification of need to specified as `NULL` unused named parameters in
`nomis_get_data()` when using similarly named parameters in `...`.

# nomisr 0.3.0

## New features and function changes

* New `nomis_codelist()` function, which returns the internal coding for 
different concepts used by the NOMIS API in a `tibble`, given a dataset 
ID and a concept name. 

* The `additional_queries` parameter in `nomis_get_data()` and 
`nomis_get_metadata()` has been deprecated and will eventually be removed. 
Please use the `...` parameter for queries including concepts not available 
through the default parameters.

* The `sex` parameter in `nomis_get_data()` will also work with datasets that 
use "gender" instead of "sex".

## Internal changes and bug fixes

* Uses `rsdmx` to parse metadata, fixing #7.

# nomisr 0.2.0

* Improved API key handling (#5)

* Increased test coverage

* Adding rOpenSci reviewers to DESCRIPTION file.


# nomisr 0.1.0

* Moved to rOpenSci github repository

* Added API key functionality, which is not required by the API but is 
useful for large requests.

* In interactive sessions, users are asked if they want to continue when 
calling more than 15 pages of data at a time.

# nomisr 0.0.2

* Introduction of additional parameters to the `nomis_get_data()` and 
`nomis_codes()` functions, improvements to documentation.

# nomisr 0.0.1

* 1st release. Rudimentary functions for retrieving information on available 
datasets and downloading datasets from nomis, with some limited parameters.

