```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                              GODOT FILE CHEATSHEET (v3.6 / v4.x)                                                      |
|                                      Đọc/ghi file – Dữ liệu thô, mã hóa, nén, CSV, Variant, hash                                        |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [FILE - OPEN & CLOSE] MỞ & ĐÓNG FILE        | [FILE - INFO & CHECK] THÔNG TIN & KIỂM TRA             | [FILE - SEEK & POSITION] CON TRỎ   |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| File.new()                     → tạo mới   | file.is_open()            → file đang mở?              | file.get_position() → vị trí hiện tại|
| file.open(path, READ)          → mở để đọc | file.get_len()            → kích thước (byte)          | file.seek(pos)      → nhảy đến vị trí|
| file.open(path, WRITE)         → mở để ghi | file.get_path()           → đường dẫn tương đối        | file.seek_end()     → đến cuối file |
| file.open(path, READ_WRITE)    → đọc+ghi   | file.get_path_absolute()  → đường dẫn tuyệt đối        | file.eof_reached()  → đã đến cuối?  |
| file.close()                   → đóng file | file.file_exists("p.txt") → file tồn tại?             |                                   |
| file.flush()                   → ghi đệm   | file.get_error()          → lỗi gần nhất              |                                   |
|                                            | file.get_modified_time(path) → thời gian sửa đổi      |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [FILE - STORE] GHI DỮ LIỆU                  | [FILE - GET] ĐỌC DỮ LIỆU                                | [FILE - BUFFER & CSV] MẢNG & CSV  |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| file.store_8(255)              → int 8-bit | file.get_8()                → đọc int 8-bit            | file.store_buffer(PoolByteArray)  |
| file.store_16(65535)           → int 16-bit| file.get_16()               → đọc int 16-bit           | file.get_buffer(len) → đọc byte   |
| file.store_32(4294967295)      → int 32-bit| file.get_32()               → đọc int 32-bit           | file.store_csv_line(arr, ",")     |
| file.store_64(-9223372036854775807)→ int 64| file.get_64()               → đọc int 64-bit           | file.get_csv_line(",") → đọc CSV  |
| file.store_float(3.14)         → float 32  | file.get_float()            → đọc float 32             |                                   |
| file.store_double(3.14159)     → float 64  | file.get_double()           → đọc float 64             |                                   |
| file.store_real(2.718)         → real     | file.get_real()             → đọc real                |                                   |
| file.store_string("text")      → string   | file.get_as_text()          → toàn bộ file (string)    |                                   |
| file.store_line("line\n")      → string + \n| file.get_line()            → đọc một dòng              |                                   |
| file.store_pascal_string("s")  → string + len| file.get_pascal_string()  → đọc chuỗi Pascal          |                                   |
| file.store_var(var, true)      → Variant  | file.get_var(true)          → đọc Variant             |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [FILE - COMPRESS & ENCRYPT] NÉN & MÃ HÓA   | [FILE - HASH] BĂM FILE                                  | [FILE - MISC] KHÁC                |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| file.open_compressed(path, WRITE, ZSTD)   | file.get_md5(path)          → hash MD5 của file        | file.set_endian_swap(true)        |
|  → nén với: ZSTD, LZO, GZIP, FASTLZ        | file.get_sha256(path)       → hash SHA-256 của file   |  → đảo byte order (Big/Little Endian)|
| file.open_encrypted(path, WRITE, key)     |                                                        |                                   |
|  → mã hóa AES-256 (key = PoolByteArray 32B)|                                                        |                                   |
| file.open_encrypted_with_pass(path, WRITE, "pass")|                                                  |                                   |
|  → mã hóa bằng mật khẩu                    |                                                        |                                   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 📁 Luôn gọi file.close() sau khi mở – tốt nhất nên dùng với if/else hoặc _exit để đảm bảo đóng.                                        |
| • 🔐 Mã hóa chỉ an toàn ở mức cơ bản – không chống được người dùng tinh vi (mod file, dump memory).                                      |
| • 🧩 Nén phù hợp để giảm kích thước file save, log, hoặc dữ liệu mạng.                                                                  |
| • 📦 store_var() / get_var() hỗ trợ mọi kiểu Godot: Dictionary, Array, Object, v.v. – rất tiện cho lưu trạng thái.                      |
| • 🔍 Con trỏ file (seek) rất quan trọng khi đọc/ghi dữ liệu nhị phân có cấu trúc.                                                       |
| • 🧮 MD5/SHA-256 dùng để kiểm tra tính toàn vẹn file (ví dụ: save file có bị sửa không?).                                                |
| • 🌐 Dữ liệu nhị phân (store_*, get_*) cần đúng thứ tự byte – dùng set_endian_swap() nếu cần tương thích nền tảng.                      |
+----------------------------------------------------------------------------------------------------------------------------------------+
```