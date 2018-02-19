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
  
  z <- nomis_search("Seekers")
  
  expect_length(z, 14)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))
  expect_equal(x[1],z[1])
  expect_equal(names(x),names(z))
  
  
})
