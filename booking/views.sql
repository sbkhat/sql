CREATE OR REPLACE VIEW orders_view AS
  SELECT
    o.id AS id,
    o.date_from AS date_from,
    o.date_to AS date_to,
    get_price(o.date_to, o.date_from, h.id) AS cost,
    u2.id AS owner_id,
    up2.value as owner_phone,
    u1.id AS user_id,
    up1.value as user_phone
  FROM orders as o
    INNER JOIN users u1 ON o.user_id = u1.id
    INNER JOIN user_phones up1 ON u1.phone_id = up1.id
    INNER JOIN hotels h ON o.hotel_id = h.id
    INNER JOIN users u2 ON h.user_id = u2.id
    INNER JOIN user_phones up2 ON u2.phone_id = up2.id;


CREATE OR REPLACE VIEW user_profile_view AS
  SELECT
    u.firstname,
    u.lastname,
    u.id,
    upn.value as phone,
    uph.value as photo_src,
    g.name as gender_name,
    us.name as status,
    p.birthday as birthday
  FROM users as u
    INNER JOIN profiles p ON u.id = p.user_id
    INNER JOIN user_phones upn ON u.phone_id = upn.id
    INNER JOIN user_photos uph ON u.photo_id = uph.id
    INNER JOIN user_statuses us ON u.status_id = us.id
    INNER JOIN genders g ON p.gender_id = g.id
