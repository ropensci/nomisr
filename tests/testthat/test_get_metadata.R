library(nomisr)
context("nomis_get_metadata")

test_that("nomis_get_metadata return expected format", {
  skip_on_cran()

  expect_error(nomis_get_metadata(), "The dataset ID must be specified.")

  a <- nomis_get_metadata("NM_1_1")
  expect_length(a, 3)
  expect_equal(nrow(a), 5)
  expect_true(tibble::is_tibble(a))

  b <- nomis_get_metadata("NM_1_1", "geography")
  expect_equal(nrow(b), 7)
  expect_true(tibble::is_tibble(b))

  c <- nomis_get_metadata("NM_1_1", "geography", "TYPE")
  expect_equal(nrow(c), 96)
  expect_true(tibble::is_tibble(c))

  d <- nomis_get_metadata(
    id = "NM_893_1", concept = "C_AHTHUK11", type = "1"
  )
  expect_equal(nrow(d), 1)
  expect_true(tibble::is_tibble(d))

  e <- nomis_get_metadata(
    "NM_1_1", "item",
    geography = 1879048226, sex = 5
  )
  expect_equal(nrow(e), 5)
  expect_true(tibble::is_tibble(e))

  f <- nomis_get_metadata("NM_1_1", "item", search = "*married*")
  expect_equal(nrow(f), 1)
  expect_true(tibble::is_tibble(f))
})
