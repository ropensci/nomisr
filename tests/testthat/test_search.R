library(nomisr)
context("nomis_search")

test_that("nomis_search return expected format", {
  
  y <- nomis_search("Claimants", keywords = TRUE)
  
  expect_length(y, 14)
  expect_type(y, "list")
  expect_true(tibble::is_tibble(y))
  
  x <- nomis_search("seekers")
  
  expect_length(x, 14)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))
  
})