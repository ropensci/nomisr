library(nomisr)
context("nomis_get_data")

test_that("nomis_get_data return expected format", {
  skip_on_cran()

  z <- nomis_get_data(
    id = "NM_1_1", time = "latest",
    measures = c(20100, 20201), sex = 5,
    exclude_missing = TRUE, geography = "TYPE499"
  )
  expect_length(z, 34)
  expect_type(z, "list")
  expect_true(tibble::is_tibble(z))

  ## Test queries of over 25000 observatiosn
  a <- nomis_get_data(
    id = "NM_893_1", date = "latest",
    geography = "TYPE266", exclude_missing = FALSE, tidy = TRUE
  )
  expect_length(a, 40)
  expect_type(a, "list")
  expect_true(tibble::is_tibble(a))
  expect_equal(
    as.numeric(a$record_offset[[nrow(a)]]) + 1,
    as.numeric(a$record_count[[nrow(a)]])
  )
  sum_check <- summary(diff(as.numeric(a$record_offset)))
  expect_equal(sum_check[[1]], 1)

  expect_error(nomis_get_data(), "Dataset ID must be specified")

  expect_message(
    b <- nomis_get_data(
      tidy = TRUE,
      id = "NM_168_1", time = "latest",
      geography = "2013265925", sex = "0", additional_queries = ""
    ), "The `additional_query` parameter is
            deprecated, please use ... instead"
  )

  expect_true(nrow(b) == b$record_count[1])
  expect_length(b, 40)
  expect_type(b, "list")
  expect_true(tibble::is_tibble(b))
  expect_true(nrow(a) == a$record_count[1])

  c <- nomis_get_data(
    id = "NM_127_1", sex = "6",
    time = "latest", tidy = TRUE, tidy_style = "camelCase", query_id = "my_query123"
  )
  expect_length(c, 29)
  expect_type(c, "list")
  expect_true(tibble::is_tibble(c))
  expect_true(nrow(c) == c$recordCount[1])
  expect_equal(names(c)[[1]], "queryId")
  expect_equal(c$queryId[[543]], "my_query123")

  expect_error(
    nomis_get_data(
      id = "NM_1_1", time = "latest",
      measures = c(20100, 20201), sex = 0,
      exclude_missing = FALSE, geography = "TYPE499"
    ),
    "The API request did not return any results. Please check your parameters."
  )

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


  select_no_obs <- nomis_get_data(
    id = "NM_1208_1", time = "latest",
    USUAL_RESIDENCE = "TYPE499",
    PLACE_OF_WORK = "TYPE499",
    TRANSPORT_POWPEW11 = "2",
    select = c(
      "USUAL_RESIDENCE_NAME",
      "PLACE_OF_WORK_NAME"
    )
  )
  expect_length(select_no_obs, 2)
  expect_true(tibble::is_tibble(select_no_obs))
  expect_true(all(names(select_no_obs) == c(
    "USUAL_RESIDENCE_NAME",
    "PLACE_OF_WORK_NAME"
  )))


  mort_data1 <- nomis_get_data(
    id = "NM_161_1", date = "2016", tidy = TRUE,
    geography = "TYPE464",
    CAUSE_OF_DEATH = "10381",
    sex = 0, age = 0, MEASURE = 6
  )

  mort_data2 <- nomis_get_data(
    id = "NM_161_1", date = "2016", tidy = TRUE,
    geography = "TYPE464", sex = 0,
    cause_of_death = "10381",
    age = 0, measure = 6, measures = NULL
  )

  expect_true(all.equal(mort_data2, mort_data1))
  expect_true(is.numeric(mort_data2$obs_value))

  expect_error(
    mort_data3 <- nomis_get_data(
      id = "NM_161_1", date = "2016",
      geography = "TYPE464", sex = 0,
      cause_of_death = "10381",
      age = 0, measure = 6
    )
  )
})
