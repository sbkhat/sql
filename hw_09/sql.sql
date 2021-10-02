-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

INSERT INTO sample.users (SELECT * FROM shop.users WHERE shop.users.id = 1);

-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.
CREATE OR REPLACE VIEW product_name_catalog_name_view AS
  SELECT p.name AS product_name, c.name AS catalog_name
  FROM products as p
    INNER JOIN catalogs as c ON p.catalog_id = c.id;

SELECT *
FROM product_name_catalog_name_view;

-- Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи
-- за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
-- если дата присутствует в исходном таблице и 0, если она отсутствует.

CREATE TABLE dates (
  created_at DATETIME
) COMMENT = 'Даты';

INSERT INTO dates VALUES
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-17');


SELECT
  if (d.created_at IS NULL, 0, 1 ) as has_date,
  DATE_FORMAT(cd.selected_date, '%Y-%m-%d'),
  DATE_FORMAT(d.created_at, '%Y-%m-%d')
FROM (
       SELECT * FROM
         (SELECT adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) selected_date FROM
           (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
           (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
           (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
           (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
           (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
       WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31'
     ) as cd
  LEFT JOIN dates d ON DATE_FORMAT(cd.selected_date, '%Y%m%d') = DATE_FORMAT(d.created_at, '%Y%m%d');

-- Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей
CREATE TABLE test (
  id INT AUTO_INCREMENT PRIMARY KEY ,
  created_at DATETIME
) COMMENT = 'Даты';

INSERT INTO test (created_at) VALUES
  ('2018-08-01'),
  ('2018-08-01'),
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-04'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-16'),
  ('2018-08-16'),
  ('2018-08-17'),
  ('2018-08-17');


-- У меня такой вариант удаления не поддерживается, но в докуметации примеры есть
DELETE FROM test WHERE id NOT IN (
  SELECT id
  FROM test
  ORDER BY created_at DESC
  LIMIT 5
);

-- получила 2018-08-16 00:00:00
SELECT created_at
FROM test
ORDER BY created_at DESC
LIMIT 4, 1;

DELETE FROM test WHERE created_at < '2018-08-16 00:00:00';

SELECT *
FROM test;

-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер",
-- с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello() RETURNS TEXT DETERMINISTIC
  BEGIN
    RETURN CASE
           WHEN '06:00' <= CURTIME() AND CURTIME() < '12:00' THEN 'Доброе утро'
           WHEN '12:00' <= CURTIME() AND CURTIME() < '18:00' THEN 'Добрый День'
           WHEN '18:00' <= CURTIME() AND CURTIME() < '00:00' THEN 'Добрый вечер'
           ELSE 'Доброй ночи'
           END;
  END;

SELECT  hello();

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

CREATE TRIGGER desc_and_name_check_before_insert
BEFORE INSERT ON products FOR EACH ROW
  BEGIN
    IF NEW.name IS NULL AND NEW.desription IS NULL
    THEN SIGNAL sqlstate '45001' set message_text = 'products name or description can not be NULL';
    END IF;
  END;

CREATE TRIGGER desc_and_name_check_before_update
BEFORE UPDATE
  ON products FOR EACH ROW
  BEGIN
    IF NEW.name IS NULL AND NEW.desription IS NULL
    THEN SIGNAL sqlstate '45001' set message_text = 'products name or description can not be NULL';
    END IF;
  END;

-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

CREATE PROCEDURE FIBONACCI(num INT)
  BEGIN
    DECLARE a BIGINT DEFAULT 0;
    DECLARE b BIGINT DEFAULT 1;
    DECLARE res BIGINT DEFAULT 0;
    DECLARE i INT DEFAULT 1;

    IF num = 0 THEN
      SET @result = 0;
    ELSEIF num <= 1 THEN
      SET @result = 1;
    ELSE
      WHILE i < num DO
        SET res = a + b;
        SET a = b;
        SET b = res;
        SET i = i + 1;
      END WHILE;
      SET @result = res;
    END IF;
  END;


CALL FIBONACCI(10);
SELECT @result;

CALL FIBONACCI(7);
SELECT @result;

CALL FIBONACCI(3);
SELECT @result;

CALL FIBONACCI(1);
SELECT @result;