DROP FUNCTION IF EXISTS get_price;
CREATE FUNCTION  get_price (date_from DATETIME, date_to DATETIME, hotel_id BIGINT)
  RETURNS DECIMAL DETERMINISTIC
  BEGIN
    RETURN ((DATEDIFF(date_to, date_from)) + 1) * (SELECT cost FROM hotels WHERE id = hotel_id);
  END;

DROP FUNCTION IF EXISTS get_age;
CREATE FUNCTION  get_age (birthday DATETIME)
  RETURNS INTEGER DETERMINISTIC
  BEGIN
    RETURN (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5) < RIGHT(birthday,5));
  END;

DROP FUNCTION IF EXISTS get_age_text;
CREATE FUNCTION  get_age_text (birthday DATETIME)
  RETURNS VARCHAR(255) DETERMINISTIC
  BEGIN
    DECLARE age INT;
    SET age = get_age(birthday);
    RETURN CASE
           WHEN age <= 10 THEN 'возраст от 0 до 10'
           WHEN age <= 20 THEN 'возраст от 10 до 20'
           WHEN age <= 30 THEN 'возраст от 20 до 30'
           WHEN age <= 40 THEN 'возраст от 30 до 40'
           WHEN age <= 50 THEN 'возраст от 40 до 50'
           WHEN age > 50 THEN  'возраст старше 50'
           END;
  END;
