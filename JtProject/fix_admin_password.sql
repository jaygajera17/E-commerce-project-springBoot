-- Fix admin password for BCrypt authentication
-- Run this in your ecomjava database if admin/123 login fails
-- This updates the admin user's password to BCrypt hash of "123"

USE ecomjava;

UPDATE CUSTOMER 
SET password = '$2a$10$Gqo6QT80w8V9jOd0hUlA2uj2lDe3bwNgz.eMP8UwnsB6zMVJ2hYh6',
    is_active = 1
WHERE username = 'admin';
