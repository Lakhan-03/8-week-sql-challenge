# Case Study #1 - Danny's Diner

Case Study Link -> https://8weeksqlchallenge.com/case-study-1

This repository contains SQL queries for analyzing customer data for Danny's Diner, a fictional restaurant. The queries address various questions related to customer spending, menu items, membership, and loyalty points.

## About Data: 
You can get ER diagram and data from case study link. **[Case Study 1 - Danny's Dinner/danny's dinner case study data.sql](https://github.com/Lakhan-03/8-week-sql-challenge/blob/2ce9868db9f4a262e71da948048c3cd3be71b369/Case%20Study%201%20-%20Danny's%20Dinner/danny's%20dinner%20case%20study%20data.sql)** is in MySQL format, suitable for use in MySQL Workbench.

## SQL Concept Used in This Case Study Analysis 
- **JOIN:** Used to combine data from multiple tables.
- **Aggregate functions (SUM, COUNT, MAX, MIN)**: Perform calculations on a set of values.
- **GROUP BY**: Groups rows based on one or more columns.
- **Subqueries**: Queries nested within another query.
- **Conditional expressions (CASE WHEN)**: Evaluate conditions and return values based on the result.
- **Sorting (ORDER BY)**: Arrange the result set based on column values.

## Queries
The project includes SQL queries that answer the following questions:

1. What is the total amount each customer spent at the restaurant?
2 How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member? 
8 What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier, how many points would each customer have? 
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

## Bonus Questions
**Join All The Things**
The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

**Rank All The Things**
Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

