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

## How to Reproduce
1. Download the dataset from Kaggle (link above).
2. Load the CSV files into your SQL environment (BigQuery, SQLite, PostgreSQL, etc.).
3. Run the SQL scripts in the sql/ folder in numerical order.
4. Review results the findings section in this README.

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
```

---

## Key Findings
- Total revenue generated: [15,419,773.75]
- Average Order Value (AOV): [159.83]
- 6.77% of orders were delivered late
- Late deliveries are strongly associated with lower review scores
- Top product category by revenue: [Health Beauty]
- 96.88% of customers made more than one purchase (high one-time buyer rate)
- Top 10 sellers contribute approximately 13.15% of total revenue

---

## Recommendations
1. Improve delivery performance
Focus on reducing late deliveries, especially in regions/categories with the highest delay rates, because late delivery significantly hurts customer satisfaction.

2. Increase customer retention
The majority of customers only buy once. Consider loyalty programs, personalized recommendations, or post-purchase incentives.

3. Optimize high-freight categories
Some categories have disproportionately high shipping costs relative to product price. Review pricing or shipping strategy for these categories.

4. Support top-performing sellers
Identify and provide better support/tools to high-performing sellers to scale their contribution further.

---

## Author
Wisnu Setianto
