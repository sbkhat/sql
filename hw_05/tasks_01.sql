-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
CREATE DATABASE new_database;

USE new_database;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL, -- искуственный ключ
  name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
);

INSERT INTO users (`name`) VALUES ('имя 1');
INSERT INTO users (`name`) VALUES ('имя 2');
INSERT INTO users (`name`) VALUES ('имя 3');

-- ставим null в датах
UPDATE users SET updated_at = null WHERE id IN (1,2,3);

-- проверяем
SELECT * FROM new_database.users;

-- обновляем
UPDATE users SET updated_at = now() WHERE updated_at is null;
UPDATE users SET created_at = now() WHERE created_at is null;

-- проверяем
SELECT * FROM new_database.users;


-- Таблица users была неудачно спроектирована. Записи created_at и updated_at
-- были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
  id SERIAL,
  name varchar(100) not null,
  created_at varchar(255) not null,
  updated_at varchar(255) not null
);

INSERT INTO users (`name`, `created_at`, `updated_at`) VALUES ('1', '20.10.2017 8:10', '20.10.2017 8:10');
INSERT INTO users (`name`, `created_at`, `updated_at`) VALUES ('2', '20.10.2017 8:10', '20.10.2017 8:10');
INSERT INTO users (`name`, `created_at`, `updated_at`) VALUES ('3', '20.10.2017 8:10', '20.10.2017 8:10');

UPDATE users SET updated_at = DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%m:%s');
UPDATE users SET created_at = DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%m:%s');

ALTER TABLE new_database.users MODIFY created_at DATETIME COMMENT 'Время создания строки';
ALTER TABLE new_database.users MODIFY updated_at DATETIME COMMENT 'Время обновления строки';

-- В таблице складских запасов storehouses_products в поле value
-- могут встречаться самые разные цифры: 0, если товар закончился и выше нуля,
-- если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value.
-- Однако нулевые запасы должны выводиться в конце, после всех записей.

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO new_database.storehouses_products (storehouse_id, product_id, value) VALUES (1, 1, 1);
INSERT INTO new_database.storehouses_products (storehouse_id, product_id, value) VALUES (1, 1, 0);
INSERT INTO new_database.storehouses_products (storehouse_id, product_id, value) VALUES (1, 1, 300);

SELECT * FROM storehouses_products
ORDER BY
  CASE
  WHEN value = 0
    THEN 2147483647 -- максимально возможное значение, чтобы ушло вниз
  ELSE value END;


-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий (may, august)
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


SELECT
  CASE
  WHEN MONTH(birthday_at) = 5
    THEN 'may'
  WHEN MONTH(birthday_at) = 8
    then 'august'
  else 'unnamed'
  END as mounth,
  name,
  birthday_at,
  id
FROM users
WHERE (MONTH(birthday_at) = 5 or MONTH(birthday_at) = 8);

/* (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Отсортируйте записи в порядке, заданном в списке IN.
*/
SELECT *
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);
