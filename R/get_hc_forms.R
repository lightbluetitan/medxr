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


#' Get Pharmaceutical Forms from Health Canada Drug Product Database
#'
#' @description
#' Retrieves information on all pharmaceutical dosage forms listed in the
#' Health Canada Drug Product Database (DPD) using the
#' RESTful API endpoint \code{/drug/form}.
#'
#' This includes details such as the drug code, form code, and the
#' pharmaceutical form name (e.g., tablet, capsule, solution).
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{drug_code}: Unique code identifying the drug product.
#'   \item \code{pharm_form_code}: Code representing the pharmaceutical form.
#'   \item \code{pharm_form_desc}: Description of the pharmaceutical form (e.g., Tablet, Capsule, Solution).
#' }
#'
#' @details
#' This function sends a GET request to the Health Canada Drug Product Database API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and respects a rate limit between successive API requests.
#'
#' If the API request fails or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an internet connection.
#'
#' @source Health Canada Drug Product Database (DPD) API:
#' \url{https://health-products.canada.ca/api/documentation/dpd-documentation-en.html}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from Health Canada
#'   get_hc_forms()
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
get_hc_forms <- function() {
  url <- "https://health-products.canada.ca/api/drug/form"
  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 requests/second)
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
    # Remove unnecessary columns (if any exist)
    if ("descriptor" %in% names(data)) data$descriptor <- NULL
    df <- dplyr::as_tibble(data)
    return(df)
  })
  df <- fetch_data(url)
  return(df)
}
