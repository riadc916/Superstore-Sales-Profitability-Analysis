# r-data-cleaning-practice
# Superstore Sales & Profitability Analysis (R / Tidyverse)

An end-to-end data analytics project performing granular sales, profitability, and customer behavior analysis using R. The project handles messy raw business records, cleans/imputes missing values, and generates stakeholder-ready statistical reports (`gt`) and visualizations (`ggplot2`).

---

## 📌 Project Overview & Key Questions

This analysis answers key strategic business questions for executive stakeholders:
1. **Category & Sub-Category Profitability:** Which product groups generate high profits, and which ones are incurring net losses?
2. **Order Priority Logistics:** How does order volume align with total sales revenue across priority levels?
3. **Geographic Logistics:** What are the top sales channels across regions and shipping modes?
4. **Discount Impact:** Does higher discounting improve overall profit contribution across customer segments?

---

## 🛠 Tech Stack & R Packages

* **Data Wrangling:** `tidyverse` (`dplyr`, `readr`, `stringr`)
* **Data Cleaning & Preprocessing:** `janitor`
* **Table Formatting:** `gt`
* **Data Visualization:** `ggplot2`, `ggrepel`, `scales`
* **Image Exporting:** `webshot2`

---

## 🧹 Data Cleaning & Preprocessing Pipeline

The initial raw dataset contained formatting issues, mixed date formats, and missing values.

1. **Column Normalization:** Snake_case column formatting via `janitor::clean_names()`.
2. **Date Conversion:** Transformed `order_date` and `ship_date` into standardized R Date objects (`%m/%d/%y`).
3. **Missing Value Imputation:** Handled missing `product_base_margin` values using **group-wise median imputation** (`group_by(product_sub_category)`).
4. **Export:** Cleaned data saved under `data/processed/cleaned_superstore.csv`.

---

## 📊 Key Findings & Visualizations

### 1. Sub-Category Profitability Analysis
Identified high-performing sub-categories alongside loss-making categories to guide product line optimization.
* **Table:** `results/tables/profit_summary_table.png`
* **Plot:** `results/figures/profit_loss_by_subcategory.png`

### 2. Regional Sales by Shipping Mode
Evaluated geographic logistics preferences and high-revenue transportation modes.
* **Table:** `results/tables/rigion_ship_table.png`
* **Plot:** `results/figures/regional_sales_by_shipping_mode.png`

### 3. Customer Segment Discount vs. Profitability
Examined average discount margins against profit totals per customer segment (`Consumer`, `Corporate`, `Home Office`, `Small Business`).
* **Table:** `results/tables/customer_segment_discount_table.png`
* **Plot:** `results/figures/customer_segment_discount_plot.png`

---

## 📂 Project Structure

```text
├── data/
│   ├── raw/                  # Original raw data files
│   └── processed/            # Cleaned data ready for analysis
├── results/
│   ├── figures/              # High-res ggplot visualizations (.png)
│   └── tables/               # Styled gt tables (.png)
├── scripts/                  # R scripts for data cleaning & analysis
├── README.md                 # Project documentation
└── Superstore-Sales-Profitability-Analysis.Rproj
