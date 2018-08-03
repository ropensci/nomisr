context("test-codelist.R")

test_that("nomis_codelist is working", {
  skip_on_cran()

  codelist <- nomis_codelist("NM_1_1", "SEX")
  expect_type(codelist, "list")
  expect_true(tibble::is_tibble(codelist))
  expect_true(all(c("id", "parentCode", "label.en") %in% names(codelist)))
})
