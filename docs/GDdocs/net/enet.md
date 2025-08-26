```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                    GODOT MULTIPLAYER & NETWORKED PEER CHEATSHEET (v4.5 beta)                                            |
|                             Thiết lập multiplayer, ENet, DTLS, RPC, kênh, relay – Game mạng toàn diện                                  |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [MULTIPLAYERAPI] QUẢN LÝ ĐA NGƯỜI CHƠI      | [ENET - CORE] CẤU HÌNH CƠ BẢN                            | [ENET - SECURITY] BẢO MẬT DTLS    |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| set_custom_multiplayer(api) → dùng API tùy chỉnh| peer.create_server(port, max) → tạo server         | set_dtls_enabled(true) → bật DTLS |
| api.set_root_node(node)    → thiết lập gốc  | peer.create_client(ip, port) → tạo client             | set_dtls_verify_enabled(true) → xác thực|
| api.is_network_server()    → kiểm tra server| peer.set_transfer_mode(mode) → chế độ truyền         | set_dtls_hostname("host") → host  |
| api.get_network_unique_id()→ lấy ID        | peer.set_refuse_new_connections(true) → từ chối      | set_dtls_key(key) → khóa DTLS     |
| api.get_network_connected_peers()→ danh sách| peer.set_transfer_channel(1) → kênh mặc định         | set_dtls_certificate(cert) → cert |
| api.send_bytes(data, id)   → gửi byte      | peer.get_connection_status() → trạng thái            |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [ENET - ADVANCED] NÂNG CAO                  | [CUSTOM PEER] TỰ TRIỂN KHAI                            | [RPC & SIGNALS] GIAO TIẾP         |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| set_always_ordered(true)   → luôn giữ thứ tự| NetworkedMultiplayerCustom.new() → tạo peer tùy chỉnh| rpc("func", args) → gọi RPC       |
| set_channel_count(4)       → 4 kênh dữ liệu| peer.initialize(id) → khởi tạo peer                  | rpc_id(id, "f", a) → RPC tới ID   |
| set_compression_mode(ZSTD) → nén dữ liệu   | peer.deliver_packet(data, from_id) → nhận gói tin    | remote func f() → chạy ở peer khác|
| set_server_relay_enabled(true)→ relay server| peer.packet_generated → tín hiệu khi gửi            | rset("prop", val) → đồng bộ thuộc tính|
| set_bind_ip("127.0.0.1")   → IP bind server| peer.set_max_packet_size(65536) → kích thước gói     | rset_id(id, "p", v) → RSET tới ID |
| set_peer_timeout(id, t, i, a)→ timeout peer|                                                        |                                   |
| get_peer_address(id)       → IP peer       |                                                        |                                   |
| get_peer_port(id)          → cổng peer     |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔄 Luôn gọi get_tree().network_peer = peer sau khi tạo – để kích hoạt hệ thống multiplayer.                                            |
| • 🔐 DTLS yêu cầu khóa (CryptoKey) và chứng chỉ (X509Certificate) – dùng generate_self_signed_certificate() để test.                    |
| • 📡 Kênh (channel) cho phép gửi dữ liệu với độ ưu tiên khác nhau – ví dụ: kênh 0: reliable, kênh 1: unordered.                           |
| • 📦 compression_mode = COMPRESS_ZSTD giúp giảm băng thông – rất hữu ích cho game online.                                               |
| • 🔄 set_server_relay_enabled(true) cho phép server chuyển tiếp dữ liệu giữa các client – cần để làm relay server.                      |
| • 🧩 NetworkedMultiplayerCustom lý tưởng để tích hợp với WebSocket, WebRTC, hoặc custom network protocol.                                |
| • 📣 RPC/RSET chỉ hoạt động nếu node có MultiplayerSynchronizer hoặc được quản lý bởi MultiplayerSpawner.                                |
+----------------------------------------------------------------------------------------------------------------------------------------+
```