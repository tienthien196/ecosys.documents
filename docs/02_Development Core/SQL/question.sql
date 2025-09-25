-- Gợi ý: Dùng TIMESTAMP để ghi nhận thời gian tạo/sửa tự động
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Section 2.4: INT as AUTO_INCREMENT
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,  -- Tự tăng, không trùng lặp
    username VARCHAR(50) NOT NULL UNIQUE
);


-- Section 2.6: Implicit / automatic casting
-- MySQL tự chuyển đổi kiểu dữ liệu trong nhiều trường hợp:
SELECT '123' + 1;          -- → 124 (chuyển chuỗi thành số)
SELECT 123 + 'abc';       -- → 123 (chỉ lấy phần đầu là số)
SELECT DATE('2024-06-15'); -- → 2024-06-15 (chuyển chuỗi thành DATE)


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
