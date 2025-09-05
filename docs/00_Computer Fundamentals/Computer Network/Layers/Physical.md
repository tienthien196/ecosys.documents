---
title: Physical Layer
sidebar_position: 7
---


## Physical - Tầng 1
    
  - Truyền dẫn: truyền bit qua CAP (sóng, ánh sáng )
      Twisted Pair: UTP, STP
      Coaxial: Dùng trong CATV
      Fiber Optic: Single-mode (xa), Multi-mode (gần)
      Wireless: Radio, Microwave, Infrared, Wi-Fi
  - Tín hiệu:
      Analog vs Digital
      Modulation: AM, FM, PM
      Line Coding: NRZ, Manchester
  - Hiệu suất: Bandwidth, Throughput, Latency
  - Ghép kênh: FDM, TDM, WDM



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

```
  Hub - Phát sóng bit
  Switch - Chuyển tiếp theo MAC
  Router - Định tuyến theo IP
  Modem - Chuyển đổi tín hiệu
  Access Point - Kết nối Wi-Fi
  Firewall/- Lọc traffic
  Bridge - Nối hai LAN
```


### Nat: 
- dịch IP public route thành các ip nội bộ trong lan 
 nat block ip packhage vì nó ko biết gói tin từ router vào là của local nào-> trước đó ko có connect ra , router huỷ gói tin 

### Fire wall: 
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
> vấn đề proxy còn tồn tại ?
- vì nó xem được toàn bộ 
- một số hệ thống tận dụng điều này để Có thể: lọc, sửa ghi gói tin
- tốc độ , do ko mã hoá giống VPn



##  Phân loại mạng
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
  PAN (Personal Area Network): Trong phạm vi cá nhân < 10m Ví dụ: Bluetooth, USB
  LAN (Local Area Network): Tòa nhà, trường học – Ví dụ: Ethernet, Wi-Fi
  MAN (Metropolitan Area Network): Thành phố – Ví dụ: ISP
  WAN (Wide Area Network): Quốc gia, toàn cầu – Ví dụ: Internet
  WLAN: LAN không dây – Ví dụ: Wi-Fi
  SAN: Kết nối lưu trữ – Ví dụ: Fibre Channel
  VAN: Mạng riêng ảo theo ngành – Ví dụ: Ngân hàng

## Kiến trúc mạng (Topology)
  Bus: Đơn giản, ít cáp – Nhược: Dễ lỗi, khó mở rộng
  Star: Dễ quản lý – Nhược: Phụ thuộc vào switch
  Ring: Tốc độ ổn định – Nhược: Một điểm hỏng → toàn mạng
  Mesh: Độ tin cậy cao – Nhược: Chi phí cao
  Tree: Mở rộng tốt – Nhược: Phức tạp

## Chế độ truyền
  Simplex: Một chiều (TV)
  Half-duplex: Hai chiều, không đồng thời (bộ đàm)
  Full-duplex: Hai chiều đồng thời (điện thoại)

  Loại truyền:
    Unicast (1-1)
    Broadcast (1-tất cả)
    Multicast (1-nhóm)
    Anycast (1-gần nhất)

## Mạng không dây - Di động 

5.1. Wi-Fi (IEEE 802.11)
  - Chuẩn: a, b, g, n (Wi-Fi 4), ac (Wi-Fi 5), ax (Wi-Fi 6)
  - Tần số: 2.4 GHz, 5 GHz, 6 GHz
  - Kênh 2.4 GHz: Dùng kênh 1, 6, 11 để tránh nhiễu
  - Chế độ: Infrastructure, Ad-hoc

5.2. Mạng di động
  - 1G → 5G: Analog → Digital → Broadband → Ultra-low latency
  - 5G: eMBB, URLLC, mMTC

5.3. Công nghệ khác
  - Bluetooth: PAN, low energy
  - NFC: Thanh toán, truyền dữ liệu cự ly ngắn



