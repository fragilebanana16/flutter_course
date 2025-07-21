-- query only
-- TESTING
-- CREATE TABLE users (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   name TEXT NOT NULL,
--   age INTEGER,
--   email TEXT UNIQUE
-- );
-- INSERT INTO users (name, age, email)
-- VALUES ('张三', 28, 'zhangsan@example.com');
-- SELECT * FROM users;
-- DROP TABLE users;
-- TESTING

 

-- DELETE FROM today_in_history;
-- SELECT * FROM today_in_history LIMIT 20;

SELECT *
FROM today_in_history
WHERE month = strftime('%m', 'now') * 1
  AND day = strftime('%d', 'now') * 1
ORDER BY year ASC;
