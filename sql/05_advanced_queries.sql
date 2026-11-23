WITH first_cte AS (
  SELECT 
  D.in_english AS category,
  FORMAT_DATE('%Y', B.order_purchase_timestamp) AS year,
  COUNT(*) AS items_sold,
  ROUND(SUM(A.price + A.freight_value),2) AS total_revenue

  FROM `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS A
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS B
    ON A.order_id = B.order_id
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_products_dataset` AS C
    ON A.product_id = C.product_id
  JOIN `animated-zenith-514906-i9.Dataset_001.product_category_name_translation` AS D
    ON C.product_category_name = D.in_brazil 
  WHERE B.order_status = 'delivered'
  GROUP BY category, year
  ORDER BY category, year ASC
),

second_cte AS(
  SELECT 
    category,
    year,
    total_revenue,
    ROW_NUMBER() OVER(
      PARTITION BY year
      ORDER BY total_revenue DESC
    ) as rn
  FROM first_cte
)

SELECT 
  year,
  category,
  total_revenue
FROM second_cte
WHERE rn = 1;

WITH 
first_purchase AS (
  SELECT 
    B.customer_unique_id,
    MIN(DATE(A.order_purchase_timestamp)) AS first_order,
    DATE_TRUNC(MIN(DATE(A.order_purchase_timestamp)), MONTH) AS cohort_month
  FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS A
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_customers_dataset` AS B
    ON A.customer_id = B.customer_id
  WHERE A.order_status = 'delivered'
  GROUP BY B.customer_unique_id
),

order_with_cohort AS (
  SELECT
    B.customer_unique_id,
    FP.cohort_month,
    DATE_TRUNC(DATE(A.order_purchase_timestamp), MONTH) AS order_month,
    DATE_DIFF(DATE_TRUNC(DATE(A.order_purchase_timestamp), MONTH), FP.cohort_month, MONTH) AS month_since_first

  FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS A
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_customers_dataset` AS B
    ON A.customer_id = B.customer_id
  JOIN first_purchase AS FP
    ON fp.customer_unique_id = B.customer_unique_id
  WHERE A.order_status = 'delivered'
),

cohort_size AS(
  SELECT
    cohort_month,
    COUNT(DISTINCT customer_unique_id) AS cohort_customer
  FROM first_purchase 
  GROUP BY cohort_month
)

SELECT 
  A.cohort_month,
  B.cohort_customer,
  A.month_since_first,
  COUNT(DISTINCT A.customer_unique_id) AS active_customer,
  ROUND(COUNT(DISTINCT A.customer_unique_id) * 100 / B.cohort_customer, 2) AS retention_pct
FROM order_with_cohort AS A
JOIN cohort_size AS B
  ON A.cohort_month = B.cohort_month
WHERE A.month_since_first BETWEEN 0 AND 6
GROUP BY A.cohort_month, B.cohort_customer, A.month_since_first
ORDER BY A.cohort_month, A.month_since_first;