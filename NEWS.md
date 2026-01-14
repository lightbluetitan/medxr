# MedxR 0.1.1

## Bug Fixes

* Fixed `get_hc_drug_by_din()` to fail gracefully when API requests are unavailable or return errors
* The function now returns `NULL` with informative messages instead of stopping execution
* Improved robustness of API error handling to comply with CRAN policies regarding internet resources

## Vignette Improvements

* Updated package vignette to use `eval = FALSE` for all API-calling examples
* Replaced live API outputs with pre-calculated results to ensure reproducibility during `R CMD check`
* Successfully rebuilt vignettes using `devtools::build_vignettes()` without errors

---


# MedxR 0.1.0

## Initial Release

* First release of the `MedxR` package
* Added functions to access and explore healthcare and drug-related data via public APIs
* Included vignettes and documentation to guide users through package functionality
