---
title: Data Link
sidebar_position: 6
---


## tầng 2  : Data link 
  - Framing: Byte stuffing, Bit stuffing
  - Phát hiện lỗi: Parity, Checksum, CRC
  - Sửa lỗi: Hamming code
  - Kiểm soát luồng: Stop-and-Wait, Sliding Window (Go-Back-N, Selective Repeat)
  - MAC: CSMA/CD (Ethernet), CSMA/CA (Wi-Fi), Token Ring
  - LAN: Ethernet, MAC Address, Switch vs Hub, VLAN



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




## Chỉ số
  - Bandwidth: Tốc độ lý thuyết (Mbps, Gbps)
  - Latency: Độ trễ (ms)
  - Jitter: Biến thiên độ trễ
  - Throughput: Tốc độ thực tế
  - MTU: 1500 bytes (Ethernet)