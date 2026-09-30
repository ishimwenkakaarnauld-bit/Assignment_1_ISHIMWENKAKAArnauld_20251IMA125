-- Q1: Every order with customer name, city, and date (INNER JOIN)
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- Q2: Every order item with product name, category, price, quantity (JOIN)
SELECT oi.order_item_id, oi.order_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- Q3: All customers and their orders, including customers with no orders (LEFT JOIN)
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

-- Q4: Customers who spent above the average customer spend (CTE)
WITH customer_totals AS (
  SELECT c.customer_id, c.customer_name,
         SUM(oi.quantity * p.price) AS total_spent
  FROM customers c
  JOIN orders o       ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p     ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_spent
FROM customer_totals
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_totals)
ORDER BY total_spent DESC;

-- Q5: Rank customers by total spent, highest first (RANK)
WITH customer_totals AS (
  SELECT c.customer_id, c.customer_name,
         SUM(oi.quantity * p.price) AS total_spent
  FROM customers c
  JOIN orders o       ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p     ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM customer_totals
ORDER BY spend_rank;

-- Q6: Number each customer's orders in the order placed (ROW_NUMBER)
SELECT c.customer_name, o.order_id, o.order_date,
       ROW_NUMBER() OVER (PARTITION BY o.customer_id
                          ORDER BY o.order_date, o.order_id) AS order_number
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_name, order_number;

-- Q7: Running total of revenue over time (SUM OVER)
WITH order_revenue AS (
  SELECT o.order_id, o.order_date,
         SUM(oi.quantity * p.price) AS order_total
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p     ON oi.product_id = p.product_id
  GROUP BY o.order_id, o.order_date
)
SELECT order_id, order_date, order_total,
       SUM(order_total) OVER (ORDER BY order_date, order_id
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM order_revenue
ORDER BY order_date, order_id;

-- Q8: Days between each order and the customer's previous order (LAG)
SELECT customer_name, order_id, order_date, prev_order_date,
       order_date - prev_order_date AS days_since_previous
FROM (
  SELECT c.customer_name, o.order_id, o.order_date,
         LAG(o.order_date) OVER (PARTITION BY o.customer_id
                                 ORDER BY o.order_date, o.order_id) AS prev_order_date
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
)
WHERE prev_order_date IS NOT NULL
ORDER BY customer_name, order_date;