---
title: Crypto
sidebar_position: 8
---

# AAA/RADIUS + FortiToken + Zero Trust Architecture (NIST SP 1800-35B)

> **Phiên bản**: 2025-08-22  
> Tài liệu này giải thích chi tiết về AAA, RADIUS, FortiToken (2FA/MFA), và Zero Trust Architecture (ZTA) theo NIST SP 1800-35B, tích hợp với các xu hướng bảo mật hiện đại (SASE, FIDO2) để hỗ trợ học tập và triển khai thực tế.

## Mục Lục
- [Giới thiệu](#giới-thiệu)
- [AAA & RADIUS & FortiToken (2FA/MFA)](#aaa--radius--fortitoken-2famfa)
  - [AAA là gì](#aaa-là-gì)
  - [RADIUS căn bản](#radius-căn-bản)
  - [RADIUS trên FortiGate – Cấu hình & Kiểm thử](#radius-trên-fortigate--cấu-hình--kiểm-thử)
  - [Hai yếu tố xác thực & OTP/FortiToken](#hai-yếu-tố-xác-thực--otpfortitoken)
- [Zero Trust Architecture (ZTA) – NIST SP 1800-35B](#zero-trust-architecture-zta--nist-sp-1800-35b)
  - [Collaborators & CRADA](#collaborators--crada)
  - [Document Conventions & Call for Patent Claims](#document-conventions--call-for-patent-claims)
  - [Tổng quan kiến trúc tham chiếu ZTA](#tổng-quan-kiến-trúc-tham-chiếu-zta)
  - [Thành phần cốt lõi ZTA](#thành-phần-cốt-lõi-zta)
  - [Thành phần hỗ trợ & ngữ cảnh](#thành-phần-hỗ-trợ--ngữ-cảnh)
  - [Luồng hoạt động ZTA điển hình](#luồng-hoạt-động-zta-điển-hình)
  - [Các pha triển khai](#các-pha-triển-khai)
  - [Kiến trúc phòng lab & kịch bản doanh nghiệp](#kiến-trúc-phòng-lab--kịch-bản-doanh-nghiệp)
  - [Năng lực tiêu biểu của vendor](#năng-lực-tiêu-biểu-của-vendor)
- [Phụ lục A – Bảng từ viết tắt](#phụ-lục-a--bảng-từ-viết-tắt)
- [Phụ lục B – Thuật ngữ nhanh](#phụ-lục-b--thuật-ngữ-nhanh)
- [Phụ lục C – Mẫu cấu hình & lệnh kiểm thử](#phụ-lục-c--mẫu-cấu-hình--lệnh-kiểm-thử)
- [Phụ lục D – Tip ghi nhớ & lộ trình ôn tập](#phụ-lục-d--tip-ghi-nhớ--lộ-trình-ôn-tập)

---

## Giới thiệu
Tài liệu này cung cấp hướng dẫn về **AAA (Authentication, Authorization, Accounting)**, giao thức **RADIUS**, triển khai **2FA/MFA** với FortiToken, và kiến trúc **Zero Trust (ZTA)** theo NIST SP 1800-35B. Nội dung tích hợp các công nghệ bảo mật hiện đại như **SASE**, **FIDO2**, và **AI-driven threat detection**, phù hợp với các hệ thống mạng năm 2025.

**Mục tiêu học tập**:
- Hiểu cách triển khai AAA/RADIUS và 2FA/MFA trên FortiGate.
- Nắm quy trình hoạt động và triển khai ZTA theo NIST.
- Áp dụng thực tế qua cấu hình, kiểm thử, và lab (TryHackMe, Cisco Secure).

---

## AAA & RADIUS & FortiToken (2FA/MFA)

### AAA là gì
- **Authentication (AuthN)**: Xác minh danh tính (username/password, token).
- **Authorization (AuthZ)**: Phân quyền truy cập dựa trên vai trò/chính sách.
- **Accounting (Acct)**: Ghi log hoạt động để audit, billing, hoặc phân tích.

### RADIUS căn bản
- **Giao thức**: Remote Authentication Dial-In User Service, dùng UDP (port **1812** cho Auth, **1813** cho Accounting; cổng 1645/1646 ít dùng hiện nay).
- **Quy trình**:
  - Client (FortiGate) gửi **ACCESS-REQUEST** đến RADIUS server.
  - Server trả về: **ACCESS-ACCEPT** (cho phép), **ACCESS-REJECT** (từ chối), hoặc **ACCESS-CHALLENGE** (yêu cầu thêm yếu tố xác thực).
- **Phương thức xác thực**: PAP, CHAP, MS-CHAPv2, EAP (như EAP-TLS, EAP-PEAP).
- **VSA (Vendor-Specific Attributes)**: Thuộc tính tùy chỉnh của vendor, ví dụ Fortinet VSA để hỗ trợ nhóm người dùng hoặc chính sách.
- **Ví dụ thực tế**: Xác thực VPN user qua RADIUS trên FortiGate.

```
+-----------------+            +----------------------------+            +------------------+
|      User       |            |  RADIUS Client: FortiGate  |            |  RADIUS Server   |
| (Alice/Bob, v.v)|            |        (NGFW/VPN)          |            | (FreeRADIUS, AD) |
+--------+--------+            +---------------+------------+            +---------+--------+
         |                                     |                                     |
         | 1) Credentials (username/password)  |                                     |
         +------------------------------------->                                     |
         |                                     | 2) ACCESS-REQUEST (PAP/CHAP/EAP...) |
         |                                     +------------------------------------->
         |                                     |                                     |
         |                                     | 3) ACCESS-ACCEPT / REJECT /         |
         |                                     |    CHALLENGE (OTP, step-up)         |
         |                                     <-------------------------------------+
         |                                     |                                     |
         | 4) Allow/Deny (VPN/Portal/Admin)    |                                     |
         <-------------------------------------+                                     |
         |                                     |                                     |
         |                                     | 5) Accounting-Start/Interim/Stop    |
         |                                     +--------------------+---------------->+
         |                                     |                    |                 |
         |                                     |                    v                 |
         |                                     |       +---------------------------+ |
         |                                     |       |      Accounting Log       | |
         |                                     |       | (RADIUS detail/SQL/CSV)   | |
         |                                     |       +---------------------------+ |
         |                                     |                                     
```

### RADIUS trên FortiGate – Cấu hình & Kiểm thử
- **GUI**: *User & Authentication → RADIUS Servers*.
- **CLI**:
  ```bash
  config user radius
      edit "corp-radius"
          set server "10.0.0.10"
          set secret ENC <your_secret>
          set auth-type mschap2
          set timeout 5
      next
  end

  # Gắn vào user group
  config user group
      edit "grp-rad-users"
          set member "corp-radius"
      next
  end
  ```
- **Kiểm thử**:
  ```bash
  diagnose test authserver radius corp-radius alice Password@123
  # Kết quả: success/failure + group membership
  ```
- **Lưu ý**:
  - FortiGate phải được khai báo là client trên RADIUS server.
  - Cấu hình backup server để tăng tính sẵn sàng.
  - Tránh bật “Include in every User Group” trừ trường hợp đặc biệt.

### Hai yếu tố xác thực & OTP/FortiToken
- **2FA/MFA**: Kết hợp **password** (biết) + **token/OTP** (có) + **biometrics** (là, tùy chọn).
- **OTP**: Mã một lần, sống ngắn (thường 60s), ví dụ FortiToken Mobile.
- **Phương thức phân phối**:
  - **FortiToken 200**: Hard token, dùng seed ban đầu.
  - **FortiToken Mobile**: Soft token, cần activation code.
  - **Email/SMS**: Gửi OTP qua email hoặc SMS.
  - **Mobile Push**: Push notification qua app.
  - **FIDO2/WebAuthn**: Chuẩn passwordless, dùng hardware key (YubiKey).
- **Quản trị FortiToken**:
  - Hard token: Import danh sách serial.
  - Soft token: Mỗi FortiGate có 2 activation miễn phí, thêm phải mua.
  - One-to-One: Một token chỉ dùng cho một FortiGate/FortiAuthenticator.
- **Đồng bộ thời gian**: Sử dụng NTP để khớp giờ giữa token và server.
- **Ví dụ thực tế**: Cấu hình FortiToken Mobile trên FortiGate:
  ```bash
  config user fortitoken
      edit "FTKMOB1234567890"
          set type mobile
          set status active
      next
  end
  ```

```
+------+           +----------------------------+            +------------------+
|User  |           |  FortiGate (RADIUS client) |            |  RADIUS Server   |
+--+---+           +---------------+------------+            +---------+--------+
   |                           (a) | ACCESS-REQUEST (user/pass)         |
   |-------------------------------->                                    |
   |                                 |                                    |
   |                      (b) ACCESS-CHALLENGE (Enter OTP)               |
   |<--------------------------------+                                    |
   |  Nhập OTP trên FortiToken       |                                    |
   |  (mobile/hard token/push)       |                                    |
   |                           (c) | ACCESS-REQUEST (kèm OTP)            |
   |-------------------------------->                                    |
   |                                 | (d) ACCESS-ACCEPT (hoặc REJECT)   |
   |<--------------------------------+------------------------------------+
   |                                 |                                    |
   |=====> Cho phép truy cập (VPN/Portal/Admin)                           |
```


---

## Zero Trust Architecture (ZTA) – NIST SP 1800-35B

### Collaborators & CRADA
- **Collaborators**: Appgate, AWS, Cisco, Microsoft, Okta, Palo Alto Networks, Zscaler, Ping Identity, Radiant Logic, SailPoint, và nhiều vendor khác.
- **CRADA**: Hợp tác nghiên cứu và phát triển với NIST để xây dựng lab ZTA đa nhà cung cấp.

### Document Conventions & Call for Patent Claims
- **Conventions**: 
  - **shall/shall not**: Bắt buộc.
  - **should/should not**: Khuyến nghị.
  - **may/need not**: Tùy chọn.
  - **can/cannot**: Khả năng.
- **Patent Claims**: NIST yêu cầu công bố bằng sáng chế thiết yếu, cam kết cấp phép công bằng hoặc không bồi hoàn.

### Tổng quan kiến trúc tham chiếu ZTA
- **Tư tưởng**: “Không tin tưởng mặc định, luôn xác minh, cấp quyền tối thiểu, giám sát liên tục.”
- **Mô hình**:

```
          +-------------------+
          |   Subject         |  (User / Service / App)
          | (Identity holder) |
          +----+--------------+
               | Request
               v
        +------+-------------------------+
        |   PEP (Policy Enforcement)     |  <== điểm thực thi (gateway/proxy/agent)
        +------+-------------------+-----+
               |                   |
     Attributes|/Telemetry         | Decision (allow/deny/step-up)
               v                   |
        +------+-------------------v-----+
        |  PA (Policy Administrator)     |  (apply/enforce config on PEP)
        +------+-------------------+-----+
               | Policy query/eval |
               v                   |
        +------+-------------------v-----+
        |     PE (Policy Engine)         |  (risk & ABAC evaluation)
        +--+--------------------+--------+
           |                    |                 Context Inputs
           |                    |                 --------------
           |               +----v----+       +----v----+     +---------+
           |               |  IdP/   |       | Device  |     |  SIEM/  |
           |               |  ICAM   |       |  Posture|     |  NDR/   |
           |               |(SSO/MFA)|       |(EDR/MDM)|     |  UEBA   |
           |               +----+----+       +----+----+     +----+----+
           |                    |                 |               |
           +--------------------+-----------------+---------------+
                                |                 |               |
                                v                 v               v
                            Identity Atrs     Device Trust     Threat Intel

               +----------------------------------------------------------+
               |                     Resource                              |
               |     (App/API/Data – on‑prem, cloud, SaaS)                |
               +----------------------------------------------------------+
```

### Thành phần cốt lõi ZTA
- **Policy Engine (PE)**: Ra quyết định dựa trên chính sách, thuộc tính, và rủi ro.
- **Policy Administrator (PA)**: Chuyển quyết định thành lệnh cho PEP.
- **Policy Enforcement Point (PEP)**: Thực thi quyết định (allow/deny/quarantine), thường ở edge hoặc gần tài nguyên.
- **ICAM**: Quản lý danh tính, xác thực, và vòng đời thuộc tính.
- **Posture/Telemetry**: Thu thập trạng thái thiết bị (EDR, MDM) và ngữ cảnh (SIEM, NDR).
- **Data/Applications**: Tài nguyên mục tiêu (on-prem, cloud, SaaS).

### Thành phần hỗ trợ & ngữ cảnh
- **Device Security**: EDR, MDM, mã hóa đĩa, kiểm tra patch level.
- **Network Security**: Micro-segmentation, SASE, TLS inspection, DNS security (DoH/DoT).
- **Data Security**: DLP, encryption, tokenization.
- **Observability**: SIEM, SOAR, UEBA, threat intelligence.
- **PKI**: Quản lý chứng thư số (DigiCert).

### Luồng hoạt động ZTA điển hình
1. **Request**: User/app yêu cầu truy cập tài nguyên.
2. **Collect**: PEP/PA thu thập thuộc tính (danh tính, thiết bị, vị trí, rủi ro).
3. **Decide**: PE đánh giá chính sách (ABAC, risk-based).
4. **Enforce**: PEP thực thi (allow/deny/step-up auth).
5. **Monitor**: Liên tục tái đánh giá dựa trên telemetry.

```
(1) Subject ---> (2) PEP ---> (3) PA ---> (4) PE ---> Decision ---> back to PA/PEP
        |             |             |            ^
        |             |             |            |
        |             |             +----- pulls identity from IdP/ICAM
        |             |                          and device posture (EDR/MDM)
        |             |--------------------------> collects attributes/telemetry
        |
        +----> On success: PEP grants scoped access to Resource (least privilege)
```

### Các pha triển khai
- **Crawl**: Kiểm kê tài nguyên/danh tính, triển khai ICAM, chính sách cơ bản.
- **Walk**: Thử nghiệm micro-segmentation, tích hợp EDR/MDM.
- **Run**: Tự động hóa (SOAR), continuous evaluation, mở rộng toàn tổ chức.

### Kiến trúc phòng lab & kịch bản doanh nghiệp
- **Môi trường**: Enterprise (on-prem), Cloud (AWS/Azure), Branch, Remote.
- **Kịch bản**: VPN, SaaS access, ứng dụng nội bộ, IoT/OT.
- **Mục tiêu**: Chứng minh khả năng liên hoạt động đa vendor.

### Năng lực tiêu biểu của vendor
- **Ping Identity**:
  - **PingAccess**: Quản lý truy cập linh hoạt (SaaS, on-prem).
  - **PingDirectory**: Directory hiệu năng cao, hỗ trợ LDAP/SCIM.
- **Radiant Logic**:
  - **RadiantOne**: Identity Data Fabric, hợp nhất danh tính từ nhiều nguồn.
  - **SSO**: Hỗ trợ SAML, OAuth, OpenID Connect.
- **SailPoint**:
  - **IdentityIQ**: Quản trị danh tính, tự động hóa provisioning, SoD.
- **Zscaler**:
  - **ZIA/ZPA**: SASE, cung cấp ZTNA và micro-segmentation.
- **Ví dụ thực tế**: Triển khai ZTNA với Zscaler:
  ```bash
  # Cấu hình ZPA connector
  zpa connector create --name "zpa-connector" --ip "10.0.0.100"
  ```

---

## Phụ lục A – Bảng từ viết tắt
- **AAA**: Authentication, Authorization, Accounting
- **ABAC**: Attribute-Based Access Control
- **CDM**: Continuous Diagnostics & Mitigation
- **EDR**: Endpoint Detection & Response
- **ICAM**: Identity, Credential, and Access Management
- **IGA**: Identity Governance & Administration
- **MFA**: Multi-Factor Authentication
- **NDR**: Network Detection & Response
- **NTP**: Network Time Protocol
- **OTP**: One-Time Password
- **PA/PE/PEP**: Policy Admin/Engine/Enforcement Point
- **SASE**: Secure Access Service Edge
- **SIEM**: Security Information & Event Management
- **SoD**: Separation of Duties
- **VSA**: Vendor-Specific Attributes
- **ZTA**: Zero Trust Architecture

---

## Phụ lục B – Thuật ngữ nhanh
- **Least Privilege**: Cấp quyền tối thiểu cần thiết.
- **Continuous Evaluation**: Tái thẩm định truy cập dựa trên ngữ cảnh.
- **Micro-segmentation**: Chia nhỏ mạng để hạn chế lateral movement.
- **Posture**: Trạng thái an toàn thiết bị (patch, AV, encryption).
- **Trust Algorithm**: Công thức kết hợp thuộc tính và rủi ro.

---

## Phụ lục C – Mẫu cấu hình & lệnh kiểm thử
### C.1 FortiGate – RADIUS
```bash
config user radius
    edit "corp-radius"
        set server "10.0.0.10"
        set secret ENC <your_secret>
        set auth-type mschap2
        set timeout 5
    next
end
```

### C.2 Kiểm thử RADIUS
```bash
diagnose test authserver radius corp-radius alice Password@123
```

### C.3 Kiểm tra TCP/UDP
```bash
# Bắt tay TCP
tcpdump -nn -i any 'tcp[tcpflags] & (tcp-syn|tcp-ack) != 0'

# Kiểm tra UDP port
nc -vzu target.example.com 1812
```

### C.4 Kiểm tra ZTNA policy
```bash
# Zscaler ZPA kiểm tra kết nối
zpa status --connector-id "zpa-connector"
```

---

### ***NOTE***
> ***TÀI LIỆU BUILD BY @GM Finn*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/)

##  Bảo mật , nén , mã hoá  


###  AAA/RADIUS – Chu trình xác thực (ví dụ FortiGate)
```
[User] → credentials → [RADIUS Client (FortiGate)]
    └─► ACCESS-REQUEST ─────────────────────────────►
                    [RADIUS Server]
           (PAP/CHAP/MS-CHAPv2/EAP, VSA)
   ◄─ ACCESS-ACCEPT / ACCESS-REJECT / ACCESS-CHALLENGE ─┘

Accounting:
[RADIUS Client] ── Start/Interim/Stop → [RADIUS Server] (UDP 1813)
```
> Mẹo: cấu hình **secret**, khai báo client trên server, **test connectivity/credentials**, cân nhắc **2FA/OTP**.

- **AAA**: Authentication (xác thực), Authorization (phân quyền), Accounting (ghi log).
- **RADIUS**: Giao thức xác thực qua UDP 1812 (auth), 1813 (accounting).
- **Ví dụ thực tế**: Cấu hình FortiGate với RADIUS server để xác thực VPN users, sử dụng 2FA (FortiToken).

---


### Crypto & PKI (rút gọn)

| Loại        | Mô tả                              | Ví dụ             |
|-------------|------------------------------------|-------------------|
| Symmetric   | Nhanh, dùng chung khóa            | AES-256, ChaCha20 |
| Asymmetric  | Khóa đôi (public/private)         | RSA, ECC, DH      |
| Hash        | Đảm bảo toàn vẹn dữ liệu          | SHA-256, SHA-3    |
| PKI         | Hệ thống quản lý chứng thư số     | Root CA, SubCA    |
| TLS         | Mã hóa kết nối (HTTPS, VPN)       | TLS 1.3           |

- **Chứng thư số**: Chứa Subject, Issuer, Validity, SAN (Subject Alternative Name).
- **Mô hình tin cậy**: Hierarchical (Root CA → SubCA) hoặc Web of Trust.
- **Ví dụ thực tế**: Sử dụng Let’s Encrypt để cấp chứng thư TLS cho website.

---

### Zero Trust – Khối thành phần
```
Identities ──┐
Devices ─────┼─►  Policy Engine (PE) ─► Decision
Network ─────┤
Posture ─────┤           ▲
Telemetry ───┘           │
                  Policy Admin (PA)
                        │
                  Policy Enforcement Point (PEP)
                        │
                     Allow/Deny + Continuous Eval
```
- **Mô tả**: Zero Trust giả định không tin tưởng bất kỳ ai, yêu cầu xác thực liên tục.
- **Thành phần**:
  - **PE (Policy Engine)**: Ra quyết định dựa trên chính sách.
  - **PEP (Policy Enforcement Point)**: Thực thi quyết định (cho phép/chặn).
  - **PA (Policy Admin)**: Quản lý chính sách.
  - **Posture**: Kiểm tra trạng thái thiết bị (cập nhật, bảo mật).
- **Ví dụ thực tế**: ZTNA (Zero Trust Network Access) trong Cisco Secure Access.


