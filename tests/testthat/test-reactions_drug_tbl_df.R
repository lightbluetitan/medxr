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

# reactions_drug_tbl_df

library(testthat)

# Test 1: Confirm the object is a tibble with spec_tbl_df class
test_that("reactions_drug_tbl_df is a tibble with spec_tbl_df class", {
  expect_s3_class(reactions_drug_tbl_df, "spec_tbl_df")
  expect_s3_class(reactions_drug_tbl_df, "tbl_df")
  expect_s3_class(reactions_drug_tbl_df, "tbl")
  expect_s3_class(reactions_drug_tbl_df, "data.frame")
})

# Test 2: Confirm it has exactly 6 columns
test_that("reactions_drug_tbl_df has 6 columns", {
  expect_equal(length(reactions_drug_tbl_df), 6)
})

# Test 3: Confirm it has exactly 69 rows
test_that("reactions_drug_tbl_df has 69 rows", {
  expect_equal(nrow(reactions_drug_tbl_df), 69)
})

# Test 4: Confirm column names are correct and in order
test_that("reactions_drug_tbl_df has correct column names", {
  expect_named(reactions_drug_tbl_df, c(
    "sequence",
    "left_drugbank_id",
    "left_drugbank_name",
    "right_drugbank_id",
    "right_drugbank_name",
    "parent_key"
  ))
})

# Test 5: Confirm column types are correct
test_that("reactions_drug_tbl_df columns have correct types", {
  expect_type(reactions_drug_tbl_df$sequence, "double")
  expect_type(reactions_drug_tbl_df$left_drugbank_id, "character")
  expect_type(reactions_drug_tbl_df$left_drugbank_name, "character")
  expect_type(reactions_drug_tbl_df$right_drugbank_id, "character")
  expect_type(reactions_drug_tbl_df$right_drugbank_name, "character")
  expect_type(reactions_drug_tbl_df$parent_key, "character")
})
