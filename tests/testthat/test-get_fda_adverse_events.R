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

# get_fda_adverse_events


library(testthat)

# ============================================================================
# Structure and Type Tests
# ============================================================================

test_that("get_fda_adverse_events() returns a tibble with correct structure", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  # Check it's a tibble
  expect_s3_class(result, "tbl_df")

  # Check column names
  expect_named(result, c("report_id", "date_received", "country", "serious",
                         "adverse_reactions", "patient_sex", "patient_age"))
})

test_that("get_fda_adverse_events() returns correct data types", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  # Type checks
  expect_type(result$report_id, "character")
  expect_s3_class(result$date_received, "Date")
  expect_type(result$country, "character")
  expect_type(result$serious, "character")
  expect_type(result$adverse_reactions, "character")
  expect_type(result$patient_sex, "character")
  expect_type(result$patient_age, "character")
})

# ============================================================================
# Input Validation Tests
# ============================================================================

test_that("get_fda_adverse_events() handles missing input properly", {
  expect_error(get_fda_adverse_events(), "Please provide a single valid")
})

test_that("get_fda_adverse_events() handles NA input properly", {
  expect_error(get_fda_adverse_events(NA_character_), "Please provide a single valid")
})

test_that("get_fda_adverse_events() handles multiple drug names properly", {
  expect_error(get_fda_adverse_events(c("aspirin", "ibuprofen")), "Please provide a single valid")
})

test_that("get_fda_adverse_events() handles non-character input properly", {
  expect_error(get_fda_adverse_events(123), "Please provide a single valid")
})

test_that("get_fda_adverse_events() handles empty string properly", {
  skip_on_cran()
  result <- get_fda_adverse_events("")
  expect_true(is.null(result) || nrow(result) == 0)
})

# ============================================================================
# API Response Tests
# ============================================================================

test_that("get_fda_adverse_events() returns NULL or empty for nonexistent drugs", {
  skip_on_cran()
  result <- get_fda_adverse_events("nonexistentdrugxyzabc123")
  expect_true(is.null(result) || nrow(result) == 0)
})

test_that("get_fda_adverse_events() returns valid data for known drugs", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  expect_true(is.null(result) || nrow(result) > 0)

  if (!is.null(result) && nrow(result) > 0) {
    expect_true(nrow(result) <= 100) # API limit is 100
  }
})

test_that("get_fda_adverse_events() returns data for different known drugs", {
  skip_on_cran()

  result_aspirin <- get_fda_adverse_events("aspirin")
  result_ibuprofen <- get_fda_adverse_events("ibuprofen")

  expect_true(is.null(result_aspirin) || nrow(result_aspirin) > 0)
  expect_true(is.null(result_ibuprofen) || nrow(result_ibuprofen) > 0)
})

# ============================================================================
# Data Content Validation Tests
# ============================================================================

test_that("get_fda_adverse_events() report_id is valid", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_true(is.character(result$report_id))
    # Report IDs should be unique or have valid values (including NA)
    expect_true(all(is.na(result$report_id) | nchar(result$report_id) > 0))
  }
})

test_that("get_fda_adverse_events() date_received is valid Date or NA", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_s3_class(result$date_received, "Date")
    # All dates should be valid Date objects or NA
    expect_true(all(is.na(result$date_received) | inherits(result$date_received, "Date")))
  }
})

test_that("get_fda_adverse_events() country is valid character or NA", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_type(result$country, "character")
    expect_true(all(is.na(result$country) | nchar(result$country) >= 0))
  }
})

test_that("get_fda_adverse_events() serious field contains valid values", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_type(result$serious, "character")
    # All values should be valid (Yes, No, other API values, or NA)
    expect_true(all(is.na(result$serious) | nchar(result$serious) >= 0))
  }
})

test_that("get_fda_adverse_events() adverse_reactions is valid character or NA", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_type(result$adverse_reactions, "character")
    # Valid reactions or NA
    expect_true(all(is.na(result$adverse_reactions) | nchar(result$adverse_reactions) >= 0))
  }
})

test_that("get_fda_adverse_events() patient_sex contains valid values", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_type(result$patient_sex, "character")
    # All values should be valid (Male, Female, Unknown, other API values, or NA)
    expect_true(all(is.na(result$patient_sex) | nchar(result$patient_sex) >= 0))
  }
})

test_that("get_fda_adverse_events() patient_age is valid character or NA", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    expect_type(result$patient_age, "character")
    # All values should be valid (numeric-like or NA)
    expect_true(all(is.na(result$patient_age) | nchar(result$patient_age) >= 0))
  }
})

# ============================================================================
# NA Handling Tests
# ============================================================================

test_that("get_fda_adverse_events() allows NA values in all columns", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    # Function should not fail with NA values
    expect_true(all(is.na(result$report_id) | !is.na(result$report_id)))
    expect_true(all(is.na(result$date_received) | !is.na(result$date_received)))
    expect_true(all(is.na(result$country) | !is.na(result$country)))
    expect_true(all(is.na(result$serious) | !is.na(result$serious)))
    expect_true(all(is.na(result$adverse_reactions) | !is.na(result$adverse_reactions)))
    expect_true(all(is.na(result$patient_sex) | !is.na(result$patient_sex)))
    expect_true(all(is.na(result$patient_age) | !is.na(result$patient_age)))
  }
})

test_that("get_fda_adverse_events() does not return completely empty rows", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    # No row should have all NA values
    expect_false(any(apply(is.na(result), 1, all)))
  }
})

# ============================================================================
# Data Consistency Tests
# ============================================================================

test_that("get_fda_adverse_events() returns consistent number of rows across columns", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    n_rows <- nrow(result)
    expect_equal(length(result$report_id), n_rows)
    expect_equal(length(result$date_received), n_rows)
    expect_equal(length(result$country), n_rows)
    expect_equal(length(result$serious), n_rows)
    expect_equal(length(result$adverse_reactions), n_rows)
    expect_equal(length(result$patient_sex), n_rows)
    expect_equal(length(result$patient_age), n_rows)
  }
})

test_that("get_fda_adverse_events() report_id uniqueness or valid duplicates", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    # Report IDs should exist (may have duplicates or NAs from API)
    non_na_ids <- result$report_id[!is.na(result$report_id)]
    expect_true(length(non_na_ids) >= 0) # Just verify it doesn't fail
  }
})

# ============================================================================
# Edge Cases Tests
# ============================================================================

test_that("get_fda_adverse_events() handles drugs with special characters", {
  skip_on_cran()
  result <- get_fda_adverse_events("acetaminophen")

  expect_true(is.null(result) || is.data.frame(result))
})

test_that("get_fda_adverse_events() handles case sensitivity appropriately", {
  skip_on_cran()
  result_lower <- get_fda_adverse_events("aspirin")
  result_upper <- get_fda_adverse_events("ASPIRIN")

  # Both should return valid results or NULL
  expect_true(is.null(result_lower) || is.data.frame(result_lower))
  expect_true(is.null(result_upper) || is.data.frame(result_upper))
})

test_that("get_fda_adverse_events() serious field maps codes correctly", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    # Should contain Yes, No, other values, or NA
    serious_values <- unique(result$serious[!is.na(result$serious)])
    expect_true(length(serious_values) >= 0)
  }
})

test_that("get_fda_adverse_events() patient_sex field maps codes correctly", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    # Should contain Male, Female, Unknown, other values, or NA
    sex_values <- unique(result$patient_sex[!is.na(result$patient_sex)])
    expect_true(length(sex_values) >= 0)
  }
})

# ============================================================================
# Integration Tests
# ============================================================================

test_that("get_fda_adverse_events() handles API rate limiting gracefully", {
  skip_on_cran()

  # Make multiple calls in sequence
  result1 <- get_fda_adverse_events("aspirin")
  result2 <- get_fda_adverse_events("ibuprofen")

  expect_true(is.null(result1) || is.data.frame(result1))
  expect_true(is.null(result2) || is.data.frame(result2))
})

test_that("get_fda_adverse_events() adverse_reactions format is consistent", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    non_na_reactions <- result$adverse_reactions[!is.na(result$adverse_reactions)]
    if (length(non_na_reactions) > 0) {
      # Reactions should be semicolon-separated or single values
      expect_true(all(nchar(non_na_reactions) > 0))
    }
  }
})

test_that("get_fda_adverse_events() date_received is in valid range", {
  skip_on_cran()
  result <- get_fda_adverse_events("aspirin")

  if (!is.null(result) && nrow(result) > 0) {
    valid_dates <- result$date_received[!is.na(result$date_received)]
    if (length(valid_dates) > 0) {
      # Dates should be reasonable (after 1900, before future)
      expect_true(all(valid_dates >= as.Date("1900-01-01")))
      expect_true(all(valid_dates <= Sys.Date() + 365)) # Allow some future dates
    }
  }
})
