WITH customer_order AS(
SELECT 
  customer_unique_id,
  COUNT(*) as duplicate_count
FROM `animated-zenith-514906-i9.Dataset_001.olist_customers_dataset`
GROUP BY 1
)
SELECT 
  COUNT(*) AS total_customer,
  COUNT(CASE WHEN duplicate_count = 1 THEN 1 END) AS one_time_buyer,
  ROUND(COUNT(CASE WHEN duplicate_count = 1 THEN 1 END) * 100 / COUNT(*),2) AS percentage_one_time_buyer,
  COUNT(CASE WHEN duplicate_count > 1 THEN 1 END) AS repeat_buyer,
  ROUND(COUNT(CASE WHEN duplicate_count > 1 THEN 1 END) * 100 / COUNT(*),2) AS percentage_repeat_buyer,
FROM customer_order;

WITH top10_revenue AS (
  SELECT 
    DISTINCT C.seller_id, 
    ROUND(SUM(B.price + B.freight_value), 2) AS sellers_revenue

  FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS A
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS B
    ON A.order_id = B.order_id
  JOIN `animated-zenith-514906-i9.Dataset_001.olist_sellers_dataset` AS C
    ON B.seller_id = C.seller_id
  GROUP BY 1
  ORDER BY sellers_revenue DESC
  LIMIT 10
),

top10_list AS(
  SELECT 
    DISTINCT TR.seller_id,
    TR.sellers_revenue,
    ROUND(TR.sellers_revenue * 100 / CAST(ROUND(SUM(A.price + A.freight_value) OVER(), 2) AS DECIMAL),2) AS percentage_over_total,
    CAST(ROUND(SUM(A.price + A.freight_value) OVER(), 2) AS DECIMAL) AS total_revenue,

  FROM `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS A
  LEFT JOIN `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS B
    ON A.order_id = B.order_id
  LEFT JOIN top10_revenue AS TR
    ON A.seller_id = TR.seller_id
  WHERE B.order_status='delivered'
  ORDER BY TR.sellers_revenue DESC
  LIMIT 10
)

SELECT 
  seller_id,
  sellers_revenue,
  percentage_over_total,
  SUM(percentage_over_total) OVER() AS sum_percentage_top_10,
  total_revenue
FROM top10_list;

SELECT 
  D.in_english, 
  ROUND(AVG(C.review_score), 2) AS avg_review_score
FROM `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS A
JOIN `animated-zenith-514906-i9.Dataset_001.olist_products_dataset` AS B
  ON A.product_id = B.product_id
JOIN `animated-zenith-514906-i9.Dataset_001.olist_order_reviews_dataset` AS C
  ON A.order_id = C.order_id
JOIN `animated-zenith-514906-i9.Dataset_001.product_category_name_translation` AS D
  ON B.product_category_name = D.in_brazil
GROUP BY 1;
