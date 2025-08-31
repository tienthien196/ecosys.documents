```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                          GODOT STREAM & PACKET CHEATSHEET (v3.6 / v4.5)                                                |
|                                Ghi/đọc dữ liệu, TCP/UDP, SSL/DTLS, Multicast – Mạng nâng cao                                           |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [STREAMPEERBUFFER - DATA] GHI/ĐỌC DỮ LIỆU   | [STREAMPEER - TCP/SSL] KẾT NỐI CÓ HƯỚNG                  | [PACKETPEER - UDP] GỬI NHẬN PACKET |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| StreamPeerBuffer.new()       → tạo mới     | tcp.connect_to_host(ip, port) → kết nối                | udp_peer.put_packet(data) → gửi   |
| peer.put_8()/get_8()         → int 8-bit   | tcp.is_connected_to_host() → đã kết nối?              | udp_peer.get_packet() → nhận      |
| peer.put_u16()/get_u16()     → uint 16-bit | tcp.get_connected_host() → IP đã kết nối              | udp_peer.put_var(data) → gửi Variant|
| peer.put_float()/get_float() → float 32   | tcp.get_connected_port() → cổng                       | udp_peer.get_var() → nhận Variant |
| peer.put_double()/get_double()→ float 64  | tcp.set_no_delay(true) → tắt Nagle (gửi ngay)         | udp_peer.get_available_packet_count()|
| peer.put_string()/get_string()→ ASCII     | ssl.connect_to_stream(tcp, verify, host) → mã hóa     |  → số packet chờ                  |
| peer.put_utf8_string()       → UTF-8      | ssl.poll() → cập nhật trạng thái SSL                  | udp_peer.get_packet_ip() → IP nguồn|
| peer.put_data(data)          → mảng byte  | ssl.get_packet_error() → kiểm tra lỗi                | udp_peer.get_packet_port() → cổng |
| peer.put_var(data)           → Variant    |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [DTLS - UDP ENCRYPTED] BẢO MẬT UDP         | [MULTICAST/BROADCAST] PHÁT TỚI NHIỀU                  | [BUFFER & CONFIG] CẤU HÌNH         |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| dtls.connect_to_peer(udp)  → client       | udp_peer.join_multicast_group(addr, iface) → tham gia| peer.big_endian = true → Big Endian|
| dtls.take_connection(udp)  → server        | udp_peer.leave_multicast_group(addr, iface) → rời    | peer.seek(0) → về đầu buffer      |
| dtls.poll()                → cập nhật     | udp_peer.set_broadcast_enabled(true) → bật broadcast | peer.resize(n) → đổi kích thước   |
| dtls.put_packet(data)      → gửi          | udp_peer.set_dest_address(mcast_ip, port) → multicast| peer.clear() → xóa dữ liệu        |
| dtls.get_packet()          → nhận         |                                                        | peer.data_array = bytes → gán trực tiếp|
| dtls.get_status()          → trạng thái   |                                                        | peer.get_position() / get_size()  |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔢 put_*/get_*: Luôn đảm bảo thứ tự ghi/đọc giống nhau – rất quan trọng khi giao tiếp giữa client/server.                               |
| • 🔐 SSL/DTLS cần chứng chỉ (X509Certificate) và khóa (CryptoKey) – dùng verify=false chỉ để test.                                       |
| • 📡 Multicast (239.0.0.0/8) dùng để gửi dữ liệu đến nhiều client – lý tưởng cho game LAN hoặc chat nhóm.                               |
| • 📻 Broadcast (255.255.255.255) gửi tới mọi thiết bị trong mạng – dùng để discover server.                                              |
| • 🧩 put_var()/get_var(): Hỗ trợ mọi kiểu dữ liệu Godot – rất tiện nhưng cần bật allow_object_decoding() nếu có object.                  |
| • ⏱ Luôn gọi poll() định kỳ: dtls.poll(), ssl.poll() – để cập nhật trạng thái kết nối.                                                  |
| • 🔄 wait() (blocking) không dùng trong _process – chỉ dùng khi chắc chắn không gây giật.                                                |
+----------------------------------------------------------------------------------------------------------------------------------------+
```