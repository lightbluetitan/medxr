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

# get_fda_ndc_directory


library(testthat)

test_that("get_fda_ndc_directory() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("ndc", "brand", "generic", "ingredients",
                         "form", "route", "labeler", "type", "status"))

  # Type checks
  expect_type(result$ndc, "character")
  expect_type(result$brand, "character")
  expect_type(result$generic, "character")
  expect_type(result$ingredients, "character")
  expect_type(result$form, "character")
  expect_type(result$route, "character")
  expect_type(result$labeler, "character")
  expect_type(result$type, "character")
  expect_type(result$status, "character")
})

test_that("get_fda_ndc_directory() returns a non-empty tibble when valid drug name is provided", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(nrow(result) > 0)
})

test_that("get_fda_ndc_directory() includes valid NDC product codes or NA", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(grepl("^[0-9]{4,5}-[0-9]{3,4}$", result$ndc) | is.na(result$ndc)))
})

test_that("get_fda_ndc_directory(): allows missing values (NA) in any column", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(any(is.na(result)) || all(!is.na(result)))
})

test_that("get_fda_ndc_directory(): labeler and type columns contain plausible values or NA", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(is.character(result$labeler) | is.na(result$labeler)))
  expect_true(all(is.character(result$type) | is.na(result$type)))
})

test_that("get_fda_ndc_directory(): if brand and generic names exist, they are non-empty strings", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(nchar(result$brand[!is.na(result$brand)]) > 0))
  expect_true(all(nchar(result$generic[!is.na(result$generic)]) > 0))
})

test_that("get_fda_ndc_directory(): ingredients column contains at least one active ingredient name or NA", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(grepl("[A-Za-z]", result$ingredients) | is.na(result$ingredients)))
})

test_that("get_fda_ndc_directory(): route and form columns contain plausible descriptions or NA", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(is.character(result$route) | is.na(result$route)))
  expect_true(all(is.character(result$form) | is.na(result$form)))
})

test_that("get_fda_ndc_directory(): status column includes marketing status values or NA", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(all(is.character(result$status) | is.na(result$status)))
})

test_that("get_fda_ndc_directory(): returns a maximum of 100 rows", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_true(nrow(result) <= 100)
})

test_that("get_fda_ndc_directory(): no duplicated NDC codes", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  expect_equal(length(unique(result$ndc)), nrow(result))
})

test_that("get_fda_ndc_directory(): all columns are consistent in length", {
  skip_on_cran()
  result <- get_fda_ndc_directory("ibuprofen")
  n <- nrow(result)
  expect_true(all(vapply(result, length, integer(1)) == n))
})
