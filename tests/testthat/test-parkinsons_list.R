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

# parkinsons_list

library(testthat)

# Test 1: Confirm the object is a list
test_that("parkinsons_list is a list", {
  expect_type(parkinsons_list, "list")
})

# Test 2: Confirm it has exactly 5 elements
test_that("parkinsons_list has 5 elements", {
  expect_length(parkinsons_list, 5)
})

# Test 3: Confirm the list has correct element names
test_that("parkinsons_list has correct element names", {
  expect_named(parkinsons_list, c(
    "Outcomes", "SE", "Treat", "Study", "Treat.order"
  ))
})

# Test 4: Confirm element types are correct
test_that("parkinsons_list elements have correct types", {
  expect_type(parkinsons_list$Outcomes, "double")
  expect_type(parkinsons_list$SE, "double")
  expect_type(parkinsons_list$Treat, "character")
  expect_type(parkinsons_list$Study, "double")
  expect_type(parkinsons_list$Treat.order, "character")
})

# Test 5: Confirm element lengths are correct
test_that("parkinsons_list elements have correct lengths", {
  expect_length(parkinsons_list$Outcomes, 15)
  expect_length(parkinsons_list$SE, 15)
  expect_length(parkinsons_list$Treat, 15)
  expect_length(parkinsons_list$Study, 15)
  expect_length(parkinsons_list$Treat.order, 5)
})
