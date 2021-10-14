-- Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)

DROP TABLE IF EXISTS vk.groups;
CREATE TABLE vk.groups (
  id SERIAL,
  name VARCHAR(50),
  description VARCHAR(255),
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW()
) COMMENT 'группы';

DROP TABLE IF EXISTS vk.user_groups;
CREATE TABLE vk.user_groups (
  id SERIAL,
  user_id BIGINT UNSIGNED NOT NULL,
  group_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW()
) COMMENT 'пользователи групп';

ALTER TABLE user_groups ADD CONSTRAINT fk_user_groups_user_id
FOREIGN KEY (user_id) REFERENCES vk.users(id);

ALTER TABLE user_groups ADD CONSTRAINT fk_user_groups_group_id
FOREIGN KEY (group_id) REFERENCES vk.groups(id);

CREATE INDEX user_groups_group_id ON vk.user_groups (group_id);
CREATE INDEX user_groups_user_id ON vk.user_groups (user_id);

DROP TABLE IF EXISTS vk.message_groups;
CREATE TABLE vk.message_groups (
  id SERIAL,
  user_id BIGINT UNSIGNED NOT NULL,
  group_id BIGINT UNSIGNED NOT NULL,
  comment VARCHAR(255),
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW()
) COMMENT 'сообщения пользователей в группах';

ALTER TABLE message_groups ADD CONSTRAINT fk_message_groups_user_id
FOREIGN KEY (user_id) REFERENCES vk.users(id);

ALTER TABLE message_groups ADD CONSTRAINT fk_message_groups_group_id
FOREIGN KEY (group_id) REFERENCES vk.groups(id);

CREATE INDEX user_groups_group_id ON vk.message_groups (group_id);
CREATE INDEX user_groups_user_id ON vk.message_groups (user_id);
