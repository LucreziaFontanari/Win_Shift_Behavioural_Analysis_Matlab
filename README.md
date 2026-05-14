# Behavioral Data Analysis: Win-Shift Task (MATLAB)

This repository contains a professional MATLAB script developed to automate data processing for spatial working memory experiments in rats.

## Research Context
The script is designed for the **Win-Shift task**, a behavioral paradigm used to assess spatial memory and cognitive flexibility. It specifically targets the transition from raw tracking data to structured performance metrics, facilitating the study of individual vulnerability in addiction research.

## Key Metrics Extracted
The script automatically processes raw Excel sequences to calculate:
* **Error Ranking (Errors to First Correct Choice):** Measures the number of incorrect arm entries before the first reward is found.
* **Total Score (Discrimination Index):** A normalized performance index calculated as `(Correct - Incorrect) / (Total Entries)`.

## 💻 Technical Features
* **Automated Pipeline:** Bypasses manual Excel editing by dynamically locating data ranges and headers.
* **RegEx Parsing:** Uses Regular Expressions to extract numeric data from varied string formats.
* **Error Handling:** Implements pre-allocation and `NaN` handling for missing or inconsistent data points.
* **English-Commented Code:** Fully documented in English for international research standards.

---
*Note: This repository contains only the analysis logic. Raw experimental data are excluded to maintain confidentiality prior to publication.*
