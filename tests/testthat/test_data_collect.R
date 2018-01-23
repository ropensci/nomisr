library(nomisr)
context("nomis_get_data")


test_that("nomis_get_data return expected format", {
  
  x <- nomis_get_data(id="NM_1_1", time="latest")
  
  expect_length(x, 34)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))
  
})