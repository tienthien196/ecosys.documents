---
title: Transport Layer
sidebar_position: 4
---

## tầng 4 : transport 
  - TCP:
      Connection-oriented
      Ba bước bắt tay: SYN → SYN-ACK → ACK
      Flow control: Sliding window
      Congestion control: Slow start, Fast retransmit
      Reliable, có ACK và retransmission
  - UDP:
      Connectionless
      Không đảm bảo, tốc độ cao
      Dùng cho: DNS, VoIP, streaming
  - Port: 0–65535
      Well-known: 80 (HTTP), 443 (HTTPS), 22 (SSH), 25 (SMTP)
  - Socket: socket(), bind(), listen(), accept(), connect(), send(), recv()



### Ports & Networking 

| Port | Protocol/Service | Description | Transport |
|------|-----------------|-------------|-----------|
| 20-21 | FTP | File Transfer Protocol | TCP |
| 22 | SSH | Secure Shell (remote login, file transfer, tunneling) | TCP |
| 23 | Telnet | Remote text communication (insecure) | TCP/UDP |
| 25 | SMTP | Email transfer between servers | TCP |
| 53 | DNS | Domain Name System (hostname ↔ IP) | TCP/UDP |
| 69 | TFTP | Trivial File Transfer Protocol | UDP |
| 80 | HTTP | Unencrypted web traffic | TCP |
| 110 | POP3 | Email retrieval from server | TCP/UDP |
| 123 | NTP | Network Time Protocol | UDP |
| 135 | DCE/RPC | Endpoint Mapper | TCP/UDP |
| 139 | NetBIOS | Session Service | TCP/UDP |
| 161 | SNMP | Network management protocol | TCP/UDP |
| 389 | LDAP | Directory Access Protocol | TCP/UDP |
| 443 | HTTPS | Encrypted web traffic | TCP/UDP |
| 445 | SMB | Microsoft Directory Services & file sharing | TCP/UDP |
| 465 | SMTP (Secure) | Secure mail submission | TCP |
| 514 | Syslog | Logging protocol | UDP |
| 587 | SMTP | Email submission | TCP |
| 636 | LDAPS | Secure LDAP over SSL | TCP/UDP |
| 993 | IMAP | Secure mail retrieval | TCP |
| 995 | POP3 (Secure) | Secure email download | TCP/UDP |
| 1433 | MSSQL | Microsoft SQL Server | TCP |
| 1521 | Oracle DB | Oracle Database | TCP |
| 3306 | MySQL | MySQL Database | TCP |
| 3389 | RDP | Remote Desktop Protocol | TCP |
| 5060 | SIP | Session Initiation Protocol (VoIP) | TCP/UDP |
| 6881–6999 | BitTorrent | Peer-to-peer sharing | TCP/UDP |

---

> Ghi nhớ: **mở port = mở bề mặt tấn công** → firewall, principle of least privilege, ưu tiên giao thức mã hoá.

- nhận lệnh từ tầng 5 , mở port dynamic trên máy , add port dest
- xử lí flags from  UDP-TCP 

TCP Header:
  Source Port:  50000  ← do OS tự chọn
  Dest Port:    27015  ← từ config của app
  Sequence:     1000
  Flags:        SYN


