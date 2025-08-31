---
title: Computer Network
sidebar_position: 1
---

# Computer Network

## Map

```
+-------------------------------------------------------------+
|                       LAYER 7: Application                  |
|   [User] Gõ: https://google.com                             |
|   → HTTP Request: "GET / HTTP/1.1"                          |
|   → Dữ liệu bắt đầu từ đây                                  |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                     LAYER 6: Presentation                   |
|   → Mã hóa dữ liệu (TLS/SSL):                               |
|      - HTTP → HTTPS (mã hóa bằng AES)                       |
|      - Dữ liệu trở thành: [Encrypted Blob]                  |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                       LAYER 5: Session                      |
|   → Thiết lập phiên làm việc (session)                      |
|   → Nếu dùng WebSocket, gRPC, hay WireGuard: tạo session ID |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                      LAYER 4: Transport                     |
|   → Chia nhỏ dữ liệu thành segment                          |
|   → Gắn port:                                               |
|        - Source Port: 54321 (ngẫu nhiên)                    |
|        - Dest Port: 443 (HTTPS)                             |
|   → Giao thức: TCP (hoặc UDP nếu dùng DNS, WireGuard)       |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                       LAYER 3: Network                      |
|   → Gắn địa chỉ IP:                                         |
|        - Source IP: 192.168.1.10 (IP nội bộ)                |
|        - Dest IP: ??? → Cần DNS để biết!                    |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                      LAYER 2: Data Link                     |
|   → Gắn MAC Address:                                        |
|        - Source MAC: aa:bb:cc:dd:ee:ff                      |
|        - Dest MAC: MAC của router (gateway)                 |
|   → Frame: [MAC][IP][TCP][Data]                             |
+-------------------------------------------------------------+
                             ↓
+-------------------------------------------------------------+
|                      LAYER 1: Physical                      |
|   → Chuyển thành tín hiệu: Wi-Fi, Ethernet, 4G              |
|   → Gửi đến router                                          |
+-------------------------------------------------------------+
                             ↓
                       [ROUTER]
                             ↓
+-------------------------------------------------------------+
|                         NAT & FIREWALL                      |
|   → NAT: Đổi IP nội bộ → IP công cộng                       |
|        192.168.1.10:54321 → 103.123.45.67:54321             |
|   → Firewall: Kiểm tra xem có cho phép kết nối ra không     |
+-------------------------------------------------------------+
                             ↓
                        [ISP NETWORK]
                             ↓
+-------------------------------------------------------------+
|                           DNS QUERY                         |
|   → Client gửi: "google.com?"                               |
|   → ISP DNS Server trả về: 142.250.180.78                   |
|   ⚠️ Nếu bị chặn: ISP không trả lời hoặc trả IP sai          |
|   ✅ Nếu dùng DoH: Gửi qua HTTPS đến 1.1.1.1                |
+-------------------------------------------------------------+
                             ↓
                     [INTERNET BACKBONE]
                             ↓
+-------------------------------------------------------------+
|                      TÙY THUỘC: Proxy hay VPN?              |
+-------------------------------------------------------------+

        ┌───────────────────────┐
        │       CASE 1: PROXY   │
        └───────────────────────┘

[Client] → Gửi đến Proxy: "CONNECT 142.250.180.78:443"
   ↓
[ISP] → Thấy: kết nối đến IP proxy (ví dụ: 203.0.113.5:8080)
   ↓
[PROXY SERVER] → Giải mã (nếu dùng HTTPS proxy)
                → Kết nối đến google.com:443
                → Gửi dữ liệu qua Internet
   ↓
[GOOGLE SERVER] ← Nhận yêu cầu như thể từ proxy
   ↓
[PROXY] ← Nhận phản hồi → gửi về client
   ↓
[Client] ← Nhận dữ liệu

🔹 Ai thấy gì?
- ISP: Thấy bạn dùng proxy, không thấy nội dung (nếu mã hóa)
- Proxy: Thấy toàn bộ dữ liệu (có thể log, chèn quảng cáo)
- Google: Thấy IP của proxy, không thấy IP thật bạn

─────────────────────────────────────────────────────────────

        ┌───────────────────────┐
        │       CASE 2: VPN     │
        └───────────────────────┘

[Client] → Gửi đến Server VPN: [UDP][Encrypted IP Packet]
         → Trong đó: "ping 142.250.180.78:443"
   ↓
[ISP] → Thấy: UDP packet đến IP_VPN:51820
      → Payload: dữ liệu ngẫu nhiên (do mã hóa)
      → Không biết nội dung, không thấy DNS
   ↓
[SERVER VPN] → Giải mã bằng WireGuard
             → Lấy ra IP packet gốc
             → Gửi ra Internet: "Từ tôi (IP_VPN) → google.com"
   ↓
[GOOGLE SERVER] ← Nhận yêu cầu từ IP_VPN
   ↓
[SERVER VPN] ← Nhận phản hồi → mã hóa lại → gửi về client
   ↓
[Client] ← Giải mã → nhận dữ liệu

🔹 Ai thấy gì?
- ISP: Thấy bạn kết nối đến IP_VPN, không thấy nội dung
- Server VPN: Thấy dữ liệu, nhưng nếu dùng HTTPS → không đọc được nội dung web
- Google: Thấy IP của server VPN
- Bạn: An toàn, như đang dùng mạng riêng

─────────────────────────────────────────────────────────────

                             ↓
+-------------------------------------------------------------+
|                     SERVER ĐÍCH (Google)                    |
|   ← Nhận gói tin từ:                                        |
|      - Proxy: IP proxy                                       |
|      - VPN: IP server VPN                                  |
|   → Xử lý request, trả về HTML đã mã hóa (HTTPS)            |
|   → Gói tin quay lại theo đường cũ                          |
+-------------------------------------------------------------+
                             ↓
           ←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←
           Gói tin quay về theo đường ngược lại
           (qua cùng các tầng, nhưng ngược chiều)
           ↓
+-------------------------------------------------------------+
|                       KẾT QUẢ TRÊN TRÌNH DUYỆT               |
|   → Hiển thị trang Google                                   |
|   🔒 Biểu tượng khóa (HTTPS) hiện lên                        |
+-------------------------------------------------------------+
```

- [(cheatsheet)](./Organization.md)


## 1. OSI ↔ TCP/IP 


```
     ┌──────────────┐
     │ Application  │◄──────────────────────┐
     └───────┬──────┘                       │
     ┌───────▼────────┐   TCP/IP            │
     │ Presentation   │   Application Layer │
     └───────┬────────┘                     │
     ┌───────▼───────┐                      │
     │ Session       │◄─────────────────────┘
     └───────┬───────┘
     ┌───────▼───────────┐   ┌──────────────┐
     │ Transport         │──►│ Transport    │
     └───────┬───────────┘   └─────┬────────┘
     ┌───────▼───────────┐         │
     │ Network           │──►┌─────▼────────┐
     └───────┬───────────┘   │ Internet     │
     ┌───────▼───────────┐   └─────┬────────┘
     │ Data Link         │──►┌─────▼────────┐
     └───────┬───────────┘   │ Link         │
     ┌───────▼───────────┐   └──────────────┘
     │ Physical          │
     └───────────────────┘
```
---
```
                  Máy Gửi (Sender)                     Máy Nhận (Receiver)
              ─────────────────────              ─────────────────────
              | 7. Application    |              | 7. Application    |
              | 6. Presentation   |              | 6. Presentation   |
              | 5. Session        |              | 5. Session        |
              | 4. Transport      |◄──TCP──►     | 4. Transport      |
              | 3. Network        |◄──IP───►     | 3. Network        |
              | 2. Data Link      |◄─Frame─►     | 2. Data Link      |
              | 1. Physical       |◄─Bit───►     | 1. Physical       |
              ─────────────────────              ─────────────────────
                    ▼                                      ▲
                Encapsulation                         Decapsulation
```

## Đầu tiên là hiểu về OSI model

## Application
tầng: 7
    DNS
    tạo ra dữ liệu n từ gói tin ->
    giao thức  đặt quy tắt -> add header 


### DNS
```
                         +----------------------+
                         |     Root (.) NS      |
                         +----------+-----------+
                                    |
                                  (referral)
                                    |
                          +---------v----------+
                          |      .com  NS      |
                          +---------+----------+
                                    |
                                  (referral)
                                    |
                     +--------------v---------------+
                     |  Authoritative NS (example)  |
                     +--------------+---------------+
                                    |
                                 (answer)
                                    |
     +-----------+         +--------v--------+
     |  Client   |  --->   | Recursive/Caching|
     | (Stub Res)|         |    Resolver      |
     +-----------+         +------------------+
```

### quá tình giao tiếp mạng gồm 2 bước 
- việc client hay server dùng OSI hay tcp/IP thì kiến trúc thực tế mà chúng giao tiếp với nhau là tcp/IP
- tại sao đã có tcp thì còn phải dùng HTTP


DNS : khởi nguồn ứng dụng 
- appliaction -> systemcall Net -> DNS server -> get IP = DOAMIN NAME
- app has IP -> connect server 

> note 
  - có thể dẫn tới DNS spoofing, DNS cache poisoning, man-in-the-middle attack (DNS UDP:53 ko đc bảo vệ)
  - DNS chặn web 
  - cấu hình sai DNS


> giao thức là gì /ko nhầm với API :
  - nó là các quy tắc chung đặt ra cho máy tính để chia sẽ data
  - giao thức là luật chia sẽ dữ liệu

> tại sao phải phân tầng OSI
  - thực ra thì có thể làm 
  - nhưng nếu làm vậy thì 
  - đòi hỏi chrome phải biết viết code  IP , TCP, MAC, driver 
  - làm khó debug tìm lỗi , kém linh hoạt 

> tại sao viết code phải dùng thư viện network
  - Nó giúp gọi các services mạng của  hệ điều hành 


### HTTP Request
| Method | Mô tả |
|--------|------|
| `GET` | Lấy dữ liệu từ server (ví dụ: tải trang web) |
| `POST` | Gửi dữ liệu đến server để xử lý (ví dụ: gửi form) |
| `PUT` | Cập nhật tài nguyên đã tồn tại trên server |
| `DELETE` | Xóa tài nguyên trên server |
| `PATCH` | Cập nhật một phần của tài nguyên |
| `HEAD` | Giống `GET` nhưng chỉ trả về header (không có body) |
| `OPTIONS` | Kiểm tra các phương thức HTTP được hỗ trợ |

### HTTP Status Codes

| Mã | Nhóm | Ý nghĩa |
|----|------|---------|
| `1xx` | Informational | Yêu cầu đang được xử lý (hiếm khi thấy trực tiếp) |
| `2xx` | Success | Yêu cầu đã được nhận và xử lý thành công |
| `3xx` | Redirection | Cần hành động thêm để hoàn tất yêu cầu |
| `4xx` | Client Error | Lỗi từ phía client (yêu cầu sai, không có quyền, v.v.) |
| `5xx` | Server Error | Lỗi từ phía server (lỗi nội bộ, quá tải, v.v.) |

---


### ✅ 2xx – Thành công

| Status | Mô tả |
|--------|------|
| `200 OK` | Yêu cầu thành công. Dùng cho hầu hết phản hồi thành công. |
| `201 Created` | Tài nguyên đã được tạo thành công (thường sau `POST`). |
| `204 No Content` | Yêu cầu thành công nhưng không có dữ liệu trả về. |

---

### 🔁 3xx – Chuyển hướng

| Status | Mô tả |
|--------|------|
| `301 Moved Permanently` | URL đã được chuyển vĩnh viễn sang địa chỉ mới. |
| `302 Found` | URL tạm thời được chuyển hướng. |
| `304 Not Modified` | Nội dung không thay đổi, client nên dùng bản cache. |

---

### ❌ 4xx – Lỗi phía Client

| Status | Mô tả |
|--------|------|
| `400 Bad Request` | Yêu cầu không hợp lệ (sai cú pháp, thiếu tham số). |
| `401 Unauthorized` | Chưa xác thực (thiếu token, cookie, hoặc sai mật khẩu). |
| `403 Forbidden` | Đã xác thực nhưng không có quyền truy cập tài nguyên. |
| `404 Not Found` | Không tìm thấy tài nguyên (URL không tồn tại). |
| `405 Method Not Allowed` | Phương thức HTTP không được hỗ trợ (ví dụ: dùng `POST` trên endpoint chỉ nhận `GET`). |
| `429 Too Many Requests` | Gửi quá nhiều yêu cầu trong thời gian ngắn (rate limiting). |

---

### ⚠️ 5xx – Lỗi phía Server

| Status | Mô tả |
|--------|------|
| `500 Internal Server Error` | Lỗi chung khi server gặp sự cố không xác định. |
| `502 Bad Gateway` | Server làm cổng trung gian nhận được phản hồi không hợp lệ từ upstream. |
| `503 Service Unavailable` | Server tạm thời không thể xử lý (quá tải hoặc bảo trì). |
| `504 Gateway Timeout` | Cổng trung gian không nhận được phản hồi kịp thời từ server backend. |

---


## xác thực 

tầng 6: 
    mã hoá __package__ , cer , bảo mật , nén gói tin 

  - 
    - Mã hóa bằng khóa công khai (asymmetric encryption) rất chậm Dùng cho lượng dữ liệu nhỏ (như trao đổi khóa).
    - Dữ liệu thật sự (web, hình ảnh, video) được mã hóa bằng mã hóa đối xứng (symmetric encryption) – nhanh hơn rất nhiều.

1. Kiểm tra chứng chỉ-> Trình duyệt->So sánh với danh sách CA tin cậy
2. Tạo khóa phiên->Client->Số ngẫu nhiên
3. Mã hóa khóa phiên bằng public key->Client->Mã hóa bất đối xứng (RSA, ECDHE)
4. Server giải mã để lấy khóa phiên->Server->Dùng private key
5. Mã hóa dữ liệu thật sự->Cả hai bên->Mã hóa đối xứng (AES-256)


> 🚫 2. Nếu server không có chứng chỉ (và không dùng Let's Encrypt)
  -  ❌ Không nên: Tự mã hóa dữ liệu bằng thuật toán riêng
Nhiều người nghĩ:
"Thôi thì không có TLS, mình tự mã hóa JSON bằng AES rồi gửi qua TCP!" 

👉 Rất nguy hiểm nếu không chuyên về mật mã học.
🧨 Những rủi ro khi "tự mã hóa":
- Không xác thực được server
- Kẻ xấu có thể giả làm server (MITM)
- Khóa bí mật bị lộ
- Nếu bạn hardcode khóa trong app → hacker bóc tách là biết
- Không chống được replay attack
- Kẻ xấu gửi lại gói tin cũ → hệ thống bị lừa
- Sai cách dùng thuật toán
- Dùng AES ở chế độ ECB → dễ bị bẻ mã
- Không có forward secrecy
- Nếu khóa bị lộ → toàn bộ dữ liệu trong quá khứ bị giải mã

👉 Đây là lý do các chuyên gia nói:

"Don't roll your own crypto" – Đừng tự viết mã hóa. 

> cách dùng an toàn đối với game 
- VPN (WireGuard)
- SSH tunnel
- Tường lửa + IP whitelisting

## sesion 
tầng 5: 
    session, token , cookie
> tránh nhầm lần session trạng thái và package data
- trong L5 session chỉ là trạng thái lí thuyết ko có gói tin
- đưa ra chi thị socket


## transport 

tầng 4 : 
    giao thức đáng tin cậy , port 
### Ports & Networking 

| Port | Protocol/Service | Description | Transport |
|------|-----------------|-------------|-----------|
| 20-21 | FTP | File Transfer Protocol | TCP |
| 22 | SSH | Secure Shell (remote login, file transfer, tunneling) | TCP |
| 23 | Telnet | Remote text communication (insecure) | TCP/UDP |
| 25 | SMTP | Email transfer between servers | TCP |
| 53 | DNS | Domain Name System (hostname ↔ IP) | TCP/UDP |
| 69 | TFTP | Trivial File Transfer Protocol | UDP |
| 80 | HTTP | Unencrypted web traffic | TCP |
| 110 | POP3 | Email retrieval from server | TCP/UDP |
| 123 | NTP | Network Time Protocol | UDP |
| 135 | DCE/RPC | Endpoint Mapper | TCP/UDP |
| 139 | NetBIOS | Session Service | TCP/UDP |
| 161 | SNMP | Network management protocol | TCP/UDP |
| 389 | LDAP | Directory Access Protocol | TCP/UDP |
| 443 | HTTPS | Encrypted web traffic | TCP/UDP |
| 445 | SMB | Microsoft Directory Services & file sharing | TCP/UDP |
| 465 | SMTP (Secure) | Secure mail submission | TCP |
| 514 | Syslog | Logging protocol | UDP |
| 587 | SMTP | Email submission | TCP |
| 636 | LDAPS | Secure LDAP over SSL | TCP/UDP |
| 993 | IMAP | Secure mail retrieval | TCP |
| 995 | POP3 (Secure) | Secure email download | TCP/UDP |
| 1433 | MSSQL | Microsoft SQL Server | TCP |
| 1521 | Oracle DB | Oracle Database | TCP |
| 3306 | MySQL | MySQL Database | TCP |
| 3389 | RDP | Remote Desktop Protocol | TCP |
| 5060 | SIP | Session Initiation Protocol (VoIP) | TCP/UDP |
| 6881–6999 | BitTorrent | Peer-to-peer sharing | TCP/UDP |

---

> Ghi nhớ: **mở port = mở bề mặt tấn công** → firewall, principle of least privilege, ưu tiên giao thức mã hoá.

- nhận lệnh từ tầng 5 , mở port dynamic trên máy , add port dest
- xử lí flags from  UDP-TCP 

TCP Header:
  Source Port:  50000  ← do OS tự chọn
  Dest Port:    27015  ← từ config của app
  Sequence:     1000
  Flags:        SYN

## Network
tầng 3 :
    add IP

Máy tính không "hiểu" HTTP hay ENet — nó chỉ gửi/nhận gói tin IP chứa TCP hoặc UDP. 
> phải hiểu được custom protocol và tcp/IP udp/IP
- hệ điều hành có stach tcp/IP 
- OS: ko hiểu gói UDP/TCP -> có TCP/IP stack -> tạo gói IP 
- tìm và gán IP src và IP dest

IP Header:
  Source IP:      192.168.1.10   ← IP nội bộ của bạn
  Destination IP: 203.0.113.5    ← từ config app
  Protocol:       6              ← 6 = TCP, 17 = UDP
  TTL:            64


## Data link 
tầng 2  :
    add MAC 
    đóng gói __package__

   link MAC of router gateway, thiết bị 
```
+-----------------------------+
|   Destination MAC: aa:bb:cc:dd:ee:ff   ← MAC của router
|   Source MAC:     11:22:33:44:55:66   ← MAC của bạn
|   EtherType:      0x0800              ← Chỉ báo đây là IP
+-----------------------------+
|   [IP Header][TCP Header][HTTP Data]  ← Gói tin IP từ tầng 3
+-----------------------------+
|   FCS (Frame Check Sequence)          ← Kiểm tra lỗi
+-----------------------------+
```
- đóng gọi IP và macs thành Ethernet Frame

## Physical

tầng 1 : 
    truyền bit qua CAP (sóng, ánh sáng )

### Các thiết bị mạng

```
 [Laptop]───┐
            │ Wi-Fi
        ┌───▼───┐
        │  AP   │
        └───┬───┘
            │ Ethernet
       ┌────▼────┐
       │ Switch  │
       └────┬────┘
            │
   ┌────────▼─────────┐
   │     Router       │───Internet (WAN)
   └────────┬─────────┘
            │
      ┌─────▼──────┐
      │  Firewall  │
      └────────────┘

```


- Frame được chuyển cho card mạng (NIC)-> tín hiệu vật lý
  - Ethernet: Xung điện trên cáp.
  - Wi-Fi: Sóng radio (2.4GHz / 5GHz).

### Nat : 
- dịch IP public route thành các ip nội bộ trong lan 
 nat block ip packhage vì nó ko biết gói tin từ router vào là của local nào-> trước đó ko có connect ra , router huỷ gói tin 

### fire wall: 
- ngoài cấp phép chặn IP và mở port local thì nó còn làm gì nữa 

 ISP (Internet Service Provider)
  Proxy có thể lưu, chỉnh sửa, bán dữ liệu của bạn
  🕵️‍♂️ISP biết bạn dùng proxy


> tại sao ISP bắt được proxy mà ko bắt đc VPN
- thật ra thì vpn có thể thông qua dấu hiệu 
- nhưng mà vpn mã hoá -> iSP ko đọc đc package 
```
📌 DÙNG PROXY:
Bạn → ISP → [Proxy] → Internet
       ↑         ↑
       └── ISP thấy: bạn dùng proxy
               └── Proxy thấy: bạn làm gì

📌 DÙNG VPN:
Bạn → ISP → [Server VPN] → Internet
       ↑               ↑
       └── ISP thấy: bạn kết nối đến IP X
                       └── Server VPN thấy: bạn làm gì
                           (nhưng ISP thì KHÔNG thấy)
```
> vấn đề proxy còn tồn tại 
- vì nó xem được toàn bộ 
- một số hệ thống tận dụng điều này để Có thể: lọc, sửa ghi gói tin
- tốc đọ , dó ko mã hoá giống VPn

```
           ┌───────────┐
           │   LAN     │ (Văn phòng, nhà ở)
           └─────┬─────┘
                 │
 ┌───────────┐   │   ┌───────────┐
 │   WAN     │<──┼──>│   MAN     │
 │ (Internet)│   │   │ (Thành phố)│
 └───────────┘   │   └───────────┘
                 │
          ┌──────▼──────┐
          │    PAN      │ (Bluetooth, USB)
          └──────┬──────┘
                 │
          ┌──────▼──────┐
          │    VPN      │ (Mạng riêng ảo)
          └─────────────┘
```

## 2. COMPUTER NETWORKS  

### 2.2. Physical Layer
- Transmission media
  - Twisted pair (UTP, STP)
  - Coaxial cable
  - Fiber optic (single-mode, multi-mode)
  - Wireless (radio, microwave, infrared)
- Signal encoding
  - Analog vs Digital signals
  - Modulation (AM, FM, PM)
  - Line coding (NRZ, Manchester, etc.)
- Bandwidth, throughput, latency
- Multiplexing
  - FDM, TDM, WDM

### 2.3. Data Link Layer
- Framing
  - Byte stuffing, bit stuffing
- Error detection
  - Parity check
  - Checksum
  - CRC (Cyclic Redundancy Check)
- Error correction
  - Hamming code
- Flow control
  - Stop-and-Wait
  - Sliding Window (Go-Back-N, Selective Repeat)
- Medium Access Control (MAC)
  - CSMA/CD (Ethernet)
  - CSMA/CA (Wi-Fi)
  - Token Ring
- LAN technologies
  - Ethernet (IEEE 802.3)
  - MAC address
  - Switch vs Hub
  - VLAN

### 2.4. Network Layer
- IP (Internet Protocol)
  - IPv4 vs IPv6
  - IP address (classful, CIDR)
  - Subnetting, supernetting
  - Private IP, public IP
  - NAT (Network Address Translation)
- Routing
  - Forwarding vs Routing
  - Routing tables
  - Static vs Dynamic routing
  - Distance Vector (RIP)
  - Link State (OSPF)
  - Path Vector (BGP)
- ICMP (Internet Control Message Protocol)
  - Ping, Traceroute
- ARP (Address Resolution Protocol)
  - MAC-to-IP mapping
- DHCP (Dynamic Host Configuration Protocol)
  - IP assignment process

### 2.5. Transport Layer
- End-to-end communication
- UDP (User Datagram Protocol)
  - Connectionless
  - No reliability
  - Use cases: DNS, VoIP, video streaming
- TCP (Transmission Control Protocol)
  - Connection-oriented
  - Three-way handshake (SYN, SYN-ACK, ACK)
  - Sequence numbers, acknowledgment
  - Flow control (sliding window)
  - Congestion control
    - Slow start
    - Congestion avoidance
    - Fast retransmit, fast recovery
  - Retransmission, timeout
- Port numbers
  - Well-known ports (HTTP:80, HTTPS:443, etc.)
  - Ephemeral ports
- Socket programming
  - Client-server model
  - `socket()`, `bind()`, `listen()`, `accept()`, `connect()`, `send()`, `recv()`

### 2.6. Application Layer
- DNS (Domain Name System)
  - Hierarchical structure (root, TLD, authoritative)
  - DNS record types (A, AAAA, CNAME, MX, TXT)
  - Recursive vs Iterative queries
  - DNS caching
- HTTP / HTTPS
  - Request methods (GET, POST, PUT, DELETE)
  - Status codes (200, 404, 500, etc.)
  - Headers, body
  - Persistent vs non-persistent connections
  - Cookies, sessions
  - TLS/SSL handshake
- Email protocols
  - SMTP (Simple Mail Transfer Protocol)
  - POP3, IMAP
- WebSockets
  - Full-duplex communication
  - Use in real-time apps (chat, games)
- APIs (REST, gRPC)

### 2.7. Network Security (Basic)
- Encryption
  - Symmetric (AES)
  - Asymmetric (RSA)
  - TLS/SSL
- Firewalls
  - Packet filtering
  - Stateful inspection
- VPN (Virtual Private Network)
- DDoS attacks, phishing, malware

### 2.8. Advanced Concepts
- Quality of Service (QoS)
- Software-Defined Networking (SDN)
- Network Function Virtualization (NFV)
- Content Delivery Networks (CDN)
- Peer-to-Peer (P2P) networks
- Cloud networking (VPC, load balancer, NAT gateway)

---



