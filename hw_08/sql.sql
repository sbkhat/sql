USE vk;
-- Задачи необходимо решить с использованием объединения таблиц (JOIN)
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT u2.id, u2.firstname, count(1) as message_count
FROM messages m
  INNER JOIN users u ON m.to_user_id = u.id
  INNER JOIN users u2 ON m.from_user_id = u2.id
WHERE u.id = 1 -- заданный пользователь
GROUP BY u2.id, u2.firstname
ORDER BY count(u2.id) DESC
LIMIT 1;


-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT count(1) as count_users
FROM likes l
  INNER JOIN users u ON u.id = l.user_id -- считаем тех, кому поставили like
  INNER JOIN profiles p ON p.user_id = u.id
WHERE (YEAR(CURRENT_DATE)-YEAR(p.birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(p.birthday,5)) < 10; -- младше 10 лет


-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT  IF(p.gender = 'M', 'male', 'female') as gender_name
FROM likes l
  INNER JOIN users u ON u.id = l.user_id
  INNER JOIN profiles p ON p.user_id = u.id
GROUP BY p.gender
ORDER BY count(1) DESC
LIMIT 1;