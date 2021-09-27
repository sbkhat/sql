-- SQL запросы по пользователям

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

-- Колличество пользователей от 30 до 50 лет
SELECT
  count(1) as count,
  (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) as age,
  p.birthday
FROM users u
  INNER JOIN profiles p ON p.user_id = u.id
WHERE (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) >= 30 AND (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) <=50
GROUP BY age
ORDER BY age ASC;

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

-- SQL запросы по отелям

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

