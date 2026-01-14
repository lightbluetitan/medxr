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

# products_drug_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble (tbl_df, tbl, data.frame)
test_that("products_drug_tbl_df is a tibble", {
  expect_s3_class(products_drug_tbl_df, "tbl_df")
  expect_s3_class(products_drug_tbl_df, "tbl")
  expect_s3_class(products_drug_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 19 columns
test_that("products_drug_tbl_df has 19 columns", {
  expect_equal(length(products_drug_tbl_df), 19)
})

# Test 3: Confirm it has exactly 3,764 rows
test_that("products_drug_tbl_df has 3,764 rows", {
  expect_equal(nrow(products_drug_tbl_df), 3764)
})

# Test 4: Confirm column names are correct and in order
test_that("products_drug_tbl_df has correct column names", {
  expect_named(products_drug_tbl_df, c(
    "name", "labeller", "ndc-id", "ndc-product-code", "dpd-id",
    "ema-product-code", "ema-ma-number", "started-marketing-on",
    "ended-marketing-on", "dosage-form", "strength", "route",
    "fda-application-number", "generic", "over-the-counter",
    "approved", "country", "source", "parent_key"
  ))
})

# Test 5: Confirm column types are correct
test_that("products_drug_tbl_df columns have correct types", {
  char_cols <- c(
    "name", "labeller", "ndc-id", "ndc-product-code", "dpd-id",
    "ema-product-code", "ema-ma-number", "started-marketing-on",
    "ended-marketing-on", "dosage-form", "strength", "route",
    "fda-application-number", "generic", "over-the-counter",
    "approved", "country", "source", "parent_key"
  )
  for (col in char_cols) {
    expect_type(products_drug_tbl_df[[col]], "character")
  }
})
