## ---- echo=TRUE----------------------------------------------------------
library(nomisr)
x <- nomis_data_info()
head(x)

## ---- echo=TRUE----------------------------------------------------------
library(dplyr, warn.conflicts = F)

y <- nomis_data_info("NM_893_1")
y$annotations.annotation %>% class()

y$annotations.annotation[[1]] %>% class()

y %>% pull(annotations.annotation) %>% class()

y %>% pull(annotations.annotation)%>% .[[1]] %>% class()

y %>% pull(annotations.annotation) %>% purrr::pluck(1) %>% class()

y %>% pull(annotations.annotation) %>% purrr::map(1) %>% class()

y %>% tidyr::unnest(annotations.annotation) %>% glimpse()

## ---- echo=TRUE----------------------------------------------------------
a <- nomis_search('*claimants*')

## ---- echo=TRUE----------------------------------------------------------
b <- nomis_search(keywords = 'Claimants')

## ---- echo=TRUE----------------------------------------------------------

  a <- nomis_get_metadata(id = "NM_893_1")

  print(a)

## ---- echo=TRUE----------------------------------------------------------
  b <- nomis_get_metadata(id = "NM_893_1", concept = "GEOGRAPHY")

  print(b)

## ---- echo=TRUE----------------------------------------------------------
  c <- nomis_get_metadata(id = "NM_893_1", concept = "geography", type = "type")

  print(c)

## ---- echo=TRUE----------------------------------------------------------
  d <- nomis_get_metadata(id = "NM_893_1", concept = "geography", type = "TYPE460")

  print(d)

## ---- echo=TRUE----------------------------------------------------------
 z <- nomis_get_data(id = "NM_893_1", time = "latest", geography = "TYPE266")

 tibble::glimpse(z)

## ---- echo=TRUE----------------------------------------------------------
 x <- nomis_get_data(id = "NM_893_1", time = "latest", geography = c("1929380119", "1929380120"))
 
tibble::glimpse(x)

