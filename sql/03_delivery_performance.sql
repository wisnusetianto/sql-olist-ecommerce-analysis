WITH order_delay AS (

SELECT 
  order_id,
  DATE(order_delivered_carrier_date) AS delivered_carrier,
  DATE(order_estimated_delivery_date) AS estimated_delivery,
  DATE_DIFF(order_estimated_delivery_date, order_delivered_carrier_date, DAY) AS estimated_on,
  DATE(order_delivered_customer_date) AS delivered_customer,
  DATE_DIFF(order_delivered_customer_date, order_delivered_carrier_date, DAY) AS delivered_on,
  DATE_DIFF(order_delivered_customer_date, order_delivered_carrier_date, DAY) - DATE_DIFF(order_estimated_delivery_date, order_delivered_carrier_date, DAY) AS delivery_time
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` 
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_carrier_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date
)

SELECT ROUND(AVG(order_delay.delivery_time),2) AS avg_delivery_time
FROM order_delay;

SELECT 
  order_id,
  order_status,
  DATE(order_delivered_customer_date) AS delivered ,
  DATE(order_estimated_delivery_date) AS estimated,
  CASE 
    WHEN DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) < 0 THEN 'early'
    WHEN DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) = 0 THEN 'ontime'
    ELSE 'late' 
  END AS delivery_status,
  DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) AS delivery_time
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` 
WHERE 
  order_status = 'delivered' 
  AND order_delivered_customer_date IS NOT NULL
  AND DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) > 0

LIMIT 100;

SELECT 
  CASE 
    WHEN DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) < 0 THEN 'early'
    WHEN DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) = 0 THEN 'ontime'
    ELSE 'late' 
  END AS delivery_status,
  COUNT(*) AS count_it,
  ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2) AS percentage
  
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` 
WHERE 
  order_status = 'delivered' 
  AND order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY count_it DESC;

SELECT
  CASE 
    WHEN DATE_DIFF(A.order_delivered_customer_date, A.order_estimated_delivery_date, DAY) < 0 THEN 'early'
    WHEN DATE_DIFF(A.order_delivered_customer_date, A.order_estimated_delivery_date, DAY) = 0 THEN 'ontime'
    ELSE 'late' 
  END AS delivery_status,
  ROUND(AVG(B.review_score),2) AS avg_score_review
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS A
JOIN `animated-zenith-514906-i9.Dataset_001.olist_order_reviews_dataset` AS B
  ON A.order_id = B.order_id
WHERE 
  order_status = 'delivered' 
  AND order_delivered_customer_date IS NOT NULL
GROUP BY 1
LIMIT 50;