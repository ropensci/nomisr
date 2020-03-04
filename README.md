
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nomisr

[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/nomisr)](https://cran.r-project.org/package=nomisr)
[![GitHub
tag](https://img.shields.io/github/tag/ropensci/nomisr.svg)](https://github.com/ropensci/nomisr)
[![](https://cranlogs.r-pkg.org/badges/grand-total/nomisr)](https://cran.r-project.org/package=nomisr)
[![Travis-CI Build
Status](https://travis-ci.org/ropensci/nomisr.svg?branch=master)](https://travis-ci.org/ropensci/nomisr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/evanodell/nomisr?branch=master&svg=true)](https://ci.appveyor.com/project/evanodell/nomisr)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ropensci/nomisr/master.svg)](https://codecov.io/github/ropensci/nomisr?branch=master)
[![ropensci](https://badges.ropensci.org/190_status.svg)](https://github.com/ropensci/onboarding/issues/190)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1157908.svg)](https://doi.org/10.5281/zenodo.1157908)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.00859/status.svg)](https://doi.org/10.21105/joss.00859)

`nomisr` is for accessing UK official statistics from the
[Nomis](https://www.nomisweb.co.uk/) database through R. Nomis contains
data from the Census, the Labour Force Survey, DWP benefit statistics
and other economic and demographic data, and is maintained on behalf of
the Office for National Statistics by the University of Durham.

The `nomisr` package provides functions to find what data is available,
the variables and query options for different datasets and a function
for downloading data. `nomisr` returns data in
[`tibble`](https://cran.r-project.org/package=tibble) format. Most of
the data available through `nomisr` is based around statistical
geographies, with a handful of exceptions.

The package is for demographers, economists, geographers, public health
researchers and any other researchers who are interested in geographic
factors. The package aims to aid reproducibility, reduce the need to
manually download area profiles, and allow easy linking of different
datasets covering the same geographic area.

## Installation

`nomisr` is available on CRAN:

``` r
install.packages("nomisr")
```

You can install the development version `nomisr` from github with:

``` r
# install.packages("devtools")
devtools::install_github("ropensci/nomisr")
```

## Using `nomisr`

`nomisr` contains functions to search for datasets, identify the query
options for different datasets and retrieve data from queries, all done
with [`tibbles`](https://tibble.tidyverse.org/), to take advantage of
how `tibble` manages list-columns. The use of metadata queries, rather
than simply downloading all available data, is useful to avoid
overwhelming the rate limits of the API. For full details on all
available functions and demonstrations of their use, please see the
package
[vignette](https://docs.evanodell.com/nomisr/articles/introduction.html).

The example below demostrates a workflow to retrieve the latest data on
Jobseeker’s Allowance with rates and proportions, on a national level,
with all male claimants and workforce.

``` r
 library(nomisr)
 jobseekers_search <- nomis_search(name = "*Jobseeker*")
 
 tibble::glimpse(jobseekers_search)
#> Observations: 17
#> Variables: 14
#> $ agencyid                             <chr> "NOMIS", "NOMIS", "NOMIS", "NOMI…
#> $ id                                   <chr> "NM_1_1", "NM_4_1", "NM_8_1", "N…
#> $ uri                                  <chr> "Nm-1d1", "Nm-4d1", "Nm-8d1", "N…
#> $ version                              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ annotations.annotation               <list> [<data.frame[10 x 2]>, <data.fr…
#> $ components.attribute                 <list> [<data.frame[7 x 4]>, <data.fra…
#> $ components.dimension                 <list> [<data.frame[5 x 3]>, <data.fra…
#> $ components.primarymeasure.conceptref <chr> "OBS_VALUE", "OBS_VALUE", "OBS_V…
#> $ components.timedimension.codelist    <chr> "CL_1_1_TIME", "CL_4_1_TIME", "C…
#> $ components.timedimension.conceptref  <chr> "TIME", "TIME", "TIME", "TIME", …
#> $ description.value                    <chr> "Records the number of people cl…
#> $ description.lang                     <chr> "en", "en", NA, "en", "en", "en"…
#> $ name.value                           <chr> "Jobseeker's Allowance with rate…
#> $ name.lang                            <chr> "en", "en", "en", "en", "en", "e…

 jobseekers_measures <- nomis_get_metadata("NM_1_1", "measures")
 
 tibble::glimpse(jobseekers_measures)
#> Observations: 4
#> Variables: 3
#> $ id             <chr> "20100", "20201", "20202", "20203"
#> $ label.en       <chr> "claimants", "workforce", "active", "residence"
#> $ description.en <chr> "claimants", "workforce", "active", "residence"
 
 jobseekers_geography <- nomis_get_metadata("NM_1_1", "geography", "TYPE")
 
 tail(jobseekers_geography)
#> # A tibble: 6 x 3
#>   id      label.en                          description.en                      
#>   <chr>   <chr>                             <chr>                               
#> 1 TYPE490 government office regions tec / … government office regions tec / lec…
#> 2 TYPE491 government office regions (forme… government office regions (former i…
#> 3 TYPE492 standard statistical regions      standard statistical regions        
#> 4 TYPE496 pre-1996 local authority distric… pre-1996 local authority districts  
#> 5 TYPE498 pre-1996 counties / scottish reg… pre-1996 counties / scottish regions
#> 6 TYPE499 countries                         countries
 
 jobseekers_sex <- nomis_get_metadata("NM_1_1", "sex", "TYPE")
 
 tibble::glimpse(jobseekers_sex)
#> Observations: 3
#> Variables: 4
#> $ id             <chr> "5", "6", "7"
#> $ parentCode     <chr> "7", "7", NA
#> $ label.en       <chr> "Male", "Female", "Total"
#> $ description.en <chr> "Male", "Female", "Total"
 
 z <- nomis_get_data(id = "NM_1_1", time = "latest", geography = "TYPE499",
                     measures=c(20100, 20201), sex=5)
#> Parsed with column specification:
#> cols(
#>   .default = col_double(),
#>   DATE = col_character(),
#>   DATE_NAME = col_character(),
#>   DATE_CODE = col_character(),
#>   DATE_TYPE = col_character(),
#>   GEOGRAPHY_NAME = col_character(),
#>   GEOGRAPHY_CODE = col_character(),
#>   GEOGRAPHY_TYPE = col_character(),
#>   SEX_NAME = col_character(),
#>   SEX_TYPE = col_character(),
#>   ITEM_NAME = col_character(),
#>   ITEM_TYPE = col_character(),
#>   MEASURES_NAME = col_character(),
#>   OBS_STATUS = col_character(),
#>   OBS_STATUS_NAME = col_character(),
#>   OBS_CONF = col_logical(),
#>   OBS_CONF_NAME = col_character(),
#>   URN = col_character()
#> )
#> See spec(...) for full column specifications.
 
 tibble::glimpse(z)
#> Observations: 70
#> Variables: 34
#> $ DATE                <chr> "2020-01", "2020-01", "2020-01", "2020-01", "2020…
#> $ DATE_NAME           <chr> "January 2020", "January 2020", "January 2020", "…
#> $ DATE_CODE           <chr> "2020-01", "2020-01", "2020-01", "2020-01", "2020…
#> $ DATE_TYPE           <chr> "date", "date", "date", "date", "date", "date", "…
#> $ DATE_TYPECODE       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ DATE_SORTORDER      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ GEOGRAPHY           <dbl> 2092957697, 2092957697, 2092957697, 2092957697, 2…
#> $ GEOGRAPHY_NAME      <chr> "United Kingdom", "United Kingdom", "United Kingd…
#> $ GEOGRAPHY_CODE      <chr> "K02000001", "K02000001", "K02000001", "K02000001…
#> $ GEOGRAPHY_TYPE      <chr> "countries", "countries", "countries", "countries…
#> $ GEOGRAPHY_TYPECODE  <dbl> 499, 499, 499, 499, 499, 499, 499, 499, 499, 499,…
#> $ GEOGRAPHY_SORTORDER <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1…
#> $ SEX                 <dbl> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5…
#> $ SEX_NAME            <chr> "Male", "Male", "Male", "Male", "Male", "Male", "…
#> $ SEX_CODE            <dbl> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5…
#> $ SEX_TYPE            <chr> "sex", "sex", "sex", "sex", "sex", "sex", "sex", …
#> $ SEX_TYPECODE        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ SEX_SORTORDER       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ ITEM                <dbl> 1, 1, 2, 2, 3, 3, 4, 4, 9, 9, 1, 1, 2, 2, 3, 3, 4…
#> $ ITEM_NAME           <chr> "Total claimants", "Total claimants", "Students o…
#> $ ITEM_CODE           <dbl> 1, 1, 2, 2, 3, 3, 4, 4, 9, 9, 1, 1, 2, 2, 3, 3, 4…
#> $ ITEM_TYPE           <chr> "item", "item", "item", "item", "item", "item", "…
#> $ ITEM_TYPECODE       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ ITEM_SORTORDER      <dbl> 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 0, 0, 1, 1, 2, 2, 3…
#> $ MEASURES            <dbl> 20100, 20201, 20100, 20201, 20100, 20201, 20100, …
#> $ MEASURES_NAME       <chr> "Persons claiming JSA", "Workplace-based estimate…
#> $ OBS_VALUE           <dbl> 105592.0, 0.6, NA, NA, NA, NA, NA, NA, NA, NA, 98…
#> $ OBS_STATUS          <chr> "A", "A", "Q", "Q", "Q", "Q", "Q", "Q", "Q", "Q",…
#> $ OBS_STATUS_NAME     <chr> "Normal Value", "Normal Value", "These figures ar…
#> $ OBS_CONF            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, …
#> $ OBS_CONF_NAME       <chr> "Free (free for publication)", "Free (free for pu…
#> $ URN                 <chr> "Nm-1d1d32321e0d2092957697d5d1d20100", "Nm-1d1d32…
#> $ RECORD_OFFSET       <dbl> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,…
#> $ RECORD_COUNT        <dbl> 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 7…
```

There is a lot of data available through Nomis, and there are some
limits to the amount of data that can be retrieved within a certain
period of time, although those are not published. For more details, see
the [full API documentation](https://www.nomisweb.co.uk/api/v01/help)
from Nomis. Full package documentation is available at
[docs.evanodell.com/nomisr](https://docs.evanodell.com/nomisr)

## Meta

Bug reports, suggestions, and code contributions are all welcome. Please
see
[CONTRIBUTING.md](https://github.com/ropensci/nomisr/blob/master/CONTRIBUTING.md)
for details.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/ropensci/nomisr/blob/master/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

Please note that this project is not affiliated with the Office for
National Statistics or the University of Durham (who run Nomis on behalf
o the Office for National Statistics).

Please use the reference below when citing `nomisr`, which is the same
as `citation(package = 'nomisr')`.

Odell, (2018). nomisr: Access ‘Nomis’ UK Labour Market Data. *Journal of
Open Source Software*, 3(27), 859,
<https://doi.org/10.21105/joss.00859>.

A BibTeX entry for LaTeX users is

    @article{odell2018,
      title = {Nomisr: {{Access Nomis UK Labour Market Data}}},
      volume = {3},
      issn = {2475-9066},
      url = {https://github.com/ropensci/nomisr},
      doi = {10.21105/joss.00859},
      number = {27},
      journaltitle = {Journal of Open Source Software},
      urldate = {2018-08-01},
      date = {2018-07-28},
      pages = {859},
      author = {Odell, Evan}
    }

License:
[MIT](https://github.com/ropensci/nomisr/blob/master/LICENSE.md)

[![ropensci\_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)
