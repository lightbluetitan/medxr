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


#' Get Companies from Health Canada Drug Product Database
#'
#' @description
#' Retrieves information on all pharmaceutical companies listed in the
#' Health Canada Drug Product Database (DPD) using the
#' RESTful API endpoint \code{/drug/company}.
#'
#' This includes details such as the company code, company name,
#' address, city, province, postal code, and country.
#' Each record corresponds to a company associated with one or more
#' approved or discontinued drug products.
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{company_code}: Unique identifier for the company
#'   \item \code{company_name}: Official registered name of the company
#'   \item \code{company_type}: Type of company (e.g., "DIN OWNER", "Manufacturer")
#'   \item \code{city_name}: City where the company is located
#'   \item \code{province_name}: Province or territory (if applicable)
#'   \item \code{country_name}: Country name
#'   \item \code{postal_code}: Postal code or ZIP code
#'   \item \code{street_name}: Street address
#' }
#'
#' @details
#' This function sends a GET request to the Health Canada Drug Product Database API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and includes a small rate limit delay between successive API requests.
#'
#' The columns \code{post_office_box} and \code{suite_number} are automatically
#' removed as they generally contain incomplete or irrelevant information.
#'
#' If the API request fails or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an active internet connection.
#'
#' @source Health Canada Drug Product Database (DPD) API:
#' \url{https://health-products.canada.ca/api/documentation/dpd-documentation-en.html}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from Health Canada
#'   get_hc_companies()
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
get_hc_companies <- function() {
  url <- "https://health-products.canada.ca/api/drug/company"
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
    # Remove unused columns
    data$post_office_box <- NULL
    data$suite_number <- NULL
    df <- dplyr::as_tibble(data)
    return(df)
  })
  df <- fetch_data(url)
  return(df)
}
