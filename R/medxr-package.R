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

#' MedxR: Access Drug Regulatory Data via FDA and Health Canada APIs
#'
#' \if{html}{\figure{logo.png}{options: style='float: right' alt='logo' width='120'}}
#'
#' Access Drug Regulatory Data via FDA and Health Canada APIs.
#'
#' @name MedxR
#' @aliases MedxR-package
#' @title MedxR: Access Drug Regulatory Data via FDA and Health Canada APIs
#' @description {
#' This package provides functions to access drug regulatory data from public RESTful APIs including the FDA Open API and the Health Canada Drug Product Database API, retrieving real-time or historical information on drug approvals, adverse events, recalls, and product details. Additionally, the package includes a curated collection of open datasets focused on drugs, pharmaceuticals, treatments, and clinical studies.
#' }
#' @seealso {
#' Useful links:
#' \itemize{
#'   \item \url{https://github.com/lightbluetitan/medxr}
#' }
#' }
#' @author {
#' \strong{Maintainer}: Renzo Caceres Rossi \email{arenzocaceresrossi@gmail.com}
#' }
#' @keywords internal
#' @importFrom utils URLencode
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

# Declaración de variables globales usadas en Non-Standard Evaluation (NSE)
# Esto evita las notas de R CMD check sobre variables indefinidas
utils::globalVariables(c(
  "drug_identification_number"
))
