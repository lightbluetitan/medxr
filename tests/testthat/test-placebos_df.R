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

# placebos_df

library(testthat)

# Test 1: Confirm the object is a data.frame (not a tibble)
test_that("placebos_df is a data.frame", {
  expect_s3_class(placebos_df, "data.frame")
  expect_false("tbl_df" %in% class(placebos_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 6 columns
test_that("placebos_df has 6 columns", {
  expect_equal(length(placebos_df), 6)
})

# Test 3: Confirm it has exactly 7 rows
test_that("placebos_df has 7 rows", {
  expect_equal(nrow(placebos_df), 7)
})

# Test 4: Confirm column names are correct and in order
test_that("placebos_df has correct column names", {
  expect_named(placebos_df, c(
    "Time",
    "Placebo",
    "Distr",
    "Asp",
    "Codis",
    "PlaceboRed"
  ))
})

# Test 5: Confirm column types are correct
test_that("placebos_df columns have correct types", {
  expect_type(placebos_df$Time, "integer")
  expect_type(placebos_df$Placebo, "double")
  expect_type(placebos_df$Distr, "double")
  expect_type(placebos_df$Asp, "double")
  expect_type(placebos_df$Codis, "double")
  expect_type(placebos_df$PlaceboRed, "double")
})
