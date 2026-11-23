# Olist Brazilian E-Commerce – SQL Analysis

**End-to-end SQL analysis of the Olist Brazilian e-commerce marketplace (2016–2018)**

This project analyzes ~100,000 real orders from the Olist marketplace to answer key business questions about revenue performance, delivery reliability, customer behavior, and seller contribution.

---

## Business Question

How is Olist performing in terms of revenue, delivery performance, customer satisfaction, and seller contribution? Where are the biggest opportunities for improvement?

---

## Dataset

- **Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)
- **Period:** 2016 – 2018
- **Size:** ~100,000 orders across 8 related tables
- **Main tables used:**
  - `orders`
  - `order_items`
  - `order_payments`
  - `order_reviews`
  - `customers`
  - `products`
  - `sellers`
  - `product_category_name_translation`

---

## Tools Used

- SQL (BigQuery / SQLite / PostgreSQL)
- Git & GitHub

---

## Project Structure

```text
olist-ecommerce-sql-analysis/
├── README.md
├── sql/
│   ├── 01_data_quality.sql
│   ├── 02_revenue_analysis.sql
│   ├── 03_delivery_performance.sql
│   ├── 04_customers_and_sellers.sql
│   └── 05_advanced_queries.sql
├── screenshots/
│   ├── monthly_revenue.png
│   ├── delivery_performance_average delivery time.png
│   ├── delivery_performance_late delivery affect review score.png
│   ├── delivery_performance_percentage of orders were delivered late.png
│   ├── Customer cohort-style analysis.png
│   └── top_categories.png                  
