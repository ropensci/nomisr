library(nomisr)
context("nomis_search")

test_that("nomis_search return expected format", {
  skip_on_cran()

  y <- nomis_search(keywords = "Claimants")
  expect_length(y, 14)
  expect_type(y, "list")
  expect_true(tibble::is_tibble(y))

  x <- nomis_search("*seekers*")
  expect_length(x, 14)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))

  z <- nomis_search("*Seekers*")
  expect_length(z, 14)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))
  expect_equal(x[1], z[1])
  expect_equal(names(x), names(z))

  a_description <- nomis_search(description = c("*actively*", "*seeking*"))
  expect_type(a_description, "list")
  expect_true(tibble::is_tibble(a_description))
  expect_length(a_description, 14)

  expect_error(nomis_search(content_type = "source"))

  b_content_type <- nomis_search(content_type = "sources-jsa")
  expect_type(b_content_type, "list")
  expect_true(tibble::is_tibble(b_content_type))
  expect_length(b_content_type, 14)

  c_units <- nomis_search(units = "*person*")
  expect_type(c_units, "list")
  expect_true(tibble::is_tibble(c_units))
  expect_length(c_units, 14)
})
