---
title: CEH
sidebar_position: 1
---
# CEH / Penetration Testing Roadmap — Cheat Sheet 
### ***NOTE***
> ***TÀI LIỆU BUILD BY @TIẾN THIỆN*** [(truy cập chi tiết)](https://tienthien196.github.io/ecosys.portfolioBNJ/)

> **Mục tiêu:** Tập hợp nhanh toàn bộ ý chính: quy trình pentest, crypto, recon, scanning, tấn công hệ thống, web/app, wireless, malware, công cụ…  

---

## Mục lục
- [Basics Guide](https://chat.qwen.ai/s/6071e273-dd70-41c7-af9d-bcef7e71d448?fev=0.0.190)
- [5 Phases to a Penetration Test](#5-phases-to-a-penetration-test)
- [Attack Types](#attack-types)
- [Legal / Standards / Compliance](#legal--standards--compliance)
- [Cryptography](#cryptography)
  - [Symmetric Encryption](#symmetric-encryption)
  - [Asymmetric Encryption](#asymmetric-encryption)
  - [Hash Algorithms](#hash-algorithms)
  - [Trust Models](#trust-models)
  - [Cryptography Attacks](#cryptography-attacks)
  - [Digital Certificate Fields](#digital-certificate-fields)
- [Reconnaissance](#reconnaissance)
  - [Google Hacking Operators](#google-hacking-operators)
  - [DNS Essentials](#dns-essentials)
  - [TCP Header Flags](#tcp-header-flags)
  - [DHCP Handshake](#dhcp-handshake)
- [Scanning & Enumeration](#scanning--enumeration)
  - [ICMP Message Types](#icmp-message-types)
  - [CIDR / IPv4 Quick Notes](#cidr--ipv4-quick-notes)
  - [Port Numbers](#port-numbers)
  - [HTTP Status Families](#http-status-families)
  - [Nmap Quick Reference](#nmap-quick-reference)
  - [Scan Types Semantics](#scan-types-semantics)
  - [NetBIOS Cheats](#netbios-cheats)
  - [SNMP Notes](#snmp-notes)
- [Sniffing & Evasion](#sniffing--evasion)
  - [IPv4 vs IPv6](#ipv4-vs-ipv6)
  - [MAC Address](#mac-address)
  - [NAT](#nat)
  - [Stateful Inspection](#stateful-inspection)
  - [HTTP Tunnelling](#http-tunnelling)
  - [Snort IDS Basics](#snort-ids-basics)
  - [IDS Evasion Tactics](#ids-evasion-tactics)
  - [tcpdump Syntax](#tcpdump-syntax)
- [Web-based Hacking](#web-based-hacking)
  - [SQL Injection Types](#sql-injection-types)
  - [Buffer Overflow Quick Notes](#buffer-overflow-quick-notes)
  - [Dangerous C Functions](#dangerous-c-functions)
- [Attacking a System](#attacking-a-system)
  - [Password Rules (CEH style)](#password-rules-ceh-style)
  - [LM Hashing Note](#lm-hashing-note)
  - [Attack Types](#attack-types-1)
  - [Sidejacking](#sidejacking)
  - [Authentication Factors](#authentication-factors)
  - [Session Hijacking Steps](#session-hijacking-steps)
  - [Kerberos Overview](#kerberos-overview)
  - [SAM File](#sam-file)
  - [Windows Registry Essentials](#windows-registry-essentials)
- [Trojans / Malware / DoS](#trojans--malware--dos)
  - [Virus Types](#virus-types)
  - [DoS Types](#dos-types)
  - [Notable CVEs / Worms](#notable-cves--worms)
- [Wireless Hacking](#wireless-hacking)
  - [802.11 Specs](#80211-specs)
  - [Bluetooth Attacks](#bluetooth-attacks)
- [Physical Security](#physical-security)
- [Social Engineering](#social-engineering)
- [Linux Commands](#linux-commands)
- [Command-Line Quickies](#command-line-quickies)
- [Tools of the Trade](#tools-of-the-trade)
---

```
                         ┌─────────────────────────┐
                         │ CEH / Pentest Roadmap   │
                         │    (Cheat Sheet)        │
                         └──────────┬─────────────┘
                                    │
      ┌─────────────────────────────┼─────────────────────────────┐
      │                             │                             │
   Basics                       Cryptography                 Reconnaissance
      │                             │                             │
 ┌────┼─────┐          ┌────────────┼────────────┐     ┌──────────┼─────────────┐
 │ 5 Phases │          │ Symmetric  │ Asymmetric │     │ Google Hacking Ops    │
 │ Attack   │          │ Hash Algo  │ TrustModel │     │ DNS Essentials        │
 │ Legal    │          │ CryptoAtk  │ Certificate│     │ TCP Flags             │
 └──────────┘          └─────────────────────────┘     │ DHCP Handshake        │
                                                       └───────────────────────┘

      ┌─────────────────────────────┼─────────────────────────────┐
      │                             │                             │
 Scanning & Enumeration        Sniffing & Evasion           Attacking System
      │                             │                             │
 ┌────┼────┐              ┌─────────┼───────────┐     ┌───────────┼─────────────┐
 │ ICMP Msg │              │ IPv4 vs IPv6      │     │ Password Rules          │
 │ CIDR/IPv4│              │ NAT / Firewall    │     │ LM Hash Note            │
 │ Ports    │              │ IDS / Snort       │     │ Attack Types            │
 │ Nmap     │              │ tcpdump           │     │ Sidejacking             │
 │ NetBIOS  │              └───────────────────┘     │ Kerberos / SAM / Reg    │
 │ SNMP     │                                        └─────────────────────────┘
 └──────────┘

      ┌─────────────────────────────┼─────────────────────────────┐
      │                             │                             │
Trojans / Malware / DoS        Web / App Hacking             Wireless Hacking
      │                             │                             │
 ┌────┼─────┐              ┌────────┼─────────┐           ┌───────┼────────────┐
 │ Virus   │              │ SQLi   │ Buffer   │           │ 802.11 Specs      │
 │ DoS     │              │ XSS    │ Overflow │           │ Bluetooth Attacks │
 │ CVEs    │              │ CSRF   │ C Funcs  │           └───────────────────┘
 └─────────┘              └───────────────────┘

      ┌─────────────────────────────┼─────────────────────────────┐
      │                             │                             │
Physical Security            Social Engineering               Linux / Commands
      │                             │                             │
 ┌────┴─────┐              ┌────────┴────────┐           ┌────────┴───────────┐
 │ Locks    │              │ Human-based     │           │ FS Layout           │
 │ Cameras  │              │ Computer-based  │           │ Users / Perms       │
 │ Policies │              │ SE Types        │           │ Snort Rules         │
 └──────────┘              └─────────────────┘           │ Cmd Quickies        │
                                                         └─────────────────────┘

                             ┌───────────────────────┐
                             │ Tools of the Trade    │
                             │ (Scanning, Exploits,  │
                             │   Sniffing, Crypto,   │
                             │   Wireless, Web…)     │
                             └───────────────────────┘
```

---
## Basics

### 5 Phases to a Penetration Test
1. Reconnaissance  
2. Scanning & Enumeration  
3. Gaining Access  
4. Maintaining Access  
5. Covering Tracks

### Attack Types
- **OS**: Tấn công cấu hình mặc định của hệ điều hành
- **App level**: Tấn công mã ứng dụng
- **Shrink Wrap**: Tận dụng script/off-the-shelf
- **Misconfiguration**: Cấu hình kém

### Legal / Standards / Compliance
- 18 U.S.C 1029 & 1030  
- RFC 1918 – Private IP Standard  
- RFC 3227 – Collecting & storing data  
- ISO 27002 – InfoSec Guidelines  
- CAN-SPAM – email marketing  
- SPY-Act – License Enforcement  
- DMCA – Intellectual Property  
- SOX – Corporate Finance Processes  
- GLBA – Personal Finance Data  
- FERPA – Education Records  
- FISMA – Gov Networks Security Std  
- CVSS – Common Vulnerability Scoring System  
- CVE – Common Vulnerabilities & Exposures  
- Regional Registry Coverage Map

---

## Cryptography

### Symmetric Encryption
- **Key pairs required =** 1 (shared secret)  
- **Algorithms:**
  - DES: 56-bit key (8-bit parity); fixed block
  - 3DES: 168-bit key; keys ≤ 3
  - AES: 128/192/256; thay DES
  - IDEA: 128-bit key
  - Twofish: block cipher, key ≤ 256-bit
  - Blowfish: thay bởi AES; 64-bit block
  - RC family: RC2→RC6; RC6 128-bit block; tối đa ~2040-bit key

### Asymmetric Encryption
- **Public Key = Encrypt**, **Private Key = Decrypt** (thông thường)  
- **Algorithms:**
  - Diffie–Hellman: Trao đổi khóa; dùng trong SSL/IPsec
  - ECC: Elliptic Curve – hiệu quả cho mobile/low-power
  - ElGamal: Dựa trên log rời rạc; mã hóa/ký
  - RSA: 2 số nguyên tố lớn; key phổ biến đến 4096-bit

### Hash Algorithms
- MD5: 128-bit hash, biểu diễn 32 hex
- SHA-1: 160-bit hash
- SHA-2: 224/256/384/512

### Trust Models
- **Web of Trust**: Thực thể ký chéo
- **Single Authority**: 1 CA gốc
- **Hierarchical**: CA gốc + RA cấp dưới
- **XMKS**: XML PKI System

### Cryptography Attacks
- **Known Plain-text**: So chuỗi lặp lại của bản rõ
- **Ciphertext-only**: Thu thập nhiều bản mã, phân tích mẫu
- **Replay (MITM)**: Lặp lại trao đổi để lừa thiết lập kênh

### Digital Certificate Fields
- Version, Serial
- Subject, Issuer
- Algorithm ID
- Valid from/to
- Key usage
- Subject’s Public Key
- Optional: Issuer ID, Subject Alt Name, …

---

## Reconnaissance

### Định nghĩa
- **Recon**: Thu thập thông tin mục tiêu (CEH dùng thay footprinting).
- **Footprinting**: Vẽ bản đồ tổng quan ở mức cao.

### Google Hacking Operators
- `operator:keyword`
- `site:` – trong domain
- `ext:` – phần mở rộng tệp
- `loc:` – vị trí bản đồ
- `intitle:` / `allintitle:`
- `inurl:` / `allinurl:`
- `incache:` – chỉ cache

### DNS Essentials
- **Port** 53 – UDP (truy vấn), TCP (zone transfer)  
- **Records:**
  - SRV – hostname & port dịch vụ
  - SOA – Primary name server
  - PTR – IP→Hostname (reverse DNS)
  - NS – Name servers
  - MX – Mail servers
  - CNAME – bí danh (alias)
  - A – Hostname→IP
- **Footprinting tools**: `whois`, `nslookup`, `dig`

### TCP Header Flags
- **URG** – out-of-band data  
- **ACK** – xác nhận (sau SYN)  
- **PSH** – đẩy dữ liệu không buffer  
- **RST** – reset kết nối 2 chiều  
- **SYN** – mở kết nối, tham số & seq  
- **FIN** – đóng kết nối có thứ tự

### DHCP Handshake
Client —**Discover**→ Server  
Client ←**Offer**— Server  
Client —**Request**→ Server  
Client ←**Ack**— Server (IP bị rút khỏi pool)

---

## Scanning & Enumeration

### ICMP Message Types
- **0**: Echo Reply  
- **3**: Destination Unreachable (Codes: 0 network, 1 host, 6 network unknown, 7 host unknown, 9/10 admin prohibited, 13 comms admin prohibited)  
- **4**: Source Quench (cũ)  
- **5**: Redirect (0 network, 1 host)  
- **8**: Echo Request  
- **11**: Time Exceeded

### CIDR / IPv4 Quick Notes
- `/30 = 4  (.255.252)`  
- `/28 = 16 (.255.240)`  
- `/26 = 64 (.255.192)`  
- `/24 = 256 (.255.0)`  
- `/22 = 1024 (.248.0)`  
- `/20 = 4096 (.240.0)`  

### Port Numbers
- **0–1023**: Well-known  
- **1024–49151**: Registered  
- **49152–65535**: Dynamic

**Important ports**
- FTP: 20/21
- SSH: 22
- Telnet: 23
- SMTP: 25
- WINS: 42
- TACACS: 49
- DNS: 53
- HTTP: 80 / 8080
- Kerberos: 88
- POP3: 110
- Portmapper (Linux): 111
- NNTP: 119
- NTP: 123
- RPC-DCOM: 135
- NetBIOS/SMB: 137–139
- IMAP: 143
- SNMP: 161/162
- LDAP: 389
- HTTPS: 443
- CIFS: 445
- RADIUS: 1812
- RDP: 3389
- IRC: 6667
- Printer: 515, 631, 9100
- Tini: 7777
- NetBus: 12345
- Back Orifice: 27374
- Sub7: 31337

### HTTP Status Families
- **200** series – OK  
- **400** series – Client error / Could not provide request  
- **500** series – Server error / Could not process request

### Nmap Quick Reference
```bash
nmap <scan options> <target>
# Popular:
-sS (SYN) -sT (TCP connect) -sA (ACK) -sF (FIN) -sN (NULL) -sX (XMAS) -sW (Window)
-sn (ping sweep) -sI (Idle) -sR (RPC) -PS (SYN ping) -PI (ICMP ping) -PT (TCP ping)
-Po (no ping) -A (OS/Version/Script) -oN (normal) -oX (XML) -T0..T4 (chậm→nhanh)
```

### Scan Types Semantics
- **TCP (full 3-way)**: Open = SYN/ACK; Closed = RST/ACK  
- **SYN (half-open)**: Open = SYN/ACK; Closed = RST/ACK  
- **FIN**: Open = no response; Closed = RST  
- **XMAS (FIN, URG, PSH)**: Open = no response; Closed = RST  
- **ACK (Linux/Unix)**: Open = RST; Closed = no response  
- **IDLE (spoofed)**: Open = SYN/ACK; Closed = RST/ACK  
- **NULL (no flags)**: Phụ thuộc OS (Linux/Unix oriented)

### NetBIOS Cheats
```bash
nbtstat -a COMPUTER190         # remote table by name
nbtstat -A 192.168.10.12       # remote table by IP
nbtstat -n                     # local name table
nbtstat -c                     # local name cache
nbtstat -r                     # purge name cache
nbtstat -S 10                  # session stats every 10s
# 1B = master browser (subnet), 1C = domain controller, 1D = domain master browser
```

### SNMP Notes
- Dùng **community string** như mật khẩu (v1/v2c)
- **SNMPv3** mã hóa & xác thực community/traffic

---

## Sniffing & Evasion

### IPv4 vs IPv6
- **IPv4**: unicast, multicast, **broadcast**
- **IPv6**: unicast, multicast, **anycast**; phạm vi: link-local, site-local, global

### MAC Address
- 3 byte đầu (OUI – Org Unique ID) + 3 byte sau (serial)

### NAT
- **Basic NAT**: 1–1 private↔public  
- **PAT (NAT Overload)**: Port Address Translation (thường dùng)

### Stateful Inspection
- Kiểm soát theo **state** kết nối; không soi từng gói

### HTTP Tunnelling
- Bọc payload qua port ít bị chặn (ví dụ 80)

### Snort IDS Basics
- 3 chế độ: **Sniffer / Packet logger / NIDS**  
- Config: `/etc/snort` hoặc `C:\snort\etc`  
- Ví dụ rule:
```snort
alert tcp !HOME_NET any -> $HOME_NET 31337 (msg:"BACKDOOR ATTEMPT-Backorifice.";)
```

### IDS Evasion Tactics
- **Chậm lại** / **flood** / **fragmentation**

### tcpdump Syntax
```bash
tcpdump [flags] <interface>
```

---

## Attacking a System

### Password Rules (CEH style)
- Không chứa tên user, tối thiểu **8** ký tự, **3/4** nhóm: đặc biệt, số, chữ hoa, chữ thường

### LM Hashing Note
- 7 spaces hashed: `AAD3B435B51404EE`

### Attack Types
- **Passive Online**: sniff/replay/MITM
- **Active Online**: đoán mật khẩu
- **Offline**: trộm SAM, crack ngoại tuyến
- **Non-electronic**: social engineering

### Sidejacking
- Đánh cắp cookie và **replay**

### Authentication Factors
- **Type 1**: Something you know  
- **Type 2**: Something you have  
- **Type 3**: Something you are

### Session Hijacking Steps
1. Sniff traffic client↔server  
2. Theo dõi & dự đoán sequence  
3. **Desynchronize** client  
4. Đoán **session token**  
5. Inject packet vào server

### Kerberos Overview
- **Thành phần**: KDC, AS, TGS, TGT  
- **Quy trình tóm tắt**: Client xin TGT (cleartext req) → Server trả key băm theo pass trên AD (TGT) → Dùng TGT xin TGS → Nhận ticket để truy cập tài nguyên

### SAM File
- `C:\Windows\System32\config`

### Windows Registry Essentials
- **Root Keys**:  
  - HKLM – thông tin HW/SW  
  - HKCR – file associations & OLE classes  
  - HKCU – profile user hiện tại  
  - HKEY_USERS – cấu hình mọi user active  
  - HKCC – Hardware Profiles  
- **Run Keys**:  
  `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run*` / `RunServices*`

---

## Social Engineering
- **Human-based**: Dumpster diving, impersonation, help desk, shoulder surfing, tailgating/piggybacking
- **Computer-based**: Phishing, **Whaling** (CEO), **Pharming** (evil twin)
- **Types of SE**:  
  - Insider Associates (quyền hạn giới hạn)  
  - Insider Affiliates (giả mạo Insider)  
  - Outsider Affiliates (kẻ ngoài lợi dụng điểm mở)

---

## Physical Security
- **Physical**: cửa, khóa, camera…  
- **Technical**: smartcards, biometrics  
- **Operational**: chính sách & quy trình

---

## Web-based Hacking
- **CSRF**
- **Dot-dot-slash** (path traversal, unicode/invalid input)

### SQL Injection Types
- **Union Query**
- **Tautology**
- **Blind SQLi**
- **Error-based** (enumeration)

### Buffer Overflow Quick Notes
- Ghi vượt bộ đệm → hỏng dữ liệu / thực thi mã
- **Stack**: thay đổi function pointer/var
- **Heap**: overwrite function pointers vùng heap
- **NOP Sled**: chuỗi NOP lớn (IDS thường chặn)

### Dangerous C Functions
- `gets()` `strcpy()` `strcat()` `printf()` (không kiểm kích thước đích)

---

## Wireless Hacking

### 802.11 Specs
- **WEP**: RC4 + 24-bit IV; key 40/104-bit  
- **WPA**: RC4; IV 48-bit  
- **WPA/TKIP**: đổi IV mỗi frame + key mixing  
- **WPA2**: AES + tính năng TKIP; IV 48-bit

| Spec    | Dist | Speed   | Freq     |
|---------|------|---------|----------|
| 802.11a | 30m  | 54 Mbps | 5 GHz    |
| 802.11b | 100m | 11 Mbps | 2.4 GHz  |
| 802.11g | 100m | 54 Mbps | 2.4 GHz  |
| 802.11n | 125m | 100+ Mb | 2.4/5GHz |

### Bluetooth Attacks
- **Bluesmacking** (DoS)  
- **Bluejacking** (nhắn tin)  
- **Bluesniffing** (sniff)  
- **Bluesnarfing** (trộm dữ liệu)

---

## Trojans / Malware / DoS

### Virus Types
- Boot, Camouflage, Cavity, Macro, Multipartite
- Metamorphic, Network, Polymorphic Code
- Shell, Stealth

### DoS Types
- **SYN Attack/Flood**, **ICMP Flood**, **App-level Flood**
- **Smurf** (ICMP broadcast spoofed), **Fraggle** (UDP)
- **Ping of Death** (reassembly > max size)

### Notable CVEs / Worms
- **Heartbleed** (CVE-2014-0160) – OpenSSL heartbeat leak (MITM)
- **POODLE** (CVE-2014-3566) – SSL 3.0 downgrade MITM
- **Shellshock** (CVE-2014-6271) – Bash code injection via env
- **ILOVEYOU** (2000, VBS macro) – from Philippines
- **Melissa** (1999, MS Word macro)

---

## Linux Commands

### FS Layout
`/` (root), `/var` (logs), `/bin` (user bins), `/sbin` (admin bins), `/root`, `/boot` (kernel), `/proc` (kernel), `/dev` (devices), `/mnt` (mount)

### Users / Procs / IDs
- `init` PID 1  
- root UID/GID 0  
- Services 1–999  
- Users ≥ 1000

### Permissions
- 4 Read / 2 Write / 1 Execute  
- `764` = User RWX / Group RW / Other R

### Snort Rule Form
```
action protocol src_ip src_port -> dst_ip dst_port (option:value; ...)
alert tcp 10.0.0.1 25 -> 10.0.0.2 25 (msg:"Sample Alert"; sid:1000;)
```

---

## Command-Line Quickies

```bash
# Nmap
nmap -sT -T5 -n -p 1-100 10.0.0.1

# Netcat
nc -v -z -w 2 10.0.0.1 1-1000

# tcpdump
tcpdump -i eth0 -v -X ip proto 1

# Snort
snort -vde -c my.rules

# hping
hping3 -I eth0 -c 10 -a 2.2.2.2 -t 100 10.0.0.1

# iptables
iptables -A FORWARD -j ACCEPT -p tcp --dport 80
```

---

## Tools of the Trade

### Vulnerability Research
- National Vuln DB, Eccouncil.org, Exploit-DB

### Foot-printing
- Netcraft, Wayback/Archive, Webmaster tools
- DNS & WHOIS: nslookup, Sam Spade, ARIN, WhereisIP, DNSstuff, DNS-Digger
- Mirroring: `wget`, Wayback, Google Cache

### Scanning & Enumeration
- Ping Sweep: Angry IP Scanner, MegaPing
- Scanners: SuperScan, Nmap (Zenmap), NetScan Tools Pro, hping, netcat
- War Dialing: THC-Scan, TeleSweep, ToneLoc, WarVox
- Banner grab: telnet, ID Serve, Netcraft, Xprobe
- Vuln Scan: Nessus, SAINT, Retina, Core Impact, Nikto
- Mapping: NetMapper, LANState, IPSonar
- Proxy/Tunnel/Anon: Tor, ProxySwitcher, ProxyChains, SoftCab, HTTP Tunnel, Anonymouse
- Enumeration: SuperScan, User2Sid/Sid2User, LDAP Admin, Xprobe, Hyena
- SNMP Enum: SolarWinds, SNMPUtil, SNMPScanner

### System Hacking
- Password: Cain, John, LCP, THC-Hydra, ElcomSoft, Aircrack, RainbowCrack, Brutus, KerbCrack
- Sniffing: Wireshark, Ace, KerbSniff, Ettercap
- Keylogger/Screen: KeyProwler, Ultimate Keylogger, All In One, Actual Spy, Ghost, Hidden Recorder, Desktop Spy, USB Grabber
- Priv Esc / Recovery: Password Recovery Boot Disk/Reset, System Recovery
- Remote Exec: PDQ Deploy, RemoteExec, Dameware
- Spyware/Monitor: Remote Desktop Spy, Activity Monitor, OSMonitor, SSPro, Spector Pro
- Cover Tracks: ELsave, CCleaner, EraserPro, Evidence Eliminator

### Packet Crafting / Spoofing
- Komodia, hping2/3, PackEth, Packet Generator, NetScan, Scapy, Nemesis

### Session Hijacking
- Paros Proxy, Burp Suite, Firesheep, Hamster/Ferret, Ettercap, Hunt

### Crypto / Stego / Hash
- Encryption: TrueCrypt, BitLocker, DriveCrypt
- Hash: MD5 Hash, HashCalc
- Stego: XPTools, ImageHide, Merge Streams, StegParty, gifShuffle, QuickStego, InvisibleSecrets, EZStego, OmniHidePro
- Cryptanalysis: Cryptobench

### Sniffing (Packet Capture)
- Wireshark, CACE, tcpdump, Capsa, OmniPeek, WinDump, dnsstuff, EtherApe

### Wireless
- Discovery: Kismet, NetStumbler, inSSIDer, NetSurveyor
- Sniffing: Cascade Pilot, OmniPeek, CommView, Capsa
- WEP/WPA: Aircrack, KisMAC, Wireless Security Auditor, WepAttack, WepCrack, coWPAtty
- Bluetooth: BTBrowser, BH Bluejack, BTScanner, Bluesnarfer
- Mobile Tracking: Where’s My Droid, Find My iPhone, GadgetTrack, iHound

### Trojans / Malware
- Wrappers: Elite Wrap
- Monitoring: HiJackThis, CurrPorts, fport
- Attack: netcat, Nemesis

### IDS / Evasion
- IDS: Snort
- Evasion: ADMutate, NIDSBench, IDSInformer, Inundator

### Web Attacks
- Recon & Audit: Wfetch, httprecon, ID Serve, WebSleuth, Black Widow, CookieDigger, NStalker, NetBrute
- SQLi: BSQL Hacker, Marathon, SQL Injection Brute, SQL Brute, SQLNinja, SQLGET

---

