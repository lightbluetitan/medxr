# MedxR

[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE)

The `MedxR` package provides a unified interface to access open drug regulatory data from the **U.S. Food and Drug Administration (FDA) Open API** and the **Health Canada Drug Product Database API**. It allows users to retrieve real-time or historical information about **drug approvals**, **adverse events**, **product recalls**, and **pharmaceutical details**, enabling transparent and reproducible analysis of regulatory information across North America.

In addition to API-access functions, the package includes a curated collection of open datasets related to **drugs, pharmaceuticals, treatments, and clinical studies**. These datasets encompass diverse topics such as, **treatment dosages**, **pharmacological research**, **placebo effects**, **drug reactions**, **misuse of pain relievers**, and **vaccine effectiveness**.

## Installation

You can install the `MedxR` package from CRAN with the following R function:

```R

install.packages("MedxR")

```

You can install the `MedxR` package from its GitHub repository using the `devtools` package with the following R function:

```R

devtools::install_github("lightbluetitan/medxr")

```

## Usage

After installation, load the package and start exploring and using its functions and datasets.

```R

library(MedxR)

```

### MedxR Functions

Below is a list of the main functions included in the package:

- `get_fda_adverse_events()`: Search Adverse Events by Drug Name in FDA Adverse Event Reporting System, e.g., `get_fda_adverse_events("aspirin")`.

- `get_fda_drug_labels()`: Search Drug Labels by Drug Name in FDA Drug Labeling Database, e.g.,
`get_fda_drug_labels("aspirin")`.

- `get_fda_drugs_approved()`: Search FDA-Approved Drugs by Drug Name, e.g.,
`get_fda_drugs_approved("lipitor")`.

- `get_fda_ndc_directory()`: Search National Drug Code (NDC) Directory by Drug Name, e.g.,
`get_fda_ndc_directory("ibuprofen")`.

- `get_hc_active_ingredients()`: Get Active Ingredients from Health Canada Drug Product Database. 

- `get_hc_companies()`: Get Companies from Health Canada Drug Product Database.

- `get_hc_din()`: Get All DINs from Health Canada Drug Product Database. 

- `get_hc_drug_by_din()`: Get a Drug Product by DIN from Health Canada Drug Product Database, e.g.,
`get_hc_drug_by_din("00000213")`.

- `get_hc_drug_products()`: Retrieve Drug Products from Health Canada Drug Product Database.

- `get_hc_forms()`: Get Pharmaceutical Forms from Health Canada Drug Product Database.

- `get_hc_search_drug()`: Search Drug Products by Brand Name in Health Canada Drug Product Database, e.g.,
`get_hc_search_drug("NEMBUTAL")`.

## Dataset Suffixes

Each dataset in `MedxR` is labeled with a *suffix* to indicate its structure and type:

- `_df`: A standard data frame.

- `_tbl_df`: A tibble data frame object.

- `_list`: A list object.

- `_matrix`: A matrix object.

## Datasets Included in MedxR

In addition to API access functions, `MedxR` offers a curated collection of open datasets focused on drugs, pharmaceuticals, treatments, and clinical studies. These datasets cover diverse topics such as treatment dosages, pharmacological studies, placebo effects, drug reactions, misuses of pain relievers, and vaccine effectiveness. Below are some featured examples:

- **aspirin_infarction_df**: A data frame containing results from a meta-analysis on the use of aspirin to prevent death after myocardial infarction.

- **drug_prices_tbl_df**: A tibble containing information on unit prices for various pharmaceutical products. Each record includes a description, currency, cost per unit, unit type, and a parent key identifier.

- **placebos_df**: A data frame containing pain relief data from both analgesics and placebos.

## Example Code:

```R

# Load the package

library(MedxR)

# Get a Drug Product by DIN from Health Canada Drug Product Database

get_hc_drug_by_din("00000213")

# Search Drug Labels by Drug Name in FDA Drug Labeling Database

get_fda_drug_labels("aspirin")

# Load a dataset

data(aspirin_infarction_df)

# Shows six rows of the dataset

head(aspirin_infarction_df)

# Display the structure of the dataset

str(aspirin_infarction_df)

# Shows the whole dataset

View(aspirin_infarction_df)


```
