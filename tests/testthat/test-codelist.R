context("test-codelist.R")

test_that("nomis_codelist is working", {
  
  codelist <- nomis_codelist("NM_1_1", "SEX")
  expect_length(codelist, 3)
  expect_type(codelist, "list")
  expect_true(tibble::is_tibble(codelist))
  expect_equal(nrow(codelist), 3)
  expect_equal(names(codelist), c("id","parentCode", "label.en"))
  
})
