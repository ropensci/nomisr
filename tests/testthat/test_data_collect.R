library(nomisr)
context("nomis_get_data")


test_that("nomis_get_data return expected format", {
  
  z <- nomis_get_data(id="NM_1_1", time="latest", geography="TYPE499", measures=c(20100, 20201), sex=5)
  
  expect_length(x, 34)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))
  
})