---
title: Plugin Network
sidebar_position: 9
---

## Formulas

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