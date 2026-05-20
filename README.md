# Behavioral Data Analysis: Win-Shift Task (MATLAB)

This repository contains a professional MATLAB pipeline developed to automate data processing for spatial working memory experiments in animal models.

##  Research Context
The script is designed for the **Win-Shift task** in a radial arm maze, a behavioral paradigm used to assess spatial memory and cognitive flexibility. It specifically targets the transition from raw tracking sequences to structured performance metrics, facilitating the study of individual behavioral variability in neuropharmacology research.

## Key Metrics Extracted
The script dynamically processes raw Excel data strings to compute two primary variables:
* **Error Ranking (Errors to First Correct Choice):** Measures the number of incorrect arm entries before the first reward is found. A score of `0` indicates an immediate correct choice.
* **First-4 Accuracy:** Evaluates the early-stage decision-making by calculating the ratio of correct choices strictly within the subject's first 4 arm entries (calculated as `Correct in First 4 / 4`). This metric provides insight into short-term working memory utilization before the maze is depleted of rewards.

## Technical Features
* **Automated Data Discovery:** Uses `detectImportOptions` to automatically locate tables regardless of varying header rows.
* **RegEx Parsing:** Employs Regular Expressions (`\d+`) to robustly extract numeric data from inconsistent string formats (ignoring spaces, commas, etc.).
* **Pre-allocation & Missing Data Handling:** Ensures processing speed and stability by handling `NaN` values and empty sequence cells.
* **English-Commented Code:** Fully documented to meet international scientific standards.

---
*Note: This repository contains only the data processing logic. Raw experimental data files are omitted.*
