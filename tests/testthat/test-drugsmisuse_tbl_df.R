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

# drugsmisuse_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble (tbl_df class)
test_that("drugsmisuse_tbl_df is a tibble with tbl_df class", {
  expect_s3_class(drugsmisuse_tbl_df, "tbl_df")
  expect_s3_class(drugsmisuse_tbl_df, "tbl")
  expect_s3_class(drugsmisuse_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 8 columns
test_that("drugsmisuse_tbl_df has 8 columns", {
  expect_equal(length(drugsmisuse_tbl_df), 8)
})

# Test 3: Confirm it has exactly 100 rows
test_that("drugsmisuse_tbl_df has 100 rows", {
  expect_equal(nrow(drugsmisuse_tbl_df), 100)
})

# Test 4: Confirm column names are correct and in order
test_that("drugsmisuse_tbl_df has correct column names", {
  expect_named(drugsmisuse_tbl_df, c(
    "caseid",
    "hydrocd",
    "oxycodp",
    "codeine",
    "tramadl",
    "morphin",
    "methdon",
    "vicolor"
  ))
})

# Test 5: Confirm column types are correct
test_that("drugsmisuse_tbl_df columns have correct types", {
  expect_type(drugsmisuse_tbl_df$caseid, "character")
  expect_type(drugsmisuse_tbl_df$hydrocd, "integer")
  expect_type(drugsmisuse_tbl_df$oxycodp, "integer")
  expect_type(drugsmisuse_tbl_df$codeine, "integer")
  expect_type(drugsmisuse_tbl_df$tramadl, "integer")
  expect_type(drugsmisuse_tbl_df$morphin, "integer")
  expect_type(drugsmisuse_tbl_df$methdon, "integer")
  expect_type(drugsmisuse_tbl_df$vicolor, "integer")
})
