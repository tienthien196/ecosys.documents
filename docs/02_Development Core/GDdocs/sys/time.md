```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                         GODOT TIME & DATE CHEATSHEET (v3.6 / v4.x)                                                    |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [TIME - SYSTEM] LẤY THỜI GIAN HỆ THỐNG     | [TIME - UNIX → FORMAT] CHUYỂN TỪ UNIX TIME             | [TIME - STRING/DICT] CHUỖI & DICT |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Time.get_date_dict_from_system()           | Time.get_date_dict_from_unix_time(unix) → dict       | Time.get_datetime_dict_from_     |
|  → Ngày hệ thống (dict)                    | Time.get_time_dict_from_unix_time(unix) → dict       |   datetime_string(str, utc)       |
| Time.get_time_dict_from_system()           | Time.get_datetime_dict_from_unix_time(unix) → dict   |  → dict từ chuỗi "YYYY-MM-DDTHH:MM"|
|  → Giờ hệ thống (dict)                     | Time.get_date_string_from_unix_time(unix) → str      | Time.get_datetime_string_from_    |
| Time.get_datetime_dict_from_system()       | Time.get_time_string_from_unix_time(unix) → str      |   datetime_dict(dict, utc)        |
|  → Ngày+giờ (dict)                         | Time.get_datetime_string_from_unix_time(unix, utc)   |  → chuỗi từ dict                   |
| Time.get_date_string_from_system()         |  → Chuỗi ngày giờ từ Unix                             |                                   |
|  → Ngày (chuỗi YYYY-MM-DD)                 |                                                        |                                   |
| Time.get_time_string_from_system()         |                                                        |                                   |
|  → Giờ (chuỗi HH:MM:SS)                    |                                                        |                                   |
| Time.get_datetime_string_from_system()     |                                                        |                                   |
|  → Ngày giờ (chuỗi)                        |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [TIME - CONVERSION] CHUYỂN ĐỔI & HỖ TRỢ   | [TIME - TICKS] THỜI GIAN KỂ TỪ KHỞI ĐỘNG             | [TIME - TIMEZONE] MÚI GIỜ         |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Time.get_unix_time_from_datetime_dict(dict)| Time.get_ticks_msec() → mili giây kể từ khởi động     | Time.get_time_zone_from_system() |
|  → Unix từ dict                            | Time.get_ticks_usec() → micro giây kể từ khởi động   |  → Thông tin múi giờ hệ thống     |
| Time.get_unix_time_from_datetime_string(str)|                                                        | Time.get_offset_string_from_     |
|  → Unix từ chuỗi                           |                                                        |   offset_minutes(mins)            |
|                                            |                                                        |  → Chuỗi offset (ví dụ: "+07:00") |
|                                            |                                                        |                                   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • Các hàm `Time.*` hoạt động trên cả Godot 3.6 và 4.x (có thể khác namespace ở v4).                                                    |
| • `OS.get_unix_time()` trả về timestamp hiện tại (integer).                                                                            |
| • `utc = true/false`: chọn múi giờ UTC hay local.                                                                                      |
| • Dùng `get_ticks_*()` để đo hiệu năng, delay, debounce — không phụ thuộc vào thời gian hệ thống.                                       |
+----------------------------------------------------------------------------------------------------------------------------------------+
```