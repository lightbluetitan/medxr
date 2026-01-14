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

# oral_anticoagulants_df

library(testthat)

# Test 1: Confirm the object is a data.frame
test_that("oral_anticoagulants_df is a data.frame", {
  expect_s3_class(oral_anticoagulants_df, "data.frame")
  expect_false("tbl_df" %in% class(oral_anticoagulants_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 9 columns
test_that("oral_anticoagulants_df has 9 columns", {
  expect_equal(length(oral_anticoagulants_df), 9)
})

# Test 3: Confirm it has exactly 34 rows
test_that("oral_anticoagulants_df has 34 rows", {
  expect_equal(nrow(oral_anticoagulants_df), 34)
})

# Test 4: Confirm column names are correct and in order
test_that("oral_anticoagulants_df has correct column names", {
  expect_named(oral_anticoagulants_df, c(
    "study", "year", "intensity", "asp.t", "asp.c", "ai", "n1i", "ci", "n2i"
  ))
})

# Test 5: Confirm column types are correct
test_that("oral_anticoagulants_df columns have correct types", {
  expect_type(oral_anticoagulants_df$study, "character")
  expect_type(oral_anticoagulants_df$year, "integer")
  expect_type(oral_anticoagulants_df$intensity, "character")
  expect_type(oral_anticoagulants_df$`asp.t`, "integer")
  expect_type(oral_anticoagulants_df$`asp.c`, "integer")
  expect_type(oral_anticoagulants_df$ai, "integer")
  expect_type(oral_anticoagulants_df$n1i, "integer")
  expect_type(oral_anticoagulants_df$ci, "integer")
  expect_type(oral_anticoagulants_df$n2i, "integer")
})
