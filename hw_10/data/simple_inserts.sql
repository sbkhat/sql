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
  user_id BIGINT NOT NULL COMMENT 'Идентификатор польователя',
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
  id INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR (255) NOT NULL COMMENT 'Идентификатор строки'
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  hotel_id BIGINT NOT NULL COMMENT 'Идентификатор отеля',
  user_id BIGINT NOT NULL COMMENT 'Идентификатор пользователя',
  status_id INTEGER NOT NULL  COMMENT 'Идентификатор статуса',
  date_from DATE COMMENT 'С какой даты заказ',
  date_to DATE COMMENT 'По какую дату заказ',
  comment TEXT  COMMENT 'Комментарий заказчика',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Время обновления строки',
  cost DECIMAL DEFAULT '0.00' COMMENT 'Стоимость'
);
ALTER TABLE orders ADD CONSTRAINT orders_hotel_id FOREIGN KEY (hotel_id) REFERENCES hotels(id);
ALTER TABLE orders ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE orders ADD CONSTRAINT orders_status_id FOREIGN KEY (status_id) REFERENCES order_statuses(id);


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  hotel_id BIGINT NOT NULL COMMENT 'Идентификатор отеля',
  user_id BIGINT NOT NULL COMMENT 'Идентификатор пользователя',
  status_id INTEGER NOT NULL  COMMENT 'Идентификатор статуса',
  created_at DATETIME DEFAULT NOW() COMMENT 'Время создания строки'
);
ALTER TABLE logs ADD CONSTRAINT logs_hotel_id FOREIGN KEY (hotel_id) REFERENCES hotels(id);
ALTER TABLE logs ADD CONSTRAINT logs_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE logs ADD CONSTRAINT logs_status_id FOREIGN KEY (status_id) REFERENCES order_statuses(id);


INSERT INTO `user_photos` VALUES
  (1,'http://lorempixel.com/600/400/','1996-03-09 08:31:52','1994-06-19 23:35:38'),
  (2,'http://lorempixel.com/600/400/','1970-05-04 17:29:13','2019-09-12 00:33:21'),
  (3,'http://lorempixel.com/600/400/','2010-07-27 22:48:08','1978-11-01 10:29:49'),
  (4,'http://lorempixel.com/600/400/','1981-06-26 13:48:05','1992-04-24 02:32:26');

INSERT INTO `user_phones` VALUES
  (1,'7513348062','1974-04-11 11:11:45','2016-03-29 04:15:47'),
  (2,'7513348063','1974-04-11 11:11:45','2016-03-29 04:15:47'),
  (3,'7513348064','1974-04-11 11:11:45','2016-03-29 04:15:47'),
  (4,'7513348065','1974-04-11 11:11:45','2016-03-29 04:15:47');

INSERT INTO `user_statuses` (name) VALUES
  ('активен'),('требует подтверждения email'),
  ('требует подтверждения телефона'),
  ('заблокирован'),
  ('удален');

INSERT INTO `profile_statuses` (name) VALUES
  ('активен'),
  ('требует подтверждения email'),
  ('требует подтверждения телефона'),
  ('удален');

INSERT INTO `regions` (name) VALUES
  ('Москва'),
  ('Московская область'),
  ('Курская Область'),
  ('Чеховская область'),
  ('Уральская область'),
  ('Минская область');

INSERT INTO `countries` (name) VALUES
  ('Российская Федерация'),
  ('Беларусия');

INSERT INTO `cities` (name, region_id, country_id) VALUES
  ('Москва', 1, 1),
  ('Мытищи', 2, 1),
  ('Балашиха', 2, 1),
  ('Курск', 3, 1),
  ('Чехов', 4, 1),
  ('Челябинск', 5, 1),
  ('Минск', 6, 2);

INSERT INTO `genders` (name) VALUES
  ('Мужчина'),
  ('Женщина');

INSERT INTO `users` VALUES
  (1,'Devante1','Stiedemann1','et1','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',1,1,1,'1978-10-16 14:34:26','1996-11-11 05:48:39'),
  (2,'Devante2','Stiedemann2','et2','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',2,2,2,'1978-10-16 14:34:26','1996-11-11 05:48:39'),
  (3,'Devante3','Stiedemann3','et3','d37cdfd6d2eb14b51e6dd2daa54df877','2004-09-06 10:46:14',3,3,3,'1978-10-16 14:34:26','1996-11-11 05:48:39');

INSERT INTO `profiles` VALUES
  (1,1,'1991-01-12',1,1,1,'1972-09-28 13:27:19','1976-10-16 17:04:34'),
  (2,2,'2009-02-02',2,2,2,'1992-10-12 03:48:27','1987-12-01 23:36:29'),
  (3,3,'2009-02-02',3,3,1,'1992-10-12 03:48:27','1987-12-01 23:36:29'),
  (4,3,'2009-02-02',4,2,2,'1992-10-12 03:48:27','1987-12-01 23:36:29');

INSERT INTO `hotel_types` (name) VALUES
  ('Дом'),
  ('Аппартаменты'),
  ('Комната'),
  ('Квартира');

INSERT INTO `hotel_statuses` (name) VALUES
  ('Сдается'),
  ('Удален'),
  ('Скрыт');

INSERT INTO `hotels` (id, name, description, type_id, cost, city_id, user_id, address, status_id) VALUES
  (1,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,1,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',1),
  (2,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,2,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',2),
  (3,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,3,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',3),
  (4,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,1,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',1),
  (5,'ipsam','Molestias ipsum saepe est. Laborum animi dolorem vero consequuntur nostrum. Sapiente neque accusantium odit nam et beatae.',3,43779,3,2,'1539 O\'Kon Valley Suite 277\nEast Flavioland, FL 83641',2);

INSERT INTO `comments` (id, hotel_id, user_id, description) VALUES
  (1,1,1,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.'),
  (2,2,1,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.'),
  (3,3,2,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.'),
  (4,4,2,'Quae quia a quod. Amet rerum voluptatibus et voluptatem velit inventore nemo. Ea aut commodi in impedit. Odio possimus quam id.');

INSERT INTO `hotel_photos` VALUES
  (1,1,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),
  (2,1,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),
  (3,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),
  (4,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46'),
  (5,2,'http://lorempixel.com/640/480/','1987-07-31 12:23:23','2008-01-05 20:29:46');


INSERT INTO `order_statuses` (name) VALUES
  ('В ожидании'),
  ('Оплачен'),
  ('Отменен');

INSERT INTO `orders` (id, hotel_id, user_id, status_id, date_from, date_to, comment) VALUES
  (1,1,1,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (2,2,2,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (3,3,2,3,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (4,4,3,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (5,5,3,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (6,1,3,3,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (7,2,3,1,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.'),
  (8,3,3,2,'1972-01-26','1977-04-15','Ut quidem quo quidem necessitatibus. Omnis minima adipisci eveniet iste. Error doloribus delectus aspernatur ut. Neque aut alias quas sunt molestiae id.');


DROP FUNCTION IF EXISTS get_price;
CREATE FUNCTION  get_price (date_from DATETIME, date_to DATETIME, hotel_id BIGINT)
  RETURNS DECIMAL DETERMINISTIC
  BEGIN
    RETURN ((DATEDIFF(date_to, date_from)) + 1) * (SELECT cost FROM hotels WHERE id = hotel_id);
  END;

DROP FUNCTION IF EXISTS get_age;
CREATE FUNCTION  get_age (birthday DATETIME)
  RETURNS INTEGER DETERMINISTIC
  BEGIN
    RETURN (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(birthday,5));
  END;

DROP FUNCTION IF EXISTS get_age_text;
CREATE FUNCTION  get_age_text (birthday DATETIME)
  RETURNS VARCHAR(255) DETERMINISTIC
  BEGIN
    DECLARE age INT;
    SET age = get_age(birthday);
    RETURN CASE
           WHEN age <= 10 THEN 'возраст от 0 до 10'
           WHEN age <= 20 THEN 'возраст от 10 до 20'
           WHEN age <= 30 THEN 'возраст от 20 до 30'
           WHEN age <= 40 THEN 'возраст от 30 до 40'
           WHEN age <= 50 THEN 'возраст от 40 до 50'
           WHEN age > 50 THEN  'возраст старше 50'
           END;
  END;


DROP TRIGGER IF EXISTS orders_log_insert_after_update;
CREATE TRIGGER orders_log_insert_after_update
AFTER UPDATE ON orders FOR EACH ROW
  BEGIN
    INSERT INTO logs (hotel_id, user_id, status_id) VALUE (NEW.hotel_id, NEW.user_id, NEW.status_id);
  END;


CREATE OR REPLACE VIEW orders_view AS
  SELECT
    o.id AS id,
    o.date_from AS date_from,
    o.date_to AS date_to,
    get_price(o.date_to, o.date_from, h.id) AS cost,
    u2.id AS owner_id,
    up2.value as owner_phone,
    u1.id AS user_id,
    up1.value as user_phone
  FROM orders as o
    INNER JOIN users u1 ON o.user_id = u1.id
    INNER JOIN user_phones up1 ON u1.phone_id = up1.id
    INNER JOIN hotels h ON o.hotel_id = h.id
    INNER JOIN users u2 ON h.user_id = u2.id
    INNER JOIN user_phones up2 ON u2.phone_id = up2.id;
