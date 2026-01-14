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


#' Get a Drug Product by DIN from Health Canada Drug Product Database
#'
#' @description
#' Retrieves detailed information for a specific drug product listed in the
#' Health Canada Drug Product Database (DPD) using the RESTful API endpoint
#' \code{/drug/drugproduct?din=<DIN>}.
#'
#' This includes details such as the Drug Identification Number (DIN),
#' product name, class, number of active ingredients, company name,
#' and update date.
#'
#' @param din A character or numeric string representing the Drug Identification Number (DIN)
#'            of the product to retrieve.
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{drug_code}: Unique code identifying the drug product
#'   \item \code{class_name}: Class of drug (e.g., Human, Veterinary)
#'   \item \code{din}: DIN assigned by Health Canada
#'   \item \code{brand_name}: Brand or trade name of the product
#'   \item \code{number_of_ais}: Number of active ingredients
#'   \item \code{ai_group_no}: Active ingredient group number
#'   \item \code{company_name}: Manufacturer name
#'   \item \code{last_update_date}: Date of last update in the database
#' }
#' Returns \code{NULL} if the resource is unavailable or if an error occurs.
#'
#' @details
#' Sends a GET request to the Health Canada Drug Product Database API.
#' Supports caching via the \pkg{memoise} package and enforces a
#' rate limit between successive API requests.
#'
#' If the DIN does not exist or the API returns an error, the function
#' returns \code{NULL} with an informative message.
#'
#' The function fails gracefully when internet resources are unavailable,
#' including SSL certificate errors, network timeouts, or server issues.
#'
#' @note Requires an internet connection.
#'
#' @source Health Canada Drug Product Database (DPD) API:
#' \url{https://health-products.canada.ca/api/documentation/dpd-documentation-en.html}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from Health Canada
#'   result <- get_hc_drug_by_din("02456789")
#'   if (!is.null(result)) {
#'     print(result)
#'   }
#' }
#'
#' @seealso
#' \code{\link[httr]{GET}},
#' \code{\link[jsonlite]{fromJSON}},
#' \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET content timeout
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom memoise memoise
#'
#' @export
get_hc_drug_by_din <- function(din) {
  if (missing(din) || length(din) != 1) {
    stop("Please provide a single DIN value as input.")
  }

  base_url <- "https://health-products.canada.ca/api/drug/drugproduct"
  url <- paste0(base_url, "?din=", din)

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)

    # Wrap the httr::GET call in tryCatch to handle network/SSL errors gracefully
    res <- tryCatch(
      {
        httr::GET(url, httr::timeout(30))
      },
      error = function(e) {
        message("Unable to connect to Health Canada API.")
        message("Error details: ", conditionMessage(e))
        message("Please check your internet connection and try again later.")
        message("If the problem persists, the API server may be temporarily unavailable.")
        return(NULL)
      }
    )

    # If connection failed, return NULL
    if (is.null(res)) {
      return(NULL)
    }

    # Handle HTTP status codes
    if (res$status_code == 404) {
      message(paste("DIN", din, "not found in Health Canada database."))
      return(NULL)
    }

    if (res$status_code != 200) {
      message(paste("Error: API request failed with status", res$status_code))
      message("The Health Canada API may be temporarily unavailable.")
      return(NULL)
    }

    # Parse JSON response
    json_text <- tryCatch(
      {
        httr::content(res, "text", encoding = "UTF-8")
      },
      error = function(e) {
        message("Error reading API response: ", conditionMessage(e))
        return(NULL)
      }
    )

    if (is.null(json_text)) {
      return(NULL)
    }

    data <- tryCatch(
      {
        jsonlite::fromJSON(json_text, flatten = TRUE)
      },
      error = function(e) {
        message("Error parsing JSON response: ", conditionMessage(e))
        return(NULL)
      }
    )

    if (is.null(data) || length(data) == 0) {
      message("No data returned from Health Canada API for DIN ", din)
      return(NULL)
    }

    # Remove unused column if present
    if ("descriptor" %in% names(data)) data$descriptor <- NULL

    # Rename the column for clarity
    if ("drug_identification_number" %in% names(data)) {
      names(data)[names(data) == "drug_identification_number"] <- "din"
    }

    df <- dplyr::as_tibble(data)
    return(df)
  })

  df <- fetch_data(url)
  return(df)
}
