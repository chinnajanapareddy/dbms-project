-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 02_create_tables.sql
-- Description: Creates all relational entities/tables with appropriate 
--              data types, primary keys, and auto-increment properties.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Table: Customers
-- Description: Stores customer personal information, contact, and address.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. Table: Categories
-- Description: Classifies products into functional catalog categories.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. Table: Products
-- Description: Stores items available for purchase with price and stock levels.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    brand VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. Table: Orders
-- Description: Records orders placed by customers and total order price.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (order_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. Table: Order_Items
-- Description: Line items belonging to an order, capturing product and unit price.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Order_Items (
    order_item_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_item_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. Table: Payments
-- Description: Captures payment transactions, payment methods, and statuses.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (payment_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 7. Table: Shipping
-- Description: Tracks fulfillment, dispatch, destination, and delivery status.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Shipping (
    shipping_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    shipping_city VARCHAR(50) NOT NULL,
    shipping_state VARCHAR(50) NOT NULL,
    shipping_pincode VARCHAR(10) NOT NULL,
    shipping_date DATETIME,
    delivery_date DATETIME,
    shipping_status VARCHAR(30) NOT NULL DEFAULT 'Processing',
    PRIMARY KEY (shipping_id)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. Table: Reviews (Additional value-added table)
-- Description: Customer ratings and written feedback for purchased products.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (review_id)
) ENGINE=InnoDB;
