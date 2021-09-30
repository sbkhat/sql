-- SQL ЗАПРОСЫ СВЯЗАННЫЕ С ПОЛЬЗОВАТЕЛЯМИ

-- Вывод пользователей для постраничной навигации
SELECT u.id as user_id, u.login, upn.value as phone, uph.value as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

SELECT u.id as user_id, u.login,
       (
         select value
         from user_photos
         where id = photo_id
       ) as photo_src,
       (
         select value
         from user_phones
         where id = photo_id
       ) as phone_number
FROM users u
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ТЕЛЕФОНОВ
SELECT u.id as user_id, u.login, upn.value as phone, uph.value as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.phone_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ФОТОГРАФИЙ
SELECT u.id as user_id, u.login, upn.value as phone, uph.value as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.photo_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ФОТОГРАФИЙ И ТЕЛЕФОНОВ
SELECT u.id as user_id, u.login, upn.value as phone, uph.value as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.photo_id IS NULL AND u.phone_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Список активных пользователей
SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  LEFT JOIN profiles p ON u.id = p.user_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1)
ORDER BY u.id ASC
LIMIT 100
OFFSET 0;

-- Колличество пользователей по статусам
SELECT count(1), up.name
FROM users u
  LEFT JOIN user_statuses up ON u.status_id = up.id
GROUP BY up.name;

SELECT count(1),
  (
    select name
    from user_statuses us
    where us.id = u.status_id
  ) as status_name
FROM users u
GROUP BY u.status_id;

-- Колличество пользователей c группировской по возрасту
SELECT
  count(1) as count,
  (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) as age
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
GROUP BY age
ORDER BY age ASC;

-- Колличество пользователей c группировской по возрасту (c шагом в 10 лет)
SELECT
  count(1) as count,
  (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) as age,
  (
    CASE
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <= 10 THEN 'возраст от 0 до 10'
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <= 20 THEN 'возраст от 10 до 20'
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <= 30 THEN 'возраст от 20 до 30'
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <= 40 THEN 'возраст от 30 до 40'
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <= 50 THEN 'возраст от 40 до 50'
    WHEN (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) > 50 THEN 'возраст старше 50'
    END
  ) as age_rate
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
GROUP BY
  CASE
  WHEN age < 10 THEN 1
  WHEN age < 20 THEN 2
  WHEN age < 30 THEN 3
  WHEN age < 40 THEN 4
  WHEN age < 50 THEN 5
  WHEN age > 50 THEN 6
  END
ORDER BY age ASC;

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

SELECT
  count(1) as count,
  (get_age_text(p.birthday)) as age_rate
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
GROUP BY
  CASE
  WHEN get_age(birthday) < 10 THEN 1
  WHEN get_age(birthday) < 20 THEN 2
  WHEN get_age(birthday) < 30 THEN 3
  WHEN get_age(birthday) < 40 THEN 4
  WHEN get_age(birthday) < 50 THEN 5
  WHEN get_age(birthday) > 50 THEN 6
  END
ORDER BY get_age(birthday) ASC;


-- Пользователи от 30 до 50 лет
SELECT
  count(1) as count,
  get_age(p.birthday) as age,
  p.birthday
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
WHERE get_age(p.birthday) <= 50 AND get_age(p.birthday) >= 30
GROUP BY age
ORDER BY age ASC;

-- количество пользователей от 30 до 50 лет
SELECT
  count(1) as count
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
WHERE get_age(p.birthday) <= 50 AND get_age(p.birthday) >= 30;

-- количество пользователей женщин от 30 до 50 лет
SELECT
  count(1) as count
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
WHERE get_age(p.birthday) <= 50 AND get_age(p.birthday) >= 30 AND p.gender_id = 2 ;

-- каких пользователей от 30 до 50 лет больше по гендерному типу
SELECT g.name
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
  INNER JOIN genders g ON p.gender_id = g.id
WHERE get_age(p.birthday) <= 50 AND get_age(p.birthday) >= 30
GROUP BY g.name
ORDER BY count(1) DESC
LIMIT 1;

-- Колличество пользователей родившиеся в 1990 году
SELECT *
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
WHERE YEAR(p.birthday) = 1990;

-- Колличество пользователей родившиеся в 1990 году и у которых стребуется подтверждения email адреса
SELECT *
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
  INNER JOIN user_statuses us ON us.id = u.status_id
WHERE YEAR(p.birthday) = 1990 AND us.id = 2;


-- Активные пользователи из города Москва
SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  LEFT JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND c.id = 1;

SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  LEFT JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND c.name = 'Москва';


-- Активные пользователи из страны Белоруссия
SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  LEFT JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND c.id = 1;

SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  INNER JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN regions r ON r.id = c.region_id
  LEFT JOIN countries cs ON cs.id = c.country_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND cs.name = 'Беларусия';

-- Активные пользователи из региона Московская область
SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  INNER JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN regions r ON r.id = c.region_id
  LEFT JOIN countries cs ON cs.id = c.country_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND r.id IN (2);

SELECT *
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  INNER JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN regions r ON r.id = c.region_id
  LEFT JOIN countries cs ON cs.id = c.country_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
WHERE u.status_id IN (1) AND r.name = 'Московская область';

-- Количество польователей с группировской по странам, регионам и городам
SELECT c.name, r.name, cs.name, count(1)
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN user_photos uph ON u.phone_id = uph.id
  INNER JOIN profiles p ON u.id = p.user_id
  LEFT JOIN cities c ON c.id = p.city_id
  LEFT JOIN regions r ON r.id = c.region_id
  LEFT JOIN countries cs ON cs.id = c.country_id
  LEFT JOIN user_statuses up ON u.status_id = up.id
GROUP BY c.name, r.name, cs.name;

-- Пользователи, у которых создано множество профилей
SELECT u.id, count(1)
FROM users u
  INNER JOIN profiles p ON u.id = p.user_id
GROUP BY u.id
HAVING count(p.user_id) > 1;

-- SQL ЗАПРОСЫ СВЯЗАННЫЕ С ОТЕЛЕМ

-- Количество отелей по типу
SELECT count(1) count, ht.name
FROM hotels h
  INNER JOIN hotel_types ht ON h.type_id = ht.id
GROUP BY ht.name;

-- Количество акивных отелей по типу
SELECT count(1) count, ht.name, hs.name
FROM hotels h
  INNER JOIN hotel_types ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses hs ON h.status_id = hs.id
GROUP BY ht.name, hs.name;

SELECT count(1) count,
       (
         select name
         from hotel_types
         where id = h.type_id
       ) type,
       (
         select name
         from hotel_statuses
         where id = h.status_id
       ) status
FROM hotels h
GROUP BY h.status_id, h.type_id
ORDER BY h.status_id DESC;


-- количество отелей по городам
SELECT c.name, count(1) count
FROM hotels h
  INNER JOIN hotel_types as ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses as hs ON h.status_id = hs.id
  INNER JOIN cities c ON h.city_id = c.id
  INNER JOIN regions r ON c.region_id = r.id
  INNER JOIN countries cs ON c.country_id = cs.id
GROUP BY c.name;

-- количество отелей по регионам
SELECT r.name, count(1) count
FROM hotels h
  INNER JOIN hotel_types as ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses as hs ON h.status_id = hs.id
  INNER JOIN cities c ON h.city_id = c.id
  INNER JOIN regions r ON c.region_id = r.id
  INNER JOIN countries cs ON c.country_id = cs.id
GROUP BY r.name;

-- количество отелей по странам
SELECT cs.name, count(1) count
FROM hotels h
  INNER JOIN hotel_types as ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses as hs ON h.status_id = hs.id
  INNER JOIN cities c ON h.city_id = c.id
  INNER JOIN regions r ON c.region_id = r.id
  INNER JOIN countries cs ON c.country_id = cs.id
GROUP BY cs.name;


-- самый максимальную и минимальную стоимость отелей по типу и годам
SELECT cs.name, ht.name, MAX(h.cost) min, MIN(h.cost) max, YEAR(h.created_at)
FROM hotels h
  INNER JOIN hotel_types as ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses as hs ON h.status_id = hs.id
  INNER JOIN cities c ON h.city_id = c.id
  INNER JOIN regions r ON c.region_id = r.id
  INNER JOIN countries cs ON c.country_id = cs.id
GROUP BY YEAR(h.created_at), cs.name, ht.name
ORDER BY YEAR(h.created_at) DESC, cs.id ASC, ht.name DESC;

-- Список комментарияе у отела
SELECT c.description, u.login, c.created_at
FROM comments c
  INNER JOIN hotels h ON h.id = c.hotel_id
  INNER JOIN hotel_types as ht ON h.type_id = ht.id
  INNER JOIN hotel_statuses as hs ON h.status_id = hs.id
  INNER JOIN cities as css ON h.city_id = css.id
  INNER JOIN regions r ON css.region_id = r.id
  INNER JOIN countries cs ON css.country_id = cs.id
  INNER JOIN users u ON c.user_id = u.id
WHERE c.hotel_id = 1
ORDER BY c.created_at DESC;

SELECT c.description, h.name
FROM hotels h
  LEFT JOIN comments c ON h.id = c.hotel_id
WHERE hotel_id = 1;

-- Фотографии отеля
SELECT hp.value, h.name
FROM hotels h
  LEFT JOIN hotel_photos hp ON h.id = hp.hotel_id
WHERE hotel_id = 1;

-- Узнать стоимость отеля за указанные даты (период аренды)
DROP FUNCTION IF EXISTS get_price;
CREATE FUNCTION  get_price (date_from DATETIME, date_to DATETIME, hotel_id BIGINT)
  RETURNS DECIMAL DETERMINISTIC
  BEGIN
    RETURN ((DATEDIFF(date_to, date_from)) + 1) * (SELECT cost FROM hotels WHERE id = hotel_id);
  END;

select get_price(DATE('2020-01-01'), DATE('2020-01-10'), 1);

-- Узнать количество заказанных дней у отелей в разрезе по годам и типам отелей
UPDATE orders SET date_from = date_to, date_to = date_from WHERE date_from > orders.date_to;

SELECT
  YEAR(o.created_at) as year,
  os.name, ht.name,
  SUM(DATEDIFF(o.date_from, o.date_to)) as count_days_ordered,
  count(DISTINCT(o.hotel_id)) as uniq_count_hotels
FROM orders o
  INNER JOIN order_statuses os ON o.status_id = os.id
  INNER JOIN hotels h ON o.hotel_id = h.id
  INNER JOIN hotel_types ht ON h.type_id = ht.id
GROUP BY os.name, ht.name, YEAR(o.created_at);

