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


# utils.R


utils::globalVariables(c(


  # Variables of the get_hc_drug_products function
  "drug_code", "class_name", "din", "brand_name", "number_of_ais", "ai_group_no", "company_name", "last_update_date",

  # Variables of the get_hc_active_ingredients function
  "dosage_unit", "dosage_value", "drug_code", "ingredient_name", "strength", "strength_unit",

  # Variables of the get_hc_companies function

  "city_name","company_code","company_name","company_type", "country_name", "postal_code", "province_name", "street_name",

  # Variables of the get_hc_forms function
  "drug_code","pharmaceutical_form_code","pharmaceutical_form_name",

  # Variables of the get_hc_drug_by_din function
  "drug_code","class_name","din", "brand_name", "number_of_ais", "ai_group_no", "company_name", "last_update_date",

  # Variables of the get_hc_din function
  "din",

  # Variables of the get_hc_search_drug function
  "drug_code","class_name","din","brand_name", "number_of_ais", "ai_group_no", "company_name", "last_update_date",

  # Variables of the get_fda_adverse_events function
  "report_id","date_received","country","serious", "adverse_reactions", "patient_sex", "patient_age",

  # Variables of the get_fda_drug_labels function
  "product_id ","brand_name","generic_name","manufacturer","product_type", "route", "indications", "warnings",

  # Variables of the get_fda_ndc_directory function
  "ndc","brand","generic","ingredients", "form", "route", "labeler", "type", "status",

  # Variables of the get_fda_drugs_approved function
  "application_number","sponsor","brand","generic","type","approval_date","strength","form", "route"



))

utils::globalVariables(c("data"))
