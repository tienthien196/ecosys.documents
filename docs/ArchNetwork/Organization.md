---
sidebar_position: 2
---


### ***NOTE***
> ***TÀI LIỆU BUILD BY @GM Finn*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/) quy trình - int2out


## Đầu tiên là hiểu về OSI model

tầng: 7
    DNS
    tạo ra dữ liệu n từ gói tin , 
    giao thức  đặt quy tắt -> add header 

tầng 6: 
    mã hoá __package__ , cer , bảo mật , nén gói tin 

tầng 5: 
    session, token , cookie

tầng 4 : 
    giao thức đáng tin cậy , port 

tầng 3 :
    add IP

tầng 2  :
    add MAC 
    đóng gói __package__

tầng 1 : 
    truyền bit qua CAP (sóng, ánh sáng )

## Application
### quá tình giao tiếp mạng gồm 2 bước 
- việc client hay server dùng oSI hay tcp/IP thì kiến trúc thực tế mà chũng giao tiếp với nahu là tcp/IP
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

## xác thực 
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
> tránh nhầm lần session trạng thái và package data
- trong L5 session chỉ là trạng thái lí thuyết ko có gói tin
- đưa ra chi thị socket


## transport 
- nhận lệnh từ tầng 5 , mở port dynamic trên máy , add port dest
- xử lí flags from  UDP-TCP 

TCP Header:
  Source Port:  50000  ← do OS tự chọn
  Dest Port:    27015  ← từ config của app
  Sequence:     1000
  Flags:        SYN

## Network
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

## List cheat sheet  Layers of  OSI, tcp/IP  cần nắm !!!
- DNS hoạt động  
- giao thức hoạt động , các loại giao thức  

- xác thực : ssl, tsl 
- Crypto & PKI , Zero Trust ,  AAA/RADIUS

- port , UDP, TCP

- IP, MAC, NIC

- firewall, Nat 
- các loại mạng , VPN - proxy :hoạt động


### ***NOTE***
> ***TÀI LIỆU BUILD BY @GM Finn*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/) quy trình - int2out

