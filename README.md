# Behavioral Data Analysis: Win-Shift Task (MATLAB)

This repository contains a professional MATLAB pipeline developed to automate data processing for spatial working memory experiments in animal models.

## Research Context
The script is designed for the **Win-Shift task** in a radial arm maze, a behavioral paradigm used to assess spatial memory, cognitive flexibility, and response strategies. It translates raw tracking strings into precise metrics, supporting advanced behavioral and neurobiological analysis.

## Key Metrics Computed
1. **Error Rank (Errors to First Correct Choice):** Measures the number of incorrect arm entries before the first reward is found, evaluating initial spatial memory recall.
2. **First-4 Accuracy:** Evaluates early-stage decision-making by calculating the ratio of correct choices strictly within the subject's first 4 arm entries (short-term working memory capacity).
3. **Clockwise Index:** An analysis of motor/egocentric strategies. It calculates the ratio of consecutive adjacent arm entries moving in a clockwise direction (`n -> n+1`, including the `8 -> 1` edge case) over the total number of transitions.

## Technical Features
* **Regex Data Extraction:** Employs Regular Expressions (`\d+`) to pull numeric data from inconsistent text strings (e.g., ignoring typos like 'file 93' inadvertently logged in raw data).
* **Missing Data & Formatting Handling:** Built to bypass empty cells and gracefully handle variable `NaN` generation based on trial phase constraints.
* **Automated Data Export:** Direct transition from processed arrays to `.xlsx` files using dynamic table handling.

---

## 🔒 Data Privacy & Availability
**Please note:** This repository contains exclusively the data processing logic and MATLAB scripts. The dataset remains confidential to protect the integrity of the upcoming scientific publication.
