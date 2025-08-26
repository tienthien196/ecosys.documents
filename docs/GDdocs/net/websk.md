```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                         GODOT WEBSOCKET & WEBRTC CHEATSHEET (v4.5 beta)                                                 |
|                              Kết nối thời gian thực, multiplayer qua mạng, Web & Desktop – Giao tiếp không đồng bộ                     |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [WEBSOCKET - CLIENT] KẾT NỐI ĐẾN SERVER     | [WEBSOCKET - SERVER] TẠO SERVER                        | [WEBSOCKET - PEER] ĐỐI TƯỢNG PEER  |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| ws_client.connect_to_url(url) → kết nối   | ws_server.listen(port, protocols) → bắt đầu          | peer.is_connected_to_host() → kết nối?|
| ws_client.poll() → xử lý kết nối           | ws_server.poll() → xử lý kết nối                     | peer.get_connected_host() → IP     |
| connection_established → thành công        | client_connected(id, proto) → client nối             | peer.get_connected_port() → cổng   |
| connection_error → lỗi                     | client_disconnected(id) → client ngắt                | peer.get_write_mode() → text/binary|
| data_received → nhận dữ liệu               | data_received(id) → nhận từ client                  | peer.set_write_mode(TEXT/BINARY)   |
| ws_client.disconnect_from_host() → ngắt    | ws_server.disconnect_peer(id) → ngắt client          | peer.was_string_packet() → dạng gói|
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [WEBSOCKET - MULTIPLAYER] TÍCH HỢP MP      | [WEBRTC - DATACHANNEL] KÊNH DỮ LIỆU                  | [WEBSOCKET - CONFIG] CẤU HÌNH      |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| ws_server.listen(..., gd_mp_api=true) → bật| WebRTCDataChannel.new() → tạo kênh                  | ws_server.set_bind_ip("127.0.0.1")|
| ws_server.connect("peer_packet", ...) → nhận| channel.get_ready_state() → trạng thái              |  → IP server lắng nghe            |
| peer_packet(peer_id) → xử lý gói tin       | channel.put_packet(data) → gửi dữ liệu              | ws_server.set_handshake_timeout(5)|
|                                            | channel.get_packet() → nhận dữ liệu                 |  → timeout bắt tay                |
|                                            | channel.get_available_packet_count() → số gói chờ   | ws_server.set_extra_headers([...])|
|                                            | channel.close() → đóng kênh                         |  → header tùy chỉnh                |
|                                            |                                                        | ws_client.set_verify_ssl_enabled(true)|
|                                            |                                                        |  → bật xác thực SSL               |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔄 Luôn gọi poll() định kỳ trong _process() – rất quan trọng để xử lý kết nối và dữ liệu.                                              |
| • 🔐 WebSocketClient hỗ trợ SSL (wss://) – dùng set_verify_ssl_enabled(true) và set_trusted_ssl_certificate() để xác thực.              |
| • 📡 WebSocketServer có thể tích hợp với MultiplayerAPI – dùng gd_mp_api=true để xử lý RPC/RSET qua WebSocket.                           |
| • 🌐 WebRTCDataChannel dùng cho kết nối P2P (trong trình duyệt hoặc qua signaling server) – lý tưởng cho game real-time, voice chat.     |
| • 🧩 put_packet() / get_packet() dùng PoolByteArray – dùng .to_utf8() và .get_string_from_utf8() để xử lý chuỗi.                        |
| • 📦 set_buffers() giúp tối ưu hiệu năng – tăng buffer nếu gửi dữ liệu lớn.                                                             |
| • 🚫 Không dùng yield() trong _on_data_received() – có thể gây treo. Dùng call_deferred() nếu cần trì hoãn.                              |
+----------------------------------------------------------------------------------------------------------------------------------------+
```