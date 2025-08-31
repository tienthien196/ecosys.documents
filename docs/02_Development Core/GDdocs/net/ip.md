```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                         GODOT MARSHALLS & IP CHEATSHEET (v3.6 / v4.5)                                                 |
|                             Mã hóa dữ liệu & Phân giải IP – Truyền tải, lưu trữ, kết nối mạng an toàn                                  |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [MARSHALLS - ENCODE] MÃ HÓA DỮ LIỆU         | [MARSHALLS - DECODE] GIẢI MÃ DỮ LIỆU                  | [MARSHALLS - VARIANT] XỬ LÝ BIẾN   |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Marshalls.raw_to_base64(b) → mã hóa byte   | Marshalls.base64_to_raw(b64) → giải mã byte          | Marshalls.variant_to_base64(v, obj)|
|  → PoolByteArray → Base64                   |                                                        |  → mã hóa Variant (kể cả object*)  |
| Marshalls.utf8_to_base64(s) → mã hóa chuỗi | Marshalls.base64_to_utf8(b64) → giải mã chuỗi        | Marshalls.base64_to_variant(b64, obj)|
|  → String → Base64                          |                                                        |  → giải mã Variant (kể cả object*) |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [IP - RESOLVE] PHÂN GIẢI DNS                | [IP - ASYNC] PHÂN GIẢI BẤT ĐỒNG BỘ                   | [IP - INFO] THÔNG TIN MẠNG         |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| IP.resolve_hostname(host, TYPE_ANY)        | IP.resolve_hostname_queue_item(host, type) → id      | IP.get_local_addresses() → danh sách IP cục bộ|
|  → trả về IP đầu tiên (đồng bộ)             | IP.get_resolve_item_status(id) → trạng thái         | IP.get_local_interfaces() → chi tiết card mạng|
| IP.resolve_hostname_addresses(host, type)  | IP.get_resolve_item_address(id) → IP đơn            |                                   |
|  → trả về tất cả IP (mảng)                  | IP.get_resolve_item_addresses(id) → mảng IP         |                                   |
|                                            | IP.poll() → xử lý phân giải (nếu dùng thread)        |                                   |
|                                            | IP.erase_resolve_item(id) → dọn dẹp hàng đợi         |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔐 Marshalls dùng Base64 – không mã hóa! Chỉ biến đổi dữ liệu thành chuỗi an toàn để truyền/lưu.                                       |
| • 🧩 variant_to_base64() rất mạnh: hỗ trợ Dictionary, Array, Object – nhưng cẩn thận khi mã hóa Node, SceneTree.                          |
| • ⚠️ Cho phép mã hóa object (allow_object=true) có thể gây lỗi bảo mật – chỉ dùng khi tin tưởng dữ liệu.                                |
| • 🌐 IP.resolve_hostname() đồng bộ – không dùng trong _process nếu sợ giật. Dùng queue_item cho bất đồng bộ.                             |
| • 🔄 IP.poll() cần gọi định kỳ nếu dùng threaded resolver – thường đặt trong _process().                                                 |
| • 🧹 Luôn gọi IP.erase_resolve_item(id) sau khi xong để giải phóng tài nguyên.                                                          |
| • 🧹 IP.clear_cache() giúp thử lại khi phân giải lỗi – hữu ích khi debug mạng.                                                          |
| • 📦 Dữ liệu từ Marshalls + Crypto → kết hợp hoàn hảo để lưu save an toàn hoặc gửi qua mạng.                                            |
+----------------------------------------------------------------------------------------------------------------------------------------+
```