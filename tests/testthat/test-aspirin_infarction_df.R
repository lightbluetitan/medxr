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

# aspirin_infarction_df

library(testthat)

# Test 1: Confirm the object is a data.frame
test_that("aspirin_infarction_df is a data.frame", {
  expect_s3_class(aspirin_infarction_df, "data.frame")
  expect_false("tbl_df" %in% class(aspirin_infarction_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 6 columns
test_that("aspirin_infarction_df has 6 columns", {
  expect_equal(length(aspirin_infarction_df), 6)
})

# Test 3: Confirm it has exactly 7 rows
test_that("aspirin_infarction_df has 7 rows", {
  expect_equal(nrow(aspirin_infarction_df), 7)
})

# Test 4: Confirm column names are correct and in order
test_that("aspirin_infarction_df has correct column names", {
  expect_named(aspirin_infarction_df, c(
    "study", "year", "d.asp", "n.asp", "d.plac", "n.plac"
  ))
})

# Test 5: Confirm column types are correct
test_that("aspirin_infarction_df columns have correct types", {
  expect_type(aspirin_infarction_df$study, "character")
  expect_type(aspirin_infarction_df$year, "integer")
  expect_type(aspirin_infarction_df$`d.asp`, "integer")
  expect_type(aspirin_infarction_df$`n.asp`, "integer")
  expect_type(aspirin_infarction_df$`d.plac`, "integer")
  expect_type(aspirin_infarction_df$`n.plac`, "integer")
})

