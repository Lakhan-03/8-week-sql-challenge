-- 1. What is the total amount each customer spent at the restaurant?

SELECT s.customer_id, SUM(price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- 2. How many days has each customer visited the restaurant?

SELECT customer_id, COUNT(DISTINCT order_date) AS visited_days
FROM sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?

SELECT DISTINCT customer_id, product_name
FROM sales
JOIN menu ON sales.product_id = menu.product_id
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM sales
    GROUP BY customer_id
);

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT
    sales.product_id,
    (SELECT product_name FROM menu WHERE sales.product_id = menu.product_id) AS most_purchased_item,
    COUNT(customer_id) AS product_count
FROM
    sales
GROUP BY
    product_id
ORDER BY
    product_count DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?

SELECT customer_id, product_id, product_name, item_count
FROM (
  SELECT customer_id, sales.product_id, product_name, COUNT(customer_id) AS item_count
  FROM sales
  JOIN menu ON sales.product_id = menu.product_id
  GROUP BY customer_id, product_id, product_name
) AS sub
WHERE (customer_id, item_count) IN (
  SELECT customer_id, MAX(item_count)
  FROM (
    SELECT customer_id, COUNT(customer_id) AS item_count
    FROM sales
    GROUP BY customer_id, product_id
  ) AS sub2
  GROUP BY customer_id
);


-- 6. Which item was purchased first by the customer after they became a member?

SELECT sales.customer_id, product_name
FROM sales
JOIN members ON sales.customer_id = members.customer_id AND order_date > join_date
JOIN menu ON sales.product_id = menu.product_id
WHERE (sales.customer_id, order_date) IN (
  SELECT sales.customer_id, MIN(order_date)
  FROM sales
  JOIN members ON sales.customer_id = members.customer_id AND order_date > join_date
  GROUP BY customer_id
)
ORDER BY customer_id;

-- 7. Which item was purchased just before the customer became a member?
SELECT sales.customer_id, product_name, order_date
FROM sales
JOIN members ON sales.customer_id = members.customer_id AND order_date < join_date
JOIN menu ON sales.product_id = menu.product_id
WHERE (sales.customer_id, order_date) IN (
  SELECT sales.customer_id, MAX(order_date)
  FROM sales
  JOIN members ON sales.customer_id = members.customer_id AND order_date < join_date
  GROUP BY customer_id 
)
ORDER BY customer_id;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT sales.customer_id, SUM(price) AS total_amount_spent, COUNT(sales.product_id) AS total_items
FROM sales
JOIN members ON sales.customer_id = members.customer_id AND order_date < join_date
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY sales.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT 
    customer_id, 
    SUM(m.price * 10 * CASE WHEN s.product_id = 1 THEN 2 ELSE 1 END) AS points 
FROM 
    sales s 
    JOIN menu m ON s.product_id = m.product_id 
GROUP BY 
    customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

SELECT 
    s.customer_id, 
    SUM(m.price * 10 * CASE 
        WHEN s.product_id = 1 THEN 2 
        WHEN DATEDIFF(s.order_date, members.join_date) = 7 THEN 2
        ELSE 1 
    END) AS points 
FROM 
    sales s 
    JOIN menu m ON s.product_id = m.product_id 
    JOIN members ON s.customer_id = members.customer_id
GROUP BY 
    s.customer_id;

/*Bonus Questions
Join All The Things
The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.
*/
SELECT 
    s.customer_id, 
    s.order_date, 
    menu.product_name, 
    menu.price, 
    CASE WHEN s.customer_id IN (
            SELECT customer_id 
            FROM members 
            WHERE s.order_date >= members.join_date
         )
         THEN 'Y'
         ELSE 'N'
    END AS member
FROM 
    sales s 
JOIN menu ON s.product_id = menu.product_id;


/* Rank All The Things
Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.
*/
SELECT 
    s.customer_id,  
    s.order_date, 
    menu.product_name,  
    menu.price, 
    CASE 
        WHEN s.customer_id IN (
            SELECT customer_id FROM members WHERE s.order_date >= members.join_date
        ) THEN 'Y' 
        ELSE 'N'
    END AS member,
    CASE 
        WHEN s.customer_id IN (
            SELECT customer_id FROM members WHERE s.order_date >= members.join_date
        ) THEN menu.product_id 
        ELSE NULL 
    END AS ranking 
FROM 
    sales s 
JOIN 
    menu ON s.product_id = menu.product_id;