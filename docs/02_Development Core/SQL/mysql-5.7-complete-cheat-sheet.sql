-- ========================================================================
-- MySQL 5.7 COMPLETE CHEAT SHEET (Vietnamese + English Comments)
-- Author: AI Assistant
-- For: MySQL 5.7 Only | Compatible with Linux/Windows/Mac
-- Last Updated: 2024
-- ========================================================================

-- ======================================
-- CHAPTER 1: Getting started with MySQL
-- ======================================

-- Section 1.1: Getting Started
-- Kết nối đến MySQL: mysql -u root -p
SHOW DATABASES;                     -- Hiển thị tất cả cơ sở dữ liệu
USE information_schema;             -- Chọn DB hệ thống để khám phá cấu trúc
SELECT USER();                      -- Xem người dùng hiện tại
SELECT VERSION();                   -- Kiểm tra phiên bản MySQL (5.7.x)

-- Section 1.2: Information Schema Examples
-- Truy vấn thông tin bảng, cột, engine...
SELECT TABLE_NAME, ENGINE, TABLE_ROWS 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'your_database_name';  -- Thay tên DB thực tế

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'your_database_name' 
  AND TABLE_NAME = 'your_table_name';

-- ======================================
-- CHAPTER 2: Data Types
-- ======================================

-- Section 2.1: CHAR(n)
-- CHAR: độ dài cố định, bổ sung khoảng trắng nếu ngắn hơn
CREATE TABLE codes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code CHAR(4)  -- 'AB' sẽ lưu thành 'AB  ' (dài 4 ký tự)
);

INSERT INTO codes (code) VALUES ('AB'), ('XYZ');  -- Lưu ý: 'XYZ' bị cắt nếu CHAR(3) nhưng ở đây là CHAR(4)

-- Section 2.2: DATE, DATETIME, TIMESTAMP, YEAR, TIME
CREATE TABLE events (
    event_date      DATE,           -- Chỉ ngày: 2024-06-15
    event_time      TIME,           -- Chỉ giờ: 14:30:00
    event_datetime  DATETIME,       -- Ngày + giờ: 2024-06-15 14:30:00
    event_timestamp TIMESTAMP,      -- Tự động cập nhật khi row thay đổi (nếu có DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
    event_year      YEAR            -- Năm: 2024 (lưu 4 chữ số)
);

-- Gợi ý: Dùng TIMESTAMP để ghi nhận thời gian tạo/sửa tự động
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Section 2.3: VARCHAR(255) -- or not
-- ❌ Đừng dùng VARCHAR(255) bừa bãi! Hãy chọn độ dài hợp lý.
-- ✅ Ví dụ tốt:
-- name VARCHAR(50), email VARCHAR(100), phone VARCHAR(20)

-- Section 2.4: INT as AUTO_INCREMENT
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,  -- Tự tăng, không trùng lặp
    username VARCHAR(50) NOT NULL UNIQUE
);

-- Section 2.5: Others
-- Các kiểu khác thường dùng:
-- TINYINT (1 byte), SMALLINT (2 bytes), MEDIUMINT (3 bytes), BIGINT (8 bytes)
-- DECIMAL(p,s), FLOAT, DOUBLE, BLOB, TEXT, ENUM, SET

-- Section 2.6: Implicit / automatic casting
-- MySQL tự chuyển đổi kiểu dữ liệu trong nhiều trường hợp:
SELECT '123' + 1;          -- → 124 (chuyển chuỗi thành số)
SELECT 123 + 'abc';       -- → 123 (chỉ lấy phần đầu là số)
SELECT DATE('2024-06-15'); -- → 2024-06-15 (chuyển chuỗi thành DATE)

-- Section 2.7: Introduction (numeric)
-- Các loại số: Integer, Fixed-point, Floating-point, Bit

-- Section 2.8: Integer Types
-- TINYINT: -128 to 127 (hoặc 0-255 UNSIGNED)
-- SMALLINT: -32768 to 32767
-- MEDIUMINT: -8388608 to 8388607
-- INT: -2147483648 to 2147483647
-- BIGINT: -9e18 to 9e18

CREATE TABLE scores (
    small_score SMALLINT,
    big_score   BIGINT UNSIGNED  -- Không âm
);

-- Section 2.9: Fixed Point Types (DECIMAL)
-- Dùng cho tiền tệ — chính xác tuyệt đối
CREATE TABLE products (
    price DECIMAL(10,2)  -- Tổng 10 chữ số, 2 sau dấu phẩy → max 99999999.99
);

INSERT INTO products (price) VALUES (199.99); -- Chính xác, không lỗi làm tròn

-- Section 2.10: Floating Point Types
-- FLOAT / DOUBLE — nhanh nhưng có sai số do biểu diễn nhị phân
CREATE TABLE measurements (
    length FLOAT,         -- ~7 chữ số chính xác
    weight DOUBLE         -- ~15 chữ số chính xác
);

-- Section 2.11: Bit Value Type
-- Lưu giá trị nhị phân (tối đa 64 bit)
CREATE TABLE flags (
    id INT PRIMARY KEY,
    permissions BIT(8)    -- 8 bit: ví dụ 01010101
);

INSERT INTO flags VALUES (1, b'10101010');
SELECT BIN(permissions) FROM flags WHERE id = 1; -- Hiển thị dưới dạng nhị phân

-- ======================================
-- CHAPTER 3: SELECT
-- ======================================

-- Section 3.1: SELECT with DISTINCT
SELECT DISTINCT country FROM customers;  -- Loại bỏ dòng trùng lặp

-- Section 3.2: SELECT all columns (*)
SELECT * FROM orders;  -- Không nên dùng trong sản xuất (tốn bộ nhớ, chậm)

-- Section 3.3: SELECT by column name
SELECT name, email, created_at FROM users;

-- Section 3.4: SELECT with LIKE (%)
SELECT * FROM products WHERE name LIKE '%phone%';  -- Chứa "phone"
SELECT * FROM users WHERE username LIKE 'a%';      -- Bắt đầu bằng 'a'
SELECT * FROM users WHERE username LIKE '%z';      -- Kết thúc bằng 'z'

-- Section 3.5: SELECT with CASE or IF
SELECT 
    name,
    CASE 
        WHEN age < 18 THEN 'Minor'
        WHEN age BETWEEN 18 AND 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    IF(gender = 'M', 'Male', 'Female') AS gender_display
FROM users;

-- Section 3.6: SELECT with Alias (AS)
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    email AS contact_email
FROM users;

-- Section 3.7: SELECT with a LIMIT clause
SELECT * FROM orders LIMIT 10;          -- Lấy 10 bản ghi đầu tiên
SELECT * FROM orders LIMIT 5 OFFSET 10; -- Bỏ 10 bản đầu, lấy 5 bản tiếp theo

-- Section 3.8: SELECT with BETWEEN
SELECT * FROM orders 
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Section 3.9: SELECT with WHERE
SELECT * FROM users WHERE status = 'active' AND age > 25;

-- Section 3.10: SELECT with LIKE(_)
-- _ : khớp đúng 1 ký tự
SELECT * FROM users WHERE username LIKE 'A__';  -- Tên gồm 3 ký tự, bắt đầu bằng A

-- Section 3.11: SELECT with date range
-- Tốt nhất: dùng >= và < để tránh lỗi giờ phút giây
SELECT * FROM logs 
WHERE created_at >= '2024-06-01' 
  AND created_at < '2024-07-01';

-- ======================================
-- CHAPTER 4: Backticks
-- ======================================

-- Section 4.1: Backticks usage
-- Dùng backtick (`) khi tên cột/tên bảng trùng từ khóa MySQL
CREATE TABLE `order` (               -- "order" là từ khóa reserved
    `select` VARCHAR(50),            -- "select" cũng là từ khóa
    `group` INT,
    `from` DATE
);

-- Tốt nhất: Tránh dùng từ khóa làm tên cột/bảng!
-- Nhưng nếu đã có, hãy luôn dùng backticks khi truy vấn:
SELECT `select`, `from` FROM `order` WHERE `group` > 10;

-- ======================================
-- CHAPTER 5: NULL
-- ======================================

-- Section 5.1: Uses for NULL
-- NULL = chưa biết, chưa có, không áp dụng — KHÔNG phải rỗng ('') hay 0

-- Section 5.2: Testing NULLs
-- ❌ Sai: WHERE column = NULL
-- ✅ Đúng: WHERE column IS NULL
-- ✅ Đúng: WHERE column IS NOT NULL

SELECT * FROM users WHERE email IS NULL;
SELECT * FROM users WHERE email IS NOT NULL;

-- Hàm xử lý NULL: IFNULL(), COALESCE()
SELECT name, IFNULL(email, 'No email provided') AS email FROM users;
SELECT name, COALESCE(phone, email, 'No contact') AS contact FROM users;

-- ======================================
-- CHAPTER 6: Limit and Offset
-- ======================================

-- Section 6.1: Limit and Offset relationship
-- Pagination: Page 1: LIMIT 10 OFFSET 0 → rows 1-10
-- Page 2: LIMIT 10 OFFSET 10 → rows 11-20
-- Page N: LIMIT 10 OFFSET (N-1)*10

-- ⚠️ CẢNH BÁO: OFFSET rất chậm với dữ liệu lớn → dùng cursor-based pagination nếu cần hiệu năng cao

-- ======================================
-- CHAPTER 7: Creating databases
-- ======================================

-- Section 7.1: Create database, users, and grants
CREATE DATABASE IF NOT EXISTS myapp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Tạo user và cấp quyền
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'StrongPass123!';
GRANT ALL PRIVILEGES ON myapp.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;

-- Section 7.2: Creating and Selecting a Database
CREATE DATABASE mydb;
USE mydb;

-- Section 7.3: MyDatabase
-- (Không có lệnh cụ thể — chỉ là ví dụ tên DB)

-- Section 7.4: System Databases
-- information_schema — metadata của hệ thống
-- mysql — lưu user, privilege, password
-- performance_schema — hiệu năng
-- sys — view tổng hợp hiệu năng (MySQL 5.7+)

-- ======================================
-- CHAPTER 8: Using Variables
-- ======================================

-- Section 8.1: Setting Variables
SET @user_count = (SELECT COUNT(*) FROM users);
SELECT @user_count;

-- Biến cục bộ trong stored procedure
DELIMITER $$
CREATE PROCEDURE GetCount()
BEGIN
    DECLARE total INT DEFAULT 0;
    SELECT COUNT(*) INTO total FROM users;
    SELECT total AS user_count;
END$$
DELIMITER ;

-- Section 8.2: Row Number and Group By using variables in Select Statement
-- Tạo row number (MySQL 5.7 không có ROW_NUMBER() window function!)
SET @row_number = 0;
SELECT 
    (@row_number := @row_number + 1) AS row_num,
    name, email
FROM users
ORDER BY name;

-- Nhóm theo và đếm thứ tự trong nhóm
SET @rank = 0, @prev_dept = '';
SELECT 
    dept,
    name,
    salary,
    @rank := IF(@prev_dept = dept, @rank + 1, 1) AS rank_in_dept,
    @prev_dept := dept
FROM employees
ORDER BY dept, salary DESC;

-- ======================================
-- CHAPTER 9: Comment MySQL
-- ======================================

-- Section 9.1: Adding comments
-- Đây là comment một dòng (--) — phổ biến nhất

/* 
Đây là comment nhiều dòng
Có thể dùng để ghi chú khối lệnh dài
*/

-- Section 9.2: Commenting table definitions
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Khóa chính tự tăng',
    name VARCHAR(100) NOT NULL COMMENT 'Tên sản phẩm',
    price DECIMAL(10,2) COMMENT 'Giá bán (đơn vị VNĐ)'
) COMMENT='Bảng lưu trữ sản phẩm của cửa hàng';

-- ======================================
-- CHAPTER 10: INSERT
-- ======================================

-- Section 10.1: INSERT, ON DUPLICATE KEY UPDATE
INSERT INTO users (id, name, email, updated_at) 
VALUES (1, 'John', 'john@example.com', NOW())
ON DUPLICATE KEY UPDATE 
    name = VALUES(name),
    email = VALUES(email),
    updated_at = NOW();

-- Section 10.2: Inserting multiple rows
INSERT INTO users (name, email) VALUES
    ('Alice', 'alice@example.com'),
    ('Bob', 'bob@example.com'),
    ('Charlie', 'charlie@example.com');

-- Section 10.3: Basic Insert
INSERT INTO users (name, email) VALUES ('David', 'david@example.com');

-- Section 10.4: INSERT with AUTO_INCREMENT + LAST_INSERT_ID()
INSERT INTO users (name, email) VALUES ('Eve', 'eve@example.com');
SELECT LAST_INSERT_ID();  -- Trả về ID vừa chèn — rất hữu ích khi insert rồi dùng lại ngay

-- Section 10.5: INSERT SELECT (Inserting data from another Table)
INSERT INTO archived_users (name, email, created_at)
SELECT name, email, created_at FROM users WHERE status = 'inactive';

-- Section 10.6: Lost AUTO_INCREMENT ids
-- Khi DELETE hoặc TRUNCATE, auto_increment không tự reset
-- Muốn reset: ALTER TABLE users AUTO_INCREMENT = 1;

-- ======================================
-- CHAPTER 11: DELETE
-- ======================================

-- Section 11.1: Multi-Table Deletes
DELETE u, o FROM users u
JOIN orders o ON u.id = o.user_id
WHERE u.status = 'deleted';

-- Section 11.2: DELETE vs TRUNCATE
-- DELETE: xóa từng dòng, có thể rollback, kích hoạt trigger, chậm
-- TRUNCATE: xóa toàn bộ bảng, không rollback, không trigger, nhanh, reset AUTO_INCREMENT
TRUNCATE TABLE temp_logs;

-- Section 11.3: Multi-table DELETE (cùng với JOIN)
-- Xem Section 11.1

-- Section 11.4: Basic delete
DELETE FROM users WHERE id = 1;

-- Section 11.5: Delete with Where clause
DELETE FROM logs WHERE created_at < '2023-01-01';

-- Section 11.6: Delete all rows from a table
DELETE FROM users;  -- Không reset AUTO_INCREMENT
-- Hoặc: TRUNCATE TABLE users;  -- Reset AUTO_INCREMENT

-- Section 11.7: LIMITing deletes
DELETE FROM logs WHERE expired = 1 ORDER BY created_at LIMIT 1000;  -- Xóa 1000 bản ghi cũ nhất

-- ======================================
-- CHAPTER 12: UPDATE
-- ======================================

-- Section 12.1: Update with Join Pattern
UPDATE users u
JOIN orders o ON u.id = o.user_id
SET u.last_order_date = o.order_date
WHERE o.status = 'completed';

-- Section 12.2: Basic Update
UPDATE users SET email = 'new@email.com' WHERE id = 1;

-- Section 12.3: Bulk UPDATE
UPDATE products SET price = price * 1.1 WHERE category = 'electronics';  -- Tăng 10%

-- Section 12.4: UPDATE with ORDER BY and LIMIT
UPDATE logs SET processed = 1 WHERE processed = 0 ORDER BY created_at LIMIT 100;

-- Section 12.5: Multiple Table UPDATE
UPDATE table1 t1, table2 t2 
SET t1.name = t2.name 
WHERE t1.id = t2.id;

-- ======================================
-- CHAPTER 13: ORDER BY
-- ======================================

-- Section 13.1: Contexts
-- Có thể dùng trong: SELECT, UPDATE, DELETE, CREATE TABLE... (khi có ORDER BY)

-- Section 13.2: Basic
SELECT * FROM users ORDER BY name;

-- Section 13.3: ASCending / DESCending
SELECT * FROM users ORDER BY created_at DESC;  -- Mới nhất trước
SELECT * FROM users ORDER BY age ASC, name DESC;  -- Sắp xếp nhiều cột

-- Section 13.4: Some tricks
-- Sắp xếp theo điều kiện
SELECT * FROM users 
ORDER BY 
    CASE WHEN status = 'admin' THEN 0
         WHEN status = 'premium' THEN 1
         ELSE 2
    END,
    name;

-- Sắp xếp theo độ dài chuỗi
SELECT name FROM users ORDER BY CHAR_LENGTH(name);

-- ======================================
-- CHAPTER 14: Group By
-- ======================================

-- Section 14.1: GROUP BY using HAVING
SELECT department, COUNT(*) AS emp_count
FROM employees
GROUP BY department
HAVING emp_count > 5;  -- Lọc nhóm — khác WHERE (lọc trước khi group)

-- Section 14.2: Group By using Group Concat
SELECT department, GROUP_CONCAT(name SEPARATOR ', ') AS staff_list
FROM employees
GROUP BY department;

-- Section 14.3: Group By Using MIN function
SELECT department, MIN(salary) AS min_salary
FROM employees
GROUP BY department;

-- Section 14.4: GROUP BY with AGGREGATE functions
SELECT 
    department,
    COUNT(*) AS total,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- ======================================
-- CHAPTER 15: Error 1055: ONLY_FULL_GROUP_BY
-- ======================================

-- Section 15.1: Misusing GROUP BY to return unpredictable results: Murphy's Law
-- ❌ Sai: SELECT name, department FROM employees GROUP BY department;
-- → name không nằm trong GROUP BY → kết quả không xác định!

-- Section 15.2: Misusing GROUP BY with SELECT *, and how to fix it
-- ❌ SELECT * FROM employees GROUP BY department;  -- LỖI nếu ONLY_FULL_GROUP_BY bật
-- ✅ Sửa: SELECT department, MAX(name), MIN(salary) ... GROUP BY department;

-- Section 15.3: ANY_VALUE()
-- Nếu bạn chắc chắn muốn chọn 1 giá trị bất kỳ từ nhóm:
SELECT department, ANY_VALUE(name) AS any_employee_name
FROM employees
GROUP BY department;

-- Section 15.4: Using and misusing GROUP BY
-- Luôn đảm bảo: mọi cột trong SELECT không thuộc hàm aggregate phải có trong GROUP BY
-- Hoặc dùng ANY_VALUE()

-- ======================================
-- CHAPTER 16: Joins
-- ======================================

-- Section 16.1: Joins visualized
-- [Hình ảnh minh họa JOIN: INNER, LEFT, RIGHT, FULL OUTER — không có trong SQL, chỉ hình]

-- Section 16.2: JOIN with subquery ("Derived" table)
SELECT u.name, o.total
FROM users u
JOIN (
    SELECT user_id, SUM(amount) AS total
    FROM orders
    GROUP BY user_id
    HAVING total > 1000
) o ON u.id = o.user_id;

-- Section 16.3: Full Outer Join (MySQL không hỗ trợ trực tiếp — dùng UNION)
SELECT u.name, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
UNION
SELECT u.name, o.amount
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id
WHERE u.id IS NULL;

-- Section 16.4: Retrieve customers with orders -- variations on a theme
-- INNER JOIN: khách hàng có đơn
SELECT DISTINCT c.name FROM customers c INNER JOIN orders o ON c.id = o.customer_id;

-- LEFT JOIN: tất cả khách hàng, kể cả không có đơn
SELECT c.name, o.order_date FROM customers c LEFT JOIN orders o ON c.id = o.customer_id;

-- Section 16.5: Joining Examples
-- Giả sử có 2 bảng: authors, books
SELECT a.name AS author, b.title
FROM authors a
JOIN books b ON a.id = b.author_id
WHERE b.published = 1;

-- ======================================
-- CHAPTER 17: JOINS: Join 3 table with the same name of id.
-- ======================================

-- Section 17.1: Join 3 tables on a column with the same name
-- Giả sử: users, profiles, settings — đều có user_id
SELECT u.name, p.bio, s.theme
FROM users u
JOIN profiles p ON u.id = p.user_id
JOIN settings s ON u.id = s.user_id;

-- ======================================
-- CHAPTER 18: UNION
-- ======================================

-- Section 18.1: Combining SELECT statements with UNION
SELECT name FROM customers
UNION
SELECT name FROM suppliers;

-- Section 18.2: Combining data with different columns
SELECT name, email, 'customer' AS type FROM customers
UNION
SELECT name, phone, 'supplier' AS type FROM suppliers;

-- Section 18.3: ORDER BY
(SELECT name FROM customers)
UNION
(SELECT name FROM suppliers)
ORDER BY name;

-- Section 18.4: Pagination via OFFSET
(SELECT name FROM customers ORDER BY name LIMIT 10 OFFSET 0)
UNION
(SELECT name FROM suppliers ORDER BY name LIMIT 10 OFFSET 0)
ORDER BY name LIMIT 10 OFFSET 10;

-- Section 18.5: Combining and merging data on different MySQL tables with the same columns into unique rows and running query
SELECT id, name, email FROM table_a
UNION
SELECT id, name, email FROM table_b
ORDER BY name;

-- Section 18.6: UNION ALL and UNION
-- UNION: loại bỏ trùng lặp → chậm hơn
-- UNION ALL: giữ nguyên tất cả → nhanh hơn
SELECT col FROM t1
UNION ALL
SELECT col FROM t2;

-- ======================================
-- CHAPTER 19: Arithmetic
-- ======================================

-- Section 19.1: Arithmetic Operators
SELECT 10 + 5, 10 - 5, 10 * 5, 10 / 5, 10 % 3;  -- + - * / %

-- Section 19.2: Mathematical Constants
SELECT PI(), E();  -- π ≈ 3.141592653589793, e ≈ 2.718281828459045

-- Section 19.3: Trigonometry (SIN, COS)
SELECT SIN(RADIANS(90)), COS(RADIANS(0));  -- sin(90°)=1, cos(0°)=1

-- Section 19.4: Rounding (ROUND, FLOOR, CEIL)
SELECT ROUND(3.14159, 2), FLOOR(3.9), CEIL(3.1);  -- 3.14, 3, 4

-- Section 19.5: Raise a number to a power (POW)
SELECT POW(2, 10);  -- 1024

-- Section 19.6: Square Root (SQRT)
SELECT SQRT(144);  -- 12

-- Section 19.7: Random Numbers (RAND)
SELECT RAND();                -- Số thực ngẫu nhiên 0-1
SELECT FLOOR(RAND() * 100);   -- Số nguyên ngẫu nhiên 0-99

-- Section 19.8: Absolute Value and Sign (ABS, SIGN)
SELECT ABS(-10), SIGN(-5), SIGN(0), SIGN(7);  -- 10, -1, 0, 1

-- ======================================
-- CHAPTER 20: String operations
-- ======================================

-- Section 20.1: LENGTH()
SELECT LENGTH('Hello');  -- 5 (byte count — quan trọng với UTF8)

-- Section 20.2: CHAR_LENGTH()
SELECT CHAR_LENGTH('Hello');  -- 5 (ký tự — phù hợp Unicode)

-- Section 20.3: HEX(str)
SELECT HEX('ABC');  -- '414243'

-- Section 20.4: SUBSTRING()
SELECT SUBSTRING('MySQL is great', 7, 2);  -- 'is'

-- Section 20.5: UPPER() / UCASE()
SELECT UPPER('hello');  -- 'HELLO'

-- Section 20.6: STR_TO_DATE - Convert string to date
SELECT STR_TO_DATE('15/06/2024', '%d/%m/%Y');  -- 2024-06-15

-- Section 20.7: LOWER() / LCASE()
SELECT LOWER('WORLD');  -- 'world'

-- Section 20.8: REPLACE()
SELECT REPLACE('Hello World', 'World', 'MySQL');  -- 'Hello MySQL'

-- Section 20.9: Find element in comma separated list
SELECT FIND_IN_SET('apple', 'banana,apple,orange');  -- trả về 2 (vị trí)

-- ======================================
-- CHAPTER 21: Date and Time Operations
-- ======================================

-- Section 21.1: Date arithmetic
SELECT DATE_ADD('2024-06-15', INTERVAL 7 DAY);     -- 2024-06-22
SELECT DATE_SUB('2024-06-15', INTERVAL 1 MONTH);   -- 2024-05-15
SELECT '2024-06-15' + INTERVAL 1 WEEK;             -- 2024-06-22

-- Section 21.2: SYSDATE(), NOW(), CURDATE()
SELECT NOW(), SYSDATE(), CURDATE();  -- NOW() = thời điểm bắt đầu câu lệnh, SYSDATE() = thời điểm thực thi

-- Section 21.3: Testing against a date range
SELECT * FROM orders WHERE order_date >= '2024-01-01' AND order_date < '2025-01-01';

-- Section 21.4: Extract Date from Given Date or DateTime Expression
SELECT EXTRACT(YEAR FROM '2024-06-15 14:30:00');  -- 2024
SELECT EXTRACT(MONTH FROM '2024-06-15');          -- 6

-- Section 21.5: Using an index for a date and time lookup
-- TỐT: WHERE created_at >= '2024-01-01'
-- XẤU: WHERE YEAR(created_at) = 2024 → không dùng được index!

-- Section 21.6: Now()
-- Xem Section 21.2

-- ======================================
-- CHAPTER 22: Handling Time Zones
-- ======================================

-- Section 22.1: Retrieve the current date and time in a particular time zone
SELECT CONVERT_TZ(NOW(), '+00:00', '+07:00');  -- UTC → Asia/Ho_Chi_Minh

-- Section 22.2: Convert a stored `DATE` or `DATETIME` value to another time zone
SELECT CONVERT_TZ(event_time, '+00:00', '-05:00') AS est_time FROM logs;

-- Section 22.3: Retrieve stored `TIMESTAMP` values in a particular time zone
-- TIMESTAMP tự động chuyển theo time_zone session
SET time_zone = '+07:00';
SELECT timestamp_col FROM logs;

-- Section 22.4: What is my server's local time zone setting?
SELECT @@global.time_zone, @@session.time_zone;

-- Section 22.5: What time_zone values are available in my server?
SELECT * FROM mysql.time_zone_name;  -- Cần load timezone data vào MySQL trước (mysql_tzinfo_to_sql)

-- ======================================
-- CHAPTER 23: Regular Expressions
-- ======================================

-- Section 23.1: REGEXP / RLIKE
SELECT name FROM users WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

-- Tìm tên chứa số
SELECT name FROM users WHERE name REGEXP '[0-9]';

-- ======================================
-- CHAPTER 24: VIEW
-- ======================================

-- Section 24.1: Create a View
CREATE VIEW active_users AS
SELECT id, name, email, created_at FROM users WHERE status = 'active';

-- Section 24.2: A view from two tables
CREATE VIEW user_orders AS
SELECT u.name, o.amount, o.order_date
FROM users u
JOIN orders o ON u.id = o.user_id;

-- Section 24.3: DROPPING A VIEW
DROP VIEW IF EXISTS active_users;

-- Section 24.4: Updating a table via a VIEW
-- Một số view có thể update nếu đơn giản (không dùng GROUP BY, JOIN, DISTINCT...)
UPDATE active_users SET email = 'new@example.com' WHERE id = 1;

-- ======================================
-- CHAPTER 25: Table Creation
-- ======================================

-- Section 25.1: Table creation with Primary Key
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Section 25.2: Basic table creation
CREATE TABLE products (
    id INT AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2),
    PRIMARY KEY (id)
);

-- Section 25.3: Table creation with Foreign Key
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Section 25.4: Show Table Structure
DESCRIBE users;  -- Hoặc: SHOW CREATE TABLE users;

-- Section 25.5: Cloning an existing table
CREATE TABLE users_backup LIKE users;
INSERT INTO users_backup SELECT * FROM users;

-- Section 25.6: Table Create With TimeStamp Column To Show Last Update
CREATE TABLE articles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Section 25.7: CREATE TABLE FROM SELECT
CREATE TABLE high_value_customers AS
SELECT * FROM customers WHERE total_spent > 10000;

-- ======================================
-- CHAPTER 26: ALTER TABLE
-- ======================================

-- Section 26.1: Changing storage engine; rebuild table; change file_per_table
ALTER TABLE users ENGINE = InnoDB;
-- Để dùng file_per_table: innodb_file_per_table=1 trong my.cnf

-- Section 26.2: ALTER COLUMN OF TABLE
ALTER TABLE users MODIFY COLUMN email VARCHAR(150);

-- Section 26.3: Change auto-increment value
ALTER TABLE users AUTO_INCREMENT = 1000;

-- Section 26.4: Renaming a MySQL table
RENAME TABLE old_name TO new_name;

-- Section 26.5: ALTER table add INDEX
ALTER TABLE users ADD INDEX idx_email (email);

-- Section 26.6: Changing the type of a primary key column
-- Cẩn thận: cần drop FK trước nếu có ràng buộc
ALTER TABLE users MODIFY id BIGINT AUTO_INCREMENT;

-- Section 26.7: Change column definition
ALTER TABLE users CHANGE COLUMN old_name new_name VARCHAR(100);

-- Section 26.8: Renaming a MySQL database
-- ❌ Không có lệnh trực tiếp! Phải dump & restore
-- Hướng dẫn: mysqldump db_old > dump.sql; mysql db_new < dump.sql

-- Section 26.9: Swapping the names of two MySQL databases
-- Không hỗ trợ trực tiếp. Làm thủ công:
-- 1. Dump cả 2 DB
-- 2. Restore vào tên mới

-- Section 26.10: Renaming a column in a MySQL table
ALTER TABLE users CHANGE COLUMN old_email email VARCHAR(100);

-- ======================================
-- CHAPTER 27: Drop Table
-- ======================================

-- Section 27.1: Drop Table
DROP TABLE IF EXISTS temp_table;

-- Section 27.2: Drop tables from database
DROP TABLE table1, table2, table3;

-- ======================================
-- CHAPTER 28: MySQL LOCK TABLE
-- ======================================

-- Section 28.1: Row Level Locking
-- InnoDB tự động lock hàng khi UPDATE/DELETE — không cần dùng LOCK TABLE
-- Chỉ dùng LOCK TABLE khi cần kiểm soát thủ công (thường dùng với MyISAM)

-- Section 28.2: Mysql Locks
LOCK TABLES users WRITE;
-- Thực hiện thao tác
UNLOCK TABLES;

-- ======================================
-- CHAPTER 29: Error codes
-- ======================================

-- Section 29.1: Error code 1064: Syntax error
-- Thường do dùng từ khóa MySQL làm tên cột mà không dùng backtick

-- Section 29.2: Error code 1175: Safe Update
-- Do không có WHERE dùng khóa chính hoặc không có LIMIT
-- Giải pháp: SET SQL_SAFE_UPDATES = 0; (rồi đặt lại sau)

-- Section 29.3: Error code 1215: Cannot add foreign key constraint
-- Nguyên nhân:
-- - Kiểu dữ liệu không khớp (INT vs BIGINT)
-- - Không có index trên cột tham chiếu
-- - Bảng cha chưa tồn tại
-- - Storage engine khác nhau (MyISAM vs InnoDB)

-- Section 29.4: 1067, 1292, 1366, 1411 - Bad Value for number, date, default, etc
-- 1067: Invalid default value for datetime
-- 1292: Incorrect datetime value
-- 1366: Incorrect integer value
-- 1411: Incorrect time value
-- → Kiểm tra format dữ liệu nhập vào (ví dụ: '2024-13-45' là sai)

-- Section 29.5: 1045 Access denied
-- Sai user/password, host không được phép kết nối, hoặc user chưa được grant

-- Section 29.6: 1236 "impossible position" in Replication
-- Slave bị mất binlog — cần re-sync từ master

-- Section 29.7: 2002, 2003 Cannot connect
-- MySQL server không chạy, socket không tồn tại, firewall chặn

-- Section 29.8: 126, 127, 134, 144, 145
-- 126: Index file corrupted
-- 127: Table is crashed
-- 134: Record has been changed
-- 144: Table is crashed
-- 145: Table is marked as crashed

-- Section 29.9: 139
-- Không phải lỗi MySQL chuẩn — có thể do ứng dụng

-- Section 29.10: 1366
-- Giá trị không hợp lệ cho cột (ví dụ: chèn 'abc' vào INT)

-- Section 29.11: 126, 1054, 1146, 1062, 24
-- 1054: Unknown column
-- 1146: Table doesn't exist
-- 1062: Duplicate entry
-- 24: Too many open files (system limit)

-- ======================================
-- CHAPTER 30: Stored routines (procedures and functions)
-- ======================================

-- Section 30.1: Stored procedure with IN, OUT, INOUT parameters
DELIMITER $$
CREATE PROCEDURE GetUserCount(
    IN dept_name VARCHAR(50),
    OUT total_count INT
)
BEGIN
    SELECT COUNT(*) INTO total_count FROM employees WHERE department = dept_name;
END$$
DELIMITER ;

CALL GetUserCount('IT', @count);
SELECT @count;

-- Section 30.2: Create a Function
DELIMITER $$
CREATE FUNCTION GetAge(birthdate DATE)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
END$$
DELIMITER ;

SELECT name, GetAge(birth_date) AS age FROM users;

-- Section 30.3: Cursors
DELIMITER $$
CREATE PROCEDURE ProcessUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE u_id INT;
    DECLARE cur CURSOR FOR SELECT id FROM users WHERE status = 'pending';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO u_id;
        IF done THEN LEAVE read_loop; END IF;
        UPDATE users SET status = 'processed' WHERE id = u_id;
    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;

-- Section 30.4: Multiple ResultSets
-- Trong procedure: chỉ cần có nhiều SELECT → client sẽ nhận nhiều result set

-- Section 30.5: Create a function (lặp lại Section 30.2 — chỉ để nhấn mạnh)

-- ======================================
-- CHAPTER 31: Indexes and Keys
-- ======================================

-- Section 31.1: Create index
CREATE INDEX idx_name ON users(name);

-- Section 31.2: Create unique index
CREATE UNIQUE INDEX idx_email ON users(email);

-- Section 31.3: AUTO_INCREMENT key
-- Tự động tạo index duy nhất khi khai báo PRIMARY KEY hoặc UNIQUE

-- Section 31.4: Create composite index
CREATE INDEX idx_status_created ON users(status, created_at);

-- Section 31.5: Drop index
DROP INDEX idx_name ON users;

-- ======================================
-- CHAPTER 32: Full-Text search
-- ======================================

-- Section 32.1: Simple FULLTEXT search
-- Tạo FULLTEXT index trước
ALTER TABLE articles ADD FULLTEXT(title, content);

SELECT * FROM articles WHERE MATCH(title, content) AGAINST('database optimization');

-- Section 32.2: Simple BOOLEAN search
SELECT * FROM articles WHERE MATCH(title, content) AGAINST('+database -mysql' IN BOOLEAN MODE);

-- Section 32.3: Multi-column FULLTEXT search
-- Xem Section 32.1

-- ======================================
-- CHAPTER 33: PREPARE Statements
-- ======================================

-- Section 33.1: PREPARE, EXECUTE and DEALLOCATE PREPARE Statements
SET @table_name = 'users';
SET @sql = CONCAT('SELECT COUNT(*) FROM ', @table_name);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Section 33.2: Alter table with add column
-- Không dùng PREPARE cho ALTER TABLE nếu không cần động — dùng trực tiếp

-- ======================================
-- CHAPTER 34: JSON
-- ======================================

-- Section 34.1: Create simple table with a primary key and JSON field
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    specs JSON
);

-- Section 34.2: Insert a simple JSON
INSERT INTO products (specs) VALUES ('{"color": "red", "weight": "2kg"}');

-- Section 34.3: Updating a JSON field
UPDATE products SET specs = JSON_SET(specs, '$.color', 'blue') WHERE id = 1;

-- Section 34.4: Insert mixed data into a JSON field
INSERT INTO products (specs) VALUES (
    '{"tags": ["sale", "new"], "price": 199.99, "in_stock": true}'
);

-- Section 34.5: CAST data to JSON type
SELECT CAST('{"key":"value"}' AS JSON) AS json_data;

-- Section 34.6: Create Json Object and Array
SELECT JSON_OBJECT('name', 'John', 'age', 30) AS person;
SELECT JSON_ARRAY('apple', 'banana', 'orange') AS fruits;

-- ======================================
-- CHAPTER 35: Extract values from JSON type
-- ======================================

-- Section 35.1: Read JSON Array value
SELECT JSON_EXTRACT(specs, '$.tags[0]') AS first_tag FROM products;

-- Section 35.2: JSON Extract Operators
-- Dùng ->> để rút gọn: JSON_UNQUOTE(JSON_EXTRACT(...))
SELECT specs->>'$.color' AS color FROM products;  -- Trả về 'blue' (không có dấu ngoặc kép)

-- ======================================
-- CHAPTER 36: MySQL Admin
-- ======================================

-- Section 36.1: Atomic RENAME & Table Reload
RENAME TABLE old_table TO temp_table, new_table TO old_table, temp_table TO new_table;

-- Section 36.2: Change root password
-- Trong MySQL 5.7:
ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewStrongPass123!';

-- Section 36.3: Drop database
DROP DATABASE IF EXISTS test_db;

-- ======================================
-- CHAPTER 37: TRIGGERS
-- ======================================

-- Section 37.1: Basic Trigger
DELIMITER $$
CREATE TRIGGER before_user_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
END$$
DELIMITER ;

-- Section 37.2: Types of triggers
-- BEFORE INSERT / UPDATE / DELETE
-- AFTER INSERT / UPDATE / DELETE
-- Mỗi bảng có tối đa 6 trigger (3 sự kiện × 2 thời điểm)

-- ======================================
-- CHAPTER 38: Configuration and tuning
-- ======================================

-- Section 38.1: InnoDB performance
-- Tối ưu hóa trong my.cnf:
-- innodb_buffer_pool_size = 70% RAM
-- innodb_log_file_size = 256M
-- innodb_flush_log_at_trx_commit = 2 (cho dev), 1 (cho prod)

-- Section 38.2: Parameter to allow huge data to insert
-- max_allowed_packet = 512M

-- Section 38.3: Increase the string limit for group_concat
SET GLOBAL group_concat_max_len = 1000000;

-- Section 38.4: Minimal InnoDB configuration
[mysqld]
innodb_buffer_pool_size = 128M
innodb_log_file_size = 48M
innodb_flush_method = O_DIRECT

-- Section 38.5: Secure MySQL encryption
-- Sử dụng SSL khi kết nối: require_secure_transport = ON
-- Cấu hình SSL certs trong my.cnf:
ssl-ca=/etc/mysql/certs/ca-cert.pem
ssl-cert=/etc/mysql/certs/server-cert.pem
ssl-key=/etc/mysql/certs/server-key.pem

-- ======================================
-- CHAPTER 39: Events
-- ======================================

-- Section 39.1: Create an Event
-- Bật scheduler trước: SET GLOBAL event_scheduler = ON;
DELIMITER $$
CREATE EVENT cleanup_old_logs
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
  DELETE FROM logs WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
END$$
DELIMITER ;

-- ======================================
-- CHAPTER 40: ENUM
-- ======================================

-- Section 40.1: Why ENUM?
-- Tiết kiệm không gian, đảm bảo dữ liệu hợp lệ
CREATE TABLE status (
    id INT,
    state ENUM('active', 'inactive', 'pending')
);

-- Section 40.2: VARCHAR as an alternative
-- ENUM khó mở rộng — nếu thêm giá trị mới: ALTER TABLE ... MODIFY COLUMN state ENUM('a','b','c','new')

-- Section 40.3: Adding a new option
ALTER TABLE status MODIFY COLUMN state ENUM('active', 'inactive', 'pending', 'archived');

-- Section 40.4: NULL vs NOT NULL
-- ENUM mặc định là NOT NULL — nếu muốn NULL: ENUM('a','b') NULL

-- ======================================
-- CHAPTER 41: Install Mysql container with Docker-Compose
-- ======================================

-- Section 41.1: Simple example with docker-compose
# docker-compose.yml
version: '3.8'
services:
  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: myapp
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:

-- ======================================
-- CHAPTER 42: Character Sets and Collations
-- ======================================

-- Section 42.1: Which CHARACTER SET and COLLATION?
-- Dùng utf8mb4 và utf8mb4_unicode_ci cho Unicode đầy đủ (bao gồm emoji)

-- Section 42.2: Setting character sets on tables and fields
CREATE TABLE users (
    name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

-- Section 42.3: Declaration
-- Tại mức server, database, table, column — có thể override

-- Section 42.4: Connection
SET NAMES utf8mb4;  -- Thiết lập charset cho kết nối client

-- ======================================
-- CHAPTER 43: MyISAM Engine
-- ======================================

-- Section 43.1: ENGINE=MyISAM
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT
) ENGINE=MyISAM;

-- ❌ Không hỗ trợ transaction, không hỗ trợ foreign key
-- ✅ Nhanh hơn cho read-heavy, không cần tính toàn vẹn

-- ======================================
-- CHAPTER 44: Converting from MyISAM to InnoDB
-- ======================================

-- Section 44.1: Basic conversion
ALTER TABLE mytable ENGINE = InnoDB;

-- Section 44.2: Converting All Tables in one Database
-- Dùng script bash:
# mysql -e "SELECT CONCAT('ALTER TABLE ', table_name, ' ENGINE=InnoDB;') FROM information_schema.tables WHERE table_schema = 'mydb' AND engine = 'MyISAM';" | mysql mydb

-- ======================================
-- CHAPTER 45: Transaction
-- ======================================

-- Section 45.1: Start Transaction
START TRANSACTION;

-- Section 45.2: COMMIT , ROLLBACK and AUTOCOMMIT
COMMIT;        -- Lưu thay đổi
ROLLBACK;      -- Hủy thay đổi

-- Kiểm tra chế độ autocommit:
SELECT @@autocommit;  -- 1 = bật, 0 = tắt

-- Tắt autocommit:
SET autocommit = 0;

-- Section 45.3: Transaction using JDBC Driver (Java)
-- Java code mẫu:
/*
Connection conn = DriverManager.getConnection(url, user, pass);
conn.setAutoCommit(false);
try {
    // execute queries
    conn.commit();
} catch (SQLException e) {
    conn.rollback();
}
*/

-- ======================================
-- CHAPTER 46: Log files
-- ======================================

-- Section 46.1: Slow Query Log
-- Bật trong my.cnf:
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2

-- Section 46.2: A List
-- Các log file chính:
-- Error Log — lỗi khởi động, crash
-- General Query Log — tất cả truy vấn (rất nặng)
-- Slow Query Log — truy vấn lâu
-- Binary Log — replication & point-in-time recovery

-- Section 46.3: General Query Log
general_log = 1
general_log_file = /var/log/mysql/query.log

-- Section 46.4: Error Log
-- Vị trí thường: /var/log/mysql/error.log

-- ======================================
-- CHAPTER 47: Clustering
-- ======================================

-- Section 47.1: Disambiguation
-- MySQL Cluster (NDB) ≠ Replication ≠ Sharding ≠ Galera
-- MySQL 5.7 không hỗ trợ MySQL Cluster (NDB) — chỉ hỗ trợ Replication & InnoDB Cluster (MySQL 8.0+)

-- ======================================
-- CHAPTER 48: Partitioning
-- ======================================

-- Section 48.1: RANGE Partitioning
CREATE TABLE sales (
    id INT,
    sale_date DATE
) PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023)
);

-- Section 48.2: LIST Partitioning
CREATE TABLE regions (
    id INT,
    region VARCHAR(10)
) PARTITION BY LIST (region) (
    PARTITION p_north VALUES IN ('north', 'northeast'),
    PARTITION p_south VALUES IN ('south', 'southeast')
);

-- Section 48.3: HASH Partitioning
CREATE TABLE users_hashed (
    id INT,
    name VARCHAR(50)
) PARTITION BY HASH(id) PARTITIONS 4;

-- ======================================
-- CHAPTER 49: Replication
-- ======================================

-- Section 49.1: Master - Slave Replication Setup
-- Trên MASTER:
-- my.cnf:
-- server-id = 1
-- log-bin = mysql-bin
-- binlog-format = ROW
-- restart MySQL
-- CREATE USER 'repl'@'%' IDENTIFIED BY 'password';
-- GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

-- Trên SLAVE:
-- server-id = 2
-- relay-log = mysql-relay-bin
-- CHANGE MASTER TO
--   MASTER_HOST='master_ip',
--   MASTER_USER='repl',
--   MASTER_PASSWORD='password',
--   MASTER_LOG_FILE='mysql-bin.000001',
--   MASTER_LOG_POS=154;
-- START SLAVE;

-- Section 49.2: Replication Errors
-- SHOW SLAVE STATUS\G
-- Fix: STOP SLAVE; RESET SLAVE; CHANGE MASTER TO ...; START SLAVE;

-- ======================================
-- CHAPTER 50: Backup using mysqldump
-- ======================================

-- Section 50.1: Specifying username and password
mysqldump -u root -p mydb > backup.sql

-- Section 50.2: Creating a backup of a database or table
mysqldump -u root -p mydb users > users_backup.sql

-- Section 50.3: Restoring a backup of a database or table
mysql -u root -p mydb < backup.sql

-- Section 50.4: Tranferring data from one MySQL server to another
mysqldump -u root -p source_db | mysql -u root -p target_db

-- Section 50.5: mysqldump from a remote server with compression
mysqldump -u root -p -h remote-server.com mydb | gzip > backup.sql.gz

-- Section 50.6: restore a gzipped mysqldump file without uncompressing
gunzip < backup.sql.gz | mysql -u root -p mydb

-- Section 50.7: Backup database with stored procedures and functions
mysqldump -u root -p --routines mydb > backup_with_routines.sql

-- Section 50.8: Backup direct to Amazon S3 with compression
mysqldump -u root -p mydb | gzip | aws s3 cp - s3://my-bucket/backup.sql.gz

-- ======================================
-- CHAPTER 51: mysqlimport
-- ======================================

-- Section 51.1: Basic usage
mysqlimport -u root -p --local mydb /path/to/data.csv

-- Section 51.2: Using a custom field-delimiter
mysqlimport -u root -p --local --fields-terminated-by=',' mydb /path/to/data.csv

-- Section 51.3: Using a custom row-delimiter
mysqlimport -u root -p --local --lines-terminated-by='\n' mydb /path/to/data.csv

-- Section 51.4: Handling duplicate keys
mysqlimport -u root -p --local --replace mydb /path/to/data.csv  -- REPLACE
-- HOẶC: --ignore → bỏ qua dòng trùng

-- Section 51.5: Conditional import
-- Không hỗ trợ trực tiếp — nên dùng LOAD DATA INFILE với IGNORE

-- Section 51.6: Import a standard csv
mysqlimport -u root -p --local --fields-terminated-by=',' --lines-terminated-by='\n' mydb /path/to/data.csv

-- ======================================
-- CHAPTER 52: LOAD DATA INFILE
-- ======================================

-- Section 52.1: using LOAD DATA INFILE to load large amount of data to database
LOAD DATA INFILE '/tmp/data.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(name, email, created_at);

-- Section 52.2: Load data with duplicates
LOAD DATA INFILE '/tmp/data.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(name, email, created_at)
IGNORE;  -- Bỏ qua dòng trùng key

-- Section 52.3: Import a CSV file into a MySQL table
-- Xem Section 52.1

-- ======================================
-- CHAPTER 53: MySQL Unions
-- ======================================

-- Section 53.1: Union operator
SELECT col FROM t1
UNION
SELECT col FROM t2;

-- Section 53.2: Union ALL
SELECT col FROM t1
UNION ALL
SELECT col FROM t2;

-- Section 53.3: UNION ALL With WHERE
SELECT name FROM users WHERE status = 'active'
UNION ALL
SELECT name FROM admins WHERE status = 'active';

-- ======================================
-- CHAPTER 54: MySQL client
-- ======================================

-- Section 54.1: Base login
mysql -u username -p

-- Section 54.2: Execute commands
mysql -u root -p -e "SELECT VERSION();"

-- ======================================
-- CHAPTER 55: Temporary Tables
-- ======================================

-- Section 55.1: Create Temporary Table
CREATE TEMPORARY TABLE temp_summary AS
SELECT department, COUNT(*) AS cnt FROM employees GROUP BY department;

-- Section 55.2: Drop Temporary Table
DROP TEMPORARY TABLE IF EXISTS temp_summary;

-- ======================================
-- CHAPTER 56: Customize PS1
-- ======================================

-- Section 56.1: Customize the MySQL PS1 with current database
-- Trong ~/.mysql_history hoặc .bashrc:
export MYSQL_PS1="(\u@\h [\d])> "

-- Section 56.2: Custom PS1 via MySQL configuration file
-- Tạo ~/.my.cnf:
[mysql]
prompt=(\\u@\\h \\d)> 

-- ======================================
-- CHAPTER 57: Dealing with sparse or missing data
-- ======================================

-- Section 57.1: Working with columns containg NULL values
-- Dùng COALESCE, IFNULL, CASE để xử lý
SELECT name, COALESCE(phone, 'Chưa có số điện thoại') AS contact FROM users;

-- ======================================
-- CHAPTER 58: Connecting with UTF-8 Using Various Programming language.
-- ======================================

-- Section 58.1: Python
-- Với pymysql:
conn = pymysql.connect(host='localhost', user='root', password='...', charset='utf8mb4')

-- Section 58.2: PHP
-- Với mysqli:
$mysqli = new mysqli($host, $user, $pass, $db);
$mysqli->set_charset("utf8mb4");

-- Với PDO:
$pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);

-- ======================================
-- CHAPTER 59: Time with subsecond precision
-- ======================================

-- Section 59.1: Get the current time with millisecond precision
SELECT NOW(3);  -- 2024-06-15 14:30:12.456

-- Section 59.2: Get the current time in a form that looks like a Javascript timestamp
SELECT UNIX_TIMESTAMP(NOW(3)) * 1000 AS js_timestamp;

-- Section 59.3: Create a table with columns to store sub-second time
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    occurred_at DATETIME(6)  -- microsecond precision
);

-- Section 59.4: Convert a millisecond-precision date / time value to text
SELECT DATE_FORMAT(NOW(3), '%Y-%m-%d %H:%i:%s.%f') AS formatted;

-- Section 59.5: Store a Javascript timestamp into a TIMESTAMP column
-- JS timestamp = milliseconds since epoch
-- MySQL: UNIX_TIMESTAMP() returns seconds
INSERT INTO events (occurred_at) VALUES (FROM_UNIXTIME(1718456789123 / 1000));

-- ======================================
-- CHAPTER 60: One to Many
-- ======================================

-- Section 60.1: Example Company Tables
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);

-- Section 60.2: Get the Employees Managed by a Single Manager
-- Giả sử có bảng managers (employee_id, manager_id)
SELECT e.name AS employee, m.name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE m.name = 'John Doe';

-- Section 60.3: Get the Manager for a Single Employee
SELECT m.name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.name = 'Alice';

-- ======================================
-- CHAPTER 61: Server Information
-- ======================================

-- Section 61.1: SHOW VARIABLES example
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';

-- Section 61.2: SHOW STATUS example
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Queries';

-- ======================================
-- CHAPTER 62: SSL Connection Setup
-- ======================================

-- Section 62.1: Setup for Debian-based systems
-- Generate certs: openssl req -newkey rsa:2048 -nodes -keyout server-key.pem -x509 -days 365 -out server-cert.pem
-- Copy to /etc/mysql/ and chown mysql:mysql
-- Trong /etc/mysql/my.cnf:
[mysqld]
ssl-ca=/etc/mysql/ca-cert.pem
ssl-cert=/etc/mysql/server-cert.pem
ssl-key=/etc/mysql/server-key.pem

-- Section 62.2: Setup for CentOS7 / RHEL7
-- Tương tự Debian — đường dẫn thường là /etc/my.cnf.d/

-- ======================================
-- CHAPTER 63: Create New User
-- ======================================

-- Section 63.1: Create a MySQL User
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';

-- Section 63.2: Specify the password
-- Dùng ALTER USER nếu đã tồn tại:
ALTER USER 'newuser'@'localhost' IDENTIFIED BY 'new_password';

-- Section 63.3: Create new user and grant all priviliges to schema
CREATE USER 'dev'@'%' IDENTIFIED BY 'dev_pass';
GRANT ALL PRIVILEGES ON myapp.* TO 'dev'@'%';
FLUSH PRIVILEGES;

-- Section 63.4: Renaming user
RENAME USER 'olduser'@'localhost' TO 'newuser'@'localhost';

-- ======================================
-- CHAPTER 64: Security via GRANTs
-- ======================================

-- Section 64.1: Best Practice
-- Principle of least privilege: chỉ cấp quyền cần thiết
-- Không dùng 'root' cho ứng dụng
-- Dùng 'user@host' cụ thể thay vì 'user@%'

-- Section 64.2: Host (of user@host)
-- localhost → chỉ từ máy chủ
-- 192.168.1.% → từ mạng nội bộ
-- % → từ bất kỳ đâu (nguy hiểm!)

-- ======================================
-- CHAPTER 65: Change Password
-- ======================================

-- Section 65.1: Change MySQL root password in Linux
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_strong_password';

-- Section 65.2: Change MySQL root password in Windows
-- Mở cmd với quyền admin
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_strong_password';

-- Section 65.3: Process
-- 1. Đăng nhập MySQL
-- 2. Chạy lệnh ALTER USER ...
-- 3. FLUSH PRIVILEGES (không bắt buộc trong MySQL 5.7+)

-- ======================================
-- CHAPTER 66: Recover and reset the default root password for MySQL 5.7+
-- ======================================

-- Section 66.1: What happens when the initial start up of the server
-- Lần đầu khởi động: MySQL tạo user 'root'@'localhost' với mật khẩu tạm thời trong error log
-- Tìm: grep 'temporary password' /var/log/mysql/error.log

-- Section 66.2: How to change the root password by using the default password
-- 1. Stop MySQL: sudo systemctl stop mysql
-- 2. Start MySQL skip-grant-tables: sudo mysqld_safe --skip-grant-tables &
-- 3. Connect: mysql -u root
-- 4. UPDATE mysql.user SET authentication_string=PASSWORD('newpass') WHERE User='root';
-- 5. FLUSH PRIVILEGES;
-- 6. Exit, restart MySQL bình thường

-- Section 66.3: reset root password when " /var/run/mysqld' for UNIX socket file don't exists"
-- Tạo thư mục: sudo mkdir -p /var/run/mysqld
-- Chỉnh quyền: sudo chown mysql:mysql /var/run/mysqld

-- ======================================
-- CHAPTER 67: Recover from lost root password
-- ======================================

-- Section 67.1: Set root password, enable root user for socket and http access
-- Đã hướng dẫn ở Section 66.2

-- ======================================
-- CHAPTER 68: MySQL Performance Tips
-- ======================================

-- Section 68.1: Building a composite index
-- Thứ tự quan trọng: WHERE clauses → ORDER BY → GROUP BY
-- Ví dụ: WHERE a=? AND b=? ORDER BY c → INDEX(a,b,c)

-- Section 68.2: Optimizing Storage Layout for InnoDB Tables
-- Dùng INT thay vì VARCHAR cho khóa ngoại
-- Sắp xếp cột theo độ dài giảm dần (giảm padding)
-- Tránh TEXT/BLOB nếu không cần — lưu riêng

-- ======================================
-- CHAPTER 69: Performance Tuning
-- ======================================

-- Section 69.1: Don't hide in function
-- ❌ SELECT * FROM users WHERE YEAR(created_at) = 2024;
-- ✅ SELECT * FROM users WHERE created_at >= '2024-01-01' AND created_at < '2025-01-01';

-- Section 69.2: OR
-- ❌ WHERE a=1 OR b=2 → không dùng index tốt
-- ✅ Dùng UNION ALL hoặc rewrite

-- Section 69.3: Add the correct index
-- Dùng EXPLAIN SELECT ... để kiểm tra

-- Section 69.4: Have an INDEX
-- Mọi cột dùng trong WHERE, JOIN, ORDER BY, GROUP BY nên có index

-- Section 69.5: Subqueries
-- Thay thế bằng JOIN nếu có thể — nhanh hơn

-- Section 69.6: JOIN + GROUP BY
-- Đảm bảo các cột JOIN có index

-- Section 69.7: Set the cache correctly
-- innodb_buffer_pool_size = 70% RAM
-- query_cache_type = 0 (bỏ trong MySQL 5.7+ — không còn hiệu quả)

-- Section 69.8: Negatives
-- ❌ WHERE status != 'active' → không dùng index
-- ✅ Dùng: WHERE status IN ('inactive', 'pending')

-- ======================================
-- APPENDIX A: Reserved Words
-- ======================================

-- Section A.1: Errors due to reserved words
-- Từ khóa MySQL 5.7 không nên dùng làm tên cột/bảng:
-- ORDER, GROUP, INDEX, KEY, OPTION, PASSWORD, ROLE, TABLE, USER, VIEW, WINDOW, WITH, ZONE...

-- Nếu bắt buộc: dùng backticks `order`

-- ======================================
-- CREDITS
-- ======================================

-- Tài liệu tham khảo chính:
-- https://dev.mysql.com/doc/refman/5.7/en/
-- https://www.mysqltutorial.org/
-- https://github.com/dennyglee/mysql-cheatsheet

-- ======================================
-- You may also like
-- ======================================

-- MySQL 8.0 Cheat Sheet
-- PostgreSQL Cheat Sheet
-- MongoDB Guide
-- Docker for MySQL

-- ========================================================================
-- END OF FILE
-- ========================================================================