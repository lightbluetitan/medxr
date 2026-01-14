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


#' Search National Drug Code (NDC) Directory by Drug Name
#'
#' @description
#' Retrieves National Drug Code (NDC) information from the FDA NDC Directory
#' that match a specific drug name using the RESTful API endpoint
#' \code{/drug/ndc.json?search=<drug_name>}.
#'
#' This includes details such as the NDC product code, brand name, generic name,
#' labeler information, product type, dosage form, route of administration,
#' marketing status, and active ingredients for pharmaceutical products
#' marketed in the United States.
#'
#' @param drug_name A character string representing the name of the drug
#'   (brand name or generic name).
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{ndc}: National Drug Code (NDC) product identifier
#'   \item \code{brand}: Brand or proprietary name of the drug product
#'   \item \code{generic}: Generic (non-proprietary) name of the drug
#'   \item \code{ingredients}: List of active ingredients with strengths
#'   \item \code{form}: Pharmaceutical dosage form (e.g., TABLET, CAPSULE)
#'   \item \code{route}: Route of administration (e.g., ORAL, INTRAVENOUS)
#'   \item \code{labeler}: Name of the company that labels/markets the product
#'   \item \code{type}: Type of drug product (e.g., HUMAN PRESCRIPTION DRUG)
#'   \item \code{status}: Current marketing status (e.g., Prescription)
#' }
#'
#' @details
#' This function sends a GET request to the FDA openFDA API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and respects a rate limit between successive API requests.
#'
#' The NDC Directory contains information on final marketed drugs submitted to FDA
#' in SPL (Structured Product Labeling) electronic listing files. Assignment of
#' an NDC number does not denote FDA approval of the product.
#'
#' If the API request fails, returns no matches, or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an internet connection. The NDC Directory is updated daily by FDA.
#'
#' @source FDA National Drug Code Directory via openFDA:
#' \url{https://open.fda.gov/apis/drug/ndc/}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from FDA
#'   get_fda_ndc_directory("aspirin")
#'   get_fda_ndc_directory("ibuprofen")
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
get_fda_ndc_directory <- function(drug_name) {
  if (missing(drug_name) || !is.character(drug_name) || length(drug_name) != 1) {
    stop("Please provide a single drug name as a character string.")
  }

  base_url <- "https://api.fda.gov/drug/ndc.json"
  search_query <- paste0("(brand_name:", URLencode(drug_name),
                         "+generic_name:", URLencode(drug_name), ")")
  url <- paste0(base_url, "?search=", search_query, "&limit=100")

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No NDC entries found matching the drug name.")
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

    # Extract key NDC information with shortened names
    ndc <- if ("product_ndc" %in% names(df)) df$product_ndc else NA_character_
    brand <- if ("brand_name" %in% names(df)) df$brand_name else NA_character_
    generic <- if ("generic_name" %in% names(df)) df$generic_name else NA_character_

    # Extract active ingredients with strengths (priority display)
    ingredients <- if ("active_ingredients" %in% names(df)) {
      sapply(seq_len(nrow(df)), function(i) {
        ing <- df$active_ingredients[[i]]
        if (is.null(ing) || nrow(ing) == 0) {
          return(NA_character_)
        }
        ing_list <- apply(ing, 1, function(row) {
          name <- if ("name" %in% names(row)) row["name"] else ""
          strength <- if ("strength" %in% names(row)) row["strength"] else ""
          if (name != "" && strength != "") {
            paste0(name, " (", strength, ")")
          } else if (name != "") {
            name
          } else {
            NA_character_
          }
        })
        paste(ing_list[!is.na(ing_list)], collapse = "; ")
      })
    } else {
      NA_character_
    }

    form <- if ("dosage_form" %in% names(df)) df$dosage_form else NA_character_
    route <- if ("route" %in% names(df)) {
      sapply(df$route, function(x) {
        if (is.null(x) || length(x) == 0) return(NA_character_)
        paste(x, collapse = "; ")
      })
    } else {
      NA_character_
    }
    labeler <- if ("labeler_name" %in% names(df)) df$labeler_name else NA_character_
    type <- if ("product_type" %in% names(df)) df$product_type else NA_character_
    status <- if ("marketing_category" %in% names(df)) {
      df$marketing_category
    } else {
      NA_character_
    }

    # Create final tibble with reordered columns (most relevant first)
    ndc_data <- dplyr::tibble(
      ndc,
      brand,
      generic,
      ingredients,
      form,
      route,
      labeler,
      type,
      status
    )

    return(ndc_data)
  })

  df <- fetch_data(url)
  return(df)
}
