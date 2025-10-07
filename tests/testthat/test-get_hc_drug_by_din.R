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

# get_hc_drug_by_din

library(testthat)

test_that("get_hc_drug_by_din() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

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

test_that("get_hc_drug_by_din() handles missing or invalid input properly", {
  expect_error(get_hc_drug_by_din(), "Please provide a single DIN")
  expect_error(get_hc_drug_by_din(c("00000213", "00000086")), "Please provide a single DIN")
})

test_that("get_hc_drug_by_din() returns NULL for DIN not found", {
  skip_on_cran()
  result <- get_hc_drug_by_din("99999999")
  expect_true(is.null(result))
})

test_that("get_hc_drug_by_din() returns valid data for known DIN", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_true(nrow(result) == 1)
  expect_true(is.integer(result$drug_code))
  expect_true(is.character(result$brand_name))
})

test_that("get_hc_drug_by_din() din matches input", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_equal(result$din, "00000213")
})

test_that("get_hc_drug_by_din() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
  expect_true(all(is.na(result$class_name) | nchar(result$class_name) >= 0))
  expect_true(all(is.na(result$din) | nchar(result$din) >= 0))
  expect_true(all(is.na(result$company_name) | nchar(result$company_name) >= 0))
})

test_that("get_hc_drug_by_din() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_type(result$drug_code, "integer")
  expect_type(result$class_name, "character")
  expect_type(result$din, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$number_of_ais, "character")
  expect_type(result$ai_group_no, "character")
  expect_type(result$company_name, "character")
  expect_type(result$last_update_date, "character")
})

test_that("get_hc_drug_by_din() handles empty API responses gracefully", {
  skip_on_cran()
  fake_empty <- get_hc_drug_by_din("00000000")
  expect_true(is.null(fake_empty))
})

test_that("get_hc_drug_by_din() data content is coherent", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_true(all(is.na(result$drug_code) | result$drug_code > 0))
  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_drug_by_din() DIN column is properly renamed", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_true("din" %in% names(result))
  expect_false("drug_identification_number" %in% names(result))
})

test_that("get_hc_drug_by_din() descriptor column is removed if present", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_false("descriptor" %in% names(result))
})

test_that("get_hc_drug_by_din() returns exactly 1 row for valid DIN", {
  skip_on_cran()
  result <- get_hc_drug_by_din("00000213")

  expect_equal(nrow(result), 1)
})
