-- Create database and tables
CREATE DATABASE IF NOT EXISTS crm;
USE crm;

-- Users table
CREATE TABLE IF NOT EXISTS crm_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gmail VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    userType VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feedback table
CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gmail VARCHAR(100) NOT NULL,
    userType VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (gmail) REFERENCES crm_users(gmail) ON DELETE CASCADE
);

-- Reports table
CREATE TABLE IF NOT EXISTS report (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gmail VARCHAR(100) NOT NULL,
    userType VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (gmail) REFERENCES crm_users(gmail) ON DELETE CASCADE
);

-- Insert test data
INSERT INTO crm_users (gmail, password, userType) VALUES
('admin2183@gmail.com', SHA2('admin@210803', 256), 'admin'),
('consumer1@example.com', SHA2('password123', 256), 'consumer'),
('consumer2@example.com', SHA2('password456', 256), 'consumer');

SELECT * FROM crm_users;
DELETE FROM crm_users;

SELECT * FROM feedback ORDER BY created_at DESC;

SELECT * FROM report;
SELECT * FROM report ORDER BY created_at DESC;