```
+----------------------------------------------------------------------------------------------------------------------------------------+
|                                           GODOT CRYPTO CHEATSHEET (v3.6 / v4.5)                                                       |
|                             Mã hóa, băm, chữ ký số, HMAC – Bảo mật dữ liệu trong game và ứng dụng                                       |
+----------------------------------------------------------------------------------------------------------------------------------------+
| [CRYPTO - CORE] MÃ HÓA & CHỮ KÝ             | [HASHING] BĂM DỮ LIỆU                                  | [HMAC] XÁC THỰC DỮ LIỆU           |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| crypto.generate_rsa(4096) → tạo khóa RSA   | HashingContext.new()     → tạo context băm           | HMACContext.new() → tạo context  |
| crypto.encrypt(key, data) → mã hóa         | ctx.start(HASH_SHA256)   → bắt đầu băm                | ctx.start(HASH_SHA256, key) → bắt đầu|
| crypto.decrypt(key, enc) → giải mã         | ctx.update(data)         → cập nhật dữ liệu          | ctx.update(chunk) → cập nhật dữ liệu|
| crypto.sign(hash, data, key) → ký số       | ctx.finish()             → kết thúc, trả về hash     | ctx.finish() → trả về HMAC       |
| crypto.verify(...) → xác minh chữ ký       | HashingContext.HASH_MD5/SHA1/SHA256 → thuật toán     |                                   |
| crypto.hmac_digest(...) → tính HMAC nhanh  | hash_file(path) → băm file theo chunk                |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| [KEY & CERT] KHÓA & CHỨNG CHỈ               | [RANDOM & COMPARE] NGẪU NHIÊN & SO SÁNH               | [AES] MÃ HÓA ĐỐI XỨNG (AES)      |
|--------------------------------------------|--------------------------------------------------------|-----------------------------------|
| CryptoKey.new()            → tạo khóa      | crypto.generate_random_bytes(16) → 16 byte ngẫu nhiên| AESContext.new() → tạo context   |
| key.save("key.key")        → lưu khóa      | crypto.constant_time_compare(a, b) → so sánh an toàn | aes.start(MODE, key, iv)         |
| X509Certificate.new()      → tạo cert      |                                                        |  → MODE: ENCRYPT/DECRYPT         |
| cert.save("cert.crt")      → lưu cert      |                                                        | aes.update(data) → cập nhật dữ liệu|
| crypto.generate_self_signed_certificate(...)→ tạo cert tự ký|                                         | aes.finish() → kết thúc           |
|                                            |                                                        |                                   |
+--------------------------------------------+--------------------------------------------------------+-----------------------------------+
| GHI CHÚ:                                                                                                                               |
| • 🔐 AES yêu cầu: key = 16 hoặc 32 byte, IV = 16 byte, dữ liệu phải padding đến bội số của 16 (dùng PKCS7).                              |
| • 🔑 RSA dùng để mã hóa khóa hoặc ký số – không dùng để mã hóa dữ liệu lớn.                                                             |
| • 🧩 HMACContext cho phép cập nhật từng phần – lý tưởng cho stream hoặc file lớn.                                                       |
| • 📏 HashingContext hỗ trợ MD5, SHA-1, SHA-256 – SHA-256 là an toàn nhất.                                                               |
| • ⏱ constant_time_compare() chống tấn công thời gian – bắt buộc khi so sánh HMAC, token, mật khẩu.                                     |
| • 📁 X509Certificate dùng để xác thực máy chủ, ký dữ liệu, hoặc bảo mật mạng (HTTPS giả lập).                                           |
| • 🛡 Tất cả đều hoạt động trên PoolByteArray – dùng .to_utf8() và .get_string_from_utf8() để chuyển đổi chuỗi.                          |
+----------------------------------------------------------------------------------------------------------------------------------------+
```