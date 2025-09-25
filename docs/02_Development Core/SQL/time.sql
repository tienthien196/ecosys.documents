-- ========================================================================
-- DỮ LIỆU MẪU CHO BẢNG events (MySQL 5.7)
-- Mục đích: Minh họa các kiểu dữ liệu ngày/giờ trong MySQL
-- ========================================================================

-- Tạo bảng (nếu chưa có)
CREATE TABLE IF NOT EXISTS events (
    event_date      DATE,           -- Chỉ ngày: 2024-06-15
    event_time      TIME,           -- Chỉ giờ: 14:30:00
    event_datetime  DATETIME,       -- Ngày + giờ: 2024-06-15 14:30:00
    event_timestamp TIMESTAMP,      -- Tự động cập nhật khi row thay đổi (nếu có DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
    event_year      YEAR            -- Năm: 2024 (lưu 4 chữ số)
);

-- Xóa dữ liệu cũ (nếu muốn chạy lại)
DELETE FROM events;

-- ========================================================================
-- CHÈN DỮ LIỆU MẪU
-- ========================================================================

-- Ví dụ 1: Sự kiện lịch sử
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('1969-07-20', '20:17:40', '1969-07-20 20:17:40', '1969-07-20 20:17:40', 1969);

-- Ví dụ 2: Sinh nhật nhân viên
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('1990-03-15', '08:30:00', '1990-03-15 08:30:00', '1990-03-15 08:30:00', 1990);

-- Ví dụ 3: Đặt hàng trực tuyến
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-06-10', '14:22:15', '2024-06-10 14:22:15', '2024-06-10 14:22:15', 2024);

-- Ví dụ 4: Cập nhật hồ sơ người dùng
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-01-01', '00:00:01', '2024-01-01 00:00:01', '2024-01-01 00:00:01', 2024);

-- Ví dụ 5: Lễ Giáng Sinh
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-12-25', '00:00:00', '2024-12-25 00:00:00', '2024-12-25 00:00:00', 2024);

-- Ví dụ 6: Thời điểm khởi động hệ thống
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-06-15', '06:30:00', '2024-06-15 06:30:00', '2024-06-15 06:30:00', 2024);

-- Ví dụ 7: Sự kiện tương lai (2025)
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2025-01-01', '00:00:00', '2025-01-01 00:00:00', '2025-01-01 00:00:00', 2025);

-- Ví dụ 8: Sự kiện vào buổi đêm
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-02-29', '23:59:59', '2024-02-29 23:59:59', '2024-02-29 23:59:59', 2024); -- Năm nhuận

-- Ví dụ 9: Sự kiện vào đầu ngày
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-12-31', '00:00:00', '2024-12-31 00:00:00', '2024-12-31 00:00:00', 2024);

-- Ví dụ 10: Sự kiện cuối ngày
INSERT INTO events (event_date, event_time, event_datetime, event_timestamp, event_year) VALUES
('2024-07-04', '23:59:59', '2024-07-04 23:59:59', '2024-07-04 23:59:59', 2024);

-- ========================================================================
-- BỔ SUNG: CẬP NHẬT event_timestamp TỰ ĐỘNG (sau khi tạo bảng)
-- ========================================================================
-- Để event_timestamp tự động cập nhật khi update, bạn cần sửa cấu trúc bảng:
ALTER TABLE events 
MODIFY COLUMN event_timestamp TIMESTAMP 
DEFAULT CURRENT_TIMESTAMP 
ON UPDATE CURRENT_TIMESTAMP;

-- Bây giờ thử cập nhật một bản ghi để xem timestamp thay đổi:
UPDATE events 
SET event_date = '2024-06-16' 
WHERE event_datetime = '2024-06-10 14:22:15';

-- ========================================================================
-- TRUY VẤN ĐỂ KIỂM TRA DỮ LIỆU
-- ========================================================================
SELECT 
    event_date AS "Ngày",
    event_time AS "Giờ",
    event_datetime AS "Ngày & Giờ",
    event_timestamp AS "Thời gian cập nhật",
    event_year AS "Năm"
FROM events
ORDER BY event_datetime DESC;