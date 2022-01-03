library(nomisr)
context("nomis_overview")


test_that("nomis_overview return expected format", {
  skip_on_cran()

  q <- nomis_overview("NM_1650_1")
  expect_length(q, 2)
  expect_equal(nrow(q), 21)
  expect_true(tibble::is_tibble(q))

  s <- nomis_overview("NM_1650_1", select = c("Units", "Keywords"))
  expect_length(s, 2)
  expect_equal(nrow(s), 3)
  expect_true(tibble::is_tibble(s))

  expect_error(nomis_overview())
})
