```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                       GODOT FILE & CONFIG CHEATSHEET (v3.6 / v4.x)                                                     |
|                                 Quản lý cấu hình, tệp tin, thư mục – Lưu trữ & truy xuất dữ liệu                                        |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [CONFIGFILE - CREATE & SAVE] TẠO & LƯU     | [CONFIGFILE - LOAD & PARSE] ĐỌC & PHÂN TÍCH           | [CONFIGFILE - DATA] QUẢN LÝ DỮ LIỆU |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| ConfigFile.new()               → tạo mới   | config.load("path.cfg")        → tải file thường      | config.get_sections() → danh sách section|
| config.save("user://cfg.cfg")  → lưu thường| config.load_encrypted("...", key) → tải mã hóa (AES)  | config.has_section("Player") → tồn tại?|
| config.save_encrypted("...", key)→ mã hóa  | config.load_encrypted_pass("...", "pass") → bằng pass| config.get_section_keys("Player") → keys|
|  → dùng PoolByteArray (32 byte)            | config.parse("[sec]\nkey=value") → từ chuỗi          | config.get_value("P", "name", "Anon")|
| config.save_encrypted_pass("...", "pass")  |                                                        |  → lấy giá trị + mặc định         |
|  → mã hóa bằng mật khẩu                    |                                                        | config.set_value("P", "score", 100)|
|                                            |                                                        |  → lưu giá trị bất kỳ kiểu        |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [DIRECTORY - INIT & INFO] KHỞI TẠO & TTIN  | [DIRECTORY - LIST & CHECK] LIỆT KÊ & KIỂM TRA         | [DIRECTORY - FILE OPS] THAO TÁC TỆP|
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Directory.new()              → tạo mới     | thu_muc.open("user://")       → mở thư mục           | thu_muc.make_dir("data") → tạo thư mục|
| thu_muc.get_current_dir()    → thư mục hiện tại| thu_muc.list_dir_begin(true,true) → bắt đầu liệt kê| thu_muc.make_dir_recursive(...) → tạo đầy đủ|
| thu_muc.get_current_drive()  → ổ hiện tại  | thu_muc.get_next()           → lấy tên tiếp theo     | thu_muc.copy(src, dst) → sao chép|
| thu_muc.get_drive_count()    → số ổ đĩa    | thu_muc.list_dir_end()       → kết thúc liệt kê      | thu_muc.rename(old, new) → đổi tên|
| thu_muc.get_drive(0)         → tên ổ 0     | thu_muc.dir_exists("data/")  → thư mục tồn tại?      | thu_muc.remove("file.txt") → xóa  |
| thu_muc.get_space_left()     → dung lượng trống| thu_muc.file_exists("f.txt") → file tồn tại?       |                                   |
|                                            | thu_muc.current_is_dir()     → mục hiện tại là thư mục?|                               |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔐 Dùng save_encrypted() hoặc save_encrypted_pass() để bảo vệ dữ liệu người chơi (lưu ý: không chống được mod file mạnh).              |
| • 🔑 Khóa AES-256 phải là PoolByteArray đúng 32 byte.                                                                                 |
| • 📁 Đường dẫn user:// trỏ đến thư mục dữ liệu người dùng (persistent), rất an toàn để lưu.                                            |
| • ⚠️ make_dir() chỉ tạo 1 cấp – dùng make_dir_recursive() để tạo nhiều cấp (như mkdir -p).                                              |
| • 🔄 copy() và rename() hỗ trợ cả file và thư mục (nếu rỗng).                                                                           |
| • 🧹 remove() chỉ xóa file hoặc thư mục rỗng – dùng DirAccess hoặc OS để xóa thư mục có nội dung.                                       |
| • 📜 ConfigFile hỗ trợ mọi kiểu dữ liệu Godot: int, float, String, Vector2, Array, Dictionary, v.v.                                     |
+----------------------------------------------------------------------------------------------------------------------------------------+
```