```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT PROJECTSETTINGS CHEATSHEET (v3.6 / v4.x)                                                |
|                                Cấu hình toàn cục dự án – Từ UI, Vật lý, Hiển thị đến Gỡ lỗi                                            |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [APP - APPLICATION] ỨNG DỤNG                | [APP - RUN] CHẠY & XUẤT RA                            | [GUI - INTERFACE] GIAO DIỆN       |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| application/config/name → tên dự án        | application/run/disable_stdout → tắt stdout          | gui/common/swap_ok_cancel → hoán đổi nút OK/Cancel|
| application/config/version → phiên bản    | application/run/disable_stderr → tắt stderr          | gui/theme/custom → theme tùy chỉnh|
| application/config/description → mô tả     |                                                        | gui/theme/use_hidpi → bật HiDPI  |
| application/config/icon → icon dự án       |                                                        | gui/timers/tooltip_delay_sec → trễ tooltip|
| application/config/project_settings_override → file ghi đè|                                         | gui/common/text_edit_undo_stack_max_size → undo stack|
| application/config/use_hidden_project_data_directory → dùng .import ẩn|                            | gui/common/version_string → phiên bản GUI|
| application/config/use_custom_user_dir → dùng thư mục người dùng tùy chỉnh|                        | gui/common/texture_anisotropic_filter → lọc anisotropic|
| application/config/custom_user_dir_name → tên thư mục người dùng|                                 |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [PHYSICS - 2D/3D] VẬT LÝ                   | [DISPLAY - WINDOW] HIỂN THỊ & CỬA SỔ                 | [SUBWINDOW] CỬA SỔ PHỤ            |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| physics/2d/physics_engine → engine 2D      | display/window/stretch/mode → chế độ stretch         | display/window/subwindows/allow_drags → kéo thả|
| physics/2d/default_gravity → trọng lực Y   | display/window/stretch/aspect → tỷ lệ stretch        | allow_reordering → sắp xếp lại   |
| physics/2d/default_gravity_vector → hướng  | display/window/stretch/use_integer_zoom → zoom nguyên| allow_input_passthrough → chuột xuyên|
| physics/2d/sleep_threshold_linear → ngưỡng tuyến tính| display/window/handheld/orientation → hướng mặc định| allow_close → cho phép đóng     |
| physics/2d/sleep_threshold_angular → ngưỡng góc| display/window/handheld/vsync_to_texture → VSync texture| allow_resize → resize          |
| physics/common/physics_fps → FPS vật lý    | display/window/per_pixel_transparency/enabled → trong suốt pixel| allow_minimize → thu nhỏ     |
| physics/common/enable_object_picking → pick vật|                                                    | allow_maximize → phóng to        |
| physics/common/physics_interpolation → nội suy|                                                      | allow_move → di chuyển           |
| world/2d/cell_size → kích thước ô lưới     |                                                        | allow_focus → focus              |
| world/2d/execution_below_fps → xử lý khi FPS thấp|                                                  | allow_close_on_escape → đóng bằng Escape|
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [DEBUG] GỠ LỖI & PROFILING                | [AUDIO] ÂM THANH                                       | [INPUT] ĐIỀU KHIỂN NGƯỜI DÙNG     |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| debug/gdscript/warnings/enable → bật cảnh báo| audio/general/driver → trình điều khiển âm thanh     | input/ui_accept → nút chấp nhận  |
| debug/gdscript/warnings/exclude_addons → bỏ qua addons|                                              | input/ui_cancel → nút hủy        |
| debug/gdscript/completion/autocomplete_setters_and_getters → tự động hoàn thành|                   | input/ui_up/down/left/right → điều hướng|
| debug/settings/stdout/print_fps → in FPS   |                                                        | input/ui_back/menu → back/menu   |
| debug/settings/stdout/verbose_stdout → verbose mode|                                                 | input/devices/enable_mouse_warp → warp chuột|
| debug/settings/fps/force_fps → buộc FPS    |                                                        | input/pointing/emulate_touch_from_mouse → giả lập chạm|
| debug/settings/profiler/max_functions → giới hạn hàm profiler|                                     |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [EDITOR] BIÊN TẬP & [LOGGING] GHI NHẬT KÝ   | [WORLD] MÔI TRƯỜNG & HIỆU SUẤT                        | [ADVANCED] NÂNG CAO               |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| editor/script_templates_search_path → thư mục template| world/2d/padding_margin → viền padding camera| logging/file_logging/enable_file_logging → ghi log vào file|
| logging/file_logging/log_path → đường dẫn log|                                                        | logging/file_logging/log_path → file log|
|                                            |                                                        |                                   |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • ProjectSettings là singleton – truy cập mọi lúc bằng ProjectSettings.get_setting(key).                                                |
| • Các cài đặt có thể được ghi đè bằng file project.godot hoặc qua CLI khi chạy.                                                         |
| • Một số cài đặt chỉ có hiệu lực khi khởi động lại editor hoặc game (ví dụ: driver, stretch mode).                                      |
| • Dùng input/ui_* để hỗ trợ đa nền tảng – người chơi có thể dùng phím, tay cầm, hoặc chuột cho UI.                                       |
| • physics_interpolation giúp mượt hơn trên màn hình có tần số quét cao – bật nếu có hiện tượng giật.                                    |
| • allow_close_on_escape rất tiện cho popup/dialog – người dùng dễ đóng cửa sổ.                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------+
```