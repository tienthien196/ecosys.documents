```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT INPUT SYSTEM CHEATSHEET (v3.6 / v4.x)                                                  |
|                               Xử lý sự kiện người dùng: Phím, Chuột, Action, Modifier, Stylus                                          |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [INPUT - BASE EVENT] SỰ KIỆN CƠ BẢN         | [INPUT - MODIFIERS] PHÍM CHỨC NĂNG                    | [INPUT - ACTION] HÀNH ĐỘNG          |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| event.get_device()       → thiết bị (0=KB) | event.get_shift()       → Shift đang nhấn?            | event.is_action("jump") → khớp action?|
| event.set_device(0)      → gán thiết bị    | event.get_control()     → Ctrl đang nhấn?             | event.is_action_pressed("jump") → nhấn?|
| event.as_text()          → tên event (str) | event.get_alt()         → Alt đang nhấn?              | event.is_action_released("jump") → nhả?|
| event.is_pressed()       → đang nhấn?      | event.get_command()     → Cmd (Mac)                  | event.get_action_strength("move") → 0~1|
| event.is_released()      → đã nhả?         | event.get_metakey()     → Meta (Windows key)          | InputMap.add_action("fire")       |
| event.is_canceled()      → bị hủy?         | event.set_shift(true)   → giả lập nhấn Shift         | InputMap.action_add_event("fire", key)|
| event.is_echo()          → lặp phím (0.5s)| event.set_control(true) → giả lập Ctrl               |                                   |
| event.is_action_type()   → là action?      |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [INPUT - KEYBOARD] BÀN PHÍM                 | [INPUT - MOUSE BUTTON] NÚT CHUỘT                      | [INPUT - MOUSE MOTION] DI CHUYỂN   |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| InputEventKey.new()      → tạo event phím  | InputEventMouseButton.new() → tạo event nút chuột     | InputEventMouseMotion.new() → tạo|
| event.scancode = KEY_A   → mã phím (layout)| event.button_index = BUTTON_LEFT                     | event.position = Vector2(300,200) |
| event.physical_scancode  → vị trí vật lý   | event.pressed = true     → trạng thái nhấn           | event.relative = Vector2(10, -5)  |
| event.unicode = 'A'      → ký tự Unicode   | event.doubleclick = true → click đúp?                | event.speed = Vector2(100, 80)    |
| event.is_echo()          → lặp phím?       | event.factor = 1.0       → hệ số cuộn (wheel)         | event.pressure = 0.7             |
|                                            | event.canceled = false   → bị hủy?                    | event.tilt = Vector2(0.3, -0.2)   |
|                                            |                                                        | event.pen_inverted = false        |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [INPUT - EVENT CONTROL] ĐIỀU KHIỂN SỰ KIỆN | [INPUT - UTILITY] TIỆN ÍCH                            | [INPUT - ENUMS] HẰNG SỐ           |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| event.shortcut_match(e2) → so sánh event   | OS.get_scancode_string(code) → tên phím từ scancode   | MouseButton:                     |
| event.accumulate(e2)     → gộp di chuyển   | event.xformed_by(transform) → biến đổi vị trí chuột   |  BUTTON_LEFT = 1                 |
| event.xformed_by(...)    → xoay/dịch chuột| Input.parse_input_event(event) → gửi event giả lập   |  BUTTON_RIGHT = 2                |
|                                            |                                                        |  BUTTON_MIDDLE = 3               |
|                                            |                                                        |  BUTTON_WHEEL_UP = 4             |
|                                            |                                                        |  BUTTON_WHEEL_DOWN = 5           |
|                                            |                                                        |  BUTTON_XBUTTON1 = 6             |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • ❗ Chỉ xử lý input trong _input(event) hoặc _unhandled_input(event) — không nên dùng _process.                                          |
| • Dùng InputMap để ánh xạ phím/mouse thành action (move, jump, fire) — dễ cấu hình và thay đổi.                                          |
| • event.relative trong InputEventMouseMotion rất hữu ích để điều khiển camera, vẽ, hoặc drag.                                           |
| • pressure và tilt chỉ có hiệu lực với bút stylus (tablet, iPad, Surface).                                                             |
| • parse_input_event() dùng để giả lập input (test, replay, remote control).                                                            |
| • Tốt nhất nên dùng is_action_pressed() thay vì kiểm tra keycode trực tiếp — để hỗ trợ tay cầm, remap.                                  |
+----------------------------------------------------------------------------------------------------------------------------------------+
```