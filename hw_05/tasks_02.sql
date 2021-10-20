-- Подсчитайте средний возраст пользователей в таблице users
SELECT AVG(
           (YEAR(CURRENT_DATE)-YEAR(birthday_at))-(RIGHT(CURRENT_DATE,5) < RIGHT(birthday_at,5))
       ) as avg_age
FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT
  name,
  birthday_at,
  DAYOFWEEK(
      CONCAT(
          YEAR(NOW()),
          '-',
          MONTH(birthday_at),
          '-',
          DAYOFMONTH(birthday_at)
      )
  ) as day_of_week
FROM users;

SELECT
  COUNT(1),
  DAYOFWEEK(
      CONCAT(
          YEAR(NOW()),
          '-',
          MONTH(birthday_at),
          '-',
          DAYOFMONTH(birthday_at)
      )
  ) as day_of_week
FROM users
GROUP BY day_of_week
ORDER BY day_of_week ASC;
-- day_of_week - дни недели. 1 = пн, 2 = вт ... 7 = вс.

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
DROP TABLE IF EXISTS some_table;
CREATE TABLE some_table (
  value INT NOT NULL
);

INSERT INTO new_database.some_table (value) VALUES
  (1),
  (2),
  (3),
  (4),
  (5);

SELECT ROUND(
           EXP(
            SUM(LOG(value))
          )
      ) as value
FROM some_table;