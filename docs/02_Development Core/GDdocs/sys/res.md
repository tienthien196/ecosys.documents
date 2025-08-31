```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT RESOURCE & PCK CHEATSHEET (v3.6 / v4.x)                                                 |
|                              Tải, lưu, đóng gói tài nguyên – Quản lý dữ liệu game hiệu quả                                             |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [RESOURCELOADER - LOAD] TẢI TÀI NGUYÊN      | [RESOURCELOADER - INFO] THÔNG TIN & KIỂM TRA           | [RESOURCELOADER - INTERACTIVE] TẢI TƯƠNG TÁC|
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| ResourceLoader.load("res://icon.png")      | ResourceLoader.exists(path) → tài nguyên tồn tại?     | ResourceLoader.load_interactive(p)|
|  → tải ngay (blocking)                     | ResourceLoader.has_cached(path) → đã cache chưa?      |  → trả về ResourceInteractiveLoader|
|                                            | ResourceLoader.get_dependencies(path) → danh sách phụ thuộc| interactive_loader.poll()     |
|                                            | ResourceLoader.get_recognized_extensions_for_type(t)  |  → tải từng phần (dùng trong _process)|
|                                            |  → đuôi file hỗ trợ cho loại tài nguyên               | interactive_loader.get_stage()  |
|                                            |                                                        |  → giai đoạn hiện tại             |
|                                            |                                                        | interactive_loader.get_resource()|
|                                            |                                                        |  → lấy tài nguyên sau khi xong   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [RESOURCESAVER - SAVE] LƯU TÀI NGUYÊN       | [PCKPACKER - CREATE] TẠO GÓI PCK                      | [PCKPACKER - USE] SỬ DỤNG GÓI PCK |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| ResourceSaver.save("path.tres", resource)  | PCKPacker.new()              → tạo mới                | ProjectSettings.load_resource_pack("pack.pck")|
|  → lưu tài nguyên ra file                   | packer.pck_start("out.pck", ver) → bắt đầu gói       |  → tải gói tài nguyên vào hệ thống|
| ResourceSaver.get_recognized_extensions(r)|  → khởi tạo file .pck                                 | File.file_exists("res://in_pack.txt")|
|  → lấy danh sách đuôi hỗ trợ (.tres, .res) | packer.add_file("res://a.txt", "user://data.txt")    |  → kiểm tra file trong gói        |
|                                            |  → thêm file vào gói (trong PCK → từ hệ thống)         | packer.flush(true)               |
|                                            | packer.flush(true)         → ghi dữ liệu vào file     |  → ghi dữ liệu (verbose = true)   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔁 ResourceLoader.load() dùng cho tải nhanh; dùng load_interactive() khi cần thanh tiến trình hoặc tránh giật.                          |
| • 🧠 has_cached() giúp tránh tải lại tài nguyên đã có trong bộ nhớ.                                                                     |
| • 📦 ResourceSaver.FLAG_RELATIVE_PATHS → giữ đường dẫn tương đối; FLAG_BUNDLE_RESOURCES → nhúng tài nguyên phụ.                          |
| • 🔐 PCK không mã hóa – chỉ đóng gói. Dùng mã hóa riêng nếu cần bảo vệ nội dung.                                                        |
| • 🔄 flush() cần gọi để hoàn tất việc ghi gói PCK – nếu không, file sẽ trống hoặc hỏng.                                                 |
| • 📁 load_resource_pack() thêm đường dẫn ảo res:// → các file trong PCK có thể truy cập như file bình thường.                           |
| • ⚠️ PCKPacker không hỗ trợ ghi đè – nếu file .pck đã tồn tại, cần xóa trước khi tạo lại.                                              |
+----------------------------------------------------------------------------------------------------------------------------------------+
```