library(nomisr)
context("nomis_content_type")

test_that("nomis_content_type return expected format", {
  skip_on_cran()

  expect_error(nomis_content_type())

  content <- nomis_content_type("sources")
  expect_true(nrow(content) == 16)
  expect_length(content, 6)
  expect_type(content, "list")
  expect_true(tibble::is_tibble(content))


  content_id <- nomis_content_type("sources", "jsa")
  expect_true(nrow(content_id) == 1)
  expect_length(content_id, 4)
  expect_type(content_id, "list")
  expect_true(tibble::is_tibble(content_id))
})
