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

# view_datasets_MedxR

library(testthat)
library(MedxR)

test_that("view_datasets_MedxR works when package is loaded", {
  result <- view_datasets_MedxR()
  expect_type(result, "character")
  expect_true(length(result) > 0)
})

test_that("view_datasets_MedxR prints correct message", {
  output <- capture_messages(view_datasets_MedxR())
  expect_match(
    output[1],
    "Datasets available in the 'MedxR' package:",
    fixed = TRUE
  )
})

test_that("view_datasets_MedxR returns expected datasets", {
  datasets <- view_datasets_MedxR()
  expected_datasets <- c(
    "aspirin_infarction_df",
    "ATC_code_tbl_df",
    "BCG_vaccine_df",
    "binding_df",
    "caffeine_matrix",
    "copd_drug_therapy_df",
    "dosage_tbl_df",
    "drug_prices_tbl_df",
    "drugsmisuse_tbl_df",
    "histamine_matrix",
    "naoh_digest_df",
    "oilvitaminA_df",
    "oral_anticoagulants_df",
    "parkinsons_list",
    "pharmacy_tbl_df",
    "placebos_df",
    "products_drug_tbl_df",
    "ratliver_df",
    "reactions_drug_tbl_df"


  )
  # Check if all expected datasets are present
  missing_datasets <- setdiff(expected_datasets, datasets)
  expect_true(
    length(missing_datasets) == 0,
    info = paste("Missing datasets:", paste(missing_datasets, collapse = ", "))
  )
})
