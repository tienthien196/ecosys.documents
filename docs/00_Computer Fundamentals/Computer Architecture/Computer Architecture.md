---
sidebar_position: 4
sidebar_label: Computer Architecture
---

# Computer Architecture

```
+---------------------+     +----------------------------+
|                     |     |                            |
|   Input Devices     |<--->|       I/O Controller       |
| (Keyboard, Mouse,   | Bus | (USB, SATA, PCIe, Network) |
|  Webcam, Scanner)   |<--->|                            |
|                     |     +-------------+--------------+
+---------------------+                   |
                                          |
                                          | System I/O Bus
                                          |
+---------------------+                   v                   +---------------------+
|                     |     +-----------------------------+   |                     |
|   Output Devices    |<--->|         GPU (Graphics       |<->|    Display /        |
| (Monitor, Printer,  | Bus |       Processing Unit)      |   |    Audio Devices    |
|  Speakers)          |<--->|                             |   |                     |
|                     |     +-----------------------------+   +---------------------+
+---------------------+                   |
                                          |
                                          | Front-Side Bus / DMI / PCIe
                                          v
                                +----------------------+
                                |       CPU            |
                                | +------------------+ |
                                | |   Control Unit   | |
                                | +------------------+ |
                                | |      ALU         | |
                                | +------------------+ |
                                | |   Registers      | |
                                | | (R0, R1, PC, SP) | |
                                | +------------------+ |
                                | |  L1 Cache (I + D)| |
                                | |  L2 Cache        | |
                                | |  L3 Cache (Shared)||
                                | +------------------+ |
                                +-----------+----------+
                                            |
                                            | CPU Memory Bus (High Speed)
                                            |
                                            v
                       +------------------------------------------+
                       |                Main Memory               |
                       | (RAM - DDR4/DDR5)                        |
                       | +------------+  +------------+           |
                       | |  Program   |  |   Data     |           |
                       | |   Code     |  |   Section  |           |
                       | +------------+  +------------+           |
                       +------------------------------------------+
                                            ^
                                            | Memory Bus
                                            |
                                            v
                     +---------------------------------------------+
                     |                Motherboard                  |
                     | +-----------------+  +--------------------+ |
                     | |   Chipset       |  |   Clock Generator  | |
                     | | (Northbridge +  |  |                    | |
                     | |  Southbridge or |  +--------------------+ |
                     | |   PCH)          |                         |
                     | |                 |                         |
                     | | - Memory Ctrl.  |                         |
                     | | - PCIe lanes    |                         |
                     | | - SATA/USB ctrl|                         |
                     | +-----------------+                         |
                     +---------------------------------------------+
                                            |
                  +------------+           | PCI Express / SATA / USB
                  |            |           |
                  |  Storage   |<----------+
                  | Devices    |
                  | (SSD, HDD, |<----------+ USB / Thunderbolt
                  |  Flash)    |
                  |            |
                  +------------+
```

```
+==================================================================+
|                   CPU CORE HIỆN ĐẠI (1 nhân)                     |
|       (Dùng đồng thời tất cả kỹ thuật để đạt IPC > 3)            |
+==================================================================+

  +---------------------+
  |  Instruction Fetch  | ← Lấy lệnh từ L1i Cache
  +----------+----------+
             |
             v
  +---------------------+
  |  Instruction Decode | ← Giải mã lệnh (CISC → µops nếu cần)
  +----------+----------+
             |
             v
  +---------------------------+
  |  μop Cache / Scheduler    | ← Chuẩn bị lệnh cho pipeline
  |  (Out-of-Order Engine)    | ← Sắp xếp lại lệnh để tối ưu
  +-------------+-------------+
                |
        +-------v--------+     +-------------------------+
        |   PIPELINE     | --> |   EXECUTION UNITS (×N)  |
        | (IF → ID → EX) |     | - ALU × 4               |
        |                |     | - FPU × 2               |
        |                |     | - Load/Store Unit × 2   |
        |                |     | - Branch Unit           |
        +----------------+     +------------+------------+
                                            |
                                            v
                                 +----------------------+
                                 |    DATA CACHE (L1d)  |
                                 +-----------+----------+
                                             |
                                             v
                                 +-----------------------+
                                 |       REGISTER FILE   |
                                 | (Rename, Bypass Logic)|
                                 +-----------------------+

                +-----------------------------------------+
                |       CÁC KỸ THUẬT CÙNG HOẠT ĐỘNG        |
                +-----------------------------------------+
                | • PIPELINE: Dây chuyền lệnh (5–14 stage)|
                | • SUPERSCALAR: 4–6 lệnh/chu kỳ          |
                | • OUT-OF-ORDER: Tối ưu thứ tự thực thi  |
                | • BRANCH PREDICTOR: Độ chính xác >95%   |
                | • SIMD (AVX/NEON): Xử lý vector         |
                | • REGISTER RENAMING: Tránh xung đột     |
                +-----------------------------------------+
```

```
+-------------------------------------------------------------+
|               ISA - Instruction Set Architecture            |
|   (Giao diện giữa phần mềm và phần cứng)                    |
+-------------------------------------------------------------+

+----------------+     +---------------------+     +-------------+
|                |     |                     |     |             |
|  Assembly Code | --> |   Machine Code      | --> |  Microcode  |
|  (ADD R1,R2,R3)|     |  (32-bit: 0x00234020)|    |  (Optional) |
|                |     |                     |     |             |
+----------------+     +----------+----------+     +-------------+
                                  |
                                  v
           +--------------------------------------------------+
           |               CPU EXECUTION FLOW                 |
           +--------------------------------------------------+
           | 1. FETCH: Lấy lệnh từ Memory → IR                |
           |    [PC] → Address Bus → Memory → Data Bus → IR   |
           |                                                  |
           | 2. DECODE: Giải mã lệnh → xác định:              |
           |    - Loại lệnh (R-type, I-type, J-type)          |
           |    - Thanh ghi nguồn (Rs, Rt), đích (Rd)         |
           |    - Opcode & Function field                     |
           |                                                  |
           | 3. EXECUTE: ALU thực hiện phép toán              |
           |    Ví dụ: R1 = R2 + R3                           |
           |                                                  |
           | 4. MEMORY ACCESS (nếu cần):                      |
           |    - LOAD: Đọc dữ liệu từ RAM                    |
           |    - STORE: Ghi dữ liệu vào RAM                  |
           |                                                  |
           | 5. WRITE BACK: Ghi kết quả vào thanh ghi (Rd)    |
           +--------------------------------------------------+

+-----------------------------------------------------------------------+
|                        ISA COMPONENTS                                 |
+----------------------------+----------------------+---------------------+
|   R-TYPE (Register)        |   I-TYPE (Immediate) |   J-TYPE (Jump)     |
| Opcode | Rs | Rt | Rd |Sh|F| Opcode | Rs | Rt | Addr | Opcode | Target |
| 6b     | 5b | 5b | 5b |5b|6b| 6b     | 5b | 5b | 16b  | 6b     | 26b   |
+----------------------------+----------------------+---------------------+
| EX: ADD R1,R2,R3           | EX: LW R1,4(R2)      | EX: J loop         |
| (Tính toán giữa thanh ghi) | (Tải từ bộ nhớ)      | (Nhảy đến nhãn)    |
+----------------------------+----------------------+---------------------+

+------------------------+     +-------------------------+
| Supported Data Types   |     | Addressing Modes        |
| - Byte (8-bit)         |     | - Immediate: #5         |
| - Halfword (16-bit)    |     | - Register: R1          |
| - Word (32-bit)        |     | - Base + Offset: 4(R2)  |
| - Single/Double Float  |     | - PC-relative: loop     |
+------------------------+     +-------------------------+

+-------------------------------------------------------------+
| Key Features of ISA                                         |
| - Tập lệnh (ADD, SUB, LW, SW, BEQ, J, ...)                  |
| - Số lượng thanh ghi (R0–R31)                               |
| - Định dạng lệnh (3 loại chính)                            |
| - Cách định địa chỉ (addressing modes)                      |
| - Hỗ trợ ngắt (interrupts) và ngoại lệ (exceptions)         |
| - Giao diện ABI (Application Binary Interface)              |
+-------------------------------------------------------------+
```



## 1. COMPUTER ARCHITECTURE  
### 1.1. Digital Logic 
- Boolean Algebra
  - AND, OR, NOT, XOR
  - NAND, NOR (universal gates)
  - Truth tables
  - Boolean expressions
  - De Morgan's Laws
- Logic Gates
  - Transistor as switch
  - CMOS technology
  - Gate delay, fan-out
- Combinational Circuits
  - Multiplexer (MUX)
  - Demultiplexer (DEMUX)
  - Decoder
  - Encoder
  - Adder (Half Adder, Full Adder)
  - Arithmetic Logic Unit (ALU) – basic design
- Sequential Circuits
  - Latch (SR Latch)
  - Flip-Flop (D Flip-Flop, JK Flip-Flop)
  - Clock signal
  - Synchronous vs Asynchronous circuits
  - Register
  - Shift Register
  - Counter (Binary Counter, Ring Counter)

### 1.2. Processor Design (Thiết kế bộ xử lý)
- Central Processing Unit (CPU)
  - Control Unit (CU)
  - Arithmetic Logic Unit (ALU)
  - Registers (General-purpose, PC, IR, ACC, SP)
- Datapath
  - Instruction fetch, decode, execute
  - Bus system (data bus, address bus, control bus)
- Instruction Set Architecture (ISA)
  - RISC vs CISC
  - x86, ARM, RISC-V
  - Instruction formats (opcode, operands)
  - Addressing modes (immediate, direct, indirect, indexed)
  - Assembly language
    - Mnemonics
    - Labels, directives
    - Assembler (two-pass)
- Control Unit Design
  - Hardwired control
  - Microprogrammed control
  - Microcode

### 1.3. Memory Hierarchy
- Memory types
  - Volatile vs Non-volatile
  - RAM (DRAM, SRAM)
  - ROM (PROM, EPROM, EEPROM, Flash)
- Memory Organization
  - Address space
  - Byte addressing
  - Endianness (Little-endian, Big-endian)
  - Memory-mapped I/O
- Cache Memory
  - Cache hit / miss
  - Hit rate, miss penalty
  - Cache mapping (Direct-mapped, Fully associative, Set-associative)
  - Replacement policies (LRU, FIFO, Random)
  - Write policies (Write-through, Write-back)
  - Cache coherence (in multi-core)
- Virtual Memory
  - Page, Frame
  - Page table
  - TLB (Translation Lookaside Buffer)
  - Paging, segmentation
  - Page fault
  - Demand paging
  - Working set model

### 1.4. Storage Systems
- Secondary storage
  - Hard Disk Drive (HDD)
    - Platter, track, sector
    - Seek time, rotational latency, transfer time
  - Solid State Drive (SSD)
    - NAND flash
    - Wear leveling
    - TRIM command
- Tertiary storage
  - Magnetic tape
  - Optical storage (CD, DVD, Blu-ray)

### 1.5. Input/Output (I/O) Systems
- I/O interfaces
  - Programmed I/O
  - Interrupt-driven I/O
  - Direct Memory Access (DMA)
- I/O controllers
- Buses
  - System bus
  - Expansion buses (PCI, PCIe, USB)
- Interrupts
  - Interrupt vector table
  - Interrupt service routine (ISR)
  - Maskable vs Non-maskable interrupts

### 1.6. Performance & Parallelism
- CPU Performance
  - Clock cycle, clock rate
  - CPI (Cycles Per Instruction)
  - MIPS, FLOPS
  - Amdahl's Law
- Pipelining
  - Pipeline stages (IF, ID, EX, MEM, WB)
  - Pipeline hazards
    - Structural hazard
    - Data hazard (forwarding, stalling)
    - Control hazard (branch prediction)
- Parallel Architectures
  - Multi-core processors
  - SIMD (Single Instruction, Multiple Data)
  - Superscalar, Out-of-order execution
  - SISD, SIMD, MISD, MIMD (Flynn's Taxonomy)

---

:::note Computer Architecture
Computer architecture is a crucial concept in computer science. It involves designing and organizing computer systems at
the hardware level, encompassing the structure and functionality of computer components and how they interact to execute
instructions and perform tasks.

At its core, computer architecture defines the blueprint of a computer system, specifying the relationships between its
various components.

- **CPU**: executes instructions stored in memory.  
- **Memory hierarchy**: registers, cache, RAM, secondary storage.  
- **Input/Output systems**: manage interactions with external devices.  
- **Interconnection structures**: buses and networks for communication.  

The **Instruction Set Architecture (ISA)** serves as the interface between hardware and software, defining the set of
instructions that a CPU can execute. Different ISAs affect software compatibility and system performance.

Modern architectures improve processing via:  
- **Parallelism**: executing multiple instructions simultaneously.  
- **Pipelining**: dividing execution into stages for concurrency.  

Evolution has moved from single-core to multi-core processors, boosting performance through parallelism. Advances in
**RISC** and **CISC** have shaped CPU design strategies.

As a foundational aspect of computer science, computer architecture determines how hardware components collaborate to
execute instructions and deliver computing capabilities.
:::

## Formulas
```
                        COMPUTER ARCHITECTURE
                                 |
        ---------------------------------------------------------
        |                        |                              |
    CPU (Central          MEMORY HIERARCHY               INPUT/OUTPUT (I/O)
   Processing Unit)            |                              |
        |              -------------------          ---------------------
        |              |        |        |          |         |         |
     --------     Cache (L1,L2,L3)  Main Memory    Keyboard   Display   Storage
     |      |           |               |           Mouse     Printer   (HDD, SSD)
  Control  ALU        TLB            ROM / RAM     Network   Sensors   Flash
   Unit   (Arithmetic               (DRAM, SRAM)    Devices   Actuators
          & Logic)                     |
             |                        |
             |                   Virtual Memory
             |                   (Paging, Segmentation)
             |
         REGISTERS
         (PC, IR, ACC, SP)
             |
        ----------------
        |      |       |
     Clock   Pipelining  CISC vs RISC
     Speed   (Fetch,     (Complex vs
     (GHz)    Decode,     Reduced Set)
             Execute,
             Memory,
             Writeback)
                 |
             PARALLELISM
                 |
        ---------------------
        |         |         |
   Multi-core  SIMD (e.g., GPU)  Superscalar
   Processors   (Vector ops)     (Multiple pipes)
                 |
             CACHE & PERFORMANCE
                 |
        ---------------------
        |         |         |
   Cache Hit   Cache Miss   Locality
   (Fast)      (Slow: Stall) (Temporal, Spatial)
```



1. **CPU Time**  

   $$
   \text{CPU time} = \text{Instruction count} \times \text{CPI} \times \text{Clock cycle time}
   $$

2. **Relative Performance**  

   $$
   X \text{ is } n \text{ times faster than } Y:\quad 
   n = \frac{\text{Execution time}_Y}{\text{Execution time}_X} 
     = \frac{\text{Performance}_X}{\text{Performance}_Y}
   $$

3. **Amdahl's Law**  

   $$
   \text{Speedup}_{overall} = 
   \frac{\text{Execution time}_{old}}{\text{Execution time}_{new}} 
   = \frac{1}{\left(1 - \text{Fraction}_{enhanced}\right) + \frac{\text{Fraction}_{enhanced}}{\text{Speedup}_{enhanced}}}
   $$

4. **Dynamic Energy**  

   $$
   \text{Energy}_{dynamic} \propto \tfrac{1}{2} \times \text{Capacitive load} \times \text{Voltage}^2
   $$

5. **Dynamic Power**  

   $$
   \text{Power}_{dynamic} \propto \tfrac{1}{2} \times \text{Capacitive load} \times \text{Voltage}^2 \times \text{Frequency}
   $$

6. **Static Power**  

   $$
   \text{Power}_{static} \propto \text{Current}_{static} \times \text{Voltage}
   $$

7. **Availability**  

   $$
   \text{Availability} = \frac{\text{MTTF}}{\text{MTTF} + \text{MTTR}}
   $$

8. **Die Yield**  

   $$
   \text{Die yield} = \text{Wafer yield} \times \frac{1}{\left(1 + \text{Defects per unit area} \times \text{Die area}\right)^N}
   $$

   where Wafer yield accounts for wafers too bad to test,  
   and $N$ is the process-complexity factor (≈ 11.5–15.5 for 40nm in 2010).

9. **Means** — Arithmetic (AM), Weighted Arithmetic (WAM), Geometric (GM):  

   $$
   \text{AM} = \frac{1}{n} \sum_{i=1}^{n} \text{Time}_i
   $$

   $$
   \text{WAM} = \frac{1}{n} \sum_{i=1}^{n} \text{Weight}_i \times \text{Time}_i
   $$

   $$
   \text{GM} = \sqrt[n]{\prod_{i=1}^{n} \text{Time}_i}
   $$

   where $\text{Time}_i$ is execution time of program $i$,  
   $\text{Weight}_i$ is the weighting of program $i$.

10. **Average Memory-Access Time**  

    $$
    \text{AMAT} = \text{Hit time} + \text{Miss rate} \times \text{Miss penalty}
    $$

11. **Misses per Instruction**  

    $$
    \text{Misses per instruction} = \text{Miss rate} \times \text{Memory accesses per instruction}
    $$

12. **Cache Index Size**  

    $$
    2^{\text{index}} = \frac{\text{Cache size}}{\text{Block size} \times \text{Set associativity}}
    $$

13. **Power Utilization Effectiveness (PUE)**  

    $$
    \text{PUE} = \frac{\text{Total Facility Power}}{\text{IT Equipment Power}}
    $$

---

## Rules of Thumb

### Amdahl/Case Rule
> A balanced computer system needs about **1 MB of main memory capacity**  
> and **1 megabit/s of I/O bandwidth** per **MIPS** of CPU performance.

### 90/10 Locality Rule
> A program executes about **90% of its instructions** in **10% of its code**.

### Bandwidth Rule
> Bandwidth grows by at least the square of the improvement in latency.

### 2:1 Cache Rule
> The miss rate of a direct-mapped cache of size $N$  
> is about the same as a two-way set-associative cache of size $\tfrac{N}{2}$.

### Dependability Rule
> Design with **no single point of failure**.