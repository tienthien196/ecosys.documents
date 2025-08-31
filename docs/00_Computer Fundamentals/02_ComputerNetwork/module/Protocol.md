---
title: Network Protocol 
sidebar_position: 7
---



## Các giao thức mạng chính

### Giao thức tầng ứng dụng
- **HTTP/HTTPS**: Giao thức truyền siêu văn bản, sử dụng cho web.
- **DNS**: Chuyển đổi tên miền thành địa chỉ IP.
- **FTP/SFTP**: Truyền tệp tin giữa client và server.
- **SMTP/POP3/IMAP**: Giao thức cho email.
- **Ví dụ thực tế**:
  - Truy cập website qua HTTPS (port 443).
  - Sử dụng DNS để phân giải `google.com` thành `172.217.167.78`.

### Giao thức tầng giao vận
- **TCP (Transmission Control Protocol)**: Đảm bảo truyền dữ liệu đáng tin cậy, có kết nối, kiểm tra lỗi.
- **UDP (User Datagram Protocol)**: Truyền dữ liệu nhanh, không cần kết nối, không đảm bảo lỗi (dùng cho streaming, game).
- **Ví dụ thực tế**:
  - TCP: Tải xuống tệp tin qua FTP.
  - UDP: Truyền video trực tiếp qua Zoom.

### Giao thức tầng mạng
- **IP**: Định tuyến gói tin (IPv4, IPv6).
- **ICMP**: Kiểm tra trạng thái mạng (`ping`, `traceroute`).
- **ARP**: Ánh xạ IP sang MAC.
- **OSPF**: Giao thức định tuyến động.
- **Ví dụ thực tế**:
  - IPv6: Sử dụng `2001:0db8::1` cho mạng hiện đại.
  - ICMP: Kiểm tra kết nối bằng `ping 8.8.8.8`.

### Giao thức tầng liên kết dữ liệu
- **Ethernet**: Giao thức LAN phổ biến.
- **Wi-Fi (IEEE 802.11)**: Kết nối không dây (802.11ax/Wi-Fi 6).
- **PPP**: Kết nối điểm-điểm.
- **VLAN**: Phân tách lưu lượng mạng.
- **Ví dụ thực tế**:
  - Ethernet: Kết nối máy tính qua cáp Cat6.
  - VLAN: Tách mạng khách và nhân viên trong doanh nghiệp.




---






