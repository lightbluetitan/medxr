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

# dosage_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble/data frame with correct S3 classes
test_that("dosage_tbl_df is a tibble with correct S3 classes", {
  expect_s3_class(dosage_tbl_df, "tbl_df")
  expect_s3_class(dosage_tbl_df, "tbl")
  expect_s3_class(dosage_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 9 columns
test_that("dosage_tbl_df has 9 columns", {
  expect_equal(length(dosage_tbl_df), 9)
})

# Test 3: Confirm it has exactly 759 rows
test_that("dosage_tbl_df has 759 rows", {
  expect_equal(nrow(dosage_tbl_df), 759)
})

# Test 4: Confirm column names are correct and in order
test_that("dosage_tbl_df has correct column names", {
  expect_named(dosage_tbl_df, c(
    "ab", "name", "type", "dose", "dose_times",
    "administration", "notes", "original_txt", "eucast_version"
  ))
})

# Test 5: Confirm column types are correct
test_that("dosage_tbl_df columns have correct types", {
  expect_type(dosage_tbl_df$ab, "character")
  expect_type(dosage_tbl_df$name, "character")
  expect_type(dosage_tbl_df$type, "character")
  expect_type(dosage_tbl_df$dose, "character")
  expect_type(dosage_tbl_df$dose_times, "integer")
  expect_type(dosage_tbl_df$administration, "character")
  expect_type(dosage_tbl_df$notes, "character")
  expect_type(dosage_tbl_df$original_txt, "character")
  expect_type(dosage_tbl_df$eucast_version, "double")
})
