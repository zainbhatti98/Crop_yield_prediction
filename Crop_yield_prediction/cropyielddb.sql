CREATE DATABASE IF NOT EXISTS cropyielddb;
USE cropyielddb;

CREATE TABLE IF NOT EXISTS admin (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), password VARCHAR(50));
CREATE TABLE IF NOT EXISTS farmers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), phone VARCHAR(20), password VARCHAR(100));
CREATE TABLE IF NOT EXISTS buyers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), phone VARCHAR(20), password VARCHAR(100));
CREATE TABLE IF NOT EXISTS crops (id INT AUTO_INCREMENT PRIMARY KEY, crop_name VARCHAR(100), rate DOUBLE);
CREATE TABLE IF NOT EXISTS sale_requests (id INT AUTO_INCREMENT PRIMARY KEY, farmer_id INT, crop_id INT, quantity DOUBLE, farmer_price DOUBLE, status VARCHAR(50));
CREATE TABLE IF NOT EXISTS orders (id INT AUTO_INCREMENT PRIMARY KEY, buyer_id INT, farmer_id INT, crop_id INT, quantity DOUBLE, payment_method VARCHAR(50), payment_number VARCHAR(50), status VARCHAR(50), buyer_name VARCHAR(100), buyer_phone VARCHAR(50), buyer_address VARCHAR(255));
CREATE TABLE IF NOT EXISTS messages (id INT AUTO_INCREMENT PRIMARY KEY, sender_id INT, receiver_id INT, message TEXT, send_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, sender_type VARCHAR(20), receiver_type VARCHAR(20));
CREATE TABLE IF NOT EXISTS ratings (id INT AUTO_INCREMENT PRIMARY KEY, farmer_id INT, rating INT, remarks TEXT);

INSERT INTO admin (username, password) VALUES ('admin', 'admin123');
INSERT INTO farmers (name, email, password) VALUES ('sara', 'sara@gmail.com', '123');
INSERT INTO buyers (name, email, password) VALUES ('Sarah Hanif', 'sara123@gmail.com', 'Sarah123');
INSERT INTO crops (crop_name, rate) VALUES
('Wheat',3500),('Maize',4000),('Rice',4200),('Cotton',5500),('Sugarcane',2800),
('Barley',3200),('Millet',3000),('Soybean',4800),('Potato',2500),('Tomato',2200),
('Onion',2000),('Chilli',6500),('Mustard',4500),('Groundnut',5200),('Sunflower',4600),
('Banana',1800),('Mango',3500),('Lentil',3800),('Chickpea',4000),('Sesame',5000);
