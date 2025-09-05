---
title: Computer Networks
sidebar_position: 1
---

# Computer Network

```
+-------------------------------------------------------------+
|                   LAYER 7: Application                      |
|   [User] Gõ: https://google.com                             |
|   → HTTP Request: "GET / HTTP/1.1"                          |
|   → Dữ liệu bắt đầu tại đây                                 |
|   🔹 Ứng dụng: Chrome, Firefox, curl                        |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                 LAYER 6: Presentation                       |
|   → Mã hóa (TLS/SSL):                                       |
|      - Khởi động TLS handshake (sẽ mô tả sau)               |
|      - Dữ liệu sau mã hóa: [Encrypted Application Data]     |
|   🔹 Giao thức: TLS 1.3 (AES-256-GCM)                       |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                   LAYER 5: Session                          |
|   → Thiết lập phiên (session):                              |
|      - Session ID (nếu dùng TLS resumption)                 |
|      - WebSocket, gRPC: quản lý kết nối dài hạn             |
|   🔹 Thường gộp vào Transport hoặc Application               |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                 LAYER 4: Transport                          |
|   → Chia dữ liệu thành segment (TCP)                        |
|   → Gắn port:                                               |
|        - Source Port: 54321 (ephemeral)                     |
|        - Dest Port: 443 (HTTPS)                             |
|   → Giao thức: TCP (đảm bảo tin cậy)                        |
|   🔹 Trước đó: TCP 3-Way Handshake:                         |
|        SYN → SYN-ACK → ACK                                  |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                   LAYER 3: Network                          |
|   → Gắn địa chỉ IP:                                         |
|        - Source IP: 192.168.1.10 (private)                  |
|        - Dest IP: ??? → Cần DNS!                            |
|   🔹 Trước khi gửi:                                         |
|        1. Kiểm tra routing table → gateway là 192.168.1.1   |
|        2. Cần MAC của gateway → dùng ARP                    |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                 LAYER 2: Data Link                          |
|   → Gắn MAC Address:                                        |
|        - Source MAC: aa:bb:cc:dd:ee:ff                      |
|        - Dest MAC: MAC của router (gateway)                 |
|        → Lấy bằng ARP: "Ai có 192.168.1.1? Gửi MAC!"        |
|   → Frame Ethernet: [MAC][IP][TCP][TLS Data]                |
|   🔹 Switch dùng MAC để forward trong LAN                   |
+-------------------------------------------------------------+
                              ↓
+-------------------------------------------------------------+
|                   LAYER 1: Physical                         |
|   → Chuyển thành tín hiệu:                                  |
|        - Wi-Fi (802.11ax): sóng radio                       |
|        - Ethernet: tín hiệu điện trên cáp                   |
|        - 4G/5G: sóng di động                                |
|   → Gửi đến router (gateway)                                |
+-------------------------------------------------------------+
                              ↓
                        [ROUTER / GATEWAY]
                              ↓
+-------------------------------------------------------------+
|                     NAT & FIREWALL                          |
|   → NAT (Network Address Translation):                      |
|        192.168.1.10:54321 → 103.123.45.67:54321             |
|        → Lưu bảng NAT: "port 54321 = client nội bộ"         |
|   → Firewall: Kiểm tra rule (outbound HTTPS cho phép)       |
|   → Router forward gói ra Internet                         |
+-------------------------------------------------------------+
                              ↓
                       [ISP NETWORK]
                              ↓
+-------------------------------------------------------------+
|                        DNS RESOLUTION                       |
|   → Client gửi DNS query (UDP port 53):                     |
|        "google.com?" → Gửi đến DNS server (ISP hoặc 8.8.8.8)|
|   → DNS server trả về: 142.250.180.78                       |
|   ⚠️ Nếu bị chặn: ISP trả IP sai hoặc không phản hồi         |
|   ✅ Nếu dùng DoH (DNS over HTTPS):                         |
|        Gửi qua HTTPS đến 1.1.1.1 (Cloudflare)               |
|        → Mã hóa, ISP không thấy nội dung                    |
+-------------------------------------------------------------+
                              ↓
                     [INTERNET BACKBONE]
                              ↓
+-------------------------------------------------------------+
|                     TÙY THUỘC: Proxy hay VPN?               |
+-------------------------------------------------------------+

─────────────────────────────────────────────────────────────
        ┌───────────────────────┐
        │       CASE 1: PROXY   │
        └───────────────────────┘

[Client] → Gửi: "CONNECT 142.250.180.78:443 HTTP/1.1" đến proxy
         → Dùng HTTP CONNECT method để tạo tunnel
         → Proxy trả về: "200 Connection Established"
   ↓
[ISP] → Thấy: kết nối đến IP proxy (e.g., 203.0.113.5:8080)
      → Không thấy nội dung HTTPS (chỉ thấy tunnel được tạo)
   ↓
[PROXY SERVER] → Kết nối đến google.com:443
                → Forward dữ liệu hai chiều
                → Có thể decrypt nếu dùng HTTPS proxy (MITM)
   ↓
[GOOGLE SERVER] ← Nhận yêu cầu từ: IP proxy
   ↓
[PROXY] ← Nhận phản hồi → gửi về client
   ↓
[Client] ← Nhận dữ liệu qua tunnel đã thiết lập

🔹 Ai thấy gì?
- ISP: Biết bạn dùng proxy, không thấy nội dung
- Proxy: Có thể thấy tất cả (nếu MITM bằng chứng chỉ CA nội bộ)
- Google: Thấy IP proxy, không thấy IP thật của bạn

─────────────────────────────────────────────────────────────
        ┌───────────────────────┐
        │       CASE 2: VPN     │
        └───────────────────────┘

[Client] → Gửi packet đến Server VPN (UDP port 51820 - WireGuard)
         → Dữ liệu: [UDP][Encrypted IP Packet]
         → Trong đó: "ping 142.250.180.78:443"
         → Dùng tunnel interface (wg0)
   ↓
[ISP] → Thấy: UDP packet đến IP_VPN, payload là dữ liệu ngẫu nhiên
      → Không thể biết nội dung, DNS, hay trang web truy cập
   ↓
[SERVER VPN] → Giải mã bằng WireGuard
             → Lấy ra IP packet gốc
             → Forward ra Internet: "Từ IP_VPN → google.com"
   ↓
[GOOGLE SERVER] ← Nhận yêu cầu từ IP_VPN
   ↓
[SERVER VPN] ← Nhận phản hồi → mã hóa lại → gửi về client
   ↓
[Client] ← Giải mã → nhận dữ liệu

🔹 Ai thấy gì?
- ISP: Chỉ thấy bạn dùng VPN, không biết nội dung
- Server VPN: Biết IP đích, nhưng nếu HTTPS → không đọc nội dung
- Google: Thấy IP server VPN
- Bạn: IP thật được ẩn, an toàn khỏi snooping

─────────────────────────────────────────────────────────────

                              ↓
+-------------------------------------------------------------+
|                   SERVER ĐÍCH (Google)                      |
|   ← Nhận gói tin từ:                                        |
|      - Nếu dùng Proxy: IP proxy                             |
|      - Nếu dùng VPN: IP server VPN                          |
|   → Xử lý request, trả về HTML đã mã hóa (HTTPS)            |
|   → Gói tin quay lại theo đường ngược lại                   |
+-------------------------------------------------------------+
                              ↓
           ←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←
           GÓI TIN QUAY VỀ: ĐI NGƯỢC LẠI QUA TẤT CẢ CÁC TẦNG
           (Từ Physical → Application, giải mã từng lớp)
           ↓
+-------------------------------------------------------------+
|                   KẾT QUẢ TRÊN TRÌNH DUYỆT                   |
|   → Hiển thị trang Google                                   |
|   🔒 Biểu tượng khóa: chứng chỉ hợp lệ (CA: Google Trust)    |
|   🌐 Địa chỉ thanh URL: https://google.com                   |
|   ⚡ Độ trễ thấp: nhờ CDN (Google dùng Edge Network toàn cầu)|
+-------------------------------------------------------------+

GHI CHÚ:
- MAC: Switch dùng địa chỉ MAC để forward frame trong LAN
- IP: Router dùng IP để định tuyến giữa các mạng
- TCP: Đảm bảo truyền tin tin cậy, có kiểm soát luồng (flow control)
- UDP: Nhanh, không đảm bảo, dùng cho DNS, VoIP, gaming
- TLS: Mã hóa end-to-end, ngăn MITM
- DNS: Chuyển tên miền → IP
- NAT: Biến đổi IP private → public (e.g., 192.168.1.10 → 8.8.8.8:54321)
- ARP: Tìm MAC từ IP trong cùng mạng
- DHCP: Tự động cấp IP, gateway, DNS
- ICMP: Dùng cho ping, traceroute
- CDN: Lưu nội dung gần người dùng để giảm độ trễ
- Firewall: Lọc gói tin dựa trên rule (stateful/stateless)
- Load Balancer: Phân tải giữa nhiều server
- CA: Xác thực danh tính máy chủ qua chứng chỉ số

```



## . Khái niệm nâng cao
  - QoS: Ưu tiên traffic
  - SDN: Mạng định nghĩa bằng phần mềm
  - NFV: Ảo hóa chức năng mạng
  - CDN: Phân phối nội dung
  - P2P: Chia sẻ ngang hàng
  - Cloud Networking: VPC, Load Balancer, NAT Gateway










