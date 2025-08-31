---
title: DNS
sidebar_position: 4
---


# 🌐 DNS (Domain Name System) 

> Tài liệu này là phần nối tiếp bộ **Network/VPN/Ports**: tập trung vào cách DNS hoạt động ở mức hệ thống, cấu trúc bản ghi, triển khai, bảo mật (DNSSEC, DoH/DoT), và troubleshooting.

<!--- -->

## Luồng phân giải DNS
```
+-----------+        query         +------------------+
|  Client   | -------------------> | Recursive Resolver|
| (Stub)    |                      +---------+--------+
+-----------+                                |
                                             | referrals
                                   +---------v----------+
                                   |   Root (.)  NS     |
                                   +---------+----------+
                                             |
                                   +---------v----------+
                                   |     TLD (.com)     |
                                   +---------+----------+
                                             |
                                   +---------v----------+
                                   | Authoritative NS   |
                                   +---------+----------+
                                             |
                                           answer
                                             |
+-----------+                                |
|  Client   | <------------------------------+
+-----------+
```
---

## 1 DNS là gì? (What & Why)
### Máy tính hiểu IP, con người thì biết domain -> Dùng DNS
**DNS** là hệ thống phân giải tên miền : doamin name -> IP
- Người dùng gõ `example.com` → hệ thống trả về **A/AAAA** (IPv4/IPv6).
- Ứng dụng/OS không phải nhớ IP, dễ thay đổi kiến trúc hạ tầng mà không làm gián đoạn người dùng.
- DNS còn làm nhiều việc hơn: email routing (MX), service discovery (SRV), chính sách bảo mật/ủy quyền (TXT, CAA)…

**Cổng & giao thức mặc định**
- Port **53/UDP** (truy vấn thông thường), **53/TCP** (truy vấn lớn/AXFR/IXFR hoặc khi UDP bị chặn/fragment).
- **DoT (DNS over TLS)**: TCP **853** Mã hóa DNS, tránh bị nghe lén
- **DoH (DNS over HTTPS)**: **443** (qua HTTPS) Gửi DNS qua HTTPS (ẩn trong web)
- **DoQ (DNS over QUIC)**: UDP **853** (được IANA cấp phát) Nhanh hơn DoH, ít độ trễ

---

## 2 Thành phần trong hệ sinh thái DNS
### Luồng phân giải (đơn giản hoá)
```ascii
[App/OS]
   │ 1. Query: example.com A?
   ▼
[Recursive Resolver]
   │ 2. Hỏi root (.) → chỉ đến .com
   ▼
[. Root NS]
   │ 3. Hỏi .com → chỉ đến NS của example.com
   ▼
[.com TLD NS]
   │ 4. Hỏi NS của zone example.com
   ▼
[Authoritative NS for example.com]
   │ 5. Trả lời A 93.184.216.34 (kèm TTL)
   ▼
[Recursive Resolver] (cache)
   │ 6. Trả về client (tôn trọng TTL)
   ▼
[App/OS]
```
- **Stub Resolver** (trên OS/app): hỏi recursive resolver.
- **Recursive Resolver** (còn gọi “resolver”/“caching resolver”): nhận từ client -> hỏi  **authoritative** và **cache** kết quả.
- **Authoritative Nameserver**: máy chủ **có thẩm quyền** cho một zone (trả lời dữ liệu gốc).
- **Registrar**: nơi đăng ký tên miền (liên kết domain ↔ nameserver thông qua **NS** tại registry).
- **Registry / TLD**: cơ quan quản lý TLD (ví dụ `.com`, `.vn`).


---

## 3 Zone, Delegation & Glue
- **Zone**: phạm vi dữ liệu DNS được quản trị thống nhất (ví dụ: zone `example.com.` trong file zone).
- **Delegation**: ủy quyền một nhánh con cho zone khác (ví dụ: `dev.example.com` do team khác quản lý).
- **Glue Record**: Khi NS của zone con dùng **hostname nằm trong chính zone đó**, cần bản ghi **A/AAAA “kèm keo”** ở zone cha để tránh vòng lặp tra cứu.

```ascii
Parent Zone: example.com.
  dev.example.com.  NS   ns1.dev.example.com.
  ns1.dev.example.com.  A  203.0.113.10   ; <-- glue tại zone cha
```

---

## 4 Các loại bản ghi (Record Types) -> Dánh dấu IP
- **A**: tên → IPv4
- **AAAA**: tên → IPv6
- **CNAME**: bí danh (alias) → *canonical name*. Không được đặt CNAME ở **apex** (gốc zone), trừ giải pháp **ALIAS/ANAME** của một số DNS providers.
- **MX**: định tuyến email (ưu tiên thấp hơn = ưu tiên cao hơn).
- **TXT**: đa dụng (SPF, DKIM, DMARC, domain verification…)
- **NS**: chỉ định nameserver có thẩm quyền cho (sub)zone.
- **SOA**: thông tin zone (serial, refresh, retry, expire, minimum/negative TTL).
- **SRV**: service discovery (ví dụ `_sip._tcp.example.com`).
- **CAA**: chỉ định CA nào được phép phát hành chứng chỉ cho domain.
- **PTR**: reverse DNS (IP → tên). Quản lý bởi chủ sở hữu block IP (thường là ISP/Cloud).

Ví dụ **zone file** rút gọn:
```zone
$ORIGIN example.com.
$TTL 3600
@       IN SOA  ns1.example.net. hostmaster.example.com. (
            20250822 ; serial (YYYYMMDD or increment)
            7200     ; refresh
            3600     ; retry
            1209600  ; expire
            300 )    ; negative caching (min TTL/NX)

        IN NS   ns1.example.net.
        IN NS   ns2.example.net.

; Web
@       IN A    203.0.113.20
@       IN AAAA 2001:db8::20
www     IN CNAME @

; Email
@       IN MX 10 mail.example.com.
mail    IN A 203.0.113.30
_dmarc  IN TXT "v=DMARC1; p=quarantine; rua=mailto:dmarc@example.com"
@       IN TXT "v=spf1 ip4:203.0.113.30 -all"
selector1._domainkey IN TXT "v=DKIM1; k=rsa; p=MIIBI..."

; Service Discovery
_sip._tcp IN SRV 10 60 5060 sip1.example.com.
sip1     IN A 203.0.113.40

; Certificate policy
@       IN CAA 0 issue "letsencrypt.org"
```

---

## 5 Caching & TTL (và “Propagation”)
- **TTL** (Time To Live) quyết định thời gian bản ghi được giữ trong cache của resolver/OS/browser.
- Thay đổi DNS **không “lan” ngay lập tức** – sẽ phụ thuộc TTL còn lại trong cache.
- **Negative Caching** (NXDOMAIN/NODATA) dùng giá trị trong **SOA minimum** / RFC 2308.
- Chiến lược deploy: hạ TTL (ví dụ 300s) **trước** khi cắt chuyển, đợi TTL cũ hết, rồi cập nhật bản ghi.

---

## 6 Recursion Control, Forwarder, Split-Horizon
- **Open Resolver** (để Internet truy vấn tùy ý) → **KHÔNG KHUYÊN DÙNG** (rủi ro DDoS amplification, lạm dụng). Chỉ bật recursion cho mạng nội bộ/trusted.
- **Forwarder**: Resolver chuyển toàn bộ truy vấn đến một upstream (ví dụ public DNS như 1.1.1.1/8.8.8.8) để đơn giản hoá quản trị/ghi log.
- **Split-Horizon / Split-Brain DNS**: Cùng một tên nhưng trả IP khác nhau cho **internal** vs **public** (hữu ích cho hybrid cloud, zero-trust).

---

## 7 DNSSEC, DoT/DoH/DoQ & Bảo mật
- **DNSSEC**: Ký số dữ liệu DNS để chống giả mạo (origin authentication, data integrity). Gồm các bản ghi **RRSIG, DNSKEY, DS, NSEC/NSEC3**.
  - Chain of trust: Root (.) → TLD → Domain (DS record tại zone cha trỏ đến DNSKEY của zone con).
  - Triển khai cần xoay **key rollover** đúng quy trình.
- **DoT (DNS over TLS)**: Mã hoá truy vấn DNS qua TLS (port 853).
- **DoH (DNS over HTTPS)**: DNS qua HTTPS (port 443), dễ vượt proxy/kiểm duyệt, tích hợp trình duyệt.
- **DoQ (DNS over QUIC)**: Độ trễ thấp, tránh head-of-line blocking (UDP 853).
- **TSIG**: Ký MAC (symmetric) để bảo vệ **zone transfer** (AXFR/IXFR) & dynamic updates.
- **RRL/ACL**: Response Rate Limiting & Access Control Lists để giảm thiểu amplification/dga abuse.

**Amplification Attack** – vì sao?  
- Truy vấn nhỏ → đáp lớn (đặc biệt với **ANY**, DNSSEC, EDNS0), kẻ xấu giả mạo **source IP** của nạn nhân.
- Giảm thiểu: tắt open recursion, RRL, hạn chế ANY, BCP-38 (ingress filtering).

---

## 8 Tooling & Troubleshooting (dig/nslookup/drill/kdig)
Các lệnh mẫu (Linux/macOS; trên Windows dùng `nslookup` hoặc PowerShell `Resolve-DnsName`):

```bash
# Truy vấn A & theo dõi đường đi (trace từ root)
dig +trace example.com A

# Truy vấn cụ thể đến 1 NS
dig @8.8.8.8 example.com A

# MX, NS, TXT
dig example.com MX
dig example.com NS
dig example.com TXT

# Kiểm tra DNSSEC
dig example.com A +dnssec
dig example.com DS +dnssec

# Kiểm tra CAA
dig example.com CAA

# Kiểm tra reverse (PTR) cho IPv4
dig -x 203.0.113.30

# EDNS0, kích thước UDP, và fallback TCP
dig example.com A +edns=0 +bufsize=1232 +tcp

# Windows PowerShell
Resolve-DnsName example.com -Type A
Resolve-DnsName example.com -Type MX
```

**Trường hợp thường gặp**
- “Propagation chậm”: do cache còn hạn, TTL lớn, resolver trung gian.
- “Email không đến”: thiếu/bị sai **MX/SPF/DKIM/DMARC**; PTR không khớp IP gửi.
- “Không trỏ CNAME ở apex”: dùng **ALIAS/ANAME** của provider, hoặc chuyển qua A/AAAA.
- “NXDOMAIN vs NODATA”: domain không tồn tại vs tồn tại nhưng không có record query type.
- “Glue lỗi thời”: thay NS/host mà quên cập nhật A/AAAA tương ứng ở zone cha.

---

## 9 Thực tiễn tốt (Best Practices)
- **Thiết kế TTL hợp lý**: 300–3600s cho dịch vụ động; cao hơn cho bản ghi ổn định (NS/SOA cân nhắc).
- **Bảo vệ zone transfer**: chỉ cho phép AXFR/IXFR với secondary đã xác thực (TSIG/ACL/VPN).
- **Giảm tấn công**: tắt open recursion, bật RRL, lọc ANY, theo dõi log.
- **Email hygiene**: triển khai **SPF, DKIM, DMARC**, reverse PTR phù hợp.
- **Giám sát**: health-check authoritative, theo dõi **serial** tăng đều (SOA).
- **Anycast authoritative/recursive** để tăng SLA, giảm latency khu vực.
- **IaC cho DNS**: quản lý zone bằng GitOps/Terraform/OctoDNS để review/rollback dễ dàng.

---

## 10 Phụ lục: Sơ đồ tổng quan
```ascii
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

---

### Tóm tắt
- DNS phân giải **tên → dữ liệu** (phổ biến nhất là **IP**), dựa trên hệ thống **authoritative + caching**.
- Nắm chắc **record types**, **TTL/cache**, **delegation/glue**, và **bảo mật (DNSSEC/DoH/DoT/DoQ)** là chìa khoá để vận hành hệ thống hiện đại.

### ***NOTE***
> ***TÀI LIỆU BUILD BY @GM Finn*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/)