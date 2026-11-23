SELECT 
  CAST(ROUND(SUM(A.price + A.freight_value), 2) AS DECIMAL) AS total_revenue,
  COUNT(DISTINCT A.order_id) AS Total_order,
  ROUND(SUM(A.price + A.freight_value) / COUNT(DISTINCT A.order_id),2) AS Average_order_value
FROM `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS A
LEFT JOIN `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS B
ON A.order_id = B.order_id
WHERE B.order_status='delivered';

SELECT 
  FORMAT_DATE('%Y-%m', B.order_purchase_timestamp) AS year_month,
  ROUND(SUM(A.price + A.freight_value), 2) AS total_revenue,
  COUNT(DISTINCT A.order_id) AS Total_order,
  ROUND(SUM(A.price + A.freight_value) / COUNT(DISTINCT A.order_id),2) AS Average_order_value
FROM `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS A
LEFT JOIN `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS B
ON A.order_id = B.order_id
WHERE B.order_status='delivered'
GROUP BY year_month
ORDER BY year_month;

SELECT 
  D.in_english AS category,
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
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 15;

SELECT 
  A.payment_type,
  COUNT(DISTINCT A.order_id) AS number_of_orders,
  ROUND(SUM(A.payment_value),2) AS total_payment_value,
  ROUND(100.0 * SUM(A.payment_value) / SUM(SUM(A.payment_value)) OVER(), 2) AS pct_of_total

FROM `animated-zenith-514906-i9.Dataset_001.olist_order_payments_dataset` AS A
JOIN `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS B
ON A.order_id = B.order_id
WHERE B.order_status = 'delivered'
GROUP BY 1
ORDER BY total_payment_value DESC;

