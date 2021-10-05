CREATE INDEX users_status_id_index ON users (status_id);

CREATE INDEX profiles_status_id_index ON profiles (status_id);

CREATE INDEX orders_status_id_index ON orders (status_id);

CREATE INDEX hotels_status_id_index ON hotels (status_id);
CREATE INDEX hotels_user_id_index ON hotels (user_id);
CREATE INDEX hotels_type_id_index ON hotels (type_id);
CREATE INDEX hotels_user_id_status_id_index ON hotels (user_id, status_id);
CREATE INDEX hotels_user_id_status_id_type_id_index ON hotels (user_id, status_id, type_id);

CREATE INDEX comments_hotel_id_index ON comments (hotel_id);
CREATE INDEX comments_user_id_index ON comments (user_id);