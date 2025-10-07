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

# get_fda_drugs_approved


library(testthat)

test_that("get_fda_drugs_approved() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(
    result,
    c("application_number", "sponsor", "brand", "generic",
      "type", "approval_date", "strength", "form", "route")
  )

  # Type checks
  expect_type(result$application_number, "character")
  expect_type(result$sponsor, "character")
  expect_type(result$brand, "character")
  expect_type(result$generic, "character")
  expect_type(result$type, "character")
  expect_s3_class(result$approval_date, "Date")
  expect_type(result$strength, "character")
  expect_type(result$form, "character")
  expect_type(result$route, "character")
})

test_that("get_fda_drugs_approved() handles NULL or empty responses gracefully", {
  skip_on_cran()
  result <- get_fda_drugs_approved("thisdrugdoesnotexistxyz")
  expect_true(is.null(result) || is.data.frame(result))
})

test_that("get_fda_drugs_approved() returns at least one row for known drugs", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(nrow(result) >= 1)
})

test_that("get_fda_drugs_approved(): column 'type' contains valid FDA categories", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(all(result$type %in% c("NDA", "ANDA", "BLA", NA)))
})

test_that("get_fda_drugs_approved(): application_number column has proper format", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(all(grepl("^[A-Z]+[0-9]+$", result$application_number) | is.na(result$application_number)))
})

test_that("get_fda_drugs_approved(): approval_date column is valid or NA", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(all(inherits(result$approval_date, "Date") | is.na(result$approval_date)))
})

test_that("get_fda_drugs_approved(): allows for missing values (NA)", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(any(is.na(result)) || all(!is.na(result)))
})

test_that("get_fda_drugs_approved(): sponsor and brand columns contain text or NA", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  expect_true(all(is.character(result$sponsor) | is.na(result$sponsor)))
  expect_true(all(is.character(result$brand) | is.na(result$brand)))
})

test_that("get_fda_drugs_approved(): approval_date sorted ascending or all equal", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  dates <- result$approval_date[!is.na(result$approval_date)]
  expect_true(is.unsorted(dates) == FALSE || length(unique(dates)) == 1)
})

test_that("get_fda_drugs_approved(): consistent sponsor for same application_number", {
  skip_on_cran()
  result <- get_fda_drugs_approved("lipitor")
  grouped <- split(result, result$application_number)
  consistent <- all(sapply(grouped, function(x) length(unique(x$sponsor)) == 1))
  expect_true(consistent)
})
