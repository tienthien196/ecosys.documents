---
title: Physical
sidebar_position: 5
---

## 1. OSI Model Protocols
### 🔹 Layer 7: Application Layer
Examples: HTTP, HTTPS, DNS, FTP, SMTP, POP3, SSH, SNMP, Telnet, BitTorrent
### 🔹 Layer 6: Presentation Layer
Examples: TLS, SSL, AFP
### 🔹 Layer 5: Session Layer
Examples: PPTP, SMB, RPC, NFS, PAP
### 🔹 Layer 4: Transport Layer
Examples: TCP, UDP, SCTP, DCCP
### 🔹 Layer 3: Network Layer
Examples: IPv4, IPv6, ICMP, IPSec, OSPF, MPLS, NAT, RIP, BGP
### 🔹 Layer 2: Data Link Layer
Examples: Ethernet, PPP, VLAN, STP, MAC, LACP, HDLC
### 🔹 Layer 1: Physical Layer
Examples: USB, Ethernet, Wi-Fi PHY, DSL, ISDN, Bluetooth


## Thiết bị & Kỹ thuật mạng (tóm tắt)
```
| Thiết bị/Kỹ thuật | Tầng | Mô tả                              |
|-------------------|------|------------------------------------|
| Router            | L3   | Định tuyến IP, NAT, ACL            |
| Switch            | L2   | MAC table, VLAN, STP               |
| Access Point      | L2   | Kết nối Wi-Fi, WPA2/3, roaming     |
| Firewall          | L3/L7 | Stateful, NAT, IDS/IPS, WAF        |
| NAT               | L3   | Ánh xạ địa chỉ IP                  |
| QoS               | L3/L7 | Ưu tiên lưu lượng                  |
| Load Balancing    | L4/L7 | Phân phối lưu lượng                |
```
---



## Các thiết bị mạng

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

  ### Router
- **Mô tả**: Chuyển tiếp gói tin giữa các mạng, hoạt động ở tầng 3.
- **Chức năng**: Định tuyến, NAT, DHCP, ACL.
- **Ví dụ thực tế**: TP-Link Archer C6 cho mạng gia đình.

### Switch
- **Mô tả**: Kết nối thiết bị trong cùng mạng, hoạt động ở tầng 2.
- **Chức năng**: Chuyển khung dữ liệu dựa trên MAC, VLAN.
- **Ví dụ thực tế**: Cisco Catalyst 9200 cho doanh nghiệp.

### Access Point
- **Mô tả**: Cung cấp kết nối Wi-Fi.
- **Chức năng**: Mở rộng mạng, hỗ trợ WPA3, roaming.
- **Ví dụ thực tế**: Ubiquiti UniFi 6 Pro.

### Firewall
- **Mô tả**: Kiểm soát lưu lượng dựa trên quy tắc.
- **Chức năng**: Chặn truy cập trái phép, IDS/IPS.
- **Ví dụ thực tế**: Fortinet FortiGate 60F.

---

## Các kỹ thuật tối ưu hóa mạng

### Load Balancing

```
           ┌─────────────┐
 Client ──►│ LoadBalancer│───► [Server1]
           └──────┬──────┘      [Server2]
                  │             [Server3]
                  ▼
              Phân phối request

```

- **Mô tả**: Phân phối lưu lượng mạng đều trên nhiều server để tăng hiệu suất và độ tin cậy.
- **Các kỹ thuật**:
  - Round-robin: Phân phối tuần tự.
  - Least connections: Gửi lưu lượng đến server ít kết nối nhất.
- **Ví dụ thực tế**: Sử dụng NGINX làm load balancer cho web server.

### Quality of Service (QoS)
```
 ┌─────────────┐
 │   Router    │
 └──────┬──────┘
        │
 ┌──────▼───────────────────────────────┐
 │   QoS Queue:                         │
 │   [VoIP] ─ High Priority             │
 │   [Video] ─ Medium Priority          │
 │   [Web/HTTP] ─ Normal                │
 │   [Bulk Download] ─ Low              │
 └──────────────────────────────────────┘

```

- **Mô tả**: Quản lý và ưu tiên lưu lượng mạng để đảm bảo hiệu suất cho các ứng dụng quan trọng.
- **Các kỹ thuật**:
  - Traffic shaping: Giới hạn băng thông cho một số ứng dụng.
  - Packet prioritization: Ưu tiên gói tin VoIP hoặc video.
- **Ví dụ thực tế**: QoS trên router để ưu tiên băng thông cho Zoom trên router MikroTik.

### Software-Defined Networking (SDN)
- **Mô tả**: Tách biệt tầng điều khiển (control plane) và tầng chuyển tiếp (data plane), quản lý mạng qua phần mềm.
- **Ứng dụng**: OpenFlow, Cisco ACI, VMware NSX.
- **Ví dụ thực tế**: Mininet mô phỏng SDN cho mạng doanh nghiệp.

---

## Cloud Networking
- **Mô tả**: Quản lý mạng trong môi trường cloud (AWS, Azure, GCP).
- **Khái niệm chính**:
  - **VPC (Virtual Private Cloud)**: Mạng riêng trong cloud, cô lập tài nguyên.
  - **Container Networking**: Kết nối container trong Kubernetes (CNI plugins như Calico, Flannel).
  - **SD-WAN**: Mạng diện rộng điều khiển bằng phần mềm, tối ưu chi phí và hiệu suất.
- **Ví dụ thực tế**: Tạo VPC trên AWS với subnets và NAT Gateway.

---

## Network Monitoring
- **Mô tả**: Theo dõi hiệu suất và bảo mật mạng.
- **Giao thức**:
  - **SNMP (Simple Network Management Protocol)**: Thu thập dữ liệu từ thiết bị mạng.
  - **NetFlow/sFlow**: Phân tích lưu lượng mạng.
- **Công cụ**: Zabbix, Nagios, Prometheus + Grafana.
- **Ví dụ thực tế**: Sử dụng Zabbix để giám sát băng thông router.

---

## Wireless Security
- **Mô tả**: Bảo vệ mạng Wi-Fi khỏi tấn công.
- **Kỹ thuật**:
  - **WPA3**: Chuẩn mã hóa Wi-Fi mới, bảo mật hơn WPA2.
  - **Rogue AP Detection**: Phát hiện điểm truy cập giả mạo.
  - **Deauthentication Attack Mitigation**: Chặn tấn công ngắt kết nối Wi-Fi.
- **Công cụ**: Aircrack-ng, Kismet.
- **Ví dụ thực tế**: Sử dụng Kismet để phát hiện rogue AP trong mạng doanh nghiệp.

---

### Pentest Roadmap – Pipeline tổng quát
```
Recon/Footprinting → Scanning/Enumeration → Gaining Access →
Maintaining Access → Covering Tracks
    │                    │                         │
    │                    ├─ nmap, banner grab,     ├─ password/crack, exploit
    │                    │  SNMP/LDAP enum         │  web app, lateral move
    ├─ OSINT, DNS, WHOIS │                         │
    │  Google dorks      └─ service/port mapping   └─ logs cleanup, evasion
```
> Bộ công cụ: Wireshark/tcpdump, nmap, Nessus/Nikto, Burp, Hydra/John, Aircrack, Scapy…

- **Recon/Footprinting**:
  - Kỹ thuật: OSINT (Google dorks, WHOIS), DNS enumeration.
  - Công cụ: Maltego, theHarvester.
- **Scanning/Enumeration**:
  - Kỹ thuật: Quét cổng (Nmap), banner grabbing, SNMP/LDAP enum.
  - Công cụ: Nmap, Nessus, OpenVAS.
- **Gaining Access**:
  - Kỹ thuật: Khai thác lỗ hổng (Metasploit), tấn công mật khẩu (Hydra).
  - Ví dụ: Khai thác CVE-2021-44228 (Log4j) bằng Metasploit.
- **Maintaining Access**:
  - Kỹ thuật: Backdoor, privilege escalation.
  - Công cụ: Netcat, Meterpreter.
- **Covering Tracks**:
  - Kỹ thuật: Xóa log, che giấu lưu lượng.
  - Công cụ: Auditpol, CCleaner.
- **Ví dụ thực tế**: Sử dụng Burp Suite để tấn công web (SQL Injection).

---


