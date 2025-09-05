---
title: OSI model
sidebar_position: 2
---

## Đầu tiên là hiểu về OSI - TCP/IP models


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



## Mô hình OSI (7 lớp)
  Lớp 7 - Application: Người dùng, dịch vụ mạng – Ví dụ: HTTP, FTP, DNS
  Lớp 6 - Presentation: Mã hóa, nén dữ liệu – Ví dụ: SSL/TLS, JPEG
  Lớp 5 - Session: Quản lý phiên – Ví dụ: SIP, RPC
  Lớp 4 - Transport: Truyền end-to-end – Ví dụ: TCP, UDP
  Lớp 3 - Network: Định tuyến, IP – Ví dụ: IP, ICMP, router
  Lớp 2 - Data Link: Frame, MAC – Ví dụ: Ethernet, switch
  Lớp 1 - Physical: Truyền bit – Ví dụ: Cáp, Wi-Fi, hub

  Đơn vị dữ liệu:
    Application → Message
    Transport → Segment (TCP) / Datagram (UDP)
    Network → Packet
    Data Link → Frame
    Physical → Bit


