# SQL Queries Explanation Guide

## E-Commerce Database Management System

This document provides student-friendly yet academically rigorous explanations for the SQL queries implemented across this project. Each section breaks down the **Query Purpose**, the **SQL Concept Used**, and the **Expected Business Output**.

---

## 1. Basic DQL Queries (`05_basic_queries.sql`)

### Query: Top 5 Most Expensive Products
```sql
SELECT product_id, product_name, brand, price
FROM Products
ORDER BY price DESC
LIMIT 5;
```
- **Purpose**: Identify the flagship premium products in the catalog.
- **SQL Concept**: `ORDER BY DESC` sorts rows from highest to lowest price; `LIMIT` restricts the output to 5 rows.
- **Expected Result**: 5 rows displaying Apple MacBook Air, Dell XPS, Samsung Galaxy S24 Ultra, iPhone 15 Pro, and Lenovo Legion.

### Query: Wildcard Product Search
```sql
SELECT product_id, product_name, brand, price
FROM Products
WHERE product_name LIKE '%Wireless%';
```
- **Purpose**: Search for any product containing "Wireless" anywhere in its title.
- **SQL Concept**: Pattern matching using `LIKE` and the `%` wildcard.
- **Expected Result**: Rows matching Sony WH-1000XM5, AirPods Pro, Logitech MX Master, etc.

---

## 2. Update & Safe Deletion Operations (`06_update_delete.sql`)

### Query: Price Revision with Mathematical Expression
```sql
UPDATE Products
SET price = ROUND(price * 0.95, 2)
WHERE brand = 'Apple';
```
- **Purpose**: Apply an automated 5% discount across all Apple products while rounding currency values.
- **SQL Concept**: `UPDATE ... SET` with arithmetic operations and `ROUND()`.
- **Expected Result**: Prices for all Apple products are adjusted downwards by 5%.

### Query: Safe Cascading Delete
```sql
DELETE FROM Orders
WHERE order_id = 30 AND order_status = 'Cancelled';
```
- **Purpose**: Purge a cancelled order along with its order items and payment logs.
- **SQL Concept**: Foreign Key `ON DELETE CASCADE`.
- **Expected Result**: Order 30 is removed from `Orders`, and its child records in `Order_Items` and `Payments` are automatically deleted by the database engine without foreign key violations.

---

## 3. Aggregate Functions & Grouping (`07_aggregate_functions.sql`)

### Query: Category Sales and Volume Aggregation
```sql
SELECT 
    c.category_name,
    COUNT(oi.order_item_id) AS total_items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_category_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY total_category_revenue DESC;
```
- **Purpose**: Identify the most profitable product categories.
- **SQL Concept**: Multi-table `JOIN`, `GROUP BY`, and aggregate functions `COUNT()` and `SUM()`.
- **Expected Result**: Categories ranked in descending order of gross revenue, with Electronics, Mobiles, and Laptops leading.

### Query: Repeat Spenders using HAVING
```sql
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 2
ORDER BY order_count DESC;
```
- **Purpose**: Isolate loyal repeat buyers who placed more than 2 orders.
- **SQL Concept**: `HAVING` filters aggregated groups (unlike `WHERE`, which filters individual rows before grouping).
- **Expected Result**: Active customers like Aarav Sharma and Sai Kiran who meet the threshold.

---

## 4. Date & Time Analytics (`08_date_time_functions.sql`)

### Query: Logistics Turnaround with DATEDIFF()
```sql
SELECT 
    shipping_id,
    order_id,
    shipping_city,
    shipping_date,
    delivery_date,
    DATEDIFF(delivery_date, shipping_date) AS days_taken_for_delivery
FROM Shipping
WHERE delivery_date IS NOT NULL
ORDER BY days_taken_for_delivery DESC;
```
- **Purpose**: Measure fulfillment SLA by calculating transit duration in days.
- **SQL Concept**: `DATEDIFF(end_date, start_date)` calculates the integer day difference between two timestamps.
- **Expected Result**: A tabular report showing delivery intervals ranging between 2 to 3 days across cities.

---

## 5. String Manipulation (`09_string_functions.sql`)

### Query: Masking Sensitive Customer Phone Numbers
```sql
SELECT 
    customer_id,
    phone,
    CONCAT('XXXXXX', SUBSTRING(phone, 7, 4)) AS masked_phone
FROM Customers;
```
- **Purpose**: Mask personal identifiable information (PII) for data privacy compliance.
- **SQL Concept**: `SUBSTRING(str, pos, len)` extracts the final 4 digits, combined with `CONCAT()`.
- **Expected Result**: Masked phone format such as `XXXXXX3210`.

---

## 6. SQL Joins (`10_joins.sql`)

### Query 1: INNER JOIN (Orders & Customers)
```sql
SELECT 
    o.order_id, o.order_date, o.total_amount,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;
```
- **Purpose**: Combine each order with its verified customer profile.
- **SQL Concept**: `INNER JOIN` outputs only rows where a match exists on `customer_id`.
- **Expected Result**: Complete order listings with matching customer names.

### Query 2: LEFT JOIN (Identifying Dormant Customers)
```sql
SELECT 
    c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id, o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
```
- **Purpose**: Display all registered customers, retaining those with 0 orders.
- **SQL Concept**: `LEFT JOIN` returns all left table rows. Unmatched right table columns become `NULL`.
- **Expected Result**: Customers who have never ordered display `NULL` for `order_id` and `total_amount`.

### Query 3: FULL OUTER JOIN Equivalent in MySQL
```sql
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
```
- **Purpose**: Emulate `FULL OUTER JOIN` which is not directly supported in MySQL.
- **SQL Concept**: `LEFT JOIN` combined with `RIGHT JOIN` using `UNION` (which removes duplicate rows).
- **Expected Result**: A full outer matrix showing all customers and all orders.

### Query 4: SELF JOIN (Geographic Cohorts)
```sql
SELECT 
    c1.city,
    CONCAT(c1.first_name, ' ', c1.last_name) AS customer_1,
    CONCAT(c2.first_name, ' ', c2.last_name) AS customer_2
FROM Customers c1
JOIN Customers c2 ON c1.city = c2.city AND c1.customer_id < c2.customer_id;
```
- **Purpose**: Pair customers living in the exact same city.
- **SQL Concept**: Joining `Customers` onto itself (`c1` and `c2`) with `<` preventing duplicate inverse pairings.
- **Expected Result**: Pairs of customers from Hyderabad, Bangalore, Visakhapatnam, and Vijayawada.

---

## 7. Subqueries (`11_subqueries.sql`)

### Query: Correlated Subquery for Price Benchmarking
```sql
SELECT 
    p1.product_id,
    p1.product_name,
    p1.category_id,
    p1.price
FROM Products p1
WHERE p1.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p2.category_id = p1.category_id
);
```
- **Purpose**: Identify products that are priced higher than their own category average.
- **SQL Concept**: Correlated Subquery — the inner query references `p1.category_id` from the outer row and executes once per evaluated product.
- **Expected Result**: Items like iPhone 15 Pro (exceeding mobile average) or Sony WH-1000XM5 (exceeding electronics average).

---

## 8. Views (`12_views.sql`)

### View: `customer_order_summary`
```sql
CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0.00) AS total_lifetime_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city;
```
- **Purpose**: Simplify complex joins and lifetime spending aggregations into a virtual table.
- **SQL Concept**: `CREATE VIEW` and `COALESCE` to convert `NULL` to `0.00`.
- **Query Usage**: `SELECT * FROM customer_order_summary WHERE total_lifetime_spent > 50000;`

---

## 9. Indexes (`13_indexes.sql`)

### Index Creation
```sql
CREATE INDEX idx_products_category_id ON Products(category_id);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_products_brand_price ON Products(brand, price);
```
- **Purpose**: Prevent slow full-table scans (`ALL`) on high-traffic filter and foreign key columns.
- **SQL Concept**: B-Tree secondary indexes and composite indexes.
- **Verification**: `EXPLAIN SELECT ...` confirms index usage in key lookups.

---

## 10. Advanced Business Analysis (`14_final_analysis_queries.sql`)

Contains 20 comprehensive analytical queries answering core business questions:
1. **Top 10 Best Sellers**: Identifies high-demand products using unit volume.
2. **VIP Spenders**: Ranks top spending customers to support loyalty perks.
3. **Store GMV**: Calculates total gross merchandise value.
4. **Category Revenue**: Measures product category profitability.
5. **Monthly Revenue Trends**: Tracks business growth month-over-month.
6. **Average Order Value (AOV)**: Benchmarks typical shopping basket size.
7. **Dormant Signups**: Pinpoints accounts needing re-engagement campaigns.
8. **Dead Inventory**: Identifies unsold products using `LEFT JOIN ... WHERE oi.order_item_id IS NULL`.
9. **Low Stock Alert**: Detects inventory items with quantity <= 15 for restocking.
10. **Most Popular Category**: Finds category with highest unit volume.
11. **Highest-Value Order**: Finds the single largest customer transaction.
12. **Payment Pending Audit**: Flags unverified transactions for accounts reconciliation.
13. **Active Logistics Pipeline**: Tracks orders in transit or processing.
14. **Average Delivery Duration**: Evaluates courier fulfillment SLAs.
15. **Customer Purchase Frequency**: Segments users by one-time vs repeat purchasing behavior.
16. **Above-Average Priced Items**: Highlights premium catalog tier.
17. **Category Inventory Valuation**: Calculates total working capital tied up in inventory stock.
18. **Pareto Revenue Contribution**: Calculates each product's percentage share of gross sales.
19. **Above-Average Spenders**: Isolates the top spending tier using nested scalar subqueries.
20. **Repeat Customers**: Identifies customers with `COUNT(order_id) > 1` for retention tracking.
