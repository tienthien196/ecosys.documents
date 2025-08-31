```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT INPUTMAP & INPUT CHEATSHEET (v3.6 / v4.5)                                               |
|                             Quản lý hành động, điều khiển toàn cục, tay cầm, con trỏ & cảm biến                                        |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [INPUTMAP - ACTION] QUẢN LÝ HÀNH ĐỘNG        | [INPUTMAP - EVENT & DEADZONE] SỰ KIỆN & VÙNG CHẾT     | [INPUTMAP - CONFIG] CẤU HÌNH       |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| InputMap.has_action("jump")  → tồn tại?    | InputMap.get_action_list("move") → danh sách event   | InputMap.add_action("jump", 0.2)  |
| InputMap.add_action("jump")  → thêm mới    | InputMap.action_has_event(act, ev) → có event không? |  → thêm hành động + deadzone      |
| InputMap.erase_action("jump")→ xóa hành động| InputMap.action_add_event(act, ev) → gán event       | InputMap.action_set_deadzone(a,z) |
| InputMap.get_actions()       → tất cả action| InputMap.action_erase_event(act, ev) → xóa event     |  → thiết lập vùng chết            |
|                                            | InputMap.action_erase_events("fire") → xóa tất cả    | InputMap.action_get_deadzone(a)   |
|                                            | InputMap.event_is_action(ev, "ui_accept", false)     |  → lấy deadzone hiện tại          |
|                                            |  → kiểm tra event có phải action?                    | InputMap.load_from_globals()     |
|                                            |                                                        |  → tải lại từ ProjectSettings    |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [INPUT - ACTION] KIỂM TRA HÀNH ĐỘNG         | [INPUT - KEY & MOUSE] PHÍM & CHUỘT                  | [INPUT - CURSOR] CON TRỎ CHUỘT   |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Input.is_action_pressed("jump")     → nhấn?| Input.is_key_pressed(KEY_A)       → nhấn phím?       | Input.set_default_cursor_shape(s) |
| Input.is_action_just_pressed("jump")→ vừa nhấn?| Input.is_physical_key_pressed(KEY_A) → theo vị trí|  → đặt kiểu con trỏ mặc định      |
| Input.is_action_just_released("jump")→ vừa nhả?| Input.is_mouse_button_pressed(BUTTON_LEFT) → chuột| Input.get_current_cursor_shape() |
| Input.get_action_strength("move")   → cường độ| Input.get_mouse_button_mask()   → bitmask nút đang nhấn|  → lấy kiểu hiện tại             |
| Input.get_action_raw_strength("move")→ raw  | Input.warp_mouse_position(pos)    → di chuyển chuột  | Input.set_custom_mouse_cursor(img, shape, hotspot)|
| Input.get_axis("left","right")      → trục (-1~1)| Input.get_last_mouse_speed()  → vận tốc chuột     |  → đặt con trỏ tùy chỉnh (PNG/SVG)|
| Input.get_vector("l","r","u","d",dz)→ vector2|                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [INPUT - JOYPAD] TAY CẦM & RUNG             | [INPUT - JOY MAPPING] ÁNH XẠ TAY CẦM                  | [INPUT - SENSORS] CẢM BIẾN (Mobile)|
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Input.is_joy_button_pressed(id, btn) → nút?| Input.add_joy_mapping(mapping, true) → thêm mapping   | Input.set_accelerometer(vec)     |
| Input.get_joy_axis(id, axis)       → trục   | Input.remove_joy_mapping(guid)    → xóa mapping      |  → giả lập gia tốc kế            |
| Input.get_joy_name(id)             → tên    | Input.get_joy_guid(id)          → GUID thiết bị      | Input.set_gravity(vec)           |
| Input.get_connected_joypads()      → danh sách| Input.get_joy_axis_string(0)    → "leftx"           |  → giả lập trọng lực             |
| Input.joy_connection_changed(...)  → sự kiện| Input.get_joy_button_string(0)  → "a"               | Input.set_gyroscope(vec)         |
|                                            | Input.get_joy_axis_index_from_string("leftx") → 0   |  → giả lập con quay hồi chuyển   |
|                                            | Input.get_joy_button_index_from_string("a") → 0     | Input.set_magnetometer(vec)      |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [INPUT - VIBRATION] RUNG & PHẢN HỒI         | [INPUT - MISC] KHÁC                                   | [INPUT - ENUMS] HẰNG SỐ           |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Input.start_joy_vibration(id, weak, strong, dur)| → rung tay cầm (0~1)                            | MouseMode:                         |
| Input.stop_joy_vibration(id)       → dừng   | Input.action_press("jump", 1.0) → giả lập nhấn      |  MOUSE_MODE_VISIBLE = 0           |
| Input.vibrate_handheld(500)        → rung mobile (ms)| Input.action_release("jump") → giả lập nhả     |  MOUSE_MODE_HIDDEN = 1            |
| Input.get_joy_vibration_duration(id)→ thời gian còn lại| Input.flush_buffered_events() → xóa event chờ|  MOUSE_MODE_CAPTURED = 2          |
| Input.get_joy_vibration_strength(id)→ cường độ rung| Input.parse_input_event(ev) → gửi event giả lập|  MOUSE_MODE_CONFINED = 3          |
|                                            |                                                        |  MOUSE_MODE_CONFINED_HIDDEN = 4   |
|                                            |                                                        |                                   |
|                                            |                                                        | CursorShape:                     |
|                                            |                                                        |  CURSOR_ARROW, IBEAM, POINTING_HAND,...|
|                                            |                                                        |  (xem danh sách đầy đủ bên dưới)  |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • InputMap dùng để định nghĩa hành động (action) như "jump", "ui_accept" — độc lập với thiết bị đầu vào.                                |
| • Dùng get_action_*() thay vì kiểm tra phím trực tiếp — để hỗ trợ remap, tay cầm, controller.                                           |
| • Deadzone rất quan trọng với joystick — tránh drift khi tay cầm không về 0 hoàn toàn.                                                  |
| • set_custom_mouse_cursor() hỗ trợ PNG, SVG — hotspot là điểm nhấp (ví dụ: đầu kim).                                                    |
| • warp_mouse_position() + MOUSE_MODE_CAPTURED → dùng để khóa chuột giữa màn hình (FPS, camera xoay).                                    |
| • Các hàm cảm biến (accelerometer, gyroscope) chỉ ảnh hưởng đến Input — dùng để test hoặc giả lập trên PC.                              |
| • add_joy_mapping() dùng để hỗ trợ tay cầm không chuẩn (theo chuẩn SDL2 Game Controller).                                               |
+----------------------------------------------------------------------------------------------------------------------------------------+
```