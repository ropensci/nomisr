library(nomisr)
context("nomis_data_info")


test_that("nomis_data_info return expected format", {
  skip_on_cran()

  x <- nomis_data_info()

  expect_length(x, 14)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))

  expect_error(
    nomis_data_info("lalala"),
    "Nomis API did not return data in required json format"
  )

  y <- nomis_data_info("NM_1658_1", tidy = TRUE)
  expect_length(y, 12)
  expect_type(y, "list")
  expect_true(tibble::is_tibble(y))
  expect_equal(nrow(y), 1)
  expect_equal(y$id, "NM_1658_1")
  expect_true(y$uri %in% x$uri)

})
