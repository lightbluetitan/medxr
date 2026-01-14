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

# pharmacy_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble (tbl_df class)
test_that("pharmacy_tbl_df is a tibble with tbl_df class", {
  expect_s3_class(pharmacy_tbl_df, "tbl_df")
  expect_s3_class(pharmacy_tbl_df, "tbl")
  expect_s3_class(pharmacy_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 4 columns
test_that("pharmacy_tbl_df has 4 columns", {
  expect_equal(length(pharmacy_tbl_df), 4)
})

# Test 3: Confirm it has exactly 17,520 rows
test_that("pharmacy_tbl_df has 17,520 rows", {
  expect_equal(nrow(pharmacy_tbl_df), 17520)
})

# Test 4: Confirm column names are correct and in order
test_that("pharmacy_tbl_df has correct column names", {
  expect_named(pharmacy_tbl_df, c(
    "date",
    "hours",
    "weekday",
    "attendance"
  ))
})

# Test 5: Confirm column types are correct
test_that("pharmacy_tbl_df columns have correct types", {
  expect_s3_class(pharmacy_tbl_df$date, "Date")
  expect_type(pharmacy_tbl_df$hours, "character")
  expect_type(pharmacy_tbl_df$weekday, "character")
  expect_type(pharmacy_tbl_df$attendance, "double")
})
