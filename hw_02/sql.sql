-- Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
DROP DATABASE IF EXISTS  example;
CREATE DATABASE example;

DROP TABLE IF EXISTS example.users;
CREATE TABLE example.users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL COMMENT 'Имя пользователяа'
);

-- Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
DROP DATABASE IF EXISTS  sample;
CREATE DATABASE sample;

INSERT INTO example.users (name) VALUES
  ('name1'),
  ('name2'),
  ('name3'),
  ('name4'),
  ('name5'),
  ('name6');