-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 03_constraints.sql
-- Description: Applies UNIQUE, CHECK, and FOREIGN KEY constraints to enforce
--              referential integrity, valid ranges, and domain logic.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. UNIQUE & CHECK Constraints on Customers
-- ----------------------------------------------------------------------------
ALTER TABLE Customers
    ADD CONSTRAINT uq_customers_email UNIQUE (email),
    ADD CONSTRAINT uq_customers_phone UNIQUE (phone);

-- ----------------------------------------------------------------------------
-- 2. UNIQUE Constraints on Categories
-- ----------------------------------------------------------------------------
ALTER TABLE Categories
    ADD CONSTRAINT uq_categories_name UNIQUE (category_name);

-- ----------------------------------------------------------------------------
-- 3. CHECK & FOREIGN KEY Constraints on Products
-- ----------------------------------------------------------------------------
ALTER TABLE Products
    ADD CONSTRAINT chk_products_price CHECK (price > 0),
    ADD CONSTRAINT chk_products_stock CHECK (stock_quantity >= 0),
    ADD CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------------------------------
-- 4. CHECK & FOREIGN KEY Constraints on Orders
-- ----------------------------------------------------------------------------
ALTER TABLE Orders
    ADD CONSTRAINT chk_orders_total CHECK (total_amount >= 0),
    ADD CONSTRAINT chk_orders_status CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    ADD CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------------------------------
-- 5. CHECK & FOREIGN KEY Constraints on Order_Items
-- ----------------------------------------------------------------------------
ALTER TABLE Order_Items
    ADD CONSTRAINT chk_order_items_qty CHECK (quantity > 0),
    ADD CONSTRAINT chk_order_items_unit_price CHECK (unit_price >= 0),
    ADD CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------------------------------
-- 6. CHECK & FOREIGN KEY Constraints on Payments
-- ----------------------------------------------------------------------------
ALTER TABLE Payments
    ADD CONSTRAINT chk_payments_amount CHECK (amount >= 0),
    ADD CONSTRAINT chk_payments_method CHECK (payment_method IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Cash on Delivery')),
    ADD CONSTRAINT chk_payments_status CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    ADD CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------------------------------------------------------
-- 7. CHECK & FOREIGN KEY Constraints on Shipping
-- ----------------------------------------------------------------------------
ALTER TABLE Shipping
    ADD CONSTRAINT chk_shipping_status CHECK (shipping_status IN ('Processing', 'Dispatched', 'In Transit', 'Out for Delivery', 'Delivered', 'Returned', 'Cancelled')),
    ADD CONSTRAINT fk_shipping_order
        FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------------------------------------------------------
-- 8. CHECK & FOREIGN KEY Constraints on Reviews
-- ----------------------------------------------------------------------------
ALTER TABLE Reviews
    ADD CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
    ADD CONSTRAINT fk_reviews_product
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT fk_reviews_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE;
