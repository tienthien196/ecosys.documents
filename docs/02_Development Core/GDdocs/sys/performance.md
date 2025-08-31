```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                         GODOT ENGINE + PERFORMANCE CHEATSHEET (v3.6)                                                  |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [ENGINE - SETTINGS] CÀI ĐẶT ENGINE        | [ENGINE - TIME & FPS] THỜI GIAN & KHUNG HÌNH           | [ENGINE - INFO] THÔNG TIN         |
|-------------------------------------------|--------------------------------------------------------|-----------------------------------|
| Engine.editor_hint          → editor mode?| Engine.get_frames_per_second() → FPS hiện tại           | Engine.get_author_info()          |
| Engine.iterations_per_second → tick vật lý| Engine.get_frames_drawn()       → # frame đã vẽ         | Engine.get_license_info()         |
| Engine.physics_jitter_fix    → giảm jitter| Engine.is_in_physics_frame()    → trong physics frame?  | Engine.get_version_info()         |
| Engine.print_error_messages  → in lỗi log | Engine.get_physics_frames()     → # physics frame       | Engine.get_donor_info()           |
| Engine.target_fps            → FPS mục tiêu| Engine.get_idle_frames()        → # idle frame          | Engine.get_copyright_info()       |
| Engine.time_scale            → tốc độ time| Engine.get_physics_interpolation_fraction() → tỉ lệ interp|                                   |
+-------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [ENGINE - SINGLETON] QUẢN LÝ SINGLETON                                                                                                 |
|----------------------------------------------------------------------------------------------------------------------------------------|
| Engine.get_main_loop()               → trả về MainLoop                                                                                 |
| Engine.has_singleton("Name")         → kiểm tra singleton tồn tại                                                                      |
| Engine.get_singleton("Name")         → lấy singleton toàn cục                                                                          |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [PERFORMANCE - TIME] THỜI GIAN & FPS      | [PERFORMANCE - MEMORY] BỘ NHỚ (debug only)              | [PERFORMANCE - OBJECT] OBJECT     |
|-------------------------------------------|--------------------------------------------------------|-----------------------------------|
| TIME_FPS                → FPS hiện tại    | MEMORY_STATIC            → Bộ nhớ tĩnh đang dùng        | OBJECT_COUNT            → # object|
| TIME_PROCESS            → Thời gian frame | MEMORY_DYNAMIC           → Bộ nhớ động đang dùng        | OBJECT_RESOURCE_COUNT   → # res   |
| TIME_PHYSICS_PROCESS    → Thời gian physics| MEMORY_STATIC_MAX        → Giới hạn bộ nhớ tĩnh        | OBJECT_NODE_COUNT       → # node  |
|                                           | MEMORY_DYNAMIC_MAX       → Giới hạn bộ nhớ động        | OBJECT_ORPHAN_NODE_COUNT→ # orphan|
|                                           | MEMORY_MESSAGE_BUFFER_MAX → bộ nhớ queue buffer        |                                   |
+-------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [PERFORMANCE - RENDER 3D]                 | [PERFORMANCE - RENDER 2D]                              | [PERFORMANCE - VIDEO MEM]         |
|-------------------------------------------|--------------------------------------------------------|-----------------------------------|
| RENDER_OBJECTS_IN_FRAME       → # obj 3D  | RENDER_2D_ITEMS_IN_FRAME      → # item 2D/frame        | RENDER_VIDEO_MEM_USED    → video  |
| RENDER_VERTICES_IN_FRAME      → # vertex  | RENDER_2D_DRAW_CALLS_IN_FRAME → # draw calls 2D        | RENDER_TEXTURE_MEM_USED  → tex    |
| RENDER_MATERIAL_CHANGES_IN_FRAME→ # thay  |                                                        | RENDER_VERTEX_MEM_USED   → vertex |
| RENDER_SHADER_CHANGES_IN_FRAME → # thay   |                                                        | RENDER_USAGE_VIDEO_MEM_TOTAL → 0  |
| RENDER_SURFACE_CHANGES_IN_FRAME→ # thay   |                                                        |                                   |
| RENDER_DRAW_CALLS_IN_FRAME    → # draw    |                                                        |                                   |
+-------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [PERFORMANCE - PHYSICS 2D]                | [PERFORMANCE - PHYSICS 3D]                             | [PERFORMANCE - AUDIO]             |
|-------------------------------------------|--------------------------------------------------------|-----------------------------------|
| PHYSICS_2D_ACTIVE_OBJECTS   → # body 2D   | PHYSICS_3D_ACTIVE_OBJECTS   → # body 3D                | AUDIO_OUTPUT_LATENCY → độ trễ âm  |
| PHYSICS_2D_COLLISION_PAIRS  → # va chạm 2D| PHYSICS_3D_COLLISION_PAIRS  → # va chạm 3D             |                                   |
| PHYSICS_2D_ISLAND_COUNT     → # island 2D | PHYSICS_3D_ISLAND_COUNT     → # island 3D              |                                   |
+-------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [PERFORMANCE - CUSTOM MONITOR]                                                                                                        |
|----------------------------------------------------------------------------------------------------------------------------------------|
| Performance.get_monitor(Performance.TIME_FPS)     → lấy monitor (ví dụ FPS)                                                           |
| Performance.add_custom_monitor("my/custom", func) → thêm custom monitor                                                              |
| Performance.has_custom_monitor("my/custom")       → kiểm tra                                                                          |
| Performance.remove_custom_monitor("my/custom")    → xóa                                                                              |
+----------------------------------------------------------------------------------------------------------------------------------------+

```