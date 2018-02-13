library(nomisr)
context("nomis_codes")


test_that("nomis_codes return expected format", {

  expect_error(nomis_codes()) # is this the best way to test errors?
  
  a <- nomis_codes("NM_1_1")
  expect_length(a, 3)
  expect_equal(nrow(a),5)
  expect_true(tibble::is_tibble(a))
  
  b <- nomis_codes("NM_1_1", "geography")
  expect_length(b, 2)
  expect_equal(nrow(b),7)
  expect_true(tibble::is_tibble(b))
  
  
  c <- nomis_codes("NM_1_1", "geography", "TYPE")
  expect_length(c, 2)
  expect_equal(nrow(c),91)
  expect_true(tibble::is_tibble(c))  
  
})
