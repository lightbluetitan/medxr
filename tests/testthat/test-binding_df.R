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

# binding_df

library(testthat)

# Test 1: Confirm the object is a base data.frame (not a tibble)
test_that("binding_df is a base data.frame", {
  expect_s3_class(binding_df, "data.frame")
  expect_false("tbl_df" %in% class(binding_df))  # ensure it's not a tibble
})

# Test 2: Confirm it has exactly 2 columns
test_that("binding_df has 2 columns", {
  expect_equal(length(binding_df), 2)
})

# Test 3: Confirm it has exactly 12 rows
test_that("binding_df has 12 rows", {
  expect_equal(nrow(binding_df), 12)
})

# Test 4: Confirm column names are correct and in order
test_that("binding_df has correct column names", {
  expect_named(binding_df, c("antibiotic", "binding"))
})

# Test 5: Confirm column types are correct
test_that("binding_df columns have correct types", {
  expect_true(is.factor(binding_df$antibiotic))
  expect_type(binding_df$binding, "double")
})
