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

-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей
SELECT COUNT(id) as sum
FROM likes
WHERE user_id IN (
  SELECT * FROM (
                  SELECT profiles.user_id FROM profiles ORDER BY birthday DESC LIMIT 10
                ) as p
);


-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT IF(
           (
             SELECT COUNT(1) FROM likes WHERE user_id IN (
               SELECT id FROM users WHERE gender = 'M'
             )
           ) > (
             SELECT COUNT(1) FROM likes WHERE user_id IN (
               SELECT id FROM users WHERE gender = 'F'
             )
           ),
           'male',
           'female'
       ) as gender;


-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- Поиск будет осуществляться по критериям количества лайков и количество постов и сообщений и количеству друзей
-- Один пост, сообщение, друг или лайк считаются за 1 бал.
SELECT
  (
    SELECT count(1)
    FROM likes as l
    WHERE l.user_id = u.id
  ) + (
    SELECT count(1)
    FROM messages as m
    WHERE m.from_user_id = u.id
  ) + (
    SELECT count(1)
    FROM posts as p
    WHERE p.user_id = u.id
  ) + (
    SELECT count(1)
    FROM friendship as f
    WHERE f.user_id = u.id
  ) as sum,
  first_name,
  last_name,
  id
FROM users as u
ORDER BY sum ASC
LIMIT 10;