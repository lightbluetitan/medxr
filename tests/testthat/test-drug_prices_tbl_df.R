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

# drug_prices_tbl_df


library(testthat)

# Test 1: Confirm the object is a tibble with spec_tbl_df class
test_that("drug_prices_tbl_df is a tibble with spec_tbl_df class", {
  expect_s3_class(drug_prices_tbl_df, "spec_tbl_df")
  expect_s3_class(drug_prices_tbl_df, "tbl_df")
  expect_s3_class(drug_prices_tbl_df, "tbl")
  expect_s3_class(drug_prices_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 5 columns
test_that("drug_prices_tbl_df has 5 columns", {
  expect_equal(length(drug_prices_tbl_df), 5)
})

# Test 3: Confirm it has exactly 208 rows
test_that("drug_prices_tbl_df has 208 rows", {
  expect_equal(nrow(drug_prices_tbl_df), 208)
})

# Test 4: Confirm column names are correct and in order
test_that("drug_prices_tbl_df has correct column names", {
  expect_named(drug_prices_tbl_df, c(
    "description", "currency", "cost", "unit", "parent_key"
  ))
})

# Test 5: Confirm column types are correct
test_that("drug_prices_tbl_df columns have correct types", {
  expect_type(drug_prices_tbl_df$description, "character")
  expect_type(drug_prices_tbl_df$currency, "character")
  expect_type(drug_prices_tbl_df$cost, "double")
  expect_type(drug_prices_tbl_df$unit, "character")
  expect_type(drug_prices_tbl_df$parent_key, "character")
})
