---
title: Application Layer
sidebar_position: 1
---


## tầng 7: Application
  - DNS: Phân giải tên miền
      Bản ghi: A, AAAA, CNAME, MX, TXT
      Truy vấn: Recursive, Iterative
  - HTTP/HTTPS:
      Methods: GET, POST, PUT, DELETE
      Status: 200, 404, 500
      HTTPS = HTTP + TLS
  - Email:
      SMTP (gửi), POP3 (tải về), IMAP (đồng bộ)
  - FTP/SFTP: Truyền file
  - WebSockets: Full-duplex, dùng cho chat
  - APIs: REST, gRPC


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


DNS : khởi nguồn ứng dụng 
- appliaction -> systemcall Net -> DNS server -> get IP = DOAMIN NAME
- app has IP -> connect server -> dùng  API

> note 
  - có thể dẫn tới DNS spoofing, DNS cache poisoning, man-in-the-middle attack (DNS UDP:53 ko đc bảo vệ)
  - DNS chặn web 
  - cấu hình sai DNS


> giao thức là gì /ko nhầm với API :
  - nó là các quy tắc chung đặt ra cho máy tính để chia sẽ data
  - giao thức là luật chia sẽ dữ liệu


> tại sao phải phân tầng OSI
  - thực ra thì có thể ko -> nhưng nếu làm vậy thì -> đòi hỏi chrome phải biết viết code  IP , TCP, MAC, driver  -> làm khó debug tìm lỗi , kém linh hoạt 




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


