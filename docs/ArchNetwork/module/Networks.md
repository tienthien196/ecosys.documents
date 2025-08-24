---
title: Networks
sidebar_position: 3
---


### Các loại mạng
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

- **LAN (Local Area Network)**: Mạng nội bộ, phạm vi nhỏ (văn phòng, nhà ở).
- **WAN (Wide Area Network)**: Mạng diện rộng, kết nối các khu vực địa lý (Internet).
- **MAN (Metropolitan Area Network)**: Mạng đô thị, kết nối trong một thành phố.
- **PAN (Personal Area Network)**: Mạng cá nhân (Bluetooth, USB).
- **VPN (Virtual Private Network)**: Mạng riêng ảo, mã hóa dữ liệu qua Internet. 
- **Ví dụ thực tế**:
  - LAN: Mạng Wi-Fi trong nhà.
  - WAN: Kết nối Internet giữa các quốc gia.
  - VPN: Sử dụng OpenVPN để truy cập mạng công ty từ xa.


## 🔐 VPN (Virtual Private Network)
VPN là một **mạng riêng ảo** được thiết lập trên hạ tầng mạng công cộng (Internet), cho phép:
- **Mã hóa (Encryption)**: Toàn bộ traffic giữa client ↔ VPN server được mã hóa.
- **Định tuyến (Routing)**: Traffic từ client được định tuyến qua VPN server trước khi đến đích.
- **Ẩn IP**: Server/website chỉ thấy IP của VPN server, không thấy IP thực.

👉 Từ góc nhìn dev: VPN giống như một **network overlay** hoạt động ở tầng OSI Layer 3 (Network Layer), thiết lập một **tunnel** encapsulating IP packets.

---

## 2. Mô hình hoạt động

### 🔹 Truy cập Internet không dùng VPN
```ascii
[Client Device] ---ISP---> [Destination Server]
       | (IP thật, data raw, dễ bị sniff)
```

### 🔹 Truy cập Internet qua VPN
```ascii
[Client Device] --Encrypted Tunnel--> [VPN Server] ---> [Destination Server]
       |                 |                 |
       |   Data mã hóa   |   Giải mã       |  IP hiển thị = IP VPN
       |   (AES, TLS)    |                 |
```

- ISP chỉ thấy client kết nối đến **VPN server**, không thấy website thật.
- Destination server thấy request đến từ **VPN server IP**, không phải IP thật của client.

---

## 3. Kỹ thuật cốt lõi
- **Tunneling**: Gói tin gốc (original packet) được bọc (encapsulated) trong một gói mới.  
  Ví dụ: `IP over UDP`, `IPSec over IP`.
- **Encryption**: 
  - AES-256 (phổ biến trong OpenVPN, WireGuard).
  - ChaCha20 (dùng trong WireGuard).
- **Authentication**:  
  - Username/password, certificate, hoặc EAP (Extensible Authentication Protocol).
- **Key Exchange**: Diffie–Hellman, Elliptic Curve DH, IKEv2.

---

## 4. Giao thức VPN phổ biến
| Protocol | Layer | Ưu điểm | Nhược điểm |
|----------|-------|---------|------------|
| PPTP | L2 | Dễ cài, nhanh | Bảo mật yếu (deprecated) |
| L2TP/IPSec | L2 + L3 | Bảo mật khá | Tốc độ chậm do double encapsulation |
| OpenVPN | L4 (TCP/UDP) | Linh hoạt, open-source, mạnh | Cấu hình phức tạp hơn |
| IKEv2/IPSec | L3 | Ổn định, reconnect nhanh | Khó triển khai cross-platform |
| WireGuard | L3 | Codebase nhỏ, nhanh, secure | Chưa phổ biến trên tất cả OS |

---

## 5. Trường hợp sử dụng cho Developer
- **Remote DevOps**: SSH vào server nội bộ qua VPN thay vì mở port public.
- **Secure API Access**: Giới hạn API chỉ cho phép gọi từ IP của VPN.
- **CI/CD Pipeline**: Build agent kết nối qua VPN vào network công ty.
- **Game Development**: Che giấu traffic test, tránh bị sniff packet khi dev game online.
- **Bypass Geo-block**: Test app/web từ nhiều quốc gia.

---

## 6. Ưu – Nhược điểm

### Ưu điểm
- 🛡️ Bảo mật dữ liệu traffic.
- 🕶️ Ẩn danh IP thật.
- 🌍 Vượt kiểm duyệt Internet.
- 🖥️ Cho phép remote access vào LAN công ty.

### Nhược điểm
- 🐌 Overhead mã hóa → tốc độ giảm.
- 📊 VPN provider có thể log traffic (nếu không chọn cẩn thận).
- 🚫 Một số dịch vụ detect & block IP VPN.

---

## 7. Sơ đồ network tổng quát

```ascii
+-----------+         +-----------+         +------------------+
|  Client   | ======> | VPN Server| ======> | Destination Host |
|  (Laptop) |  TLS    |  (Gateway)|   IP    |   (Web/API/Game) |
+-----------+         +-----------+         +------------------+
       ^                    ^
       |                    |
   Encrypt traffic      Decrypt traffic
```

---

## 8. Best Practices cho Dev
- Sử dụng **WireGuard** hoặc **OpenVPN** thay vì PPTP.
- Dùng **Split tunneling** khi không cần tất cả traffic đi qua VPN (giảm latency).
- Triển khai **Self-hosted VPN** (vd: OpenVPN, WireGuard trên VPS) khi muốn toàn quyền kiểm soát.
- Luôn kiểm tra **DNS Leak** và **WebRTC Leak** khi dev ứng dụng web liên quan đến bảo mật.
- Với microservices: có thể dùng VPN để nối các cluster trên nhiều cloud provider.

---

## 9. Kết luận
VPN không chỉ để "fake IP" hay "xem Netflix US" 😄.  
Với developer, nó là **một công cụ hạ tầng quan trọng** giúp:
- Thiết lập môi trường dev/test an toàn.
- Bảo mật kết nối đến resource nội bộ.
- Kiểm thử ứng dụng từ nhiều region.


### ***NOTE***
> ***TÀI LIỆU BUILD BY @GM Finn*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/)
