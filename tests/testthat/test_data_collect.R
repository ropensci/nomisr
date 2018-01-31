library(nomisr)
context("nomis_get_data")


test_that("nomis_get_data return expected format", {
  
  z <- nomis_get_data(id="NM_1_1", time="latest", geography="TYPE499",
                      measures=c(20100, 20201), sex=5)
  
  expect_length(z, 34)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))
  
  ## Test queries of over 25000 observatiosn
  a <- nomis_get_data(id="NM_893_1", time="latest", geography = "TYPE266")
  expect_length(a, 40)
  expect_type(a, "list")
  expect_true(tibble::is_tibble(a))
  
  expect_error(nomis_get_data()) # is this the best way to test errors?
  
})