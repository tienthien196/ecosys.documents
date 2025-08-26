```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT NETWORKING CHEATSHEET (v3.6 / v4.5)                                                    |
|                               UPnP, UDP, TCP, DTLS, SSL – Kết nối, bảo mật và truyền dữ liệu mạng                                      |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [UPNP - PORT MAPPING] MỞ CỔNG TỰ ĐỘNG     | [UDP - CONNECTIONLESS] GỬI NHẬN NHANH                    | [TCP - CONNECTION] KẾT NỐI ỔN ĐỊNH |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| UPNP.new()                   → tạo mới     | UDPServer.listen(port)     → server lắng nghe           | TCP_Server.listen(port) → server  |
| upnp.discover()              → tìm router  | server.is_connection_available() → có kết nối?         | server.is_connection_available() → có client?|
| upnp.get_gateway()           → lấy gateway | server.take_connection()   → nhận client (PacketPeerUDP)| server.take_connection() → StreamPeerTCP|
| upnp.query_external_address()→ IP công cộng| peer.put_packet(data)      → gửi dữ liệu               | peer.put_utf8_string("msg") → gửi chuỗi|
| upnp.add_port_mapping(p,0,n,"UDP")→ mở cổng| peer.get_packet()          → nhận dữ liệu              | peer.get_utf8_string() → nhận chuỗi|
| upnp.delete_port_mapping(p,"TCP")→ đóng cổng| udp.listen(port)           → client lắng nghe           | peer.get_u32() / put_u32() → số nguyên|
|                                            | udp.connect_to_host(ip,p)  → kết nối đến server         | peer.get_var() / put_var() → Variant|
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [DTLS - UDP + ENCRYPTION] BẢO MẬT UDP      | [SSL - TCP + ENCRYPTION] BẢO MẬT TCP                   | [UTILS] TIỆN ÍCH MẠNG             |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| DTLSServer.setup(key, cert)  → setup server| StreamPeerSSL.new()        → tạo SSL peer              | PacketPeerUDP.get_packet_ip()    |
| dtls.take_connection(udp_peer)→ nhận client| ssl.connect_to_stream(tcp, false, "host") → client     |  → IP gói tin vừa nhận           |
| dtls.poll()                  → cập nhật trạng thái| ssl.poll()            → cập nhật SSL               | PacketPeerUDP.get_packet_port()  |
| dtls.put_packet(data)        → gửi dữ liệu | ssl.put_string("msg")      → gửi chuỗi                |  → cổng gói tin vừa nhận         |
| dtls.get_packet()            → nhận dữ liệu| ssl.get_data(len)          → nhận dữ liệu             | StreamPeer.get_available_bytes() |
|                                            |                                                    |  → kiểm tra dữ liệu khả dụng     |
|                                            |                                                    | OS.is_socket_connected()         |
|                                            |                                                    |  → kiểm tra socket còn kết nối?  |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔌 UPnP giúp tự động mở cổng – cần chạy trong thread để không làm giật game.                                                          |
| • 📦 UDP nhanh nhưng không đảm bảo – dùng cho game real-time (FPS, platformer).                                                         |
| • 🔗 TCP đảm bảo thứ tự và độ tin cậy – dùng cho chat, turn-based, truyền file.                                                         |
| • 🔐 DTLS (trên UDP) và SSL/TLS (trên TCP) dùng để mã hóa – cần chứng chỉ (X509Certificate + CryptoKey).                                |
| • 🧩 put_var() / get_var() hỗ trợ mọi kiểu Godot – rất tiện để gửi dữ liệu phức tạp.                                                    |
| • ⏱ Luôn gọi poll() định kỳ: server.poll(), dtls.poll(), ssl.poll() – để cập nhật trạng thái.                                           |
| • 🧹 Dọn dẹp kết nối: dùng yield() + call_deferred() để tránh lỗi khi xóa node đang xử lý mạng.                                          |
+----------------------------------------------------------------------------------------------------------------------------------------+
```