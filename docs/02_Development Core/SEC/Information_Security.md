># An Toàn Thông Tin --Information Security--



##  Mind Map

```
                          +----------------------------------+
                          |        AN TOÀN THÔNG TIN         |
                          |    (Information Security)        |
                          +----------------+-----------------+
                                           |
        +----------------------------------+----------------------------------+
        |                                  |                                  |
        v                                  v                                  v
+-------+--------+              +----------+-----------+            +---------+--------+
| 1. Bảo Mật &   |              | 2. Quản Lý Rủi Ro   |            | 3. Kiểm Thử &    |
|    Vận Hành    |              |    & Tuân Thủ       |            |     Tấn Công      |
+----------------+              +---------------------+            +------------------+
        |                                  |                                  |
        v                                  v                                  v
SOC (Security Ops Center)        Risk = Threat × Vuln × Impact     PenTest (Kiểm thử xâm nhập)
SIEM (Log & Event Mgmt)          CIA: Confidentiality, Integrity, Availability
SOAR (Tự động hóa)               ISO 27001, NIST, GDPR, PCI-DSS
EDR (Endpoint Detection)         PII, BCP, DRP, RA
WAF, IDS/IPS, DLP, IAM           MFA, SSO, PAM
XDR (Extended Detection)

        |                                  |                                  |
        v                                  v                                  v
+-------+--------+              +----------+-----------+            +---------+--------+
| 4. Mạng &     |              | 5. Ứng Phó Sự Cố    |            | 6. Chứng Chỉ     |
|    Hệ Thống   |              |    (Incident Response) |         |  (Certifications) |
+---------------+              +----------------------+            +------------------+
        |                                  |                                  |
        v                                  v                                  v
VPN, DNS, DDoS                   IR (Incident Response)            CompTIA:
SSL/TLS, SSH, FTP/SFTP           IOC (Indicators of Compromise)      - Security+  → SOC, IR
LAN/WAN, ACL                     TTPs (MITRE ATT&CK)                 - CySA+     → Analyst
                                 DFIR (Digital Forensics)            - PenTest+  → Pentest
                                                                            |
                                                                            v
                                                                    EC-Council:
                                                                    - CEH → Ethical Hacker
                                                                            |
                                                                            v
                                                                    Offensive Security:
                                                                    - OSCP → Pentest thực chiến
                                                                            |
                                                                            v
                                                                    (ISC)²:
                                                                    - CISSP → Quản lý an ninh
                                                                    - CISM  → Quản lý rủi ro
                                                                            |
                                                                            v
                                                                    ISACA:
                                                                    - CISA  → Kiểm toán
                                                                    - CRISC → Quản lý rủi ro
                                                                            |
                                                                            v
                                                                    +----------------------+
                                                                    | 7. Công Cụ & FW     |
                                                                    +----------------------+
                                                                            |
                                                                            v
                                                                    MITRE ATT&CK → TTPs hacker
                                                                    CVE/CVSS/CWE → Lỗ hổng
                                                                    OSINT → Thu thập công khai
                                                                    Splunk, QRadar → SIEM
                                                                    CrowdStrike, SentinelOne → EDR
```

## Giải Thích Chi Tiết Các Phần

Dưới đây là giải thích chi tiết cho từng nhánh chính trong mind map. Mỗi phần bao gồm mô tả tổng quát, giải thích các khái niệm con, và ví dụ ứng dụng thực tế.

### 1. Bảo Mật & Vận Hành
Phần này tập trung vào các hoạt động hàng ngày để bảo vệ hệ thống thông tin, bao gồm giám sát, phát hiện và phản ứng tự động. Đây là "lá chắn" đầu tiên chống lại các mối đe dọa.

- **SOC (Security Operations Center)**: Trung tâm vận hành an ninh, nơi các chuyên gia giám sát 24/7 các sự kiện an ninh. SOC sử dụng công cụ như SIEM để phát hiện và phản ứng với các mối đe dọa. Ví dụ: Phát hiện tấn công brute-force qua log hệ thống và chặn IP độc hại.
- **SIEM (Security Information and Event Management)**: Hệ thống thu thập, phân tích log và sự kiện từ nhiều nguồn (firewall, server, ứng dụng) để phát hiện bất thường. Ví dụ: Splunk hoặc QRadar cảnh báo khi phát hiện nhiều lần đăng nhập thất bại.
- **SOAR (Security Orchestration, Automation, and Response)**: Công cụ tự động hóa quy trình an ninh, giảm thời gian xử lý thủ công. Ví dụ: Tự động cách ly thiết bị nhiễm mã độc sau khi EDR phát hiện.
- **EDR (Endpoint Detection and Response)**: Giải pháp bảo vệ và phản ứng tại các thiết bị đầu cuối (máy tính, điện thoại). EDR theo dõi hành vi để phát hiện và ngăn chặn mã độc. Ví dụ: CrowdStrike chặn ransomware trên máy trạm.
- **WAF (Web Application Firewall)**: Tường lửa bảo vệ ứng dụng web khỏi các cuộc tấn công như SQL injection hoặc XSS. Ví dụ: Cloudflare WAF lọc lưu lượng độc hại đến website.
- **IDS/IPS (Intrusion Detection/Prevention System)**: Hệ thống phát hiện (IDS) hoặc ngăn chặn (IPS) xâm nhập mạng. Ví dụ: Snort phát hiện lưu lượng mạng bất thường.
- **DLP (Data Loss Prevention)**: Công cụ ngăn chặn rò rỉ dữ liệu nhạy cảm. Ví dụ: Symantec DLP chặn email chứa thông tin thẻ tín dụng.
- **IAM (Identity and Access Management)**: Quản lý danh tính và quyền truy cập. Ví dụ: Okta quản lý quyền truy cập ứng dụng dựa trên vai trò người dùng.
- **XDR (Extended Detection and Response)**: Phiên bản mở rộng của EDR, tích hợp dữ liệu từ nhiều nguồn (mạng, cloud, endpoint) để phản ứng toàn diện. Ví dụ: Palo Alto Networks XDR phát hiện chuỗi tấn công phức tạp.

### 2. Quản Lý Rủi Ro & Tuân Thủ
Phần này tập trung vào việc đánh giá, quản lý rủi ro và đảm bảo tuân thủ các tiêu chuẩn an ninh.

- **Risk = Threat × Vulnerability × Impact**: Công thức cơ bản để đánh giá rủi ro. Threat (mối đe dọa) là khả năng tấn công, Vulnerability (lỗ hổng) là điểm yếu, Impact (tác động) là thiệt hại nếu rủi ro xảy ra. Ví dụ: Lỗ hổng phần mềm (vuln) bị hacker khai thác (threat) gây mất dữ liệu (impact).
- **CIA Triad (Confidentiality, Integrity, Availability)**: Ba trụ cột của an toàn thông tin:
  - **Confidentiality (Bảo mật)**: Đảm bảo dữ liệu chỉ được truy cập bởi người có quyền. Ví dụ: Mã hóa dữ liệu bằng AES-256.
  - **Integrity (Toàn vẹn)**: Đảm bảo dữ liệu không bị thay đổi trái phép. Ví dụ: Sử dụng hash SHA-256 để kiểm tra tính toàn vẹn của file.
  - **Availability (Tính sẵn sàng)**: Đảm bảo hệ thống luôn hoạt động. Ví dụ: DDoS protection để duy trì uptime website.
- **ISO 27001**: Tiêu chuẩn quốc tế về quản lý an ninh thông tin. Ví dụ: Công ty triển khai ISO 27001 để chuẩn hóa quy trình bảo mật.
- **NIST**: Khung an ninh của Viện Tiêu chuẩn và Công nghệ Quốc gia Mỹ. Ví dụ: NIST Cybersecurity Framework hướng dẫn quản lý rủi ro.
- **GDPR**: Quy định bảo vệ dữ liệu của EU. Ví dụ: Yêu cầu xóa dữ liệu người dùng khi được yêu cầu.
- **PCI-DSS**: Tiêu chuẩn bảo mật cho ngành thanh toán thẻ. Ví dụ: Mã hóa giao dịch thẻ tín dụng.
- **PII (Personally Identifiable Information)**: Thông tin cá nhân có thể nhận diện như tên, số CMND. Ví dụ: Bảo vệ PII bằng DLP.
- **BCP (Business Continuity Plan)**: Kế hoạch đảm bảo hoạt động kinh doanh liên tục trong khủng hoảng. Ví dụ: Sao lưu dữ liệu để khôi phục sau tấn công ransomware.
- **DRP (Disaster Recovery Plan)**: Kế hoạch khôi phục sau thảm họa. Ví dụ: Khôi phục hệ thống từ backup sau sự cố mất điện.
- **RA (Risk Assessment)**: Đánh giá rủi ro để xác định mối đe dọa và biện pháp giảm thiểu. Ví dụ: Phân tích rủi ro của hệ thống ERP.
- **MFA (Multi-Factor Authentication)**: Xác thực đa yếu tố để tăng bảo mật. Ví dụ: Kết hợp mật khẩu và OTP.
- **SSO (Single Sign-On)**: Đăng nhập một lần để truy cập nhiều hệ thống. Ví dụ: Google SSO cho Gmail và Drive.
- **PAM (Privileged Access Management)**: Quản lý quyền truy cập đặc quyền. Ví dụ: CyberArk giới hạn quyền admin.

### 3. Kiểm Thử & Tấn Công
Phần này tập trung vào việc kiểm tra bảo mật hệ thống thông qua mô phỏng tấn công.

- **PenTest (Penetration Testing)**: Kiểm thử xâm nhập, mô phỏng tấn công của hacker để tìm lỗ hổng. Ví dụ: Thử khai thác lỗ hổng SQL injection trên ứng dụng web.

### 4. Mạng & Hệ Thống
Phần này bao gồm các công nghệ và giao thức để bảo vệ hạ tầng mạng và hệ thống.

- **VPN (Virtual Private Network)**: Mạng riêng ảo để mã hóa kết nối. Ví dụ: NordVPN mã hóa lưu lượng khi làm việc từ xa.
- **DNS (Domain Name System)**: Hệ thống phân giải tên miền. Ví dụ: DNSSEC ngăn chặn tấn công giả mạo DNS.
- **DDoS (Distributed Denial of Service)**: Tấn công từ chối dịch vụ phân tán. Ví dụ: Cloudflare giảm thiểu DDoS bằng cách phân tán lưu lượng.
- **SSL/TLS**: Giao thức mã hóa kết nối web. Ví dụ: HTTPS sử dụng TLS để bảo vệ dữ liệu người dùng.
- **SSH (Secure Shell)**: Giao thức truy cập từ xa an toàn. Ví dụ: Quản lý server Linux qua SSH.
- **FTP/SFTP**: Giao thức truyền file, SFTP là phiên bản mã hóa. Ví dụ: SFTP để truyền file nhạy cảm.
- **LAN/WAN**: Mạng nội bộ (LAN) và mạng diện rộng (WAN). Ví dụ: VLAN phân tách lưu lượng trong doanh nghiệp.
- **ACL (Access Control List)**: Danh sách kiểm soát truy cập. Ví dụ: Firewall ACL chặn IP không được phép.

### 5. Ứng Phó Sự Cố (Incident Response)
Phần này tập trung vào quy trình xử lý khi xảy ra sự cố an ninh.

- **IR (Incident Response)**: Quy trình phản ứng với sự cố an ninh. Ví dụ: Điều tra và khắc phục sau khi phát hiện mã độc.
- **IOC (Indicators of Compromise)**: Dấu hiệu của sự xâm nhập. Ví dụ: Hash của file mã độc hoặc IP bất thường.
- **TTPs (Tactics, Techniques, and Procedures)**: Kỹ thuật và chiến thuật của hacker, dựa trên MITRE ATT&CK. Ví dụ: Sử dụng phishing để lấy cắp thông tin.
- **DFIR (Digital Forensics and Incident Response)**: Điều tra số để phân tích sự cố. Ví dụ: Phân tích log để truy vết nguồn tấn công.

### 6. Chứng Chỉ (Certifications)
Phần này liệt kê các chứng chỉ an ninh phổ biến, phù hợp với từng vai trò.

- **CompTIA**:
  - **Security+**: Chứng chỉ nhập môn cho SOC và IR. Ví dụ: Hiểu về firewall và mã hóa.
  - **CySA+**: Dành cho nhà phân tích an ninh. Ví dụ: Phân tích log SIEM.
  - **PenTest+**: Dành cho kiểm thử xâm nhập. Ví dụ: Thực hiện pentest web.
- **EC-Council**:
  - **CEH (Certified Ethical Hacker)**: Chứng chỉ cho hacker mũ trắng. Ví dụ: Học kỹ thuật khai thác lỗ hổng.
- **Offensive Security**:
  - **OSCP (Offensive Security Certified Professional)**: Chứng chỉ pentest thực chiến. Ví dụ: Thực hiện tấn công mạng trong môi trường lab.
- **(ISC)²**:
  - **CISSP (Certified Information Systems Security Professional)**: Chứng chỉ quản lý an ninh. Ví dụ: Thiết kế chính sách bảo mật.
  - **CISM (Certified Information Security Manager)**: Quản lý rủi ro và chiến lược an ninh. Ví dụ: Xây dựng BCP.
- **ISACA**:
  - **CISA (Certified Information Systems Auditor)**: Chứng chỉ kiểm toán hệ thống. Ví dụ: Đánh giá tuân thủ ISO 27001.
  - **CRISC (Certified in Risk and Information Systems Control)**: Quản lý rủi ro. Ví dụ: Đánh giá rủi ro cho dự án CNTT.

### 7. Công Cụ & Framework
Phần này bao gồm các công cụ và framework hỗ trợ an toàn thông tin.

- **MITRE ATT&CK**: Khung phân tích chiến thuật và kỹ thuật của hacker. Ví dụ: Xác định TTPs của tấn công APT.
- **CVE/CVSS/CWE**: Hệ thống xác định và đánh giá lỗ hổng.
  - **CVE (Common Vulnerabilities and Exposures)**: Mã định danh lỗ hổng. Ví dụ: CVE-2021-44228 (Log4j).
  - **CVSS (Common Vulnerability Scoring System)**: Điểm số đánh giá mức độ nghiêm trọng. Ví dụ: CVSS 9.8 cho lỗ hổng nghiêm trọng.
  - **CWE (Common Weakness Enumeration)**: Danh mục điểm yếu phần mềm. Ví dụ: CWE-79 (XSS).
- **OSINT (Open-Source Intelligence)**: Thu thập thông tin công khai. Ví dụ: Sử dụng Shodan để tìm thiết bị IoT dễ bị tấn công.
- **Splunk, QRadar**: Công cụ SIEM để phân tích log. Ví dụ: Splunk tạo dashboard cảnh báo tấn công.
- **CrowdStrike, SentinelOne**: Công cụ EDR để bảo vệ endpoint. Ví dụ: SentinelOne chặn mã độc dựa trên AI.

### ***NOTE***
> ***TÀI LIỆU BUILD BY @TIẾN THIỆN*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/)