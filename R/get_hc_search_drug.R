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


#' Search Drug Products by Brand Name in Health Canada Drug Product Database
#'
#' @description
#' Retrieves drug products from the Health Canada Drug Product Database (DPD)
#' that match a specific brand (commercial) name using the RESTful API endpoint
#' \code{/drug/drugproduct?search=<brand_name>}.
#'
#' This includes details such as the Drug Identification Number (DIN),
#' product name, class, number of active ingredients, company name,
#' and update date for each approved or discontinued pharmaceutical product.
#'
#' @param brand_name A character string representing the commercial name of the drug.
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
#'   get_hc_search_drug("NEMBUTAL")
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
get_hc_search_drug <- function(brand_name) {
  if (missing(brand_name) || !is.character(brand_name) || length(brand_name) != 1) {
    stop("Please provide a single brand name as a character string.")
  }

  base_url <- "https://health-products.canada.ca/api/drug/drugproduct"
  url <- paste0(base_url, "?search=", URLencode(brand_name))

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No products found matching the brand name.")
      return(NULL)
    }

    if (res$status_code != 200) {
      message(paste("Error: API request failed with status", res$status_code))
      return(NULL)
    }

    json_text <- httr::content(res, "text", encoding = "UTF-8")
    data <- jsonlite::fromJSON(json_text, flatten = TRUE)

    if (is.null(data) || length(data) == 0) {
      message("No data returned from Health Canada API for brand name: ", brand_name)
      return(NULL)
    }

    # Remove unused column if present
    if ("descriptor" %in% names(data)) data$descriptor <- NULL

    # Convert to tibble
    df <- dplyr::as_tibble(data)

    # Rename DIN column for convenience
    if ("drug_identification_number" %in% names(df)) {
      names(df)[names(df) == "drug_identification_number"] <- "din"
    }

    # Filter rows by brand_name (case-insensitive)
    df <- df[grepl(brand_name, df$brand_name, ignore.case = TRUE), ]

    return(df)
  })

  df <- fetch_data(url)
  return(df)
}
