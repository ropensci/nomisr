library(nomisr)
context("nomis_get_data")


test_that("nomis_get_data return expected format", {
  
  z <- nomis_get_data(id = "NM_1_1", time = "latest",
                      measures = c(20100, 20201), sex=5,
                      additional_queries = "&geography=TYPE499", 
                      exclude_missing = FALSE)
  
  expect_length(z, 34)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))
  expect_true(nrow(z)==z$RECORD_COUNT[1])
  
  ## Test queries of over 25000 observatiosn
  a <- nomis_get_data(id = "NM_893_1", date = "latest",
                      geography = "TYPE266", exclude_missing = TRUE)
  expect_length(a, 40)
  expect_type(a, "list")
  expect_true(tibble::is_tibble(a))
  
  expect_error(nomis_get_data()) # is this the best way to test errors?
  
  b <- nomis_get_data(id = "NM_168_1", time = "latest", 
                      geography = "2013265925", sex = "0")
  
  expect_true(nrow(b)==b$RECORD_COUNT[1])
  expect_length(b, 40)
  expect_type(b, "list")
  expect_true(tibble::is_tibble(b))
  expect_true(nrow(a)==a$RECORD_COUNT[1])
  
  c <- nomis_get_data(id = "NM_127_1", sex = "6", 
                      additional_queries = "&time=latest")
  expect_length(c, 28)
  expect_type(c, "list")
  expect_true(tibble::is_tibble(c))
  expect_true(nrow(c)==c$RECORD_COUNT[1])
  
})
