DROP TRIGGER IF EXISTS orders_log_insert_after_update;
CREATE TRIGGER orders_log_insert_after_update
AFTER UPDATE ON orders FOR EACH ROW
  BEGIN
    INSERT INTO logs (hotel_id, user_id, status_id) VALUE (NEW.hotel_id, NEW.user_id, NEW.status_id);
  END;
