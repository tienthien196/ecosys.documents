```
MYSQL — HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU QUAN HỆ (RDBMS)
│
├─── 1. BẢN CHẤT TỔNG QUÁT
│    │
│    ├─── Là phần mềm DBMS (Database Management System)
│    ├─── Tuân thủ mô hình quan hệ (Relational Model) của E.F. Codd (1970)
│    ├─── Dữ liệu được tổ chức thành các BẢNG (Table) — tập hợp các MỐI QUAN HỆ
│    ├─── Mỗi bảng = Tập hợp các HÀNG (Tuple/Record) và CỘT (Attribute/Field)
│    └─── Tất cả thao tác đều dựa trên ĐẠI SỐ QUAN HỆ (Relational Algebra) và CALCULUS
│
├─── 2. MÔ HÌNH DỮ LIỆU QUAN HỆ (RELATIONAL MODEL)
│    │
│    ├─── 📌 BẢNG (Table)
│    │    ├─── Là tập con của tích Descartes giữa các miền giá trị (domains)
│    │    └─── Không có thứ tự hàng → mỗi hàng là một tập hợp các cặp (tên_cột, giá_trị)
│    │
│    ├─── 📌 KHÓA (Key)
│    │    ├─── Khóa chính (Primary Key): xác định duy nhất một hàng trong bảng
│    │    │    └─── Không NULL, không trùng lặp → đảm bảo tính toàn vẹn thực thể (Entity Integrity)
│    │    │
│    │    ├─── Khóa ngoại (Foreign Key): tham chiếu đến PK của bảng khác
│    │    │    └─── Đảm bảo tính toàn vẹn tham chiếu (Referential Integrity)
│    │    │
│    │    └─── Khóa candidate: thuộc tính hoặc tập thuộc tính có thể trở thành PK
│    │
│    └─── 📌 MỐI QUAN HỆ (Relationship)
│         ├─── 1:1, 1:N, N:M → biểu diễn bằng FK + bảng trung gian (junction table)
│         └─── Không dùng con trỏ vật lý → tất cả kết nối là LOGICAL thông qua giá trị khóa
│
├─── 3. NGÔN NGỮ SQL — LỚP GIAO TIẾP VỚI MÔ HÌNH QUAN HỆ
│    │
│    ├─── SQL = Structured Query Language — ngôn ngữ chuẩn ANSI/ISO
│    │    ├─── 3 thành phần chính:
│    │    │
│    │    ├─── DDL (Data Definition Language) — Định nghĩa cấu trúc
│    │    │    ├─── CREATE TABLE — tạo bảng, khai báo kiểu, ràng buộc
│    │    │    ├─── ALTER TABLE — sửa cấu trúc (thêm/xóa cột, ràng buộc)
│    │    │    └─── DROP TABLE — xóa hoàn toàn bảng (và dữ liệu)
│    │    │
│    │    ├─── DML (Data Manipulation Language) — Thao tác dữ liệu
│    │    │    ├─── SELECT — truy vấn (phép chiếu π, chọn σ, join ⋈, union ∪, difference −)
│    │    │    ├─── INSERT — chèn tuple mới vào quan hệ
│    │    │    ├─── UPDATE — sửa giá trị các thuộc tính trong tuple
│    │    │    └─── DELETE — loại bỏ tuple khỏi quan hệ
│    │    │
│    │    └─── DCL (Data Control Language) — Kiểm soát truy cập
│    │         ├─── GRANT / REVOKE — cấp/phê duyệt quyền truy cập
│    │         └─── TRANSACTION CONTROL: BEGIN, COMMIT, ROLLBACK — đảm bảo ACID
│    │
│    └─── SQL là ngôn ngữ DECLARATIVE — bạn nói “CẦN GÌ”, không nói “LÀM THẾ NÀO”
│         → Hệ thống tự sinh ra kế hoạch truy vấn (Query Plan) tối ưu
│
├─── 4. CƠ CHẾ HOẠT ĐỘNG NỀN TẢNG (PHÍA SAU SQL)
│    │
│    ├─── 🧠 QUERY EXECUTION PIPELINE
│    │    ├─── 1. Parser — Phân tích cú pháp SQL → cây AST (Abstract Syntax Tree)
│    │    ├─── 2. Optimizer — Chọn cách thực thi hiệu quả nhất:
│    │    │    ├─── Xem chỉ mục (index) nào có thể dùng
│    │    │    ├─── Tối ưu thứ tự JOIN (JOIN ordering)
│    │    │    └─── Ước lượng chi phí (cost-based optimization)
│    │    └─── 3. Executor — Thực thi kế hoạch → truy cập storage engine
│    │
│    ├─── 🗃️ STORAGE ENGINE — Lớp lưu trữ vật lý
│    │    ├─── InnoDB (mặc định từ MySQL 5.5+)
│    │    │    ├─── Dùng B+Tree để lưu index & data (clustered index)
│    │    │    ├─── Hỗ trợ transaction → dùng WAL (Write-Ahead Logging)
│    │    │    ├─── MVCC (Multi-Version Concurrency Control) → đọc không chặn viết
│    │    │    └─── Dùng undo log để rollback, redo log để crash recovery
│    │    │
│    │    └─── MyISAM (cũ, không hỗ trợ transaction)
│    │         ├─── Dùng HEAP + B-Tree
│    │         └─── Lock cấp bảng (table-level locking) → không phù hợp write-heavy
│    │
│    └─── 🔄 TRANSACTIONS & ACID
│         ├─── Atomicity — Toàn bộ giao dịch hoặc thành công, hoặc thất bại hoàn toàn
│         │    └─── Dùng UNDO LOG để khôi phục trạng thái trước giao dịch
│         │
│         ├─── Consistency — Dữ liệu luôn ở trạng thái hợp lệ (ràng buộc, FK, check)
│         │    └─── Được đảm bảo bởi ràng buộc (constraints) do người dùng định nghĩa
│         │
│         ├─── Isolation — Giao dịch chạy song song nhưng không ảnh hưởng lẫn nhau
│         │    └─── Dùng mức cô lập (isolation level):
│         │         ├─── READ UNCOMMITTED → dirty read
│         │         ├─── READ COMMITTED → non-repeatable read
│         │         ├─── REPEATABLE READ (mặc định MySQL) → phantom read bị ngăn
│         │         └─── SERIALIZABLE → nghiêm ngặt nhất, hiệu năng thấp
│         │
│         └─── Durability — Sau khi COMMIT, dữ liệu không mất dù hệ thống sập
│              └─── Dùng REDO LOG (ghi trước lên đĩa) → phục hồi sau crash
│
├─── 5. TÍNH TOÁN QUAN HỆ — NHỮNG PHÉP TOÁN CƠ BẢN
│    │
│    ├─── SELECTION (σ) — lọc hàng theo điều kiện
│    │    └─── Tương đương: WHERE age > 18
│    │
│    ├─── PROJECTION (π) — lấy một số cột
│    │    └─── Tương đương: SELECT name, email FROM users
│    │
│    ├─── JOIN (⋈) — kết hợp hai bảng theo điều kiện
│    │    ├─── INNER JOIN: chỉ giữ hàng có match
│    │    ├─── LEFT JOIN: giữ tất cả hàng bảng trái, thêm NULL nếu không match
│    │    └─── CROSS JOIN: tích Descartes (không điều kiện)
│    │
│    ├─── UNION (∪), INTERSECT (∩), DIFFERENCE (−) — phép toán tập hợp
│    │    └─── Hai bảng phải cùng schema (số cột, kiểu dữ liệu tương thích)
│    │
│    └─── DIVISION (÷) — hiếm gặp, dùng để tìm "tất cả" (VD: khách hàng mua tất cả sản phẩm)
│
└─── 6. TÍNH TOÀN VẸN DỮ LIỆU (INTEGRITY CONSTRAINTS)
     │
     ├─── PRIMARY KEY — đảm bảo uniqueness + NOT NULL
     ├─── FOREIGN KEY — đảm bảo tham chiếu hợp lệ (referential integrity)
     ├─── UNIQUE — đảm bảo không trùng giá trị trong cột
     ├─── NOT NULL — bắt buộc có giá trị
     ├─── CHECK — ràng buộc điều kiện (VD: age >= 0)
     └─── DEFAULT — giá trị mặc định khi không cung cấp
```
---
```
MYSQL — TƯƠNG TỰ NHƯ GAME BACKEND
│
├─── BẢNG (Table)  
│    └─── Là một mảng object: [{id:1,name:"Alice",level:25}, {id:2,name:"Bob",level:30}]  
│         → Không phải file, không phải Excel — mà là "dữ liệu có quy tắc"  
│         → Mỗi dòng = 1 entity trong game: player, item, quest...  
│
├─── SQL  
│    └─── Bạn không viết code — bạn hỏi:  
│         "Cho tôi tên những player level > 20"  
│         → Hệ thống tự tìm cách trả lời — không cần loop, không cần if  
│         → SELECT name FROM players WHERE level > 20  
│
├─── FK (Khóa ngoại)  
│    └─── Là ID trỏ đến PK của bảng khác — chỉ được trỏ vào ID  
│         ✅ Đúng: weapon_id → REFERENCES weapons.id  
│         ❌ Sai: weapon_name → REFERENCES weapons.name  
│         → Vì sao? Có 5 thanh "Sword" — bạn muốn trang bị cái nào?  
│         → FK = "chỉ đường đến đúng vật phẩm" — không để dữ liệu ma  
│
├─── ACID — GIAO DỊCH AN TOÀN  
│    ├─── A (Atomic): Hoặc cả hai cùng thành công — hoặc cùng thất bại  
│    │      (Alice mất 100 gold → Bob nhận 100 gold)  
│    ├─── C (Consistency): Tổng gold trong hệ thống luôn đúng  
│    ├─── I (Isolation): 10k người chơi giao dịch cùng lúc — không lộn xộn  
│    └─── D (Durability): Server sập? Gold vẫn còn — vì đã ghi log trước  
│
├─── MVCC  
│    └─── Khi bạn đọc danh sách player — hệ thống không lock  
│         → Nó tạo bản sao dữ liệu tại thời điểm bạn bắt đầu  
│         → Người A đọc lúc 10:00:00 → thấy level=20  
│         → Người B sửa level=30 lúc 10:00:01  
│         → Người A VẪN thấy 20 — không bị nhiễu  
│         → Giải thích vì sao leaderboard không lag  
│
├─── B+Tree (Index)  
│    └─── Là mục lục trong sổ tay — giúp tìm nhanh  
│         🔍 Tìm id=100 → nhanh (O(log n))  
│         🔍 Tìm level BETWEEN 20 AND 30 → NHANH HƠN vì dữ liệu sắp xếp theo thứ tự  
│         🚫 Không có index? → Phải quét từng hàng → chậm như tải phim 360p  
│
├─── UNDO LOG  
│    └─── Ghi lại "trước khi sửa" — để rollback dễ dàng  
│         UPDATE player SET level=30 → Undo Log ghi: "trước đó level=25"  
│         → Rollback? Dùng lại 25  
│         → Cũng là nền tảng cho MVCC — đọc phiên bản cũ  
│
└─── REDO LOG  
     └─── Ghi lại "tôi định làm gì" — NGAY TRƯỚC khi ghi vào đĩa  
          UPDATE → ghi vào redo log → mới ghi vào file  
          → Server tắt? Khởi động lại → đọc redo log → làm lại mọi việc chưa xong  
          → KHÔNG CẦN BACKUP — chỉ cần log này là cứu được dữ liệu  
```
---

```sql
-- =============================================
-- MYSQL 5.7 CHEAT SHEET (HỌC TẬP)
-- =============================================
-- Author: Bạn
-- Date: 2025
-- Target: Ôn tập nhanh các câu lệnh cơ bản và nâng cao MySQL 5.7
-- =============================================

-- ========================
-- 1. KẾT NỐI & QUẢN LÝ CƠ SỞ DỮ LIỆU
-- ========================

-- Kết nối đến MySQL (dòng lệnh)
mysql -u username -p

-- Hiển thị tất cả database
SHOW DATABASES;

-- Tạo database
CREATE DATABASE mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Xóa database
DROP DATABASE IF EXISTS mydb;

-- Sử dụng database
USE mydb;

-- Xem database đang dùng
SELECT DATABASE();

-- Xem cấu trúc table hiện tại
DESCRIBE tablename;
-- Hoặc
SHOW CREATE TABLE tablename;

-- ========================
-- 2. QUẢN LÝ BẢNG (TABLE)
-- ========================

-- Tạo bảng cơ bản
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    age TINYINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm cột
ALTER TABLE users ADD COLUMN phone VARCHAR(15);

-- Sửa cột
ALTER TABLE users MODIFY COLUMN phone VARCHAR(20);

-- Đổi tên cột
ALTER TABLE users CHANGE COLUMN phone mobile VARCHAR(20);

-- Xóa cột
ALTER TABLE users DROP COLUMN mobile;

-- Đổi tên bảng
RENAME TABLE users TO users_info;

-- Xóa bảng
DROP TABLE IF EXISTS users_info;

-- Xem danh sách table trong DB hiện tại
SHOW TABLES;

-- ========================
-- 3. INSERT DATA
-- ========================

-- Chèn một bản ghi
INSERT INTO users (username, email, age) 
VALUES ('john_doe', 'john@example.com', 25);

-- Chèn nhiều bản ghi
INSERT INTO users (username, email, age) 
VALUES 
    ('alice', 'alice@x.com', 30),
    ('bob', 'bob@y.com', 22),
    ('charlie', 'charlie@z.com', 35);

-- Chèn từ truy vấn khác
INSERT INTO users (username, email, age)
SELECT name, email, age FROM temp_users WHERE age > 18;

-- ========================
-- 4. SELECT DATA (TRUY VẤN)
-- ========================

-- Lấy tất cả dữ liệu
SELECT * FROM users;

-- Lấy một số cột
SELECT username, email, age FROM users;

-- Điều kiện WHERE
SELECT * FROM users WHERE age > 25 AND is_active = TRUE;

-- LIKE (tìm kiếm mẫu)
SELECT * FROM users WHERE username LIKE '%john%';

-- IN / NOT IN
SELECT * FROM users WHERE age IN (25, 30, 35);

-- BETWEEN
SELECT * FROM users WHERE age BETWEEN 20 AND 30;

-- ORDER BY
SELECT * FROM users ORDER BY age DESC, username ASC;

-- LIMIT (giới hạn kết quả)
SELECT * FROM users ORDER BY id DESC LIMIT 5;

-- OFFSET + LIMIT (phân trang)
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 20;

-- DISTINCT (loại bỏ trùng lặp)
SELECT DISTINCT age FROM users;

-- GROUP BY + HAVING
SELECT age, COUNT(*) as count 
FROM users 
WHERE age > 18 
GROUP BY age 
HAVING count > 1 
ORDER BY count DESC;

-- JOINs

-- INNER JOIN
SELECT u.username, o.order_id 
FROM users u 
INNER JOIN orders o ON u.id = o.user_id;

-- LEFT JOIN
SELECT u.username, o.order_id 
FROM users u 
LEFT JOIN orders o ON u.id = o.user_id;

-- RIGHT JOIN (hiếm dùng hơn)
SELECT u.username, o.order_id 
FROM users u 
RIGHT JOIN orders o ON u.id = o.user_id;

-- ========================
-- 5. CẬP NHẬT & XÓA DỮ LIỆU
-- ========================

-- Cập nhật dữ liệu
UPDATE users 
SET age = 26, updated_at = NOW() 
WHERE username = 'john_doe';

-- Cập nhật nhiều điều kiện
UPDATE users 
SET is_active = FALSE 
WHERE age < 18 OR email IS NULL;

-- Xóa bản ghi
DELETE FROM users WHERE id = 5;

-- Xóa tất cả (cẩn thận!)
DELETE FROM users; -- Không xóa nếu không có WHERE!

-- Xóa tất cả + reset auto_increment
TRUNCATE TABLE users;

-- ========================
-- 6. CHỈ MỤC (INDEXES)
-- ========================

-- Tạo chỉ mục đơn
CREATE INDEX idx_username ON users (username);

-- Tạo chỉ mục đa cột
CREATE INDEX idx_email_age ON users (email, age);

-- Xóa chỉ mục
DROP INDEX idx_username ON users;

-- Xem chỉ mục của bảng
SHOW INDEX FROM users;

-- ========================
-- 7. KHÓA NGOẠI & RÀNG BUỘC
-- ========================

-- Tạo khóa ngoại khi tạo bảng
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Thêm khóa ngoại sau này
ALTER TABLE orders 
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;

-- Xóa khóa ngoại
ALTER TABLE orders DROP FOREIGN KEY fk_user_id;

-- ========================
-- 8. HÀM HỖ TRỢ THƯỜNG DÙNG
-- ========================

-- Hàm chuỗi
SELECT UPPER(username), LOWER(email), LENGTH(username), SUBSTRING(email, 1, 5) FROM users;

-- Hàm ngày tháng
SELECT 
    CURDATE(),           -- Ngày hiện tại
    CURTIME(),           -- Giờ hiện tại
    NOW(),               -- Ngày giờ hiện tại
    DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS formatted,
    DATEDIFF(NOW(), created_at) AS days_old
FROM users;

-- Hàm toán học
SELECT 
    ABS(-10),            -- Trị tuyệt đối
    ROUND(3.14159, 2),   -- Làm tròn
    CEIL(3.1),           -- Làm tròn lên
    FLOOR(3.9),          -- Làm tròn xuống
    RAND();              -- Số ngẫu nhiên

-- Hàm điều kiện
SELECT 
    username,
    CASE 
        WHEN age < 18 THEN 'Teen'
        WHEN age BETWEEN 18 AND 30 THEN 'Young'
        ELSE 'Adult'
    END AS age_group
FROM users;

-- Hàm xử lý NULL
SELECT 
    COALESCE(phone, 'Chưa có số') AS contact,
    IFNULL(email, 'Không có email') AS email_check
FROM users;

-- ========================
-- 9. SAO LƯU & KHÔI PHỤC (BACKUP & RESTORE)
-- ========================

-- Sao lưu toàn bộ database
mysqldump -u username -p mydb > mydb_backup.sql

-- Sao lưu một bảng
mysqldump -u username -p mydb users > users_backup.sql

-- Khôi phục database
mysql -u username -p mydb < mydb_backup.sql

-- Khôi phục vào database mới
mysql -u username -p newdb < mydb_backup.sql

-- ========================
-- 10. NGƯỜI DÙNG & QUYỀN (USER & PRIVILEGES)
-- ========================

-- Tạo người dùng
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password123';

-- Cấp quyền
GRANT ALL PRIVILEGES ON mydb.* TO 'newuser'@'localhost';

-- Cấp quyền cụ thể
GRANT SELECT, INSERT, UPDATE ON mydb.users TO 'newuser'@'localhost';

-- Xem quyền của user
SHOW GRANTS FOR 'newuser'@'localhost';

-- Thu hồi quyền
REVOKE INSERT ON mydb.users FROM 'newuser'@'localhost';

-- Xóa user
DROP USER 'newuser'@'localhost';

-- Đổi mật khẩu
ALTER USER 'newuser'@'localhost' IDENTIFIED BY 'newpass456';

-- ========================
-- 11. MẸO & LƯU Ý QUAN TRỌNG (MYSQL 5.7)
-- ========================

-- ✅ Luôn dùng `ENGINE=InnoDB` (hỗ trợ transaction, FK)
-- ✅ Dùng `utf8mb4` thay vì `utf8` để hỗ trợ emoji
-- ✅ Dùng `TIMESTAMP` tự động cập nhật khi update
-- ✅ Tránh `SELECT *` trong production → chọn cột cụ thể
-- ✅ Dùng `EXPLAIN` để tối ưu truy vấn:
EXPLAIN SELECT * FROM users WHERE username = 'john_doe';
-- ✅ Luôn kiểm tra `sql_mode`:
SELECT @@sql_mode;

-- ✅ Tắt chế độ safe update (nếu cần):
SET SQL_SAFE_UPDATES = 0;

-- ✅ Kiểm tra phiên bản MySQL
SELECT VERSION();

-- ✅ Xem trạng thái server
SHOW STATUS;

-- ✅ Xem biến hệ thống
SHOW VARIABLES LIKE 'max_connections';

-- ========================
-- ✅ LUYỆN TẬP: TỰ TẠO BÀI TẬP NHỎ
-- ========================

-- Tạo 2 bảng: students & courses
-- students: id, name, email, course_id
-- courses: id, title, credits
-- Chèn vài bản ghi
-- Viết query: lấy tên sinh viên + tên khóa học
-- Viết query: đếm số sinh viên theo từng khóa học
-- Viết query: tìm sinh viên chưa đăng ký khóa nào
-- Viết query: cập nhật điểm trung bình (thêm cột avg_score)

-- 💡 Gợi ý: Dùng `LEFT JOIN`, `GROUP BY`, `COUNT`, `CASE`

```