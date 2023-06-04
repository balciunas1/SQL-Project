/*SQL Project Question Set 1 code*/

Q1:
WITH t1 AS(
    SELECT f.title film_title, c.name category_name, COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc
    ON fc.category_id = c.category_id
    JOIN film f
    ON f.film_id = fc.film_id
    JOIN inventory i
    ON i.film_id = f.film_id
    JOIN rental r
    ON r.inventory_id = i.inventory_id
    GROUP BY 1, 2
    ORDER BY 2, 1)

SELECT film_title,
       category_name,
       rental_count
FROM t1
WHERE category_name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')

Q2:
WITH t1 AS(
    SELECT f.title film_title,
         c.name category_name,
         f.rental_duration rent_dur
    FROM category c
    JOIN film_category fc
    ON fc.category_id = c.category_id
    JOIN film f
    ON f.film_id = fc.film_id)

SELECT film_title,
       category_name,
       rent_dur,
       NTILE(4) OVER (ORDER BY rent_dur) AS standard_quartile
FROM t1
WHERE category_name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')

Q3:
WITH t1 AS (
    SELECT name,
       NTILE(4) OVER (ORDER BY f.rental_duration) AS quart,
       title,
       rental_duration
	  FROM category c
	  JOIN film_category fc
	  ON c.category_id = fc.category_id
	  JOIN film f
	  ON fc.film_id = f.film_id
	  WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))

SELECT name,
       quart,
       COUNT(title) as count
FROM t1
GROUP BY 1, 2
ORDER BY 1, 2
