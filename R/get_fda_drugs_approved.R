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


#' Search FDA-Approved Drugs by Drug Name
#'
#' @description
#' Retrieves information about FDA-approved drug products from the official
#' Drugs at FDA database that match a specific drug name using the RESTful API
#' endpoint \code{/drug/drugsfda.json?search=<drug_name>}.
#'
#' This includes details such as the application number, sponsor name, approval dates,
#' product information, application type (NDA, ANDA, BLA), and submission details
#' for brand name drugs, generic drugs, and therapeutic biological products approved
#' by the FDA since 1939.
#'
#' @param drug_name A character string representing the name of the drug
#'   (brand name or generic name).
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{application_number}: FDA application number (NDA, ANDA, or BLA)
#'   \item \code{sponsor}: Name of the company that holds the application
#'   \item \code{brand}: Brand or trade name of the approved product
#'   \item \code{generic}: Generic (non-proprietary) name of the active ingredient
#'   \item \code{type}: Application type (NDA, ANDA, BLA)
#'   \item \code{approval_date}: Date the product was approved by FDA
#'   \item \code{strength}: Dosage strength of the product
#'   \item \code{form}: Pharmaceutical dosage form
#'   \item \code{route}: Route of administration
#' }
#'
#' @details
#' This function sends a GET request to the FDA openFDA API.
#' It supports caching via the \pkg{memoise} package to avoid redundant calls,
#' and respects a rate limit between successive API requests.
#'
#' The Drugs at FDA database contains information about drug products approved
#' since 1939. The majority of labels, approval letters, and reviews are
#' available for products approved since 1998. This database includes brand
#' name drugs, generic drugs, and therapeutic biological products.
#'
#' If the API request fails, returns no matches, or returns an error status code,
#' the function returns \code{NULL} with an informative message.
#'
#' @note Requires an internet connection.
#'
#' @source FDA Drugs at FDA Database via openFDA:
#' \url{https://open.fda.gov/apis/drug/drugsfda/}
#'
#' @examples
#' \donttest{
#'   # This function requires an internet connection and downloads data from FDA
#'   get_fda_drugs_approved("aspirin")
#'   get_fda_drugs_approved("lipitor")
#' }
#'
#' @seealso
#' \code{\link[httr]{GET}},
#' \code{\link[jsonlite]{fromJSON}},
#' \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows
#' @importFrom memoise memoise
#'
#' @export
get_fda_drugs_approved <- function(drug_name) {
  if (missing(drug_name) || !is.character(drug_name) || length(drug_name) != 1) {
    stop("Please provide a single drug name as a character string.")
  }

  base_url <- "https://api.fda.gov/drug/drugsfda.json"
  search_query <- paste0("(openfda.brand_name:", URLencode(drug_name),
                         "+openfda.generic_name:", URLencode(drug_name), ")")
  url <- paste0(base_url, "?search=", search_query, "&limit=100")

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No approved drugs found matching the drug name.")
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

    # Extract application-level information
    application_number <- if ("application_number" %in% names(df)) {
      df$application_number
    } else {
      NA_character_
    }

    sponsor <- if ("sponsor_name" %in% names(df)) {
      df$sponsor_name
    } else {
      NA_character_
    }

    # Process products nested within each application
    products_list <- lapply(seq_len(nrow(df)), function(i) {
      app_num <- application_number[i]
      sponsor_name <- sponsor[i]

      if ("products" %in% names(df) && !is.null(df$products[[i]])) {
        products <- df$products[[i]]

        if (nrow(products) > 0) {
          # Extract product details
          brand <- if ("brand_name" %in% names(products)) {
            products$brand_name
          } else {
            NA_character_
          }

          generic <- if ("active_ingredients" %in% names(products)) {
            sapply(products$active_ingredients, function(ing) {
              if (is.null(ing) || nrow(ing) == 0) return(NA_character_)
              if ("name" %in% names(ing)) {
                paste(ing$name, collapse = "; ")
              } else {
                NA_character_
              }
            })
          } else {
            NA_character_
          }

          strength <- if ("active_ingredients" %in% names(products)) {
            sapply(products$active_ingredients, function(ing) {
              if (is.null(ing) || nrow(ing) == 0) return(NA_character_)
              if ("strength" %in% names(ing)) {
                paste(ing$strength, collapse = "; ")
              } else {
                NA_character_
              }
            })
          } else {
            NA_character_
          }

          form <- if ("dosage_form" %in% names(products)) {
            products$dosage_form
          } else {
            NA_character_
          }

          route <- if ("route" %in% names(products)) {
            products$route
          } else {
            NA_character_
          }

          # Extract submission information for approval dates
          approval_date <- if ("submissions" %in% names(df) && !is.null(df$submissions[[i]])) {
            submissions <- df$submissions[[i]]
            if (nrow(submissions) > 0 && "submission_status_date" %in% names(submissions)) {
              # Get the earliest approval date
              dates <- submissions$submission_status_date[submissions$submission_status == "AP"]
              if (length(dates) > 0) {
                min(as.Date(dates, format = "%Y%m%d"), na.rm = TRUE)
              } else {
                NA_character_
              }
            } else {
              NA_character_
            }
          } else {
            NA_character_
          }

          # Determine application type from application number
          type <- if (!is.na(app_num)) {
            if (grepl("^NDA", app_num)) {
              "NDA"
            } else if (grepl("^ANDA", app_num)) {
              "ANDA"
            } else if (grepl("^BLA", app_num)) {
              "BLA"
            } else {
              NA_character_
            }
          } else {
            NA_character_
          }

          # Create a tibble for this application's products
          return(dplyr::tibble(
            application_number = rep(app_num, nrow(products)),
            sponsor = rep(sponsor_name, nrow(products)),
            brand = brand,
            generic = generic,
            type = rep(type, nrow(products)),
            approval_date = rep(as.character(approval_date), nrow(products)),
            strength = strength,
            form = form,
            route = route
          ))
        }
      }
      return(NULL)
    })

    # Combine all products into a single tibble
    products_list <- products_list[!sapply(products_list, is.null)]

    if (length(products_list) == 0) {
      message("No product information found for drug name: ", drug_name)
      return(NULL)
    }

    drugs_data <- dplyr::bind_rows(products_list)

    # Convert approval_date back to Date type
    drugs_data$approval_date <- as.Date(drugs_data$approval_date)

    return(drugs_data)
  })

  df <- fetch_data(url)
  return(df)
}
