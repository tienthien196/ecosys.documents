
## tầng 6: Presentation

  - Mã hóa: AES (đối xứng), RSA (bất đối xứng)
  - TLS/SSL: Bảo mật HTTPS
  - Firewall: Lọc gói tin
  - VPN: Mạng riêng ảo
  - IDS/IPS: Phát hiện xâm nhập
  - Các mối đe dọa: DDoS, Phishing, Malware
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





