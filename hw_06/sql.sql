-- Проанализировать запросы, которые выполнялись на занятии,
-- определить возможные корректировки и/или улучшения (JOIN пока не применять)


-- запросы выводит сообщества и число друзей и подписчиков в них для пользователя id = 1
WITH friends AS (
  SELECT
  CASE 1
    WHEN friend_id THEN user_id
    ELSE friend_id
  END AS friend_id
  FROM
    friendship
  WHERE
      request_type_id = 1
    AND confirmed_at IS NOT NULL
    AND (user_id = 1 OR friend_id = 1)
  UNION
  SELECT
    friend_id
  FROM
    friendship
  WHERE
    request_type_id = 2
    AND user_id = 1
    AND friend_id IN (
      SELECT
      user_id
      FROM
      friendship
      WHERE
      request_type_id = 2
      AND friend_id = 1
    )
)
SELECT
  (SELECT name FROM communities c WHERE c.id = cu.community_id) AS name, -- коррелированный подзапрос
  COUNT(1) user_count,
  community_id
FROM
  communities_users cu
WHERE cu.user_id IN (
  SELECT friend_id FROM friends
)
GROUP BY
  cu.community_id;

-- Мне не очень понятна эта часть запроса.
-- Здесь выводятся кто в друзьях у пользователя 1 и у кого в друзьях пользователь 1
-- Сама ситуация не понятка, как может быть кто-то у когото в друзьях, а другой человек
-- в друзьях его не иметь.
SELECT
  CASE 1
  WHEN friend_id THEN user_id
  ELSE friend_id
  END AS friend_id
FROM
  friendship
WHERE
  request_type_id = 1
  AND confirmed_at IS NOT NULL
  AND (user_id = 1 OR friend_id = 1);

-- Ситуация с подписчиками. В первом случаи мы выбирали пользователей,
-- которые были в друзьях или которые были в друзьях у 1, а здесь выбираем только подписанных на пользователя 1
-- необходимо тогда выбирать и тех, на кого подписан пользователь 1 и кто подписан на пользователя 1
SELECT
  friend_id
FROM
  friendship
WHERE
  request_type_id = 2
  AND user_id = 1
  AND friend_id IN (
    SELECT
      user_id
    FROM
      friendship
    WHERE
      request_type_id = 2
      AND friend_id = 1
  )


-- Полностью повторила все условия sql запроса
WITH user_ids AS (
  SELECT
    CASE 1
      WHEN friend_id THEN user_id
      ELSE friend_id
    END AS user_id
  FROM friendship
  WHERE
    confirmed_at IS NOT NULL
    AND (
          (
            request_type_id = 1 AND (user_id = 1 OR friend_id = 1)
          )
          OR
          (
            request_type_id = 2
              AND user_id = 1
              AND friend_id IN (
                SELECT user_id
                FROM friendship
                WHERE request_type_id = 2
                AND friend_id = 1
              )
          )
    )
)

SELECT
  c.id as community_id,
  c.name as community_name,
  (
    SELECT count(*)
    FROM communities_users cu
    WHERE cu.community_id = c.id
      AND user_id IN (select user_id from user_ids)
  ) as count_friends
FROM communities c
WHERE id IN (
  SELECT DISTINCT (community_id)
  FROM communities_users
  WHERE user_id IN (select user_id from user_ids)
);

-- При условии, что у нас нельзя быть кому-то другом без взаимого добавления в друзья,
-- но можно подписываться друг на друга не взамно, то запрос выглядит следующми образом
WITH user_ids AS (
  SELECT
    DISTINCT(
      CASE 1
        WHEN friend_id THEN user_id
        ELSE friend_id
      END
    ) AS user_id
  FROM friendship
  WHERE
    confirmed_at IS NOT NULL
    AND request_type_id IN (1, 2) AND (user_id = 1 OR friend_id = 1)
)

SELECT
  c.id as community_id,
  c.name as community_name,
  (
    SELECT count(*)
    FROM communities_users cu
    WHERE cu.community_id = c.id
          AND user_id IN (select user_id from user_ids)
  ) as count_friends
FROM communities c
WHERE id IN (
  SELECT DISTINCT (community_id)
  FROM communities_users
  WHERE user_id IN (select user_id from user_ids)
);


-- Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT from_user_id
FROM messages
WHERE  to_user_id = 1 AND from_user_id IN (
  SELECT
    friend_id
  FROM
    friendship
  WHERE
    request_type_id = 1
    AND confirmed_at IS NOT NULL
    AND user_id = 1
)
GROUP BY from_user_id
ORDER BY count(from_user_id) DESC
LIMIT 1;


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