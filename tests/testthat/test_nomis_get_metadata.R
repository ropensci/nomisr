library(nomisr)
context("nomis_get_metadata")


test_that("nomis_get_metadata return expected format", {
  expect_error(nomis_get_metadata()) # is this the best way to test errors?

  a <- nomis_get_metadata("NM_1_1")
  expect_length(a, 3)
  expect_equal(nrow(a), 5)
  expect_true(tibble::is_tibble(a))

  b <- nomis_get_metadata("NM_1_1", "geography")
  expect_length(b, 2)
  expect_equal(nrow(b), 7)
  expect_true(tibble::is_tibble(b))


  c <- nomis_get_metadata("NM_1_1", "geography", "TYPE")
  expect_length(c, 2)
  expect_equal(nrow(c), 96)
  expect_true(tibble::is_tibble(c))
  
  d <- nomis_get_metadata(id = "NM_893_1", concept = "C_AHTHUK11",
                          type = "type")
  expect_length(d, 6)
  expect_equal(nrow(d), 1)
  expect_true(tibble::is_tibble(d))
  
})
