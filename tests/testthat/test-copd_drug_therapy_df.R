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

# copd_drug_therapy_df

library(testthat)

# Test 1: Confirm the object is a data.frame
test_that("copd_drug_therapy_df is a data.frame", {
  expect_s3_class(copd_drug_therapy_df, "data.frame")
  expect_false("tbl_df" %in% class(copd_drug_therapy_df))  # Ensure it's not a tibble
})

# Test 2: Confirm it has exactly 6 columns
test_that("copd_drug_therapy_df has 6 columns", {
  expect_equal(length(copd_drug_therapy_df), 6)
})

# Test 3: Confirm it has exactly 94 rows
test_that("copd_drug_therapy_df has 94 rows", {
  expect_equal(nrow(copd_drug_therapy_df), 94)
})

# Test 4: Confirm column names are correct and in order
test_that("copd_drug_therapy_df has correct column names", {
  expect_named(copd_drug_therapy_df, c(
    "study", "year", "id", "treatment", "exac", "total"
  ))
})

# Test 5: Confirm column types are correct
test_that("copd_drug_therapy_df columns have correct types", {
  expect_type(copd_drug_therapy_df$study, "character")
  expect_type(copd_drug_therapy_df$year, "integer")
  expect_type(copd_drug_therapy_df$id, "integer")
  expect_type(copd_drug_therapy_df$treatment, "character")
  expect_type(copd_drug_therapy_df$exac, "integer")
  expect_type(copd_drug_therapy_df$total, "integer")
})
