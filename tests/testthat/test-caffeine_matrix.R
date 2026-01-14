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

# caffeine_matrix


library(testthat)

# Test 1: Confirm the object is a matrix and an array
test_that("caffeine_matrix is a matrix and an array", {
  expect_true(is.matrix(caffeine_matrix))
  expect_true(is.array(caffeine_matrix))
})

# Test 2: Confirm it has exactly 3 columns and 28 rows
test_that("caffeine_matrix has correct dimensions", {
  expect_equal(dim(caffeine_matrix), c(28, 3))
})

# Test 3: Confirm it has exactly 84 elements (28 * 3)
test_that("caffeine_matrix has 84 elements", {
  expect_equal(length(caffeine_matrix), 84)
})

# Test 4: Confirm column names are correct and in order
test_that("caffeine_matrix has correct column names", {
  expect_equal(colnames(caffeine_matrix), c("Grade", "Without", "With"))
})

# Test 5: Confirm all elements are numeric
test_that("caffeine_matrix contains only numeric values", {
  expect_type(caffeine_matrix, "double")
})

# Test 6: Confirm row and column names exist
test_that("caffeine_matrix has both row and column names", {
  expect_true(!is.null(rownames(caffeine_matrix)))
  expect_true(!is.null(colnames(caffeine_matrix)))
})
