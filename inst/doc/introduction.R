## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
  library(nomisr) 
  x <- nomis_data_info()
  head(x)

## ------------------------------------------------------------------------
  y <- nomis_data_info("NM_893_1")
  tibble::glimpse(y)
  
  y$annotations.annotation
  
  y$components.attribute
  
  y$components.dimension

## ------------------------------------------------------------------------
  a <- nomis_codes(id = "NM_893_1", code = "geography", type = "type")
  a


## ------------------------------------------------------------------------
 z <- nomis_get_data(id = "NM_893_1", time = "latest", geography = "TYPE266")
 tibble::glimpse(z)

