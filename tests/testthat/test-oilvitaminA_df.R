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

# oilvitaminA_df

library(testthat)

# Test 1: Confirm the object is a base data.frame (not a tibble)
test_that("oilvitaminA_df is a base data.frame", {
  expect_s3_class(oilvitaminA_df, "data.frame")
  expect_false("tbl_df" %in% class(oilvitaminA_df))  # ensure it's not a tibble
})

# Test 2: Confirm it has exactly 2 columns
test_that("oilvitaminA_df has 2 columns", {
  expect_equal(length(oilvitaminA_df), 2)
})

# Test 3: Confirm it has exactly 20 rows
test_that("oilvitaminA_df has 20 rows", {
  expect_equal(nrow(oilvitaminA_df), 20)
})

# Test 4: Confirm column names are correct and in order
test_that("oilvitaminA_df has correct column names", {
  expect_named(oilvitaminA_df, c("type", "avit"))
})

# Test 5: Confirm column types are correct
test_that("oilvitaminA_df columns have correct types", {
  expect_true(is.factor(oilvitaminA_df$type))
  expect_type(oilvitaminA_df$avit, "integer")
})
