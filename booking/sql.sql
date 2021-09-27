-- SQL запросы по пользователям

-- Вывод пользователей для постраничной навигации
SELECT u.id as user_id, u.login, upn.value as phone, uph.src as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

SELECT u.id as user_id, u.login,
  (
    select src
    from user_photos
    where id = photo_id
  ) as photo_src,
  (
    select value
    from user_phones
    where id = photo_id
  ) as phone_number
 FROM users u
 LIMIT 100
 OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ТЕЛЕФОНОВ
SELECT u.id as user_id, u.login, upn.value as phone, uph.src as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.phone_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ФОТОГРАФИЙ
SELECT u.id as user_id, u.login, upn.value as phone, uph.src as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.photo_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;

-- Вывод пользователей для постраничной навигации БЕЗ ФОТОГРАФИЙ И ТЕЛЕФОНОВ
SELECT u.id as user_id, u.login, upn.value as phone, uph.src as photo_src
FROM users u
  LEFT JOIN user_phones upn ON u.phone_id = upn.id
  LEFT JOIN  user_photos uph ON u.phone_id = uph.id
WHERE u.photo_id IS NULL AND u.phone_id IS NULL
ORDER BY u.id DESC
LIMIT 100
OFFSET 0;
