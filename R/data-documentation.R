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

#' The Effects of Caffeine
#'
#' This dataset, caffeine_matrix, is a matrix containing data from Henson et al.
#' [1996] investigating caffeine's effect on short-term visual memory. High school
#' students (9 eighth-graders, 10 tenth-graders, 9 twelfth-graders) were tested
#' twice: once after drinking caffeinated Coke and once after decaffeinated Coke.
#' Students had 10 seconds to memorize 20 common objects, then 1 minute to recall
#' them. The study examined whether students remembered more objects with
#' decaffeinated versus caffeinated Coke.
#'
#' The dataset name has been kept as 'caffeine_matrix' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'matrix' indicates that the dataset is stored as a matrix object. The original content has not been modified
#' in any way.
#'
#' @name caffeine_matrix
#' @format A numeric matrix with 28 rows and 3 columns:
#' \describe{
#'   \item{Grade}{Numeric values indicating the grade level of the student (8, 10, or 12)}
#'   \item{Without}{Number of objects remembered after drinking decaffeinated Coke}
#'   \item{With}{Number of objects remembered after drinking caffeinated Coke}
#' }
#' @source Data taken from the msos package version 1.2.0
#' @usage data(caffeine_matrix)
#' @export
load("data/caffeine_matrix.rda")
NULL


#' Histamine in Dogs
#'
#' This dataset, histamine_matrix, is a matrix containing data on blood histamine
#' levels in dogs after drug treatment. Sixteen dogs were used to assess morphine
#' and trimethaphan effects on blood histamine concentration. Dogs were divided into
#' four groups: two received morphine, two received trimethaphan (both intravenous).
#' In each drug pair, one group had histamine depleted prior to treatment, the other
#' retained normal levels. Values of "0.10" indicate originally missing data,
#' arbitrarily imputed with that value.
#'
#' The dataset name has been kept as 'histamine_matrix' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'matrix' indicates that the dataset is stored as a matrix object. The original content has not been modified
#' in any way.
#'
#' @name histamine_matrix
#' @format A numeric matrix with 16 rows and 4 columns:
#' \describe{
#'   \item{Before}{Blood histamine levels measured before drug administration}
#'   \item{After1}{Histamine levels measured after 1 minute}
#'   \item{After3}{Histamine levels measured after 3 minutes}
#'   \item{After5}{Histamine levels measured after 5 minutes}
#' }
#' @source Data taken from the msos package version 1.2.0
#' @usage data(histamine_matrix)
#' @export
load("data/histamine_matrix.rda")
NULL



#' Treatment Dosages Defined by EUCAST
#'
#' This dataset, dosage_tbl_df, is a tibble containing treatment dosage information for
#' antimicrobial agents as defined by EUCAST. The dosages are used to support interpretive
#' breakpoints in antimicrobial susceptibility testing.
#'
#' The dataset name has been kept as 'dosage_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble. The original content has not been modified
#' in any way.
#'
#' @name dosage_tbl_df
#' @format A tibble with 759 observations and 9 variables:
#' \describe{
#'   \item{ab}{Antimicrobial ID}
#'   \item{name}{Name of the antimicrobial agent}
#'   \item{type}{Type of dosage scheme}
#'   \item{dose}{Dose amount}
#'   \item{dose_times}{Number of doses per day}
#'   \item{administration}{Route of administration}
#'   \item{notes}{Additional clinical notes}
#'   \item{original_txt}{Original EUCAST dosage description}
#'   \item{eucast_version}{EUCAST guideline version number}
#' }
#' @source Data taken from the AMR package version 3.0.0
#' @usage data(dosage_tbl_df)
#' @export
load("data/dosage_tbl_df.rda")
NULL


#' Antibiotic Binding in Cows
#'
#' This dataset, binding_df, is a data frame containing the binding rate of antibiotics to serum protein
#' in cows. The study measured the extent to which antibiotics bind to protein in the bloodstream, which
#' can reduce the medical effectiveness of the drug. Twelve cows were given one of three antibiotics:
#' chloramphenicol, erythromycin, or tetracycline.
#'
#' The dataset name has been kept as 'binding_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name binding_df
#' @format A data frame with 12 observations and 2 variables:
#' \describe{
#'   \item{antibiotic}{Factor variable indicating the type of antibiotic administered}
#'   \item{binding}{Numeric variable representing the measured binding rate to serum protein}
#' }
#' @source Data taken from the isdals package version 3.0.1
#' @usage data(binding_df)
#' @export
load("data/binding_df.rda")
NULL


#' Digestibility of Straw Treated with NaOH
#'
#' This dataset, naoh_digest_df, is a data frame containing digestibility coefficients
#' for six horses that were fed straw. Each horse was tested under two conditions:
#' once after being fed ordinary straw and once after being fed straw treated with sodium hydroxide (NaOH).
#'
#' The dataset name has been kept as 'naoh_digest_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name naoh_digest_df
#' @format A data frame with 6 observations and 3 variables:
#' \describe{
#'   \item{horse}{Integer identifier for each horse}
#'   \item{ordinary}{Numeric variable representing digestibility after consuming ordinary straw}
#'   \item{naoh}{Numeric variable representing digestibility after consuming NaOH-treated straw}
#' }
#' @source Data taken from the isdals package version 3.0.1
#' @usage data(naoh_digest_df)
#' @export
load("data/naoh_digest_df.rda")
NULL



#' Utilization of Vitamin A in Rats
#'
#' This dataset, oilvitaminA_df, is a data frame containing vitamin A concentrations
#' in the livers of rats after being fed vitamin A dissolved in different types of oil.
#' Twenty rats were divided into two groups: one received vitamin A in corn oil and the other
#' in castor oil (American oil). After three days of feeding, vitamin A concentration in the liver
#' was measured on the fourth day.
#'
#' The dataset name has been kept as 'oilvitaminA_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name oilvitaminA_df
#' @format A data frame with 20 observations and 2 variables:
#' \describe{
#'   \item{type}{Factor variable indicating the oil type used to deliver vitamin A (corn or castor oil)}
#'   \item{avit}{Integer variable representing the measured vitamin A concentration in the liver}
#' }
#' @source Data taken from the isdals package version 3.0.1
#' @usage data(oilvitaminA_df)
#' @export
load("data/oilvitaminA_df.rda")
NULL


#' Drug Concentration in Rat Livers
#'
#' This dataset, ratliver_df, is a data frame containing results from an experiment
#' investigating drug absorption in the livers of rats. Nineteen rats were weighed,
#' given an oral dose of approximately 40 mg of drug per kilogram of body weight,
#' and sacrificed after a fixed period. Liver weight and the percentage of the administered
#' dose found in the liver were recorded.
#'
#' The dataset name has been kept as 'ratliver_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name ratliver_df
#' @format A data frame with 19 observations and 4 variables:
#' \describe{
#'   \item{BodyWt}{Integer variable indicating body weight of the rat (in grams)}
#'   \item{LiverWt}{Numeric variable representing the weight of the liver (in grams)}
#'   \item{Dose}{Numeric variable representing the total dose administered (in mg)}
#'   \item{DoseInLiver}{Numeric variable representing the percentage of the dose found in the liver}
#' }
#' @source Data taken from the isdals package version 3.0.1
#' @usage data(ratliver_df)
#' @export
load("data/ratliver_df.rda")
NULL


#' Unit Drug Prices
#'
#' This dataset, drug_prices_tbl_df, is a tibble containing information on unit prices
#' for various pharmaceutical products. Each record includes a description, currency,
#' cost per unit, unit type, and a parent key identifier.
#'
#' The dataset name has been kept as 'drug_prices_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble data frame. The original content has not been modified
#' in any way.
#'
#' @name drug_prices_tbl_df
#' @format A tibble with 208 observations and 5 variables:
#' \describe{
#'   \item{description}{Character variable describing the drug or product}
#'   \item{currency}{Character variable indicating the currency in which the price is expressed}
#'   \item{cost}{Numeric variable indicating the unit cost of the drug}
#'   \item{unit}{Character variable representing the measurement unit (e.g., tablet, mL)}
#'   \item{parent_key}{Character variable serving as a linking identifier to related records}
#' }
#' @source Data taken from the covid19dbcand package version 0.1.1
#' @usage data(drug_prices_tbl_df)
#' @export
load("data/drug_prices_tbl_df.rda")
NULL


#' Drug Product Records
#'
#' This dataset, products_drug_tbl_df, is a tibble containing detailed information on 3,764
#' commercially available pharmaceutical products in Canada and the United States. Each
#' record includes identifiers such as NDC and DPD codes, marketing start and end dates,
#' strength, dosage form, administration route, approval status, and source agency.
#'
#' The dataset name has been kept as 'products_drug_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble data frame. The original content has not been modified
#' in any way.
#'
#' @name products_drug_tbl_df
#' @format A tibble with 3,764 observations and 19 variables:
#' \describe{
#'   \item{name}{Character variable with the commercial name of the drug product}
#'   \item{labeller}{Character variable indicating the name of the pharmaceutical company}
#'   \item{ndc-id}{Character variable with the U.S. National Drug Code (NDC) identifier}
#'   \item{ndc-product-code}{Character variable for the product-level NDC code}
#'   \item{dpd-id}{Character variable for the Canadian Drug Product Database (DPD) ID}
#'   \item{ema-product-code}{Character variable for the European Medicines Agency product code}
#'   \item{ema-ma-number}{Character variable with the EMA marketing authorization number}
#'   \item{started-marketing-on}{Character variable indicating marketing start date}
#'   \item{ended-marketing-on}{Character variable indicating marketing end date}
#'   \item{dosage-form}{Character variable representing the drug's dosage form}
#'   \item{strength}{Character variable with the dosage strength}
#'   \item{route}{Character variable describing the route of administration}
#'   \item{fda-application-number}{Character variable for the FDA application number}
#'   \item{generic}{Character variable indicating if the product is a generic formulation}
#'   \item{over-the-counter}{Character variable indicating OTC availability}
#'   \item{approved}{Character variable specifying whether the product is approved}
#'   \item{country}{Character variable indicating the country of approval (Canada/US)}
#'   \item{source}{Character variable with the originating regulatory body}
#'   \item{parent_key}{Character variable linking to related records}
#' }
#' @source Data taken from the covid19dbcand package version 0.1.1
#' @usage data(products_drug_tbl_df)
#' @export
load("data/products_drug_tbl_df.rda")
NULL


#' Drug Reactions
#'
#' This dataset, reactions_drug_tbl_df, is a tibble containing detailed information on
#' 69 biochemical reactions involving drug molecules. It includes enzyme-mediated
#' transformations, pharmacological activity of drug metabolites, and mappings between
#' substrates and products as described by DrugBank identifiers.
#'
#' The dataset name has been kept as 'reactions_drug_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble data frame. The original content has not been modified
#' in any way.
#'
#' @name reactions_drug_tbl_df
#' @format A tibble with 69 observations and 6 variables:
#' \describe{
#'   \item{sequence}{Numeric variable indicating the order of the metabolic reaction}
#'   \item{left_drugbank_id}{Character variable with the DrugBank ID of the input compound}
#'   \item{left_drugbank_name}{Character variable with the name of the input compound}
#'   \item{right_drugbank_id}{Character variable with the DrugBank ID of the resulting metabolite}
#'   \item{right_drugbank_name}{Character variable with the name of the resulting metabolite}
#'   \item{parent_key}{Character variable for linking to external reference records}
#' }
#' @source Data taken from the covid19dbcand package version 0.1.1
#' @usage data(reactions_drug_tbl_df)
#' @export
load("data/reactions_drug_tbl_df.rda")
NULL


#' Drug Related ATC Codes
#'
#' This dataset, ATC_code_tbl_df, is a tibble containing ATC (Anatomical Therapeutic Chemical)
#' classification codes assigned to drugs by the World Health Organization. The classification
#' system categorizes drugs into different levels of anatomical and chemical structure.
#'
#' The dataset name has been kept as 'ATC_code_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble. The original content has not been modified
#' in any way.
#'
#' @name ATC_code_tbl_df
#' @format A tibble with 50 observations and 10 variables:
#' \describe{
#'   \item{atc_code}{Character variable representing the ATC code assigned to the drug}
#'   \item{level_1}{Character variable indicating the anatomical main group}
#'   \item{code_1}{Character variable indicating the code of level 1}
#'   \item{level_2}{Character variable indicating the therapeutic subgroup}
#'   \item{code_2}{Character variable indicating the code of level 2}
#'   \item{level_3}{Character variable indicating the pharmacological subgroup}
#'   \item{code_3}{Character variable indicating the code of level 3}
#'   \item{level_4}{Character variable indicating the chemical subgroup}
#'   \item{code_4}{Character variable indicating the code of level 4}
#'   \item{drugbank-id}{Character variable with the corresponding DrugBank identifier}
#' }
#' @source Data taken from the package covid19dbcand version 0.1.1
#' @usage data(ATC_code_tbl_df)
#' @export
load("data/ATC_code_tbl_df.rda")
NULL


#' Pharmacy Client Attendance
#'
#' This dataset, pharmacy_tbl_df, is a tibble containing hourly client attendance
#' data in a pharmacy located in Geneva, Switzerland. The dataset spans two years,
#' recording the number of clients per hour alongside the date and weekday.
#'
#' The dataset name has been kept as 'pharmacy_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble. The original content has not been modified
#' in any way.
#'
#' @name pharmacy_tbl_df
#' @format A tibble with 17,520 observations and 4 variables:
#' \describe{
#'   \item{date}{Date variable indicating the calendar date}
#'   \item{hours}{Character variable representing the hour of observation}
#'   \item{weekday}{Character variable representing the day of the week}
#'   \item{attendance}{Numeric variable indicating the number of clients observed}
#' }
#' @source Data taken from the package idarps version 0.0.5
#' @usage data(pharmacy_tbl_df)
#' @export
load("data/pharmacy_tbl_df.rda")
NULL


#' Placebos and Pain Relief
#'
#' This dataset, placebos_df, is a data frame containing pain relief data from both analgesics and placebos.
#' It presents observations over time comparing the effects of different treatments including placebo,
#' aspirin (Asp), and codis (a combination analgesic), along with calculated placebo reduction.
#'
#' The dataset name has been kept as 'placebos_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name placebos_df
#' @format A data frame with 7 observations and 6 variables:
#' \describe{
#'   \item{Time}{Integer variable indicating the time point of observation}
#'   \item{Placebo}{Numeric variable indicating the measured effect of the placebo}
#'   \item{Distr}{Numeric variable indicating the measured effect of a distractor treatment}
#'   \item{Asp}{Numeric variable indicating the measured effect of aspirin}
#'   \item{Codis}{Numeric variable indicating the measured effect of codis}
#'   \item{PlaceboRed}{Numeric variable indicating the reduction attributed to the placebo}
#' }
#' @source Data taken from the package SRMData version 1.0.2
#' @usage data(placebos_df)
#' @export
load("data/placebos_df.rda")
NULL


#' Pain Relievers Misuse in the US
#'
#' This dataset, drugsmisuse_tbl_df, is a tibble containing information about the use of pain relievers
#' for non-medical purposes in the United States. It includes individual-level data for 100 cases,
#' detailing misuse patterns across various opioid-based medications.
#'
#' The dataset name has been kept as 'drugsmisuse_tbl_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'tbl_df' indicates that the dataset is a tibble. The original content has not been modified
#' in any way.
#'
#' @name drugsmisuse_tbl_df
#' @format A tibble with 100 observations and 8 variables:
#' \describe{
#'   \item{caseid}{Character variable representing the unique case identifier}
#'   \item{hydrocd}{Integer variable indicating hydrocodone misuse (1 = Yes, 0 = No)}
#'   \item{oxycodp}{Integer variable indicating oxycodone misuse (1 = Yes, 0 = No)}
#'   \item{codeine}{Integer variable indicating codeine misuse (1 = Yes, 0 = No)}
#'   \item{tramadl}{Integer variable indicating tramadol misuse (1 = Yes, 0 = No)}
#'   \item{morphin}{Integer variable indicating morphine misuse (1 = Yes, 0 = No)}
#'   \item{methdon}{Integer variable indicating methadone misuse (1 = Yes, 0 = No)}
#'   \item{vicolor}{Integer variable indicating Vicodin or similar misuse (1 = Yes, 0 = No)}
#' }
#' @source Data taken from the package lay version 0.1.3
#' @usage data(drugsmisuse_tbl_df)
#' @export
load("data/drugsmisuse_tbl_df.rda")
NULL


#' BCG Vaccine Effectiveness Studies
#'
#' This dataset, BCG_vaccine_df, is a data frame containing results from 13 studies
#' evaluating the effectiveness of the Bacillus Calmette-Guerin (BCG) vaccine against tuberculosis.
#' The dataset includes trial metadata and outcome counts for treatment and control groups.
#'
#' The dataset name has been kept as 'BCG_vaccine_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name BCG_vaccine_df
#' @format A data frame with 13 observations and 9 variables:
#' \describe{
#'   \item{trial}{Integer variable identifying each trial}
#'   \item{author}{Character variable with the name of the study author}
#'   \item{year}{Integer variable indicating the publication year of the study}
#'   \item{tpos}{Integer variable indicating the number of TB-positive cases in the treatment group}
#'   \item{tneg}{Integer variable indicating the number of TB-negative cases in the treatment group}
#'   \item{cpos}{Integer variable indicating the number of TB-positive cases in the control group}
#'   \item{cneg}{Integer variable indicating the number of TB-negative cases in the control group}
#'   \item{ablat}{Integer variable indicating the absolute latitude of the study location}
#'   \item{alloc}{Character variable indicating the allocation type}
#' }
#' @source Data taken from the package metadat version 1.4-0
#' @usage data(BCG_vaccine_df)
#' @export
load("data/BCG_vaccine_df.rda")
NULL


#' Oral Anticoagulants in Coronary Artery Disease
#'
#' This dataset, oral_anticoagulants_df, is a data frame containing results from 34 studies
#' evaluating the effectiveness of oral anticoagulants in patients with coronary artery disease.
#' The dataset includes study metadata and outcome counts for treatment and control groups, as well as intensity classifications.
#'
#' The dataset name has been kept as 'oral_anticoagulants_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name oral_anticoagulants_df
#' @format A data frame with 34 observations and 9 variables:
#' \describe{
#'   \item{study}{Character variable identifying each study}
#'   \item{year}{Integer variable indicating the publication year}
#'   \item{intensity}{Character variable describing treatment intensity}
#'   \item{asp.t}{Integer variable indicating the number of aspirin users in the treatment group}
#'   \item{asp.c}{Integer variable indicating the number of aspirin users in the control group}
#'   \item{ai}{Integer variable indicating the number of adverse events in the treatment group}
#'   \item{n1i}{Integer variable for the sample size of the treatment group}
#'   \item{ci}{Integer variable indicating the number of adverse events in the control group}
#'   \item{n2i}{Integer variable for the sample size of the control group}
#' }
#' @source Data taken from the package metadat version 1.4-0
#' @usage data(oral_anticoagulants_df)
#' @export
load("data/oral_anticoagulants_df.rda")
NULL


#' Pharmacologic Treatments for COPD
#'
#' This dataset, copd_drug_therapy_df, is a data frame containing results from 39 trials
#' examining pharmacologic treatments for chronic obstructive pulmonary disease (COPD).
#' It includes study identifiers, treatment groups, number of exacerbations, and sample sizes.
#'
#' The dataset name has been kept as 'copd_drug_therapy_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name copd_drug_therapy_df
#' @format A data frame with 94 observations and 6 variables:
#' \describe{
#'   \item{study}{Character variable identifying each study}
#'   \item{year}{Integer variable indicating the publication year}
#'   \item{id}{Integer variable representing the study ID}
#'   \item{treatment}{Character variable describing the treatment group}
#'   \item{exac}{Integer variable indicating the number of COPD exacerbations}
#'   \item{total}{Integer variable for the total number of patients in the group}
#' }
#' @source Data taken from the package metadat version 1.4-0
#' @usage data(copd_drug_therapy_df)
#' @export
load("data/copd_drug_therapy_df.rda")
NULL



#' Aspirin after Myocardial Infarction
#'
#' This dataset, aspirin_infarction_df, is a data frame containing results from a meta-analysis
#' on the use of aspirin to prevent death after myocardial infarction. It includes binary outcome
#' data comparing aspirin and placebo groups.
#'
#' The dataset name has been kept as 'aspirin_infarction_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name aspirin_infarction_df
#' @format A data frame with 7 observations and 6 variables:
#' \describe{
#'   \item{study}{Character variable identifying each study}
#'   \item{year}{Integer variable indicating the publication year}
#'   \item{d.asp}{Integer variable for the number of deaths in the aspirin group}
#'   \item{n.asp}{Integer variable for the total number of patients in the aspirin group}
#'   \item{d.plac}{Integer variable for the number of deaths in the placebo group}
#'   \item{n.plac}{Integer variable for the total number of patients in the placebo group}
#' }
#' @source Data taken from the package meta version 8.2-1
#' @usage data(aspirin_infarction_df)
#' @export
load("data/aspirin_infarction_df.rda")
NULL


#' Dopamine Agonists in Parkinson's Disease
#'
#' This dataset, parkinsons_list, is a list containing information from 7 studies investigating
#' the effect of dopamine agonists as adjunct therapy in patients with Parkinson's disease.
#' The dataset includes placebo and four active drugs coded from 2 to 5, measuring outcomes
#' such as lost work-time reduction.
#'
#' The dataset name has been kept as 'parkinsons_list' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' MedxR package and assists users in identifying its specific characteristics.
#' The suffix 'list' indicates that the dataset is a list. The original content has not been modified
#' in any way.
#'
#' @name parkinsons_list
#' @format A list with 5 elements:
#' \describe{
#'   \item{Outcomes}{Numeric vector representing the reduction in lost work-time for each treatment arm}
#'   \item{SE}{Numeric vector indicating the standard error of each observation}
#'   \item{Treat}{Character vector identifying the treatment type (placebo or drug)}
#'   \item{Study}{Numeric vector indicating the study each observation belongs to}
#'   \item{Treat.order}{Character vector listing the treatment names in the order of coding}
#' }
#' @source Data taken from the package bnma version 1.6.1
#' @usage data(parkinsons_list)
#' @export
load("data/parkinsons_list.rda")
NULL




