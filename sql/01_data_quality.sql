SELECT 
  COUNT(DISTINCT D1.order_id) AS count_of_order,
  COUNT(DISTINCT D1.customer_id) AS count_of_customer,
  COUNT(DISTINCT D2.seller_id) AS count_of_seller,
  COUNT(DISTINCT D2.product_id) AS count_of_product
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset` AS D1
LEFT JOIN `animated-zenith-514906-i9.Dataset_001.olist_order_items_dataset` AS D2
ON D1.order_id = D2.order_id;

SELECT DISTINCT order_status, COUNT(*) AS count_order_status
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset`
GROUP BY order_status;

SELECT order_status, COUNT(*) AS count_null 
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset`
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status 
LIMIT 1000;

SELECT order_id, count(*) AS count_order
FROM `animated-zenith-514906-i9.Dataset_001.olist_orders_dataset`
GROUP BY order_id
HAVING COUNT(*) > 1 
LIMIT 1000;
