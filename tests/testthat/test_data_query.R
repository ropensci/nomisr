library(nomisr)
context("nomis_data_info")


test_that("nomis_data_info return expected format", {
  
  x <- nomis_data_info()
  
  expect_length(x, 14)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))
  
})
