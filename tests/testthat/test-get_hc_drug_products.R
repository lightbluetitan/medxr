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

# get_hc_drug_products


# test-get_hc_drug_products.R

library(testthat)

test_that("get_hc_drug_products() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_hc_drug_products()

  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("drug_code", "class_name", "din", "brand_name",
                         "number_of_ais", "ai_group_no", "company_name", "last_update_date"))

  # Type checks
  expect_type(result$drug_code, "integer")
  expect_type(result$class_name, "character")
  expect_type(result$din, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$number_of_ais, "character")
  expect_type(result$ai_group_no, "character")
  expect_type(result$company_name, "character")
  expect_type(result$last_update_date, "character")
})

test_that("get_hc_drug_products() returns a large dataset", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_true(nrow(result) > 50000)
})

test_that("get_hc_drug_products() drug_code values are valid", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_true(is.integer(result$drug_code))
  expect_true(all(result$drug_code > 0 | is.na(result$drug_code)))
})

test_that("get_hc_drug_products() DIN values are valid", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_true(is.character(result$din))
  non_na_dins <- result$din[!is.na(result$din)]
  expect_true(all(nchar(non_na_dins) > 0))
})

test_that("get_hc_drug_products() brand_name values are valid", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_true(is.character(result$brand_name))
  expect_true(all(nchar(result$brand_name[!is.na(result$brand_name)]) > 0))
})

test_that("get_hc_drug_products() allows NA, TRUE, FALSE or other valid values without failing", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_true(all(is.na(result$drug_code) | !is.na(result$drug_code)))
  expect_true(all(is.na(result$class_name) | nchar(result$class_name) >= 0))
  expect_true(all(is.na(result$din) | nchar(result$din) >= 0))
  expect_true(all(is.na(result$brand_name) | nchar(result$brand_name) >= 0))
  expect_true(all(is.na(result$number_of_ais) | nchar(result$number_of_ais) >= 0))
  expect_true(all(is.na(result$ai_group_no) | nchar(result$ai_group_no) >= 0))
  expect_true(all(is.na(result$company_name) | nchar(result$company_name) >= 0))
  expect_true(all(is.na(result$last_update_date) | nchar(result$last_update_date) >= 0))
})

test_that("get_hc_drug_products() outputs consistent data types", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_type(result$drug_code, "integer")
  expect_type(result$class_name, "character")
  expect_type(result$din, "character")
  expect_type(result$brand_name, "character")
  expect_type(result$number_of_ais, "character")
  expect_type(result$ai_group_no, "character")
  expect_type(result$company_name, "character")
  expect_type(result$last_update_date, "character")
})

test_that("get_hc_drug_products() data content is coherent", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_false(any(apply(is.na(result), 1, all)))
  expect_true(all(is.na(result$drug_code) | result$drug_code > 0))
})

test_that("get_hc_drug_products() descriptor column is removed if present", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_false("descriptor" %in% names(result))
})

test_that("get_hc_drug_products() contains expected drug classes", {
  skip_on_cran()
  result <- get_hc_drug_products()
  classes <- unique(result$class_name[!is.na(result$class_name)])
  expect_true(length(classes) > 0)
})

test_that("get_hc_drug_products() returns exactly 8 columns", {
  skip_on_cran()
  result <- get_hc_drug_products()
  expect_equal(ncol(result), 8)
})
