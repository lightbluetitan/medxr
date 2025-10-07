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

# naoh_digest_df

library(testthat)

# Test 1: Confirm the object is a base data.frame (not a tibble)
test_that("naoh_digest_df is a base data.frame", {
  expect_s3_class(naoh_digest_df, "data.frame")
  expect_false("tbl_df" %in% class(naoh_digest_df))  # ensure it's not a tibble
})

# Test 2: Confirm it has exactly 3 columns
test_that("naoh_digest_df has 3 columns", {
  expect_equal(length(naoh_digest_df), 3)
})

# Test 3: Confirm it has exactly 6 rows
test_that("naoh_digest_df has 6 rows", {
  expect_equal(nrow(naoh_digest_df), 6)
})

# Test 4: Confirm column names are correct and in order
test_that("naoh_digest_df has correct column names", {
  expect_named(naoh_digest_df, c("horse", "ordinary", "naoh"))
})

# Test 5: Confirm column types are correct
test_that("naoh_digest_df columns have correct types", {
  expect_type(naoh_digest_df$horse, "integer")
  expect_type(naoh_digest_df$ordinary, "double")
  expect_type(naoh_digest_df$naoh, "double")
})
