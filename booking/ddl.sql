CREATE DATABASE IF NOT EXISTS booking;
USE booking;
---------------------------
DROP TABLE IF EXISTS user_phones;
CREATE TABLE user_phones (
  id serial PRIMARY KEY,
  value VARCHAR(10) NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
---------------------------
DROP TABLE IF EXISTS user_photos;
CREATE TABLE user_photos (
  id serial PRIMARY KEY,
  src VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
---------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(100) NULL,
  lastname VARCHAR(100) NULL,
  login VARCHAR(100) UNIQUE NOT NULL,
  phone_id BIGINT DEFAULT NULL,
  photo_id BIGINT DEFAULT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
ALTER TABLE users ADD CONSTRAINT users_phone_id_r FOREIGN KEY (phone_id) REFERENCES user_phones(id);
ALTER TABLE users ADD CONSTRAINT users_photo_id_r FOREIGN KEY (photo_id) REFERENCES user_photos(id);
---------------------------
DROP TABLE IF EXISTS hotel_types;
CREATE TABLE hotel_types (
  id int AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
---------------------------
DROP TABLE IF EXISTS hotels;
CREATE TABLE hotels (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  type_id int NOT NULL,
  cost int NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
ALTER TABLE hotels ADD CONSTRAINT hotels_type_id_r FOREIGN KEY (type_id) REFERENCES hotel_types(id);
-------------------------------
DROP TABLE IF EXISTS hotel_types;
CREATE TABLE hotel_types (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
---------------------------
DROP TABLE IF EXISTS hotels;
CREATE TABLE hotels (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL ,
  name VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  type_id int NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
ALTER TABLE hotels ADD CONSTRAINT hotels_type_id_r FOREIGN KEY (type_id) REFERENCES hotel_types(id);

---------------------------
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  hotel_id BIGINT NOT NULL ,
  user_id BIGINT NOT NULL ,
  description TEXT NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
ALTER TABLE comments ADD CONSTRAINT comments_user_id FOREIGN KEY (user_id) REFERENCES users(id);
---------------------------
DROP TABLE IF EXISTS order_statuses;
CREATE TABLE order_statuses (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) not null
);
---------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  hotel_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  status_id INTEGER NOT NULL,
  date_from DATE,
  date_to DATE,
  comment TEXT,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);
ALTER TABLE orders ADD CONSTRAINT orders_hotel_id FOREIGN KEY (hotel_id) REFERENCES hotels(id);
ALTER TABLE orders ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE orders ADD CONSTRAINT orders_status_id FOREIGN KEY (user_id) REFERENCES order_statuses(id);
---------------------------