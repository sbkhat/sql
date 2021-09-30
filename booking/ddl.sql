CREATE DATABASE IF NOT EXISTS booking;
USE booking;

DROP TABLE IF EXISTS user_phones;
CREATE TABLE user_phones (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  value VARCHAR(10) NOT NULL COMMENT 'Номер телефона',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
);


DROP TABLE IF EXISTS user_photos;
CREATE TABLE user_photos (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  value VARCHAR(255) NOT NULL COMMENT 'Ссылка на изображения',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
);


DROP TABLE IF EXISTS user_statuses;
CREATE TABLE user_statuses (
  id SMALLINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL COMMENT 'Название статуса',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
);


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  firstname VARCHAR(100) NULL COMMENT 'Имя пользователяа',
  lastname VARCHAR(100) NULL COMMENT 'Фамилия пользователя',
  login VARCHAR(100) UNIQUE NOT NULL COMMENT 'Логин пользователя',
  password VARCHAR (100) NOT NULL COMMENT 'Пароль пользователя',
  last_activity DATETIME DEFAULT NOW() COMMENT 'Дата последней активности',
  status_id SMALLINT NOT NULL DEFAULT 1 COMMENT 'Идентификатор статуса',
  phone_id BIGINT DEFAULT NULL DEFAULT 1 COMMENT 'Идентификатор номера телефона',
  photo_id BIGINT DEFAULT NULL DEFAULT 1 COMMENT 'Идентификатор картинки',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
);
ALTER TABLE users ADD CONSTRAINT users_phone_id FOREIGN KEY (phone_id) REFERENCES user_phones(id);
ALTER TABLE users ADD CONSTRAINT users_photo_id FOREIGN KEY (photo_id) REFERENCES user_photos(id);
ALTER TABLE users ADD CONSTRAINT users_status_id FOREIGN KEY (status_id) REFERENCES user_statuses(id);


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название Города',
  region_id BIGINT NOT NULL COMMENT 'Идентификатор Региона',
  country_id BIGINT NOT NULL COMMENT 'Идентификатор Страны'
);


DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название Региона'
);


DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название Региона'
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название Города',
  region_id BIGINT NOT NULL COMMENT 'Идентификатор Региона',
  country_id BIGINT NOT NULL COMMENT 'Идентификатор Страны'
);
ALTER TABLE cities ADD CONSTRAINT cities_region_id FOREIGN KEY (region_id) REFERENCES regions(id);
ALTER TABLE cities ADD CONSTRAINT cities_country_id FOREIGN KEY (country_id) REFERENCES countries(id);

DROP TABLE IF EXISTS genders;
CREATE TABLE genders (
  id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название пола'
);

DROP TABLE IF EXISTS profile_statuses;
CREATE TABLE profile_statuses (
  id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Название Региона'
);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  user_id BIGINT NOT NULL COMMENT 'Ссылка на пользователя',
  birthday date DEFAULT NULL COMMENT 'Дата рождения',
  city_id BIGINT DEFAULT NULL COMMENT 'Идентификатор проживания',
  status_id SMALLINT NOT NULL DEFAULT 1,
  gender_id SMALLINT NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
);
ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE profiles ADD CONSTRAINT profiles_city_id FOREIGN KEY (city_id) REFERENCES cities(id);
ALTER TABLE profiles ADD CONSTRAINT profiles_status_id FOREIGN KEY (status_id) REFERENCES profile_statuses(id);


DROP TABLE IF EXISTS hotel_types;
CREATE TABLE hotel_types (
  id INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL  COMMENT 'Название'
);

DROP TABLE IF EXISTS hotel_statuses;
CREATE TABLE hotel_statuses (
  id INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL  COMMENT 'Название'
);

DROP TABLE IF EXISTS hotels;
CREATE TABLE hotels (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL COMMENT 'Идентификатор строки',
  description TEXT NOT NULL COMMENT 'Описание',
  type_id INTEGER NOT NULL COMMENT 'Идентификатор типа',
  cost DECIMAL NOT NULL COMMENT 'Стоимость за сутки',
  city_id BIGINT NOT NULL COMMENT 'Идентификатор Города',
  user_id INTEGER NOT NULL COMMENT 'Идентификатор польователя',
  address TEXT NOT NULL COMMENT 'Адрес',
  status_id INTEGER NOT NULL COMMENT 'Идентификатор статуса',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
);
ALTER TABLE hotels ADD CONSTRAINT hotel_type_id FOREIGN KEY (type_id) REFERENCES hotel_types(id);
ALTER TABLE hotels ADD CONSTRAINT hotel_status_id FOREIGN KEY (status_id) REFERENCES hotel_statuses(id);
ALTER TABLE hotels ADD CONSTRAINT hotel_user_id FOREIGN KEY (user_id) REFERENCES users(id);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  hotel_id BIGINT NOT NULL COMMENT 'Идентификатор строки',
  user_id BIGINT NOT NULL COMMENT 'Идентификатор строки',
  description TEXT NOT NULL COMMENT 'Идентификатор строки',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
);
ALTER TABLE comments ADD CONSTRAINT comments_user_id FOREIGN KEY (user_id) REFERENCES users(id);

DROP TABLE IF EXISTS hotel_photos;
CREATE TABLE hotel_photos (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  hotel_id BIGINT NOT NULL COMMENT 'Идентификатор отеля',
  value VARCHAR(255) NOT NULL COMMENT 'Ссылка на изображения',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки'
);
ALTER TABLE hotel_photos ADD CONSTRAINT hotel_photos_hotel_id FOREIGN KEY (hotel_id) REFERENCES hotels(id);

DROP TABLE IF EXISTS order_statuses;
CREATE TABLE order_statuses (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (255) not null
);

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
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  cost DECIMAL DEFAULT '0.00'
);
ALTER TABLE orders ADD CONSTRAINT orders_hotel_id FOREIGN KEY (hotel_id) REFERENCES hotels(id);
ALTER TABLE orders ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE orders ADD CONSTRAINT orders_status_id FOREIGN KEY (status_id) REFERENCES order_statuses(id);
