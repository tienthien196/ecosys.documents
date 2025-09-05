---
title: Network Layer
sidebar_position: 4
---

## Network - Tầng 3
- việc client hay server dùng OSI hay tcp/IP thì kiến trúc thực tế mà chúng giao tiếp với nhau là tcp/IP ?
- tại sao đã có tcp thì còn phải dùng HTTP ?


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


## Network Layer (Lớp 3)
  - IP: IPv4 (32-bit), IPv6 (128-bit)
  - Địa chỉ: Public, Private (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
  - CIDR: /24, /16 – thay thế classful
  - Subnetting: Số mạng = 2^n, Số host = 2^h - 2
  - NAT: Chuyển đổi địa chỉ
  - Định tuyến: Static, Dynamic (RIP, OSPF, BGP)
  - ICMP: ping, traceroute
  - ARP: IP ↔ MAC
  - DHCP: DORA (Discover → Offer → Request → Acknowledge)

## Công cụ dòng lệnh
  ping: Kiểm tra kết nối
  traceroute / tracert: Theo dõi đường đi
  ipconfig / ifconfig: Xem cấu hình mạng
  nslookup / dig: Tra DNS
  netstat: Xem kết nối
  tcpdump / Wireshark: Bắt gói tin