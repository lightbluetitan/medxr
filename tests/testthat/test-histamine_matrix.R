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

# histamine_matrix

library(testthat)

# Test 1: Confirm the object is a matrix and an array
test_that("histamine_matrix is a matrix and an array", {
  expect_true(is.matrix(histamine_matrix))
  expect_true(is.array(histamine_matrix))
})

# Test 2: Confirm it has exactly 4 columns and 16 rows
test_that("histamine_matrix has correct dimensions", {
  expect_equal(dim(histamine_matrix), c(16, 4))
})

# Test 3: Confirm it has exactly 64 elements (16 * 4)
test_that("histamine_matrix has 64 elements", {
  expect_equal(length(histamine_matrix), 64)
})

# Test 4: Confirm column names are correct and in order
test_that("histamine_matrix has correct column names", {
  expect_equal(colnames(histamine_matrix), c("Before", "After1", "After3", "After5"))
})

# Test 5: Confirm all elements are numeric
test_that("histamine_matrix contains only numeric values", {
  expect_type(histamine_matrix, "double")
})

# Test 6: Confirm row and column names exist
test_that("histamine_matrix has both row and column names", {
  expect_true(!is.null(rownames(histamine_matrix)))
  expect_true(!is.null(colnames(histamine_matrix)))
})
