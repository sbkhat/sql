-- Пусть задан некоторый пользователь.
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

-- задан пользователь с id = 1

SELECT count(1), from_user_id
FROM vk.messages m
WHERE m.to_user_id = 1
GROUP BY m.from_user_id
ORDER BY count(1) DESC
;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT COUNT(id) as sum
FROM likes
WHERE user_id IN (
  SELECT * FROM (
                  SELECT p.user_id FROM profiles p WHERE
                    (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) < 10
                ) as p
);

-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT IF(
           (
             SELECT COUNT(1) FROM likes WHERE user_id IN (
               SELECT id FROM users INNER JOIN profiles ON users.id = profiles.user_id WHERE gender = 'M'
             )
           ) > (
             SELECT COUNT(1) FROM likes WHERE user_id IN (
               SELECT id FROM users INNER JOIN profiles ON users.id = profiles.user_id WHERE gender = 'F'
             )
           ),
           'male',
           'female'
       ) as gender;


SELECT
  (
    SELECT COUNT(1) FROM likes WHERE user_id IN (
      SELECT id
      FROM users
        INNER JOIN profiles ON users.id = profiles.user_id
      WHERE gender = 'M'
    )
  ) as count_male,
  (
    SELECT COUNT(1) FROM likes WHERE user_id IN (
      SELECT id
      FROM users
        INNER JOIN profiles ON users.id = profiles.user_id
      WHERE gender = 'F'
    )
  ) as count_female;