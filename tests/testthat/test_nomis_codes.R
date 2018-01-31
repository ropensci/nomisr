library(nomisr)
context("nomis_codes")


test_that("nomis_codes return expected format", {

  expect_error(nomis_codes()) # is this the best way to test errors?
  
  a <- nomis_codes("NM_1_1")
   
  b <- nomis_codes("NM_1_1", "geography")
   
  c <- nomis_codes("NM_1_1", "geography", "TYPE")
  
  
})