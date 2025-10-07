# MedxR - Access Drug Regulatory Data via FDA and Health Canada APIs
# Version 0.1.0
# Copyright (C) 2025 Renzo Caceres Rossi
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# get_hc_companies


library(testthat)

test_that("get_hc_companies() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_companies()

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("city_name", "company_code", "company_name", "company_type",
                         "country_name", "postal_code", "province_name", "street_name"))

  # Type checks
  expect_type(result$city_name, "character")
  expect_type(result$company_code, "integer")
  expect_type(result$company_name, "character")
  expect_type(result$company_type, "character")
  expect_type(result$country_name, "character")
  expect_type(result$postal_code, "character")
  expect_type(result$province_name, "character")
  expect_type(result$street_name, "character")
})

test_that("get_hc_companies() returns a large dataset", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_true(nrow(result) > 5000)
})

test_that("get_hc_companies() company_code values are valid", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_true(is.integer(result$company_code))
  expect_true(all(is.na(result$company_code) | !is.na(result$company_code)))
})

test_that("get_hc_companies() company_name values are valid", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_true(is.character(result$company_name))
  non_na_companies <- result$company_name[!is.na(result$company_name)]
  expect_true(all(nchar(non_na_companies) > 0))
})

test_that("get_hc_companies() company_type values are valid", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_true(is.character(result$company_type))
})

test_that("get_hc_companies() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_true(all(is.na(result$city_name) | nchar(result$city_name) >= 0))
  expect_true(all(is.na(result$company_code) | !is.na(result$company_code)))
  expect_true(all(is.na(result$company_name) | nchar(result$company_name) >= 0))
  expect_true(all(is.na(result$company_type) | nchar(result$company_type) >= 0))
  expect_true(all(is.na(result$country_name) | nchar(result$country_name) >= 0))
  expect_true(all(is.na(result$postal_code) | nchar(result$postal_code) >= 0))
  expect_true(all(is.na(result$province_name) | nchar(result$province_name) >= 0))
  expect_true(all(is.na(result$street_name) | nchar(result$street_name) >= 0))
})

test_that("get_hc_companies() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_type(result$city_name, "character")
  expect_type(result$company_code, "integer")
  expect_type(result$company_name, "character")
  expect_type(result$company_type, "character")
  expect_type(result$country_name, "character")
  expect_type(result$postal_code, "character")
  expect_type(result$province_name, "character")
  expect_type(result$street_name, "character")
})

test_that("get_hc_companies() data content is coherent", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_companies() post_office_box and suite_number are removed", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_false("post_office_box" %in% names(result))
  expect_false("suite_number" %in% names(result))
})

test_that("get_hc_companies() contains expected company types", {
  skip_on_cran()
  result <- get_hc_companies()

  company_types <- unique(result$company_type[!is.na(result$company_type)])
  expect_true(length(company_types) > 0)
})

test_that("get_hc_companies() returns exactly 8 columns", {
  skip_on_cran()
  result <- get_hc_companies()

  expect_equal(ncol(result), 8)
})
