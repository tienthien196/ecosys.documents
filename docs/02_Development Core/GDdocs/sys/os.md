```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                               GODOT OS CHEATSHEET (v3.6 / v4.x)                                                       |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [OS - DEVICE INFO] THIẾT BỊ & PHẦN CỨNG     | [OS - SYSTEM INFO] HỆ THỐNG & MÔI TRƯỜNG               | [OS - TIME & TICKS] THỜI GIAN     |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| OS.get_model_name()        → tên thiết bị  | OS.get_name()             → tên HĐH (Windows, Linux)   | OS.get_ticks_msec()    → tick (ms)|
| OS.get_unique_id()         → ID duy nhất   | OS.get_locale()           → locale hệ thống (vi_VN)    | OS.get_ticks_usec()    → tick (μs)|
| OS.get_processor_count()   → số lõi CPU    | OS.get_locale_language()  → ngôn ngữ (vi, en)         | OS.get_splash_tick_msec()→ splash|
| OS.get_processor_name()    → tên CPU       | OS.has_environment("HOME")→ có biến môi trường?       | OS.get_system_time_msecs() → sys |
| OS.get_power_percent_left()→ % pin còn lại | OS.get_environment("HOME")→ giá trị biến             | OS.get_system_time_secs()  → sys |
| OS.get_power_seconds_left()→ thời lượng pin| OS.set_environment("K","V")→ đặt biến môi trường      | OS.get_unix_time()       → Unix  |
| OS.get_power_state()       → trạng thái pin| OS.get_executable_path()  → đường dẫn thực thi        | OS.get_datetime_from_unix_time(t)|
|                                            | OS.get_cache_dir()        → thư mục cache             | OS.get_unix_time_from_datetime(d)|
|                                            | OS.get_config_dir()       → cấu hình người dùng       |                                   |
|                                            | OS.get_data_dir()         → dữ liệu toàn cục          |                                   |
|                                            | OS.get_user_data_dir()    → user://                  |                                   |
|                                            | OS.get_system_dir(...)    → thư mục hệ thống          |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [OS - WINDOW] QUẢN LÝ CỬA SỔ                | [OS - DISPLAY] MÀN HÌNH & HIỂN THỊ                    | [OS - INPUT] BÀN PHÍM & NHẬP LIỆU |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| OS.window_position         → vị trí cửa sổ | OS.get_screen_count()     → số màn hình              | OS.keyboard_get_layout_count()   |
| OS.window_size             → kích thước    | OS.get_current_screen()   → màn hình hiện tại         |  → số layout bàn phím             |
| OS.max_window_size         → kích thước max| OS.get_screen_size()      → kích thước màn hình       | OS.keyboard_get_layout_name(i)   |
| OS.min_window_size         → kích thước min| OS.get_screen_position()  → vị trí màn hình          |  → tên layout                     |
| OS.get_real_window_size()  → kích thước thật| OS.get_screen_dpi()       → DPI màn hình             | OS.keyboard_get_current_layout() |
| OS.get_window_safe_area()  → vùng an toàn  | OS.get_screen_refresh_rate()→ tần số quét             |  → layout hiện tại                |
| OS.window_fullscreen       → toàn màn hình | OS.get_screen_scale()     → tỷ lệ scale              | OS.keyboard_set_current_layout(i)|
| OS.window_resizable        → có thể resize?| OS.get_screen_max_scale() → scale tối đa             | OS.find_scancode_from_string("A")|
| OS.window_maximized        → đã phóng to?  | OS.vsync_enabled           → bật VSync               |  → scancode từ tên                |
| OS.window_minimized        → đã thu nhỏ?   | OS.vsync_via_compositor   → VSync qua compositor     | OS.get_scancode_string(KEY_A)    |
| OS.window_borderless       → không viền    | OS.delta_smoothing         → làm mịn delta time      |  → tên phím từ scancode           |
| OS.window_per_pixel_transparency_enabled →| OS.low_processor_usage_mode → tiết kiệm CPU           | OS.is_scancode_unicode(KEY_A)    |
|  trong suốt pixel                          |  sleep_usec → thời gian nghỉ giữa frame               |  → scancode có Unicode?           |
| OS.set_window_title("Game")→ đặt tiêu đề   | OS.can_draw()              → có thể vẽ không?         |                                   |
| OS.set_icon(load("icon.png"))→ đặt icon    |                                                        |                                   |
| OS.center_window()         → giữa màn hình |                                                        |                                   |
| OS.move_window_to_foreground()→ đưa lên trước|                                                      |                                   |
| OS.set_window_always_on_top(true) → luôn trên|                                                      |                                   |
| OS.is_window_focused()     → đang focus?   |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [OS - RESOURCES & MEMORY] BỘ NHỚ & TÀI NGUYÊN| [OS - PROCESS & THREADS] TIẾN TRÌNH & LUỒNG         | [OS - INTERACTION] TƯƠNG TÁC     |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| OS.get_static_memory_usage()   → bộ nhớ tĩnh| OS.get_process_id()        → ID tiến trình           | OS.alert("msg", "title") → thông báo|
| OS.get_dynamic_memory_usage()  → bộ nhớ động| OS.is_process_running(pid) → tiến trình đang chạy?   | OS.crash("error")        → gây crash|
| OS.get_static_memory_peak_usage()→ đỉnh bộ nhớ| OS.kill(pid)              → giết tiến trình          | OS.delay_msec(1000)      → chờ 1s  |
| OS.print_resources_in_use()    → in tài nguyên| OS.get_main_thread_id()   → ID luồng chính           | OS.delay_usec(1000000)   → chờ 1s  |
| OS.print_all_resources("log.txt")→ in tất cả| OS.get_thread_caller_id() → ID luồng hiện tại        | OS.shell_open("url")     → mở URL |
| OS.print_resources_by_type(["T"])→ theo loại| OS.can_use_threads()       → hỗ trợ đa luồng?         | OS.execute("cmd",args,block,out) |
| OS.dump_memory_to_file("mem.log")→ ghi log bộ nhớ| OS.set_thread_name("Worker") → đặt tên luồng      |  → chạy lệnh hệ thống             |
| OS.dump_resources_to_file("res.log")→ ghi tài nguyên|                                             | OS.get_cmdline_args()  → tham số CLI|
|                                            |                                                        | OS.read_string_from_stdin() → nhập|
|                                            |                                                        | OS.get_clipboard()     → clipboard|
|                                            |                                                        | OS.has_clipboard()     → có clipboard?|
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [OS - FEATURES & PLATFORM] NỀN TẢNG         | [OS - TOUCH & TTS] CẢM ỨNG & TEXT-TO-SPEECH           | [OS - ADVANCED] NÂNG CAO (macOS/Android)|
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| OS.has_feature("standalone") → tính năng?  | OS.has_touchscreen_ui_hint() → có cảm ứng?            | OS.keep_screen_on = true → giữ sáng|
| OS.is_debug_build()        → build debug?  | OS.show_virtual_keyboard()   → hiện bàn phím ảo      | OS.get_display_cutouts() → cutouts|
| OS.is_stdout_verbose()     → verbose mode? | OS.hide_virtual_keyboard()   → ẩn bàn phím ảo        | OS.set_native_icon("icon.ico")    |
|                                            | OS.get_virtual_keyboard_height() → chiều cao         |  → đặt icon gốc (Windows/macOS)   |
|                                            | OS.tts_speak("text", "voice")→ đọc văn bản            | OS.get_native_handle(HANDLE_WINDOW)|
|                                            | OS.tts_pause() / resume() / stop()                    |  → handle nội bộ (GDNative)       |
|                                            | OS.tts_is_speaking() → đang đọc?                     | OS.global_menu_add_item("_dock",..)|
|                                            | OS.tts_get_voices() → danh sách giọng                |  → menu macOS                     |
|                                            | OS.tts_set_utterance_callback(...) → callback        |                                   |
|                                            | OS.native_video_play("vid.mp4") → phát video native   |                                   |
|                                            | OS.native_video_pause() / stop()                     |                                   |
|                                            | OS.get_connected_midi_inputs() → thiết bị MIDI       |                                   |
|                                            | OS.open_midi_inputs() / close_midi_inputs()          |                                   |
|                                            | OS.request_permission("REC") → quyền Android         |                                   |
|                                            | OS.get_granted_permissions() → quyền đã cấp          |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • (debug only): Các hàm in bộ nhớ, tài nguyên chỉ hoạt động trong build debug.                                                         |
| • user:// là đường dẫn ảo, trỏ đến thư mục dữ liệu người dùng.                                                                        |
| • OS.execute() cần `blocking=true` để lấy output.                                                                                      |
| • Một số hàm chỉ hoạt động trên nền tảng cụ thể (Android, macOS, desktop).                                                             |
| • TTS và bàn phím ảo chủ yếu hỗ trợ mobile & desktop (tùy HĐH).                                                                        |
+----------------------------------------------------------------------------------------------------------------------------------------+
```