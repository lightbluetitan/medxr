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


#' Search Adverse Events by Drug Name in FDA Adverse Event Reporting System
#'
#' @description
#' Retrieves adverse event reports from the FDA Adverse Event Reporting System (FAERS)
#' that match a specific drug name using the RESTful API endpoint
#' \code{/drug/event.json?search=<drug_name>}.
#'
#' This includes details such as the safety report ID, receive date,
#' serious status, patient information, drug details, and adverse reactions
#' for each reported adverse event related to pharmaceutical products.
#'
#' @param drug_name A character string representing the name of the drug.
#'
#' @return A tibble with the following columns:
#' \itemize{
#'   \item \code{report_id}: Unique identifier for the adverse event report
#'   \item \code{date_received}: Date FDA received the report
#'   \item \code{country}: Country where event occurred
#'   \item \code{serious}: Is it serious? ("Yes", "No", or original API value / NA)
#'   \item \code{adverse_reactions}: List of adverse reactions reported (separated by semicolons) or NA
#'   \item \code{patient_sex}: Patient sex ("Male", "Female", "Unknown", original API value, or NA)
#'   \item \code{patient_age}: Patient age at onset (as returned by API) or NA
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
#' @source FDA Adverse Event Reporting System (FAERS) via openFDA:
#' \url{https://open.fda.gov/apis/drug/event/}
#'
#' @examples
#' if (interactive()) {
#'   get_fda_adverse_events("aspirin")
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
get_fda_adverse_events <- function(drug_name) {
  # Validate input (reject missing, non-character, length != 1, or NA)
  if (missing(drug_name) || !is.character(drug_name) || length(drug_name) != 1 || is.na(drug_name)) {
    stop("Please provide a single valid (non-NA) drug name as a character string.")
  }

  base_url <- "https://api.fda.gov/drug/event.json"
  search_query <- paste0(
    "(patient.drug.openfda.generic_name:", URLencode(drug_name),
    "+patient.drug.openfda.brand_name:", URLencode(drug_name), ")"
  )
  url <- paste0(base_url, "?search=", search_query, "&limit=100")

  fetch_data <- memoise::memoise(function(url) {
    Sys.sleep(0.2) # Rate limit (max 5 req/sec)
    res <- httr::GET(url)

    if (res$status_code == 404) {
      message("No adverse events found matching the drug name.")
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

    df_raw <- dplyr::as_tibble(data$results)
    n <- nrow(df_raw)

    # Safely extract fields; if missing in API, return vector of NAs of length n
    report_id <- if ("safetyreportid" %in% names(df_raw)) as.character(df_raw$safetyreportid) else rep(NA_character_, n)

    date_received <- if ("receivedate" %in% names(df_raw)) {
      # receivedate is typically YYYYMMDD
      parsed <- as.Date(as.character(df_raw$receivedate), format = "%Y%m%d")
      # If parsing fails, parsed will be NA; keep as Date vector
      parsed
    } else {
      rep(as.Date(NA), n)
    }

    country <- if ("occurcountry" %in% names(df_raw)) as.character(df_raw$occurcountry) else rep(NA_character_, n)

    # Map serious codes if present, but preserve other values (do not invent)
    serious <- if ("serious" %in% names(df_raw)) {
      s <- as.character(df_raw$serious)
      ifelse(s == "1", "Yes",
             ifelse(s == "2", "No", s))
    } else {
      rep(NA_character_, n)
    }

    # Extract adverse reactions (concatenate reactionmeddrapt if present)
    reactions_list <- vector("list", n)
    for (i in seq_len(n)) {
      reactions_list[[i]] <- NA_character_
      if ("patient.reaction" %in% names(df_raw) && !is.null(df_raw$patient.reaction[[i]])) {
        reactions <- df_raw$patient.reaction[[i]]
        if (is.data.frame(reactions) && nrow(reactions) > 0 && "reactionmeddrapt" %in% names(reactions)) {
          rx <- paste(as.character(reactions$reactionmeddrapt), collapse = "; ")
          # Keep the API-provided text (even if empty); treat empty as NA
          reactions_list[[i]] <- if (nzchar(rx)) rx else NA_character_
        }
      }
    }
    adverse_reactions <- unlist(reactions_list, use.names = FALSE)
    if (length(adverse_reactions) == 0) adverse_reactions <- rep(NA_character_, n)

    # Patient sex: map common codes but preserve as described; otherwise Unknown
    patient_sex <- if ("patient.patientsex" %in% names(df_raw)) {
      ps <- as.character(df_raw$patient.patientsex)
      ifelse(ps == "1", "Male",
             ifelse(ps == "2", "Female", ifelse(nzchar(ps), ps, "Unknown")))
    } else {
      rep(NA_character_, n)
    }

    # Patient age: preserve whatever the API provides (could be numeric or character); cast to character to keep consistent type
    patient_age <- if ("patient.patientonsetage" %in% names(df_raw)) {
      # Keep original values as character; NA where missing
      as.character(df_raw$patient.patientonsetage)
    } else {
      rep(NA_character_, n)
    }

    # Build final tibble with exactly the documented columns (no invented warnings)
    result_df <- dplyr::tibble(
      report_id = report_id,
      date_received = date_received,
      country = country,
      serious = serious,
      adverse_reactions = adverse_reactions,
      patient_sex = patient_sex,
      patient_age = patient_age
    )

    return(result_df)
  })

  df_out <- fetch_data(url)
  return(df_out)
}
