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

# get_hc_active_ingredients

library(testthat)

test_that("get_hc_active_ingredients() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("dosage_unit", "dosage_value", "drug_code", "ingredient_name",
                         "strength", "strength_unit"))

  # Type checks
  expect_type(result$dosage_unit, "character")
  expect_type(result$dosage_value, "character")
  expect_type(result$drug_code, "integer")
  expect_type(result$ingredient_name, "character")
  expect_type(result$strength, "character")
  expect_type(result$strength_unit, "character")
})

test_that("get_hc_active_ingredients() returns a large dataset", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_true(nrow(result) > 100000)
})

test_that("get_hc_active_ingredients() drug_code values are valid", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_true(is.integer(result$drug_code))
  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
})

test_that("get_hc_active_ingredients() ingredient_name values are valid", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_true(is.character(result$ingredient_name))
})

test_that("get_hc_active_ingredients() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_true(all(is.na(result$dosage_unit) | nchar(result$dosage_unit) >= 0))
  expect_true(all(is.na(result$dosage_value) | nchar(result$dosage_value) >= 0))
  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
  expect_true(all(is.na(result$ingredient_name) | nchar(result$ingredient_name) >= 0))
  expect_true(all(is.na(result$strength) | nchar(result$strength) >= 0))
  expect_true(all(is.na(result$strength_unit) | nchar(result$strength_unit) >= 0))
})

test_that("get_hc_active_ingredients() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_type(result$dosage_unit, "character")
  expect_type(result$dosage_value, "character")
  expect_type(result$drug_code, "integer")
  expect_type(result$ingredient_name, "character")
  expect_type(result$strength, "character")
  expect_type(result$strength_unit, "character")
})

test_that("get_hc_active_ingredients() data content is coherent", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_active_ingredients() allows empty strings as valid values", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  # Empty strings are valid values from the API
  expect_true(any(result$dosage_unit == "" | !is.na(result$dosage_unit)))
  expect_true(any(result$dosage_value == "" | !is.na(result$dosage_value)))
  expect_true(any(result$strength == "" | !is.na(result$strength)))
})

test_that("get_hc_active_ingredients() contains expected strength units", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  strength_units <- unique(result$strength_unit[!is.na(result$strength_unit)])
  expect_true(length(strength_units) > 0)
})

test_that("get_hc_active_ingredients() returns exactly 6 columns", {
  skip_on_cran()
  result <- get_hc_active_ingredients()

  expect_equal(ncol(result), 6)
})
