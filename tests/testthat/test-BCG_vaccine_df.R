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

# BCG_vaccine_df

library(testthat)

# Test 1: Confirm the object is a data.frame (not a tibble)
test_that("BCG_vaccine_df is a data.frame", {
  expect_s3_class(BCG_vaccine_df, "data.frame")
  expect_false("tbl_df" %in% class(BCG_vaccine_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 9 columns
test_that("BCG_vaccine_df has 9 columns", {
  expect_equal(length(BCG_vaccine_df), 9)
})

# Test 3: Confirm it has exactly 13 rows
test_that("BCG_vaccine_df has 13 rows", {
  expect_equal(nrow(BCG_vaccine_df), 13)
})

# Test 4: Confirm column names are correct and in order
test_that("BCG_vaccine_df has correct column names", {
  expect_named(BCG_vaccine_df, c(
    "trial",
    "author",
    "year",
    "tpos",
    "tneg",
    "cpos",
    "cneg",
    "ablat",
    "alloc"
  ))
})

# Test 5: Confirm column types are correct
test_that("BCG_vaccine_df columns have correct types", {
  expect_type(BCG_vaccine_df$trial, "integer")
  expect_type(BCG_vaccine_df$author, "character")
  expect_type(BCG_vaccine_df$year, "integer")
  expect_type(BCG_vaccine_df$tpos, "integer")
  expect_type(BCG_vaccine_df$tneg, "integer")
  expect_type(BCG_vaccine_df$cpos, "integer")
  expect_type(BCG_vaccine_df$cneg, "integer")
  expect_type(BCG_vaccine_df$ablat, "integer")
  expect_type(BCG_vaccine_df$alloc, "character")
})
