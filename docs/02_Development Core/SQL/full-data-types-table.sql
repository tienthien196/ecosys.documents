-- ========================================================================
-- BẢNG ĐẦY ĐỦ CÁC KIỂU DỮ LIỆU TRONG MySQL 5.7
-- Mục đích: Minh họa toàn bộ kiểu dữ liệu có sẵn trong MySQL 5.7
-- Tác giả: AI Assistant
-- Ngày: 2024
-- ========================================================================

-- Xóa bảng nếu đã tồn tại (để chạy lại dễ dàng)
DROP TABLE IF EXISTS full_data_types_demo;

-- Tạo bảng với tất cả kiểu dữ liệu phổ biến và ít dùng trong MySQL 5.7
CREATE TABLE full_data_types_demo (
    -- ======================================
    -- 1. INTEGER TYPES (Số nguyên)
    -- ======================================
    tinyint_col       TINYINT,           -- -128 đến 127 | 1 byte
    tinyint_unsigned  TINYINT UNSIGNED,  -- 0 đến 255 | 1 byte
    smallint_col      SMALLINT,          -- -32768 đến 32767 | 2 bytes
    mediumint_col     MEDIUMINT,         -- -8388608 đến 8388607 | 3 bytes
    int_col           INT,               -- -2147483648 đến 2147483647 | 4 bytes
    bigint_col        BIGINT,            -- -9e18 đến 9e18 | 8 bytes
    bigint_unsigned   BIGINT UNSIGNED,   -- 0 đến 1.8e19 | 8 bytes

    -- ======================================
    -- 2. FIXED-POINT NUMERIC (Số thập phân chính xác)
    -- ======================================
    decimal_col       DECIMAL(10,2),     -- Số thập phân: tổng 10 chữ số, 2 sau dấu phẩy → max 99999999.99
    numeric_col       NUMERIC(12,4),     -- NUMERIC = DECIMAL (tương đương)

    -- ======================================
    -- 3. FLOATING-POINT (Số thực - có sai số)
    -- ======================================
    float_col         FLOAT,             -- ~7 chữ số chính xác | 4 bytes
    double_col        DOUBLE,            -- ~15 chữ số chính xác | 8 bytes
    double_precision  DOUBLE PRECISION,  -- Tương đương DOUBLE

    -- ======================================
    -- 4. BIT VALUE TYPE (Giá trị nhị phân)
    -- ======================================
    bit_col           BIT(8),            -- Lưu 8 bit nhị phân (b'10101010')

    -- ======================================
    -- 5. DATE & TIME TYPES
    -- ======================================
    date_col          DATE,              -- Ngày: 'YYYY-MM-DD' | 3 bytes
    time_col          TIME,              -- Giờ: 'HH:MM:SS' hoặc '-HH:MM:SS' | 3 bytes
    datetime_col      DATETIME,          -- Ngày + giờ: 'YYYY-MM-DD HH:MM:SS' | 8 bytes
    timestamp_col     TIMESTAMP,         -- Tương tự DATETIME nhưng có thể tự động cập nhật | 4 bytes
    year_col          YEAR,              -- Năm: 1901–2155 hoặc 0000 | 1 byte

    -- ======================================
    -- 6. STRING TYPES
    -- ======================================
    char_col          CHAR(10),          -- Chuỗi cố định 10 ký tự (padded với space nếu ngắn)
    varchar_col       VARCHAR(255),      -- Chuỗi biến đổi tối đa 255 ký tự
    text_col          TEXT,              -- Văn bản dài (max ~65KB) — không có giới hạn độ dài khi khai báo
    tinytext_col      TINYTEXT,          -- Max 255 ký tự
    mediumtext_col    MEDIUMTEXT,        -- Max ~16MB
    longtext_col      LONGTEXT,          -- Max ~4GB

    -- ======================================
    -- 7. BINARY TYPES (Dữ liệu nhị phân)
    -- ======================================
    binary_col        BINARY(10),        -- Dữ liệu nhị phân cố định 10 byte
    varbinary_col     VARBINARY(255),    -- Dữ liệu nhị phân thay đổi tối đa 255 byte
    blob_col          BLOB,              -- Blob lớn (max ~65KB)
    tinyblob_col      TINYBLOB,          -- Max 255 byte
    mediumblob_col    MEDIUMBLOB,        -- Max ~16MB
    longblob_col      LONGBLOB,          -- Max ~4GB

    -- ======================================
    -- 8. ENUM (Liệt kê giá trị)
    -- ======================================
    status_enum       ENUM('active', 'inactive', 'pending', 'deleted'),
    
    -- ======================================
    -- 9. SET (Tập hợp nhiều giá trị từ danh sách)
    -- ======================================
    permissions_set   SET('read', 'write', 'delete', 'admin'),

    -- ======================================
    -- 10. JSON (MySQL 5.7+ hỗ trợ JSON như một kiểu dữ liệu)
    -- ======================================
    json_col          JSON,              -- Lưu cấu trúc JSON (MySQL 5.7+)
    
    -- ======================================
    -- 11. AUTO_INCREMENT (Chỉ dùng với INT/BIGINT)
    -- ======================================
    id                INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Khóa chính tự tăng'
);

-- ========================================================================
-- CHÈN DỮ LIỆU MẪU CHO TẤT CẢ CÁC CỘT
-- ========================================================================
INSERT INTO full_data_types_demo (
    tinyint_col, tinyint_unsigned,
    smallint_col, mediumint_col, int_col, bigint_col, bigint_unsigned,
    decimal_col, numeric_col,
    float_col, double_col, double_precision,
    bit_col,
    date_col, time_col, datetime_col, timestamp_col, year_col,
    char_col, varchar_col, text_col, tinytext_col, mediumtext_col, longtext_col,
    binary_col, varbinary_col, blob_col, tinyblob_col, mediumblob_col, longblob_col,
    status_enum, permissions_set,
    json_col
) VALUES (
    -- Integer types
    127,            -- TINYINT (giá trị max)
    255,            -- TINYINT UNSIGNED (giá trị max)
    32767,          -- SMALLINT
    8388607,        -- MEDIUMINT
    2147483647,     -- INT
    9223372036854775807, -- BIGINT (max signed)
    18446744073709551615, -- BIGINT UNSIGNED (max)

    -- Fixed-point
    99999999.99,    -- DECIMAL(10,2)
    9999999999.9999,-- NUMERIC(12,4)

    -- Floating-point
    3.14159,        -- FLOAT
    3.141592653589793, -- DOUBLE
    2.718281828459045, -- DOUBLE PRECISION

    -- Bit value
    b'10101010',    -- 8-bit binary: 170 in decimal

    -- Date & Time
    '2024-06-15',   -- DATE
    '14:30:00',     -- TIME
    '2024-06-15 14:30:00', -- DATETIME
    '2024-06-15 14:30:00', -- TIMESTAMP (sẽ tự động cập nhật nếu UPDATE)
    2024,           -- YEAR

    -- String types
    'Hello     ',   -- CHAR(10): được padding bằng khoảng trắng
    'This is a long string that fits within 255 chars...', -- VARCHAR
    'This is a TEXT field with more than 255 characters. It can hold up to 65,535 bytes.', -- TEXT
    'Tiny text content', -- TINYTEXT
    REPEAT('A', 10000), -- MEDIUMTEXT (10k chars)
    REPEAT('B', 100000), -- LONGTEXT (100k chars)

    -- Binary types
    x'48656C6C6F20576F726C64', -- BINARY(10): hex của "Hello World" (10 byte)
    x'4D7953514C',                 -- VARBINARY(255): hex của "MySQL"
    x'424C4F422064617461',         -- BLOB: hex của "BLOB data"
    x'54696E79424C4F42',           -- TINYBLOB: hex của "TinyBLOB"
    REPEAT(x'41', 10000),          -- MEDIUMBLOB (10k bytes)
    REPEAT(x'42', 100000),         -- LONGBLOB (100k bytes)

    -- ENUM
    'active',                       -- Chỉ chọn 1 trong các giá trị

    -- SET (có thể chọn nhiều giá trị)
    'read,write,admin',             -- Nhiều giá trị cách nhau bằng dấu phẩy

    -- JSON (MySQL 5.7+)
    '{"name": "John Doe", "age": 30, "hobbies": ["reading", "coding"], "active": true}'
);

-- ========================================================================
-- THỬ NGHIỆM CÁC GIÁ TRỊ HỢP LỆ KHÁC
-- ========================================================================
-- Thêm dòng thứ hai để kiểm tra các giá trị đặc biệt
INSERT INTO full_data_types_demo (
    tinyint_col, tinyint_unsigned,
    smallint_col, mediumint_col, int_col, bigint_col, bigint_unsigned,
    decimal_col, numeric_col,
    float_col, double_col, double_precision,
    bit_col,
    date_col, time_col, datetime_col, timestamp_col, year_col,
    char_col, varchar_col, text_col, tinytext_col, mediumtext_col, longtext_col,
    binary_col, varbinary_col, blob_col, tinyblob_col, mediumblob_col, longblob_col,
    status_enum, permissions_set,
    json_col
) VALUES (
    -128,           -- TINYINT min
    0,              -- TINYINT UNSIGNED min
    -32768,         -- SMALLINT min
    -8388608,       -- MEDIUMINT min
    -2147483648,    -- INT min
    -9223372036854775808, -- BIGINT min
    0,              -- BIGINT UNSIGNED min

    0.00,           -- DECIMAL min
    0.0000,         -- NUMERIC min

    0.0,            -- FLOAT
    0.0,            -- DOUBLE
    0.0,            -- DOUBLE PRECISION

    b'00000000',    -- Bit zero

    '1901-01-01',   -- DATE min
    '00:00:00',     -- TIME min
    '1901-01-01 00:00:00', -- DATETIME min
    '1970-01-01 00:00:00', -- TIMESTAMP min (epoch)
    1901,           -- YEAR min

    'A',            -- CHAR(10) chỉ 1 ký tự → còn 9 space
    '',             -- VARCHAR rỗng
    '',             -- TEXT rỗng
    '',             -- TINYTEXT rỗng
    '',             -- MEDIUMTEXT rỗng
    '',             -- LONGTEXT rỗng

    x'00000000000000000000', -- BINARY 10 byte zero
    x'',            -- VARBINARY rỗng
    x'',            -- BLOB rỗng
    x'',            -- TINYBLOB rỗng
    x'',            -- MEDIUMBLOB rỗng
    x'',            -- LONGBLOB rỗng

    'pending',      -- ENUM khác
    'read,delete',  -- SET khác
    '{"config": {"theme": "dark", "notifications": false}, "version": "1.0"}'
);

-- ========================================================================
-- KIỂM TRA DỮ LIỆU VỪA CHÈN
-- ========================================================================
SELECT 
    id,
    tinyint_col AS t_int, tinyint_unsigned AS t_uint,
    smallint_col, mediumint_col, int_col, bigint_col, bigint_unsigned,
    decimal_col, numeric_col,
    float_col, double_col, double_precision,
    BIN(bit_col) AS bit_binary, -- Hiển thị dưới dạng nhị phân
    date_col, time_col, datetime_col, timestamp_col, year_col,
    CONCAT('"', char_col, '"') AS char_quoted, -- Để thấy padding
    varchar_col, LEFT(text_col, 50) AS text_preview,
    LEFT(tinytext_col, 20) AS tinytext_preview,
    LEFT(mediumtext_col, 20) AS medtext_preview,
    LEFT(longtext_col, 20) AS longtext_preview,
    HEX(binary_col) AS bin_hex, HEX(varbinary_col) AS varbin_hex,
    HEX(blob_col) AS blob_hex, HEX(tinyblob_col) AS tinyblob_hex,
    HEX(mediumblob_col) AS medblob_hex, HEX(longblob_col) AS longblob_hex,
    status_enum,
    permissions_set,
    json_col
FROM full_data_types_demo;