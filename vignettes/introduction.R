## ---- echo=TRUE----------------------------------------------------------
library(nomisr)
x <- nomis_data_info()
head(x)

## ---- echo=TRUE----------------------------------------------------------
y <- nomis_data_info("NM_893_1")

tibble::glimpse(y)

## ---- echo=TRUE----------------------------------------------------------
library(dplyr, warn.conflicts = F)

y$annotations.annotation %>% class()

y$annotations.annotation %>% length()

y$annotations.annotation[[1]] %>% class()

y %>% pull(annotations.annotation) %>% class()

y %>% pull(annotations.annotation) %>% .[[1]] %>% class()

y %>% pull(annotations.annotation) %>% purrr::pluck() %>% class()

## Unnesting list columns
y %>% tidyr::unnest(annotations.annotation) %>% glimpse()

## ---- echo=TRUE----------------------------------------------------------
a <- nomis_search(name = '*jobseekers*', keywords = 'Claimants')

tibble::glimpse(a)

a %>% tidyr::unnest(components.attribute) %>% glimpse()

b <- nomis_search(keywords = c('Claimants', '*Year*'))

tibble::glimpse(b)

b %>% tidyr::unnest(components.attribute) %>% glimpse()


## ---- echo=TRUE----------------------------------------------------------
q <- nomis_overview("NM_1650_1")

q %>% tidyr::unnest(name) %>% glimpse()


## ---- echo=TRUE----------------------------------------------------------
 s <- nomis_overview("NM_1650_1", select = c("units", "keywords"))
 
 s %>% tidyr::unnest(name) %>% glimpse()

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

print(z)

## ---- echo=TRUE----------------------------------------------------------
 x <- nomis_get_data(id = "NM_893_1", time = "latest", geography = c("1929380119", "1929380120"))
 
print(x)

