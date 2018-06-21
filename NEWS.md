
# nomisr 0.3.0.9000

## Bug fixes

* Dot queries to `nomis_get_data()` work with case-insensitive measurements 
more persistently. 


# nomisr 0.3.0

## New features and function changes

* New `nomis_codelist()` function, which returns the internal coding for 
different concepts used by the NOMIS API in a \code{tibble}, given a dataset 
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

