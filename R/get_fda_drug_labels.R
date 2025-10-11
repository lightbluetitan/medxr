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


#' Search Drug Labels by Drug Name in FDA Drug Labeling Database
#'
#' @description
#' Retrieves drug label information from the FDA Drug Labeling Database
#' that match a specific drug name using the RESTful API endpoint
#' \code{/drug/label.json?search=<drug_name>}.
#'
#' This includes details such as the product ID, brand name, generic name,
#' indications and usage, dosage and administration, warnings,
#' drug interactions, and other prescribing information from FDA-approved drug labels.
#'
#' @param drug_name A character string representing the name of the drug.
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{product_id}: Unique identifier for the product
#'   \item \code{brand_name}: Brand or trade name of the product
#'   \item \code{generic_name}: Generic name of the active ingredient
#'   \item \code{manufacturer}: Name of the manufacturer
#'   \item \code{product_type}: Type of drug product
#'   \item \code{route}: Route of administration
#'   \item \code{indications}: Approved indications for use
#'   \item \code{warnings}: Important warnings and precautions
#' }
#'
#' @details
#' This function sends a GET request to the FDA openFDA API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and respects a rate limit between successive API requests.
#'
#' If the API request fails, returns no matches, or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an internet connection.
#'
#' @source FDA Drug Labeling Database via openFDA:
#' \url{https://open.fda.gov/apis/drug/label/}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from FDA
#'   get_fda_drug_labels("aspirin")
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
get_fda_drug_labels <- function(drug_name) {
  if (missing(drug_name) || !is.character(drug_name) || length(drug_name) != 1) {
    stop("Please provide a single drug name as a character string.")
  }

  base_url <- "https://api.fda.gov/drug/label.json"
  search_query <- paste0("(openfda.generic_name:", URLencode(drug_name),
                         "+openfda.brand_name:", URLencode(drug_name), ")")
  url <- paste0(base_url, "?search=", search_query, "&limit=100")

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No drug labels found matching the drug name.")
      return(NULL)
    }
    if (res$status_code != 200) {
      message(paste("Error: API request failed with status", res$status_code))
      return(NULL)
    }

    json_text <- httr::content(res, "text", encoding = "UTF-8")
    data <- jsonlite::fromJSON(json_text, flatten = TRUE)

    if (is.null(data$results) || length(data$results) == 0) {
      message("No data returned from FDA API for drug name: ", drug_name)
      return(NULL)
    }

    df <- dplyr::as_tibble(data$results)

    # Extract desired columns
    product_id <- if ("id" %in% names(df)) df$id else NA_character_
    brand_name <- if ("openfda.brand_name" %in% names(df)) sapply(df$openfda.brand_name, function(x) paste(x, collapse = "; ")) else NA_character_
    generic_name <- if ("openfda.generic_name" %in% names(df)) sapply(df$openfda.generic_name, function(x) paste(x, collapse = "; ")) else NA_character_
    manufacturer <- if ("openfda.manufacturer_name" %in% names(df)) sapply(df$openfda.manufacturer_name, function(x) paste(x, collapse = "; ")) else NA_character_
    product_type <- if ("openfda.product_type" %in% names(df)) sapply(df$openfda.product_type, function(x) paste(x, collapse = "; ")) else NA_character_
    route <- if ("openfda.route" %in% names(df)) sapply(df$openfda.route, function(x) paste(x, collapse = "; ")) else NA_character_
    indications <- if ("indications_and_usage" %in% names(df)) sapply(df$indications_and_usage, function(x) paste(x, collapse = " ")) else NA_character_
    warnings <- if ("warnings" %in% names(df)) sapply(df$warnings, function(x) paste(x, collapse = " ")) else if ("warnings_and_cautions" %in% names(df)) sapply(df$warnings_and_cautions, function(x) paste(x, collapse = " ")) else NA_character_

    # Final tibble with 8 columns (removed adverse_effects as it's not provided by API)
    label_data <- dplyr::tibble(
      product_id = product_id,
      brand_name = brand_name,
      generic_name = generic_name,
      manufacturer = manufacturer,
      product_type = product_type,
      route = route,
      indications = indications,
      warnings = warnings
    )

    return(label_data)
  })

  df <- fetch_data(url)
  return(df)
}
