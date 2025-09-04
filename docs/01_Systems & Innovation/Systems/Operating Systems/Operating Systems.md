```
                             OPERATING SYSTEM (OS)
                                      |
        ---------------------------------------------------------------------------------
        |                |                  |                   |                     |
    PROCESS        MEMORY MANAGEMENT    FILE SYSTEM        I/O & DEVICE        SECURITY & PROTECTION
   MANAGEMENT             |                   |               MANAGEMENT               |
        |                |                   |                   |                     |
    -----------    ----------------    ----------------    ----------------    -------------------
    |    |    |    |       |       |    |       |       |    |       |       |    |       |       |
  Process  Thread  Scheduling     Paging    Segmentation   FAT, NTFS, ext4   Device Drivers  Buffering  Authentication  Access Control  Encryption
  States   (Multithreading)     (Page Table, TLB)  (Logical → Physical)   (Directory, Inode)   (Kernel I/O)  Caching        (Password, Biometric) (ACL, Roles)   (AES, RSA)
  (New,     |          |             |           |             |             |          |          |                     |
  Ready,    |    FCFS, SJF,        Virtual      Page Fault    File Ops      Interrupts  DMA      Firewall     Privilege Rings
  Running,  |    Round Robin,     Memory       Demand Paging   (open, read)   (Polling vs) (Direct Memory Access)   (User vs Kernel Mode)
  Blocked)  |    Priority)        (Swap Space)  (Lazy Loading)                Interrupt-Driven)
            |         |                |           |             |                   |
            |    Multilevel           |        Thrashing       |                   |
            |    Feedback Queue       |    (Fix: Increase RAM)  |                   |
            |                         |                        Hard Links vs Soft Links
            |                         |                        (Same inode vs Path-based)
            |
        SYNCHRONIZATION
            |
    ---------------------
    |         |         |
  Mutex    Semaphore   Monitor
  (Lock)   (Counting,  (High-level
           Binary)     construct)
            |
        DEADLOCK
            |
    ---------------------
    |         |         |
  Mutual   Hold &    No Preemption   Circular Wait
  Exclusion  Wait      (Can't force stop)   (A→B→C→A)
            |
     Prevention / Avoidance / Detection / Recovery
```

## 1. OPERATING SYSTEMS  
### 1.1. Introduction to Operating Systems  
- Definition:  
  Phần mềm hệ thống quản lý phần cứng và tài nguyên, cung cấp môi trường cho ứng dụng chạy.  
- Mục tiêu:  
  - Tận dụng hiệu quả tài nguyên (CPU, memory, I/O).  
  - Cung cấp giao diện dễ dùng cho người dùng và lập trình viên.  
  - Đảm bảo an toàn, ổn định, cô lập giữa các tiến trình.  

- Các loại hệ điều hành:  
  - Batch OS (xử lý theo lô – cũ)  
  - Time-Sharing (Multi-user, chia thời gian)  
  - Real-Time OS (RTOS): Hard RTOS, Soft RTOS  
  - Distributed OS: Nhiều máy phối hợp như một hệ thống  
  - Network OS: Quản lý mạng cục bộ  
  - Mobile OS: Android, iOS  
  - Embedded OS: Thiết bị nhúng (IoT, xe, máy y tế)  

- Vai trò chính:  
  - Quản lý tiến trình (Process Management)  
  - Quản lý bộ nhớ (Memory Management)  
  - Quản lý hệ thống tệp (File System)  
  - Quản lý thiết bị (Device Management)  
  - Bảo mật và bảo vệ (Security & Protection)  

### 1.2. Process Management  
- Process (Tiến trình):  
  - Một chương trình đang thực thi.  
  - Có PCB (Process Control Block): lưu trạng thái, register, priority, tài nguyên.  
- States:  
  - New → Ready → Running → Waiting → Terminated  
- Process Scheduling:  
  - Mục tiêu: Tối ưu CPU utilization, throughput, turnaround time, waiting time, response time.  
  - Schedulers:  
    - Long-term (chọn process vào memory)  
    - Short-term (CPU scheduling)  
    - Medium-term (swapping)  

- Scheduling Algorithms:  
  - FCFS (First-Come, First-Served) – unfair nếu tiến trình dài  
  - SJF (Shortest Job First) – tối ưu nhưng khó đoán trước  
  - SRTF (SJF dạng preemptive)  
  - Round Robin (RR) – công bằng, dùng time quantum  
  - Priority Scheduling – có thể bị starvation  
  - Multilevel Queue, Multilevel Feedback Queue  

- IPC (Inter-Process Communication):  
  - Shared Memory  
  - Message Passing (pipes, sockets, message queues)  

- Threads (Luồng):  
  - Lightweight process, chia sẻ address space với process cha.  
  - Ưu điểm: nhanh tạo, ít tốn tài nguyên, giao tiếp dễ.  
  - User-level vs Kernel-level threads  

### 1.3. CPU Scheduling Formulas  
- CPU Utilization = (Thời gian bận / Tổng thời gian) × 100%  
- Throughput = Số tiến trình hoàn thành / Thời gian  
- Turnaround Time = Thời gian hoàn thành – Thời gian đến  
- Waiting Time = Turnaround – Burst Time  
- Response Time = Thời gian từ khi đến → lần đầu được CPU  

### 1.4. Concurrency & Synchronization  
- Race Condition: Kết quả phụ thuộc vào thứ tự thực thi.  
- Critical Section: Đoạn code truy cập tài nguyên chung → cần đồng bộ.  
- Yêu cầu:  
  - Mutual Exclusion  
  - Progress  
  - Bounded Waiting  

- Solutions:  
  - Locks / Mutex (mutual exclusion)  
  - Semaphores (counting, binary)  
  - Monitors  
  - Condition Variables  

- Deadlock:  
  - 4 điều kiện cần:  
    1. Mutual Exclusion  
    2. Hold and Wait  
    3. No Preemption  
    4. Circular Wait  
  - Xử lý:  
    - Prevention (ngăn 1 điều kiện)  
    - Avoidance (Banker’s Algorithm)  
    - Detection & Recovery (resource allocation graph)  
    - Ignore (như trong Linux)  

- Starvation: Tiến trình không bao giờ được cấp tài nguyên.  

### 1.5. Memory Management  
- Logical vs Physical Address  
- Address Binding: Compile time, Load time, Execution time  
- Swapping: Di chuyển process giữa RAM và disk  

- Contiguous Allocation:  
  - Single partition, Multiple fixed/var partitions  
  - External fragmentation (không gian rảnh rải rác)  

- Paging:  
  - Chia memory thành các frame (physical), process thành page (logical)  
  - Page Table: ánh xạ page → frame  
  - TLB (Translation Lookaside Buffer): cache cho page table  
  - Multi-level Page Table: giảm bộ nhớ page table  

- Segmentation:  
  - Chia theo logic: code, data, stack  
  - Có độ dài thay đổi → internal fragmentation  
  - Có thể kết hợp với paging (segmented paging)  

- Virtual Memory:  
  - Cho phép process dùng bộ nhớ lớn hơn RAM  
  - Demand Paging: chỉ nạp page khi cần  
  - Page Fault: khi truy cập page chưa ở RAM → OS nạp từ disk  
  - Page Replacement Algorithms:  
    - FIFO (có thể bị Belady’s anomaly)  
    - OPT (lý tưởng, biết tương lai)  
    - LRU (Least Recently Used) – phổ biến  
    - Clock (Second Chance)  
  - Working Set Model: giữ các page đang dùng gần đây  
  - Thrashing: quá nhiều page fault → CPU idle → giải pháp: giảm độ đa chương  

### 1.6. File Systems  
- File: Tập hợp dữ liệu có tên, được lưu trữ lâu dài.  
- Attributes: tên, kích thước, vị trí, quyền, thời gian tạo…  
- Operations: create, open, read, write, close, delete  

- Directory Structure:  
  - Single-level, Two-level, Hierarchical (tree), DAG, Acyclic Graph  
- Path: Absolute vs Relative  

- File System Layout:  
  - Boot block, Superblock, Inodes/FAT, Data blocks  
- Allocation Methods:  
  - Contiguous: đơn giản, nhưng external fragmentation  
  - Linked: không fragmentation, nhưng truy cập tuần tự  
  - Indexed: dùng block index → linh hoạt, dùng trong Unix/Ext  

- Free Space Management:  
  - Bit vector  
  - Linked list  
  - Grouping, Counting  

- Mounting: Gắn hệ thống tệp vào cây thư mục  
- Virtual File System (VFS): Hỗ trợ nhiều loại file system (ext4, NTFS, FAT32)  

### 1.7. I/O & Device Management  
- I/O Hardware:  
  - Port, Controller, Device  
  - Memory-mapped I/O vs Port-mapped I/O  
- Interrupts:  
  - Hardware interrupt từ thiết bị  
  - Interrupt Vector Table → ISR (Interrupt Service Routine)  

- I/O Software Layers:  
  - User-level I/O  
  - Device-independent I/O  
  - Device drivers  
  - Interrupt handlers  

- Disk Scheduling:  
  - FCFS, SSTF (Shortest Seek Time First)  
  - SCAN (elevator), C-SCAN (vòng tròn), LOOK, C-LOOK  
- RAID: Redundant Array of Independent Disks  
  - Mục đích: hiệu suất, độ tin cậy  
  - Cấp độ: RAID 0 (striping), RAID 1 (mirroring), RAID 5 (parity), RAID 6, RAID 10  

### 1.8. Security & Protection  
- Threats: Malware, Unauthorized access, DoS  
- Protection:  
  - Authentication (password, 2FA, biometrics)  
  - Authorization (DAC, MAC, RBAC)  
  - Access Control Matrix  
  - Capability-based systems  
- Encryption: File system encryption (BitLocker, FileVault)  
- Auditing: Log events for security analysis  

### 1.9. Virtualization  
- VM (Virtual Machine): Mô phỏng toàn bộ máy tính  
- Hypervisor (VMM):  
  - Type 1 (bare-metal): VMware ESXi, Hyper-V  
  - Type 2 (hosted): VirtualBox, VMware Workstation  
- Containerization (nhẹ hơn VM): Docker, Kubernetes  
  - Chia sẻ kernel, cô lập bằng namespaces, cgroups  

### 1.10. Modern OS Features  
- Microkernel vs Monolithic Kernel  
  - Monolithic: kernel lớn, mọi thứ trong kernel space (Linux)  
  - Microkernel: chỉ core trong kernel, phần còn lại ở user space (Mach, QNX)  
- Hybrid Kernels: kết hợp cả hai (Windows NT, macOS)  
- Real-time Support: trong Linux (PREEMPT_RT), FreeRTOS  
- Power Management: sleep, hibernate, dynamic frequency scaling  
- Container & Cloud Integration: systemd, cgroups, namespaces  

---

:::note Operating Systems
An operating system (OS) is the core software that manages hardware resources and provides services for applications.  
It acts as an intermediary between users and the computer hardware.

Key responsibilities:
- **Process Management**: Create, schedule, and synchronize processes.
- **Memory Management**: Allocate RAM, handle virtual memory and paging.
- **File System**: Organize and manage persistent data.
- **Device Management**: Control I/O devices via drivers and interrupts.
- **Security**: Enforce access control and protect system integrity.

Modern OS design emphasizes:
- **Efficiency** through scheduling and caching.
- **Reliability** via isolation and error handling.
- **Security** with authentication and encryption.
- **Scalability** for multi-core and distributed environments.

Understanding OS concepts is essential for system programming, performance tuning, and building robust software.
:::

## Formulas

                        OPERATING SYSTEMS
                                 |
        ---------------------------------------------------------
        |                        |                              |
  PROCESS & SCHEDULING      MEMORY MANAGEMENT            FILE & I/O SYSTEMS
        |                        |                              |
   ---------------       -------------------         ---------------------
   |      |      |       |        |        |         |         |         |
States  Scheduling   Paging   Virtual Mem   TLB     File Sys  Disk     RAID
        Algorithms         Page Fault, Swap          Allocation  Scheduling

1. **CPU Utilization**  
   $$
   \text{CPU Util\%} = \frac{\text{Busy Time}}{\text{Total Time}} \times 100\%
   $$

2. **Throughput**  
   $$
   \text{Throughput} = \frac{\text{Number of processes completed}}{\text{Time}}
   $$

3. **Turnaround Time**  
   $$
   T_{\text{turnaround}} = T_{\text{completion}} - T_{\text{arrival}}
   $$

4. **Waiting Time**  
   $$
   T_{\text{waiting}} = T_{\text{turnaround}} - T_{\text{burst}}
   $$

5. **Average Memory Access Time (AMAT) with TLB**  
   $$
   \text{AMAT} = \text{TLB Hit Rate} \times \text{TLB Access Time} + (1 - \text{Hit Rate}) \times (\text{TLB Access} + \text{Page Table Access})
   $$

6. **Effective Access Time (EAT) with Page Fault**  
   $$
   \text{EAT} = (1 - p) \times \text{Memory Access} + p \times \text{Page Fault Overhead}
   $$
   where \( p \) = page fault rate.

7. **Disk Access Time**  
   $$
   T_{\text{access}} = T_{\text{seek}} + T_{\text{rotational latency}} + T_{\text{transfer}}
   $$

---

## Rules of Thumb

### The 50% Rule (CPU Scheduling)
> If CPU utilization < 50%, the system is underutilized; if > 90%, it may be overloaded.

### Thrashing Rule
> If page fault rate is high and CPU utilization is low → thrashing. Reduce degree of multiprogramming.

### 2x Memory Rule
> For smooth multitasking, RAM should be at least twice the size of the largest application set in use.

### TLB Rule
> A good TLB hit rate is > 98%. Misses significantly slow down memory access.

### Disk Scheduling Rule
> Use C-SCAN for uniform response time; SSTF for low average wait (but risk starvation).

### File System Block Size
> Larger blocks → less fragmentation, but more internal waste. Typical: 4KB.

### Real-Time Deadline Rule
> In hard RTOS, missing a deadline = system failure.

### Principle of Least Privilege
> Processes should run with minimal necessary permissions.