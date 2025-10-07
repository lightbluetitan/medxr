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


#' Retrieve Drug Products from Health Canada Drug Product Database
#'
#' @description
#' Retrieves information on all drug products listed in the
#' Health Canada Drug Product Database (DPD) using the
#' RESTful API endpoint \code{/drug/drugproduct}.
#'
#' Optionally, a partial product name can be provided to
#' filter the results to products that contain the search term
#' in their brand name.
#'
#' @param name Optional. A character string representing a partial
#' or complete name of the drug product to filter results.
#' If omitted, returns all available products.
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{drug_code}: Unique code identifying the drug product
#'   \item \code{class_name}: Class of drug (e.g., Human, Veterinary)
#'   \item \code{din}: Drug Identification Number (DIN)
#'   \item \code{brand_name}: Brand or trade name of the product
#'   \item \code{number_of_ais}: Number of active ingredients
#'   \item \code{ai_group_no}: Active ingredient group number
#'   \item \code{company_name}: Manufacturer name
#'   \item \code{last_update_date}: Date of last update in the database
#' }
#'
#' @details
#' This function sends a GET request to the Health Canada Drug Product Database API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and respects a rate limit between successive API requests.
#'
#' If the API request fails, returns no matches, or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an internet connection.
#'
#' @source Health Canada Drug Product Database (DPD) API:
#' \url{https://health-products.canada.ca/api/documentation/dpd-documentation-en.html}
#'
#' @examples
#' if (interactive()) {
#'   # Retrieve all products
#'   get_hc_drug_products()
#'
#'   # Retrieve products matching a partial name
#'   get_hc_drug_products("acetaminophen")
#' }
#'
#' @seealso
#' \code{\link[httr]{GET}},
#' \code{\link[jsonlite]{fromJSON}},
#' \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom memoise memoise
#'
#' @export
get_hc_drug_products <- function(name = NULL) {
  base_url <- "https://health-products.canada.ca/api/drug/drugproduct"

  # If a name is provided, add query parameter
  if (!is.null(name)) {
    if (!is.character(name) || length(name) != 1) {
      stop("Please provide a single name as a character string.")
    }
    url <- paste0(base_url, "?search=", URLencode(name))
  } else {
    url <- base_url
  }

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Respect rate limit (max 5 req/sec)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No products found matching the search term.")
      return(NULL)
    }

    if (res$status_code != 200) {
      message(paste("Error: API request failed with status", res$status_code))
      return(NULL)
    }

    json_text <- httr::content(res, "text", encoding = "UTF-8")
    data <- jsonlite::fromJSON(json_text, flatten = TRUE)

    if (is.null(data) || length(data) == 0) {
      message("No data returned from Health Canada API.")
      return(NULL)
    }

    # Remove unused column if present
    if ("descriptor" %in% names(data)) data$descriptor <- NULL

    # Convert to tibble
    df <- dplyr::as_tibble(data)

    # Rename DIN column for consistency
    if ("drug_identification_number" %in% names(df)) {
      names(df)[names(df) == "drug_identification_number"] <- "din"
    }

    # Optional name filter (case-insensitive)
    if (!is.null(name)) {
      df <- df[grepl(name, df$brand_name, ignore.case = TRUE), ]
    }

    return(df)
  })

  df <- fetch_data(url)
  return(df)
}
