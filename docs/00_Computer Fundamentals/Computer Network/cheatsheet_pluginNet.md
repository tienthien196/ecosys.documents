## 1. COMPUTER NETWORKS  
### 1.1. Network Fundamentals  
- Definition:  
  A computer network is a collection of interconnected devices (computers, servers, routers, etc.)  
  that communicate and share resources using standardized protocols.  
- Goals:  
  - Resource sharing (files, printers, internet)  
  - Communication (email, video, chat)  
  - Reliability and availability  
  - Scalability  

- Types of Networks:  
  - PAN (Personal Area Network) – Bluetooth, USB  
  - LAN (Local Area Network) – within a building, Ethernet/Wi-Fi  
  - MAN (Metropolitan Area Network) – city-wide (e.g., ISP)  
  - WAN (Wide Area Network) – global, e.g., Internet  
  - WLAN, SAN, VAN, etc.  

- Network Topologies:  
  - Bus, Star, Ring, Mesh, Tree  
  - Physical vs Logical topology  

- Transmission Modes:  
  - Simplex, Half-duplex, Full-duplex  
  - Unicast, Broadcast, Multicast, Anycast  

### 1.2. OSI Model (7 Layers)  
| Layer | Name | Function | Examples |  
|-------|------|----------|----------|  
| 7 | Application | User interface, network services | HTTP, FTP, SMTP, DNS |  
| 6 | Presentation | Data translation, encryption, compression | SSL/TLS, JPEG, ASCII |  
| 5 | Session | Establish, manage, terminate connections | NetBIOS, RPC, SIP |  
| 4 | Transport | End-to-end communication, error recovery | TCP, UDP |  
| 3 | Network | Logical addressing, routing | IP, ICMP, routers |  
| 2 | Data Link | Framing, MAC addressing, error detection | Ethernet, PPP, switches |  
| 1 | Physical | Bit transmission over medium | Cables, hubs, NICs, Wi-Fi |  

- Data Unit per Layer:  
  - Application → Message  
  - Transport → Segment (TCP) / Datagram (UDP)  
  - Network → Packet  
  - Data Link → Frame  
  - Physical → Bit  

### 1.3. TCP/IP Model (4 Layers)  
| Layer | Equivalent OSI Layers | Protocols |  
|-------|------------------------|----------|  
| Application | 5–7 | HTTP, FTP, DNS, SMTP, DHCP |  
| Transport | 4 | TCP, UDP |  
| Internet | 3 | IP (IPv4, IPv6), ICMP, ARP |  
| Network Interface | 1–2 | Ethernet, Wi-Fi, PPP |  

- TCP/IP is the foundation of the Internet.  
- More practical than OSI; used in real-world implementations.  

### 1.4. IP Addressing & Subnetting  
- IPv4:  
  - 32-bit address (e.g., 192.168.1.1)  
  - Classes: A (1–126), B (128–191), C (192–223)  
  - Private IPs:  
    - 10.0.0.0/8  
    - 172.16.0.0/12  
    - 192.168.0.0/16  
  - Public IPs: Globally routable  
  - Subnet Mask: e.g., 255.255.255.0 = /24  

- IPv6:  
  - 128-bit address (e.g., 2001:0db8:85a3::8a2e:0370:7334)  
  - No NAT required  
  - Built-in security (IPsec)  
  - Types: Unicast, Multicast, Anycast  

- CIDR (Classless Inter-Domain Routing):  
  - /24, /16, /8 notation  
  - Enables flexible subnetting  

- Subnetting Formula:  
  - Number of subnets = \(2^n\) (n = borrowed bits)  
  - Hosts per subnet = \(2^h - 2\) (h = host bits, -2 for network & broadcast)  

### 1.5. Transport Layer Protocols  
- **TCP (Transmission Control Protocol)**  
  - Connection-oriented, reliable  
  - 3-way handshake: SYN → SYN-ACK → ACK  
  - Flow control (sliding window)  
  - Error control (ACK, retransmission)  
  - Congestion control (slow start, AIMD)  
  - Port numbers (0–65535), well-known: 80, 443, 21, 22, 25  

- **UDP (User Datagram Protocol)**  
  - Connectionless, unreliable  
  - Low overhead, fast  
  - Used in: DNS, VoIP, video streaming, online games  
  - No handshake, no retransmission  

### 1.6. Application Layer Protocols  
- **HTTP/HTTPS**: Web (port 80 / 443)  
  - Request methods: GET, POST, PUT, DELETE  
  - Status codes: 200, 404, 500, 301, 403  
  - HTTPS = HTTP + TLS/SSL encryption  

- **DNS (Domain Name System)**  
  - Translates domain → IP  
  - Hierarchical: root → TLD (.com) → authoritative servers  
  - Query types: recursive, iterative  
  - Record types: A, AAAA, CNAME, MX, NS  

- **DHCP (Dynamic Host Configuration Protocol)**  
  - Assigns IP automatically  
  - DORA: Discover → Offer → Request → Acknowledge  

- **SMTP, POP3, IMAP**  
  - SMTP (port 25/587): Send email  
  - POP3 (110): Download & delete  
  - IMAP (143): Sync across devices  

- **FTP/SFTP**  
  - File transfer (port 21)  
  - SFTP = SSH File Transfer Protocol (secure)  

### 1.7. Network Devices  
| Device | Layer | Function |  
|--------|------|----------|  
| Hub | Physical | Broadcasts bits (dumb) |  
| Switch | Data Link | Forwards frames using MAC |  
| Router | Network | Routes packets using IP |  
| Modem | Physical | Converts digital ↔ analog (DSL, cable) |  
| Access Point | Data Link | Wireless connectivity |  
| Firewall | L3/L4 | Filters traffic, security |  
| Bridge | Data Link | Connects LAN segments |  

### 1.8. Wireless & Mobile Networks  
- Wi-Fi Standards:  
  - 802.11a/b/g/n/ac/ax (Wi-Fi 4/5/6)  
  - Frequency: 2.4 GHz, 5 GHz, 6 GHz  
  - Modes: Infrastructure (AP), Ad-hoc  

- Mobile Networks:  
  - 1G → 5G: Analog → Digital → Broadband → Ultra-low latency  
  - 5G: eMBB, URLLC, mMTC  
  - Components: Cell tower, base station, core network  

- Bluetooth: PAN, short-range, low power  
- NFC: Contactless, very short range (payments)  

### 1.9. Network Security  
- Threats:  
  - Malware, Phishing, DoS/DDoS, Man-in-the-Middle  
- Defense Mechanisms:  
  - Firewall (stateful, packet filtering)  
  - IDS/IPS (Intrusion Detection/Prevention)  
  - VPN (Virtual Private Network)  
  - TLS/SSL (encryption for web)  
  - Authentication: 802.1X, RADIUS  
- Encryption:  
  - Symmetric (AES), Asymmetric (RSA)  
  - PKI, Digital Certificates  

### 1.10. Performance & Troubleshooting  
- Bandwidth: Max data rate (Mbps, Gbps)  
- Latency: Delay (ms) – propagation, transmission, queuing  
- Jitter: Variation in delay (bad for VoIP)  
- Throughput: Actual data rate (≤ bandwidth)  
- MTU: Maximum Transmission Unit (1500 bytes typical)  

- Tools:  
  - `ping` – test reachability  
  - `traceroute` / `tracert` – path to destination  
  - `ipconfig` / `ifconfig` – network config  
  - `nslookup` / `dig` – DNS lookup  
  - `netstat` – active connections  
  - `tcpdump` / Wireshark – packet analysis  

---

:::note Computer Networks
Computer networks enable communication and resource sharing across devices through interconnected pathways.  
They rely on layered architectures (OSI, TCP/IP) and standardized protocols to ensure interoperability.

Core principles:
- **Layering**: Each layer has a specific role, abstracts lower layers.
- **Addressing**: IP for routing, MAC for local delivery.
- **Reliability**: TCP ensures delivery; UDP prioritizes speed.
- **Scalability**: Hierarchical design (DNS, IP addressing).
- **Security**: Encryption, firewalls, authentication.

Modern networks support:
- High-speed internet (fiber, 5G)
- Cloud computing and streaming
- IoT and smart devices
- Real-time applications (gaming, video calls)

Understanding networks is essential for system design, cybersecurity, and distributed applications.
:::

## Formulas

                        COMPUTER NETWORKS
                                 |
        ---------------------------------------------------------
        |                        |                              |
    TCP/IP MODEL            IP & SUBNETTING               SECURITY & PERFORMANCE
        |                        |                              |
   ---------------       -------------------         ---------------------
   |      |      |       |        |        |         |         |         |
Application  Transport   IPv4    IPv6    Subnetting   Firewall  TLS/SSL   Latency
(HTTP, DNS)  (TCP, UDP)  Classes  Address  CIDR       VPN       PKI       Jitter
        |               Private IPs
        |
     ROUTING & DEVICES
        |
   ---------------------
   |         |         |
Router   Switch   Modem/AP
         |
      WIRELESS
         |
   ---------------------
   |         |         |
Wi-Fi    Bluetooth   5G/4G
(802.11)   (PAN)     (Cellular)

1. **Bandwidth-Delay Product (BDP)**  
   $$
   \text{BDP} = \text{Bandwidth (bps)} \times \text{Round-Trip Time (s)}
   $$  
   → Determines optimal TCP window size.

2. **Maximum Data Rate (Shannon-Hartley)**  
   $$
   C = B \log_2(1 + \text{SNR})
   $$  
   where \( C \) = channel capacity, \( B \) = bandwidth, SNR = signal-to-noise ratio.

3. **Subnet Hosts Calculation**  
   $$
   \text{Usable Hosts} = 2^{(32 - \text{prefix})} - 2
   $$  
   (e.g., /24 → \(2^8 - 2 = 254\) hosts)

4. **Propagation Delay**  
   $$
   d_{\text{prop}} = \frac{\text{Distance}}{\text{Propagation Speed}}
   $$  
   (e.g., speed of light ≈ \(2 \times 10^8\) m/s in fiber)

5. **Transmission Delay**  
   $$
   d_{\text{trans}} = \frac{\text{Packet Size (bits)}}{\text{Bandwidth (bps)}}
   $$

6. **Total Delay**  
   $$
   d_{\text{total}} = d_{\text{prop}} + d_{\text{trans}} + d_{\text{queue}} + d_{\text{proc}}
   $$

7. **TCP Throughput (Ideal)**  
   $$
   \text{Throughput} \approx \frac{\text{Window Size}}{\text{RTT}}
   $$

---

## Rules of Thumb

### The 80/20 Rule (Network Traffic)
> 80% of traffic stays within LAN; 20% goes to WAN. Design accordingly.

### Bandwidth vs Latency
> High bandwidth doesn’t fix high latency. Real-time apps need low RTT.

### MTU Rule
> Default Ethernet MTU = 1500 bytes. Lower if using VPN or tunneling.

### TCP Retransmission Rule
> If packet loss > 2%, TCP throughput drops sharply. Optimize network.

### Wi-Fi Channel Rule
> In 2.4 GHz, use channels 1, 6, 11 to avoid interference.

### DNS TTL Rule
> Set low TTL (300s) before migration; high TTL (86400s) for stability.

### 3-2-1 Backup Rule (applies to network storage)
> 3 copies, 2 media types, 1 offsite.

### 5-4-3 Rule (Legacy Ethernet)
> 5 segments, 4 repeaters, 3 populated segments – obsolete but historic.