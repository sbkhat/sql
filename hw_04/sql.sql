-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT (firstname)
FROM vk.users
ORDER BY firstname ASC;


/* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
 Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1) */

ALTER TABLE  vk.profiles ADD is_active TINYINT(1) NOT NULL DEFAULT 1;

UPDATE vk.profiles
SET is_active = 0
WHERE ((YEAR(CURRENT_DATE) - YEAR(birthday))-(RIGHT(CURRENT_DATE, 5) < RIGHT(birthday, 5))) < 18;


-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

DELETE FROM vk.messages WHERE created_at > now();