/*SQL Project Question Set 2*/

Q1:
SELECT DATE_PART('month', rental_date) AS month,
       DATE_PART('year', rental_date) AS year,
       store_id,
       COUNT(rental_id) rentals
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC


Q2:
WITH topcust AS (
    SELECT customer_id,
       SUM(amount) tot_spend
	  FROM payment
	  GROUP BY 1
    ORDER BY 2 DESC
	  LIMIT 10)

SELECT DATE_TRUNC('month', payment_date) pay_mon,
       CONCAT(first_name, ' ', last_name) cust_name,
       COUNT(payment_id) pay_count,
       SUM(amount) pay_amount
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
JOIN topcust
ON topcust.customer_id = p.customer_id
GROUP BY 1, 2
ORDER BY 2

Q3:
WITH topcust AS (
    SELECT customer_id,
       SUM(amount) tot_spend
	  FROM payment
	  GROUP BY 1
	  ORDER BY 2 DESC
	  LIMIT 10)

SELECT DATE_TRUNC('month', payment_date) pay_mon,
       CONCAT(first_name, ' ', last_name) cust_name,
       COUNT(payment_id) pay_count,
       SUM(amount) pay_amount,
       SUM(amount) - LAG(SUM(amount)) OVER (PARTITION BY CONCAT(first_name, ' ', last_name) ORDER BY CONCAT(first_name, ' ', last_name)) AS pay_diff
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
JOIN topcust
ON topcust.customer_id = p.customer_id
GROUP BY 1, 2
ORDER BY 2
