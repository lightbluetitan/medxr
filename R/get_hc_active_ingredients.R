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

#' Get Active Ingredients from Health Canada Drug Product Database
#'
#' @description
#' Retrieves detailed information on all active ingredients
#' listed in the Health Canada Drug Product Database (DPD)
#' through the RESTful API endpoint \code{/drug/activeingredient}.
#'
#' Each record corresponds to a specific active ingredient
#' within a registered drug product, including concentration,
#' unit, and dosage details (if available).
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{dosage_unit}: Unit of dosage form (e.g., "ML", "%", "W/W")
#'   \item \code{dosage_value}: Numeric dosage quantity (e.g., "100")
#'   \item \code{drug_code}: Unique code identifying the drug product
#'   \item \code{ingredient_name}: Name of the active ingredient
#'   \item \code{strength}: Strength or concentration value (e.g., "50", "0.05")
#'   \item \code{strength_unit}: Unit of the strength (e.g., "MG", "G", "%", "NIL")
#' }
#'
#' @details
#' The function sends a GET request to the Health Canada DPD API.
#' It uses memoisation via the \pkg{memoise} package to cache results
#' and includes a rate limit delay between API requests.
#'
#' Missing values are retained as empty strings (\code{""}),
#' preserving the original schema of the API.
#'
#' @note Requires an active internet connection.
#'
#' @source Health Canada Drug Product Database (DPD) API:
#' \url{https://health-products.canada.ca/api/documentation/dpd-documentation-en.html}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from Health Canada
#'   get_hc_active_ingredients()
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
get_hc_active_ingredients <- function() {
  url <- "https://health-products.canada.ca/api/drug/activeingredient"
  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)
    res <- httr::GET(url)
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
    df <- dplyr::as_tibble(data)
    return(df)
  })
  df <- fetch_data(url)
  return(df)
}
