-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 12_views.sql
-- Description: Creates reusable, abstract database views for standard reporting:
--              1. customer_order_summary
--              2. product_sales_summary
--              3. order_details_view
--              4. pending_shipments_view
--              5. category_performance_view
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- View 1: customer_order_summary
-- Description: Aggregates lifetime purchasing metrics for every customer.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS customer_order_summary;

CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0.00) AS total_lifetime_spent,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0.00) AS average_order_value,
    MAX(o.order_date) AS most_recent_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.phone, c.city, c.state;

-- Test View 1:
SELECT * 
FROM customer_order_summary 
ORDER BY total_lifetime_spent DESC 
LIMIT 5;

-- ----------------------------------------------------------------------------
-- View 2: product_sales_summary
-- Description: Tracks catalog performance, inventory stock, total units sold,
--              and total revenue generated per product.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS product_sales_summary;

CREATE VIEW product_sales_summary AS
SELECT 
    p.product_id,
    p.product_name,
    p.brand,
    c.category_name,
    p.price AS current_unit_price,
    p.stock_quantity AS warehouse_stock,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0.00) AS total_revenue_generated
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
LEFT JOIN Orders o ON oi.order_id = o.order_id AND o.order_status != 'Cancelled'
GROUP BY p.product_id, p.product_name, p.brand, c.category_name, p.price, p.stock_quantity;

-- Test View 2:
SELECT * 
FROM product_sales_summary 
ORDER BY total_revenue_generated DESC 
LIMIT 5;

-- ----------------------------------------------------------------------------
-- View 3: order_details_view
-- Description: Complete 360-degree operational view of orders, matching order
--              headers with line items, customer details, payment, and shipping.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS order_details_view;

CREATE VIEW order_details_view AS
SELECT 
    o.order_id,
    o.order_date,
    o.order_status,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email AS customer_email,
    c.phone AS customer_phone,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_item_total,
    o.total_amount AS order_total_amount,
    pay.payment_method,
    pay.payment_status,
    s.shipping_city,
    s.shipping_status,
    s.delivery_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipping s ON o.order_id = s.order_id;

-- Test View 3:
SELECT * 
FROM order_details_view 
WHERE order_id = 1;

-- ----------------------------------------------------------------------------
-- View 4: pending_shipments_view
-- Description: Surfaces shipments requiring dispatch or currently in transit.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS pending_shipments_view;

CREATE VIEW pending_shipments_view AS
SELECT 
    s.shipping_id,
    s.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS recipient_name,
    s.shipping_address,
    s.shipping_city,
    s.shipping_pincode,
    s.shipping_status,
    s.shipping_date
FROM Shipping s
JOIN Orders o ON s.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE s.shipping_status NOT IN ('Delivered', 'Cancelled');

-- Test View 4:
SELECT * 
FROM pending_shipments_view;

-- ----------------------------------------------------------------------------
-- View 5: category_performance_view
-- Description: High-level financial reporting view across product categories.
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS category_performance_view;

CREATE VIEW category_performance_view AS
SELECT 
    c.category_id,
    c.category_name,
    COUNT(DISTINCT p.product_id) AS total_products_in_catalog,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0.00) AS total_category_gross_revenue
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
LEFT JOIN Orders o ON oi.order_id = o.order_id AND o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name;

-- Test View 5:
SELECT * 
FROM category_performance_view 
ORDER BY total_category_gross_revenue DESC;
