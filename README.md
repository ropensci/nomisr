
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nomisr

[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/nomisr)](https://cran.r-project.org/package=nomisr)
[![GitHub
tag](https://img.shields.io/github/tag/evanodell/nomisr.svg)](https://github.com/evanodell/nomisr)
[![](https://cranlogs.r-pkg.org/badges/grand-total/nomisr)](https://dgrtwo.shinyapps.io/cranview/)
[![Travis-CI Build
Status](https://travis-ci.org/evanodell/nomisr.svg?branch=master)](https://travis-ci.org/evanodell/nomisr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/evanodell/nomisr?branch=master&svg=true)](https://ci.appveyor.com/project/evanodell/nomisr)
[![Coverage
Status](https://img.shields.io/codecov/c/github/evanodell/nomisr/master.svg)](https://codecov.io/github/evanodell/nomisr?branch=master)
[![DOI](https://zenodo.org/badge/118144805.svg)](https://zenodo.org/badge/latestdoi/118144805)

`nomisr` is for accessing [nomis](https://www.nomisweb.co.uk/) data with
R. nomis contains labour market statistics, including data on benefits,
and census data.

## Installation

You can install nomisr from github with:

``` r
# install.packages("devtools")
devtools::install_github("evanodell/nomisr")
```

## Using `nomisr`

The example below gets the latest data on Jobseeker’s Allowance with
rates and proportions, on a national level, with all male claimants and
workforce

``` r
 library(nomisr)
 z <- nomis_get_data(id="NM_1_1", time="latest", geography="TYPE499", measures=c(20100, 20201), sex=5)
```

There is a lot of data available through nomis, and there are some
limits to the amount of data that can be retrieved within a certain
period of time, although those are not published. For more details, see
the [full API documentation](https://www.nomisweb.co.uk/api/v01/help)
from nomis.
