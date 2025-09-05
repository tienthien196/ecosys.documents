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


---
```
==========================================================================================================
                   CPU CORE TOÀN DIỆN – BẢN CHẤT TỪ LỆNH ĐẾN THỰC THI
==========================================================================================================

                                    +----------------------------+
                                    |       CLOCK SIGNAL         |
                                    | (e.g., 3.5 GHz)            |
                                    +--------------+-------------+
                                                   |
                                                   v
                    +------------------------------------------------------------------+
                    |                        CONTROL UNIT (CU)                           |
                    | - Giải mã lệnh (Instruction Decode)                              |
                    | - Điều phối luồng thực thi                                       |
                    | - Tạo tín hiệu điều khiển (control signals)                      |
                    | - Quản lý pipeline stages: IF → ID → EX → MEM → WB               |
                    +----------------------------+-------------------------------------+
                                                 |
       +----------------------------------------+----------------------------------------+
       |                                        |                                        |
       v                                        v                                        v
+--------------+                     +---------------------+                  +------------------+
| INSTRUCTION  |                     |   INSTRUCTION       |                  |   REGISTER FILE  |
|  FETCH (IF)  |<---> L1i Cache <----|   DECODE (ID)       |<-----------------| (General Purpose)|
|              |   (32KB, 8-way)     |                     |    Register     | RAX, RBX, RCX, ...|
| - PC → Addr  |                     | - Opcode → µops     |    Renaming     | RSP, RBP, RDI, ...|
| - Fetch inst |                     | - Decode engine     |    (Tomasulo)   | (128/256-bit)     |
| - PC += 4    |                     | - Dispatch to RS    |                 +--------+---------+
+--------------+                     +---------------------+                          |
       |                                        |                                      |
       |                                        v                                      |
       |                             +------------------------+                        |
       |                             |    REORDER BUFFER (ROB)|                        |
       |                             | - Giữ lệnh theo thứ tự |                        |
       |                             |   xuất hiện (program order)                    |
       |                             | - Commit kết quả cuối cùng                    |
       |                             +------------------------+                        |
       |                                        |                                       |
       |                                        v                                       |
       |                             +------------------------+                        |
       |                             |    RESERVATION STATIONS  | <--------------------+
       |                             | (RS - Issue Queue)       |    Operand từ RF hoặc
       |                             | - Chờ operand sẵn sàng   |    bypass network
       |                             | - Ready → đưa vào EX     |
       |                             +------------------------+
       |                                        |
       |                                        v
       |                    +--------------------------------------------------+
       |                    |               EXECUTION UNITS (×N)               |
       |                    |                                                  |
       |        +-----------+-----------+     +----------------------+       |
       |        |   ARITHMETIC LOGIC    |     |   FLOATING-POINT     |       |
       |        |       UNIT (ALU)      |     |     UNIT (FPU)       |       |
       |        | - ADD, SUB, AND, OR   |     | - ADD, MUL, DIV (FP) |       |
       |        | - LEA, INC, DEC       |     | - SIMD (SSE/AVX)     |       |
       |        | - 4 units (port 0,1,5)|     | - 2 units (port 1,5) |       |
       |        +-----------+-----------+     +----------+-----------+       |
       |                    |                            |                   |
       |        +-----------v-----------+     +----------v-----------+       |
       |        |   BRANCH UNIT         |     |   LOAD/STORE UNIT    |       |
       |        | - Compare, JUMP       |     | - AGU (Address Gen)  |       |
       |        | - Branch Prediction   |     | - D-Cache interface  |       |
       |        |   (BTB, RAS)          |     | - 2 Load, 1 Store    |       |
       |        +-----------+-----------+     +----------+-----------+       |
       |                    |                            |                   |
       +--------------------+----------------------------+-------------------+
                            |                            |
                            v                            v
                   +--------------+             +------------------+
                   | BRANCH TARGET|             |   DATA CACHE     |
                   |   BUFFER     |             |   (L1d, 48KB)      |
                   | (BTB) & RAS  |             | 8-way, 64B/line    |
                   | - Dự đoán nhảy|             +---------+--------+
                   +--------------+                       |
                                                        v
                                               +------------------+
                                               |   L2 CACHE (per-core)  |
                                               | 1.5MB, inclusive     |
                                               | Low-latency (~12 cycles)|
                                               +----------+-----------+
                                                          |
                                                          v
                                          +----------------------------------+
                                          |    LAST-LEVEL CACHE (LLC)        |
                                          |            L3 Cache              |
                                          | - Shared giữa các core (e.g., 30MB)|
                                          | - Ring/Mesh Bus                  |
                                          | - Coherence: MESI/MOESI Protocol |
                                          +------------------+---------------+
                                                             |
                                                             | (Memory Bus - IMC)
                                                             v
                                          +----------------------------------+
                                          |           MAIN MEMORY            |
                                          | (DDR5, 4800 MT/s)                |
                                          | - DRAM Controller (IMC)          |
                                          +----------------------------------+

                                                                 ^
                                                                 | (Write Back)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          WRITE-BACK & MEMORY HIERARCHY                                           |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   MEMORY ACCESS      | <-- |   WRITE BACK (WB)    | <-- |   EXECUTION (EX)              |                   |
|  |   (MEM)              |     | - Ghi kết quả vào RF |     | - ALU/FPU hoàn tất              |                   |
|  | - Load: RF ← [addr]  |     | - Cập nhật ROB       |     | - Store: xếp hàng chờ ghi       |                   |
|  | - Store: [addr] ← RF |     | - Commit theo thứ tự |     |                                |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|                                                                                                                  |
|  ✅ ROB đảm bảo: dù thực thi out-of-order, kết quả vẫn commit theo đúng thứ tự chương trình                     |
+------------------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Interrupt & System Call)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          EXCEPTION & INTERRUPT HANDLING                                          |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   EXCEPTIONS         |     |   INTERRUPTS (IRQ)   |     |   SYSTEM CALLS                |                   |
|  | - Page Fault         |     | - Timer (1ms)        |     | - syscall instruction         |                   |
|  | - Divide by Zero     |     | - Keyboard, Disk     |     | - Chuyển sang kernel mode     |                   |
|  | - Invalid Opcode     |     | - GPU, Network       |     | - Gọi kernel function         |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|         |                            |                                 |                                       |
|         +----------------------------+---------------------------------+                                       |
|                                          |                                                                       |
|                                          v                                                                       |
|                                  [TRAP to Kernel Mode]                                                           |
|                                  → OS xử lý → quay lại chương trình                                              |
+------------------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Parallelism & Optimization)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          ADVANCED FEATURES                                                       |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   OUT-OF-ORDER EXEC  |     |   SUPERSCALAR        |     |   SPECULATIVE EXECUTION       |                   |
|  | - Tomasulo Algorithm |     | - Nhiều lệnh/cycle   |     | - Dự đoán nhánh → thực thi trước|                   |
|  | - ROB + RS + Bypass  |     | - 6 ports phát hành  |     | - Rollback nếu sai             |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   SIMD (SSE/AVX)     |     |   POWER MANAGEMENT   |     |   MICROCODE                   |                   |
|  | - Xử lý 8/16 số cùng|     | - P-states, C-states |     | - Firmware cho lệnh phức      |                   |
|  |   lúc (vector)       |     | - Dynamic voltage    |     | - Cập nhật qua BIOS           |                   |
|  +----------------------+     |   & frequency scaling|     +-------------------------------+                   |
|                                +----------------------+                                                         |
+------------------------------------------------------------------------------------------------------------------+
```
>
GHI CHÚ:
- **Pipeline Stages**:
  IF: Fetch → ID: Decode → EX: Execute → MEM: Memory Access → WB: Write Back

- **Out-of-Order Execution**:
  - Lệnh có thể thực thi không theo thứ tự → nhưng cam kết (commit) theo đúng thứ tự nhờ ROB

- **Register Renaming**:
  - Tránh false dependency (vd: `mov rax, 1` → `add rax, 2` → `mov rax, 3`) → rax cũ và mới được ánh xạ sang thanh ghi vật lý khác nhau

- **Branch Prediction**:
  - BTB (Branch Target Buffer): lưu địa chỉ nhảy
  - RAS (Return Address Stack): dự đoán lệnh `ret`

- **Bypass Network (Forwarding)**:
  - Kết quả từ EX → trực tiếp đến RS hoặc ID → không chờ WB → tăng hiệu suất

- **L1i / L1d**: Tách riêng cache lệnh và dữ liệu → tránh xung đột

- **L2**: Riêng cho từng core
- **L3**: Chung cho tất cả core, dùng giao thức **cache coherence (MESI)** để đồng bộ

- **IMC (Integrated Memory Controller)**: Nằm trong CPU die → giảm độ trễ truy cập RAM

- **System Call**: Dùng lệnh `syscall` → trap vào kernel → chuyển sang Ring 0

- **Microcode**: Như firmware của CPU, xử lý các lệnh phức tạp (vd: `string` instructions)
