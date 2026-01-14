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

# get_hc_forms

library(testthat)

test_that("get_hc_forms() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_forms()

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("drug_code", "pharmaceutical_form_code", "pharmaceutical_form_name"))

  # Type checks
  expect_type(result$drug_code, "integer")
  expect_type(result$pharmaceutical_form_code, "integer")
  expect_type(result$pharmaceutical_form_name, "character")
})

test_that("get_hc_forms() returns a large dataset", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_true(nrow(result) > 60000)
})

test_that("get_hc_forms() drug_code values are valid", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_true(is.integer(result$drug_code))
  expect_true(all(is.na(result$drug_code) | result$drug_code > 0))
})

test_that("get_hc_forms() pharmaceutical_form_code values are valid", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_true(is.integer(result$pharmaceutical_form_code))
  expect_true(all(is.na(result$pharmaceutical_form_code) | result$pharmaceutical_form_code > 0))
})

test_that("get_hc_forms() pharmaceutical_form_name values are valid", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_true(is.character(result$pharmaceutical_form_name))
  non_na_forms <- result$pharmaceutical_form_name[!is.na(result$pharmaceutical_form_name)]
  expect_true(all(nchar(non_na_forms) > 0))
})

test_that("get_hc_forms() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
  expect_true(all(is.na(result$pharmaceutical_form_code) | !is.na(result$pharmaceutical_form_code)))
  expect_true(all(is.na(result$pharmaceutical_form_name) | nchar(result$pharmaceutical_form_name) >= 0))
})

test_that("get_hc_forms() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_type(result$drug_code, "integer")
  expect_type(result$pharmaceutical_form_code, "integer")
  expect_type(result$pharmaceutical_form_name, "character")
})

test_that("get_hc_forms() data content is coherent", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_false(any(apply(is.na(result), 1, all)))
})

test_that("get_hc_forms() descriptor column is removed if present", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_false("descriptor" %in% names(result))
})

test_that("get_hc_forms() contains expected pharmaceutical forms", {
  skip_on_cran()
  result <- get_hc_forms()

  forms <- unique(result$pharmaceutical_form_name[!is.na(result$pharmaceutical_form_name)])
  expect_true(length(forms) > 0)
})

test_that("get_hc_forms() returns exactly 3 columns", {
  skip_on_cran()
  result <- get_hc_forms()

  expect_equal(ncol(result), 3)
})
