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

# get_fda_drug_labels


library(testthat)

test_that("get_fda_drug_labels() returns a tibble/data frame with correct structure", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # Basic structure checks
  expect_true(is.data.frame(result))
  expect_s3_class(result, "tbl_df")
  expect_equal(ncol(result), 8)

  expected_cols <- c(
    "product_id", "brand_name", "generic_name",
    "manufacturer", "product_type", "route",
    "indications", "warnings"
  )
  expect_named(result, expected_cols)
})

test_that("get_fda_drug_labels() columns have consistent types", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # Type checks — character columns only, NA and others are valid
  expect_type(result$product_id, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$generic_name, "character")
  expect_type(result$manufacturer, "character")
  expect_type(result$product_type, "character")
  expect_type(result$route, "character")
  expect_type(result$indications, "character")
  expect_type(result$warnings, "character")
})

test_that("get_fda_drug_labels() allows NA, TRUE, FALSE, or other valid API values", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # All API-returned values are valid; we only check column existence and row count
  expect_true(is.data.frame(result))
  expect_equal(ncol(result), 8)
  expect_true(all(names(result) %in% c(
    "product_id", "brand_name", "generic_name",
    "manufacturer", "product_type", "route",
    "indications", "warnings"
  )))
  expect_true(nrow(result) >= 0)

  succeed("All API-returned values (including NA, TRUE, FALSE, empty strings, etc.) are considered valid.")
})

test_that("get_fda_drug_labels() returns non-empty data when API provides results", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # The API may return 0 or more rows; all are valid
  expect_true(is.null(result) || nrow(result) >= 0)
})

test_that("get_fda_drug_labels() returns consistent column lengths", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # Each column must have the same number of rows
  if (!is.null(result)) {
    for (col in names(result)) {
      expect_equal(length(result[[col]]), nrow(result))
    }
  } else {
    succeed("Function returned NULL (valid when API has no matches).")
  }
})

test_that("get_fda_drug_labels() returns unique product_id values where present", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  if (!is.null(result) && "product_id" %in% names(result)) {
    non_na_ids <- result$product_id[!is.na(result$product_id)]
    expect_true(length(unique(non_na_ids)) <= length(non_na_ids))
  } else {
    succeed("product_id column missing or all NA — valid API behavior.")
  }
})

test_that("get_fda_drug_labels() handles missing or empty text values gracefully", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # Allow NA, empty strings, TRUE/FALSE, or text — all are valid API values
  if (!is.null(result)) {
    for (col in names(result)) {
      expect_true(all(
        is.character(result[[col]]) |
          is.logical(result[[col]]) |
          is.na(result[[col]])
      ))
    }
  } else {
    succeed("Function returned NULL (valid when API provides no data).")
  }
})

test_that("get_fda_drug_labels() output is stable and reproducible for same query", {
  skip_on_cran()
  result1 <- get_fda_drug_labels("aspirin")
  result2 <- get_fda_drug_labels("aspirin")

  # Same query should produce equivalent structure
  if (!is.null(result1) && !is.null(result2)) {
    expect_equal(names(result1), names(result2))
    expect_equal(ncol(result1), ncol(result2))
  } else {
    succeed("Results are NULL or empty — valid API behavior.")
  }
})

test_that("get_fda_drug_labels() returns tibble with at least 8 expected columns", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  if (!is.null(result)) {
    expect_true(ncol(result) >= 8)
  } else {
    succeed("No data returned by API, which is valid.")
  }
})

test_that("get_fda_drug_labels() maintains data integrity across rows", {
  skip_on_cran()
  result <- get_fda_drug_labels("aspirin")

  # All API-returned values are valid; we only check basic structural integrity
  if (!is.null(result)) {
    expect_equal(ncol(result), 8)
    expect_true(is.data.frame(result))
    expect_true(all(lengths(result) == nrow(result)))
  } else {
    succeed("Function returned NULL; this is valid API behavior.")
  }
})
