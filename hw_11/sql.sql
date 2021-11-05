-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
-- в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.


-- предварительно выполнить source_dump.sql

DROP TABLE IF EXISTS shop.logs;
CREATE TABLE shop.logs (
  id SERIAL,
  name varchar(255) NOT NULL,
  item_id BIGINT NOT NULL,
  table_name VARCHAR(255) NOT NULL
) ENGINE=Archive;

CREATE TRIGGER shop.catalogs_after_insert AFTER INSERT ON shop.catalogs
FOR EACH ROW
  BEGIN
    INSERT INTO shop.logs (name, item_id, table_name) VALUE (NEW.name, NEW.id, 'catalogs');
  END;

CREATE TRIGGER shop.products_after_insert AFTER INSERT ON shop.products
FOR EACH ROW
  BEGIN
    INSERT INTO shop.logs (name, item_id, table_name) VALUE (NEW.name, NEW.id, 'products');
  END;

CREATE TRIGGER shop.users_after_insert AFTER INSERT ON shop.users
FOR EACH ROW
  BEGIN
    INSERT INTO shop.logs (name, item_id, table_name) VALUE (NEW.name, NEW.id, 'users');
  END;

-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- выполняется очень долго из-за shop.users_after_insert триггера и INSERT по одному значению
CREATE PROCEDURE INSERT_ITEMS_TO_USERS (IN i INT)
  BEGIN
    WHILE i > 0 DO
      INSERT INTO shop.users (name) VALUES (i);
      SET i = i - 1;
    END WHILE;
  END;

CALL INSERT_ITEMS_TO_USERS(1000000);