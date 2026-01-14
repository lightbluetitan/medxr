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

# ratliver_df

library(testthat)

# Test 1: Confirm the object is a data.frame (not a tibble)
test_that("ratliver_df is a data.frame", {
  expect_s3_class(ratliver_df, "data.frame")
  expect_false("tbl_df" %in% class(ratliver_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 4 columns
test_that("ratliver_df has 4 columns", {
  expect_equal(length(ratliver_df), 4)
})

# Test 3: Confirm it has exactly 19 rows
test_that("ratliver_df has 19 rows", {
  expect_equal(nrow(ratliver_df), 19)
})

# Test 4: Confirm column names are correct and in order
test_that("ratliver_df has correct column names", {
  expect_named(ratliver_df, c("BodyWt", "LiverWt", "Dose", "DoseInLiver"))
})

# Test 5: Confirm column types are correct
test_that("ratliver_df columns have correct types", {
  expect_type(ratliver_df$BodyWt, "integer")
  expect_type(ratliver_df$LiverWt, "double")
  expect_type(ratliver_df$Dose, "double")
  expect_type(ratliver_df$DoseInLiver, "double")
})
