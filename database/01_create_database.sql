-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 01_create_database.sql
-- Description: Creates the database if it doesn't already exist, sets character
--              encoding, and selects the database for active session use.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

-- Drop the database if it exists (useful for fresh installation / script re-runs)
-- WARNING: This will drop existing data in ecommerce_db.
DROP DATABASE IF EXISTS ecommerce_db;

-- Create the database with UTF-8 Unicode character set support
CREATE DATABASE ecommerce_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Switch to the newly created database
USE ecommerce_db;

-- Verify database creation and selected database
SELECT DATABASE() AS current_active_database;
