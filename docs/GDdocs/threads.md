```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                      GODOT THREADING CHEATSHEET (v3.6 / v4.x)                                                         |
|                                Đa luồng, Đồng bộ hóa: Mutex, Semaphore – An toàn & Hiệu suất                                           |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [THREAD - CORE] QUẢN LÝ LUỒNG               | [THREAD - INFO & CONTROL] THÔNG TIN & KIỂM SOÁT        | [THREAD - STATIC] HÀM TĨNH         |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Thread.new()                   → tạo mới   | thread.is_active()       → đã start chưa?             | Thread.is_main_thread()          |
| thread.start(obj, method, data, prio)      | thread.is_alive()        → đang chạy?                 |  → Có phải luồng chính không?     |
|  → bắt đầu luồng với dữ liệu, ưu tiên       | thread.get_id()          → ID duy nhất (string)       |                                   |
| thread.wait_to_finish()        → chờ xong  | thread.call_deferred(...)→ gọi an toàn từ thread     |                                   |
|                                            | thread.kill()            → (⚠️ nguy hiểm) dừng thread |                                   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [MUTEX - ĐỒNG BỘ HÓA] Khóa truy cập         | [SEMAPHORE - QUẢN LÝ TÀI NGUYÊN] Dùng chung tài nguyên | [PRIORITY] ƯU TIÊN LUỒNG          |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Mutex.new()                    → tạo mới   | Semaphore.new()           → tạo mới (giá trị = 0)       | Thread.PRIORITY_LOW     → thấp   |
| mutex.lock()                   → khóa, chờ  | semaphore.wait()          → chờ tài nguyên (trừ 1)     | Thread.PRIORITY_NORMAL  → bình thường|
| mutex.try_lock()               → thử khóa   | semaphore.try_wait()      → thử lấy tài nguyên       | Thread.PRIORITY_HIGH    → cao    |
|  → trả về OK nếu thành công                  | semaphore.post()          → trả lại tài nguyên (+1)  |                                   |
| mutex.unlock()                 → giải phóng |                                                        |                                   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • ❗ Không bao giờ gọi Node, SceneTree, hay hàm vẽ từ thread con — dùng call_deferred() hoặc signal.                                     |
| • Mutex dùng để bảo vệ dữ liệu chung (ví dụ: biến toàn cục).                                                                           |
| • Semaphore dùng để giới hạn số luồng truy cập tài nguyên (ví dụ: 2 luồng được xử lý cùng lúc).                                        |
| • wait_to_finish() chặn luồng chính — chỉ dùng khi thực sự cần kết quả ngay.                                                           |
| • Ưu tiên (priority) ảnh hưởng đến thứ tự lập lịch, nhưng không đảm bảo trên mọi hệ điều hành.                                          |
| • Dùng try_lock() hoặc try_wait() để tránh deadlock trong logic phức tạp.                                                              |
+----------------------------------------------------------------------------------------------------------------------------------------+
```