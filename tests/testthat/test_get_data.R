library(nomisr)
context("nomis_get_data")

test_that("nomis_get_data return expected format", {
  skip_on_cran()

  z <- nomis_get_data(
    id = "NM_1_1", time = "latest",
    measures = c(20100, 20201), sex = 5,
    additional_queries = "&geography=TYPE499",
    exclude_missing = TRUE
  )
  expect_length(z, 34)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))

  ## Test queries of over 25000 observatiosn
  a <- nomis_get_data(
    id = "NM_893_1", date = "latest",
    geography = "TYPE266", exclude_missing = FALSE
  )
  expect_length(a, 40)
  expect_type(a, "list")
  expect_true(tibble::is_tibble(a))
  expect_equal(
    as.numeric(a$RECORD_OFFSET[[nrow(a)]]) + 1,
    as.numeric(a$RECORD_COUNT[[nrow(a)]])
  )
  sum_check <- summary(diff(as.numeric(a$RECORD_OFFSET)))
  expect_equal(sum_check[[1]], 1)

  expect_error(nomis_get_data(), "Dataset ID must be specified")

  b <- nomis_get_data(
    id = "NM_168_1", time = "latest",
    geography = "2013265925", sex = "0"
  )

  expect_true(nrow(b) == b$RECORD_COUNT[1])
  expect_length(b, 40)
  expect_type(b, "list")
  expect_true(tibble::is_tibble(b))
  expect_true(nrow(a) == a$RECORD_COUNT[1])

  c <- nomis_get_data(
    id = "NM_127_1", sex = "6",
    additional_queries = "&time=latest"
  )
  expect_length(c, 28)
  expect_type(c, "list")
  expect_true(tibble::is_tibble(c))
  expect_true(nrow(c) == c$RECORD_COUNT[1])

  expect_error(nomis_get_data(
    id = "NM_1_1", time = "latest",
    measures = c(20100, 20201), sex = 0,
    additional_queries = "&geography=TYPE499",
    exclude_missing = FALSE
  ))

  x_select <- nomis_get_data(
    id = "NM_168_1", time = "latest",
    geography = "2013265925", sex = "0",
    select = c(
      "geography_code", "C_OCCPUK11H_0_NAME",
      "obs_vAlUE"
    )
  )
  expect_length(x_select, 3)
  expect_type(x_select, "list")
  expect_true(tibble::is_tibble(x_select))

  # x_many <- nomis_get_data( id = "NM_1_1")
  #   expect_message(nomis_get_data(id = "NM_1_1"), "Warning: You are trying to
  # acess more than 350,000 rows of data. This may cause timeout issues and/or
  #                  automatic rate limiting by the Nomis API.")
})
