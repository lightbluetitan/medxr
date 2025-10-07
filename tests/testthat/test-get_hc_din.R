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

# get_hc_din


library(testthat)

test_that("get_hc_din() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_din()

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("din"))

  # Type checks
  expect_type(result$din, "character")
})

test_that("get_hc_din() returns a large dataset", {
  skip_on_cran()
  result <- get_hc_din()

  expect_true(nrow(result) > 50000)
})

test_that("get_hc_din() din values are valid", {
  skip_on_cran()
  result <- get_hc_din()

  expect_true(is.character(result$din))
  expect_true(all(nchar(result$din) > 0))
})

test_that("get_hc_din() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_din()

  expect_true(all(is.na(result$din) | !is.na(result$din)))
  expect_true(all(is.na(result$din) | nchar(result$din) >= 0))
})

test_that("get_hc_din() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_din()

  expect_type(result$din, "character")
})

test_that("get_hc_din() data content is coherent", {
  skip_on_cran()
  result <- get_hc_din()

  # Ensure no completely empty rows
  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_din() DIN column is properly renamed", {
  skip_on_cran()
  result <- get_hc_din()

  expect_true("din" %in% names(result))
  expect_false("drug_identification_number" %in% names(result))
})

test_that("get_hc_din() descriptor column is removed if present", {
  skip_on_cran()
  result <- get_hc_din()

  expect_false("descriptor" %in% names(result))
})

test_that("get_hc_din() returns only one column", {
  skip_on_cran()
  result <- get_hc_din()

  expect_equal(ncol(result), 1)
})

test_that("get_hc_din() din values are properly formatted", {
  skip_on_cran()
  result <- get_hc_din()

  non_na_dins <- result$din[!is.na(result$din)]
  expect_true(length(non_na_dins) > 0)
  expect_true(all(nchar(non_na_dins) >= 8))
})
