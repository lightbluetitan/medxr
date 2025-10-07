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

# ATC_code_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble with spec_tbl_df class
test_that("ATC_code_tbl_df is a tibble with spec_tbl_df class", {
  expect_s3_class(ATC_code_tbl_df, "spec_tbl_df")
  expect_s3_class(ATC_code_tbl_df, "tbl_df")
  expect_s3_class(ATC_code_tbl_df, "tbl")
  expect_s3_class(ATC_code_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 10 columns
test_that("ATC_code_tbl_df has 10 columns", {
  expect_equal(length(ATC_code_tbl_df), 10)
})

# Test 3: Confirm it has exactly 50 rows
test_that("ATC_code_tbl_df has 50 rows", {
  expect_equal(nrow(ATC_code_tbl_df), 50)
})

# Test 4: Confirm column names are correct and in order
test_that("ATC_code_tbl_df has correct column names", {
  expect_named(ATC_code_tbl_df, c(
    "atc_code",
    "level_1",
    "code_1",
    "level_2",
    "code_2",
    "level_3",
    "code_3",
    "level_4",
    "code_4",
    "drugbank-id"
  ))
})

# Test 5: Confirm column types are correct
test_that("ATC_code_tbl_df columns have correct types", {
  expect_type(ATC_code_tbl_df$atc_code, "character")
  expect_type(ATC_code_tbl_df$level_1, "character")
  expect_type(ATC_code_tbl_df$code_1, "character")
  expect_type(ATC_code_tbl_df$level_2, "character")
  expect_type(ATC_code_tbl_df$code_2, "character")
  expect_type(ATC_code_tbl_df$level_3, "character")
  expect_type(ATC_code_tbl_df$code_3, "character")
  expect_type(ATC_code_tbl_df$level_4, "character")
  expect_type(ATC_code_tbl_df$code_4, "character")
  expect_type(ATC_code_tbl_df$`drugbank-id`, "character")
})
