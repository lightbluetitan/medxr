# MedxR - Access Drug Regulatory Data via FDA and Health Canada APIs
# Version 0.1.1
# Copyright (C) 2026 Renzo Caceres Rossi
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

# get_hc_search_drug

library(testthat)

test_that("get_hc_search_drug() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("drug_code", "class_name", "din", "brand_name",
                         "number_of_ais", "ai_group_no", "company_name",
                         "last_update_date"))

  # Type checks
  expect_type(result$drug_code, "integer")
  expect_type(result$class_name, "character")
  expect_type(result$din, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$number_of_ais, "character")
  expect_type(result$ai_group_no, "character")
  expect_type(result$company_name, "character")
  expect_type(result$last_update_date, "character")
})

test_that("get_hc_search_drug() handles missing or invalid input properly", {
  expect_error(get_hc_search_drug(), "Please provide a single brand name")
  expect_error(get_hc_search_drug(c("NEMBUTAL", "ASPIRIN")), "Please provide a single brand name")
})

test_that("get_hc_search_drug() returns NULL for drugs not found", {
  skip_on_cran()
  result <- get_hc_search_drug("NONEXISTENTDRUGXYZABC123")
  expect_true(is.null(result) || nrow(result) == 0)
})

test_that("get_hc_search_drug() returns valid data for known drugs", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_true(nrow(result) > 0)
  expect_true(is.integer(result$drug_code))
  expect_true(is.character(result$brand_name))
})

test_that("get_hc_search_drug() brand_name matches search term", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_true(all(grepl("NEMBUTAL", result$brand_name, ignore.case = TRUE)))
})

test_that("get_hc_search_drug() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
  expect_true(all(is.na(result$class_name) | nchar(result$class_name) >= 0))
  expect_true(all(is.na(result$din) | nchar(result$din) >= 0))
  expect_true(all(is.na(result$company_name) | nchar(result$company_name) >= 0))
})

test_that("get_hc_search_drug() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_type(result$drug_code, "integer")
  expect_type(result$class_name, "character")
  expect_type(result$din, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$number_of_ais, "character")
  expect_type(result$ai_group_no, "character")
  expect_type(result$company_name, "character")
  expect_type(result$last_update_date, "character")
})

test_that("get_hc_search_drug() handles empty API responses gracefully", {
  skip_on_cran()
  fake_empty <- get_hc_search_drug("zzzzzzzzzzz")
  expect_true(is.null(fake_empty) || nrow(fake_empty) == 0)
})

test_that("get_hc_search_drug() data content is coherent", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_true(all(is.na(result$drug_code) | result$drug_code > 0))
  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_search_drug() DIN column is properly renamed", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_true("din" %in% names(result))
  expect_false("drug_identification_number" %in% names(result))
})

test_that("get_hc_search_drug() descriptor column is removed if present", {
  skip_on_cran()
  result <- get_hc_search_drug("NEMBUTAL")

  expect_false("descriptor" %in% names(result))
})
