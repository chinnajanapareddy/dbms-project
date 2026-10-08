-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 13_indexes.sql
-- Description: Creates strategically placed B-Tree indexes on high-cardinality
--              and frequently joined/filtered columns to optimize query execution.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Index on Customers(city)
-- Rationale:
-- Frequently filtered and grouped in regional reports and localized shipping lookups.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_customers_city 
ON Customers(city);

-- ----------------------------------------------------------------------------
-- 2. Index on Products(category_id)
-- Rationale:
-- Critical foreign key column joined in nearly every catalog browse and report query.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_products_category_id 
ON Products(category_id);

-- ----------------------------------------------------------------------------
-- 3. Composite Index on Products(brand, price)
-- Rationale:
-- Accelerates e-commerce catalog filtering where users filter by brand and sort by price.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_products_brand_price 
ON Products(brand, price);

-- ----------------------------------------------------------------------------
-- 4. Index on Orders(customer_id)
-- Rationale:
-- Foreign key used heavily to fetch customer purchase history and order joins.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_orders_customer_id 
ON Orders(customer_id);

-- ----------------------------------------------------------------------------
-- 5. Index on Orders(order_date)
-- Rationale:
-- Speeds up date-range filtering, monthly/annual accounting reports, and chronological sorting.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_orders_order_date 
ON Orders(order_date);

-- ----------------------------------------------------------------------------
-- 6. Index on Orders(order_status)
-- Rationale:
-- Used by operational dashboards to quickly filter 'Pending', 'Processing', or 'Cancelled' orders.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_orders_status 
ON Orders(order_status);

-- ----------------------------------------------------------------------------
-- 7. Composite Index on Order_Items(order_id, product_id)
-- Rationale:
-- Greatly speeds up junction table joins connecting Orders with Products.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_order_items_order_product 
ON Order_Items(order_id, product_id);

-- ----------------------------------------------------------------------------
-- 8. Index on Payments(payment_status)
-- Rationale:
-- Supports finance team audits filtering for failed, refunded, or pending transactions.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_payments_status 
ON Payments(payment_status);

-- ----------------------------------------------------------------------------
-- 9. Index on Shipping(shipping_status)
-- Rationale:
-- Essential for logistics fulfillment systems to locate active shipments awaiting delivery.
-- ----------------------------------------------------------------------------
CREATE INDEX idx_shipping_status 
ON Shipping(shipping_status);

-- ----------------------------------------------------------------------------
-- 10. Inspection & Verification of Indexes
-- Description: Displays index structures created across major tables.
-- ----------------------------------------------------------------------------
SHOW INDEX FROM Customers;
SHOW INDEX FROM Products;
SHOW INDEX FROM Orders;
SHOW INDEX FROM Order_Items;
SHOW INDEX FROM Payments;
SHOW INDEX FROM Shipping;
