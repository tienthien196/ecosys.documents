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
==================================================================
             CẤU TRÚC BÊN TRONG MỘT CPU CORE (ĐƠN GIẢN, RÕ RÀNG)
==================================================================

                              +---------------------+
                              |     CLOCK SIGNAL    |
                              +----------+----------+
                                         |
                                         v
                    +------------------------------------------+
                    |             CONTROL UNIT (CU)            |
                    |  - Giải mã lệnh (Decode)                 |
                    |  - Điều khiển các khối khác              |
                    |  - Quản lý pipeline                      |
                    +------------------------------------------+
                              |        |        |
              (Fetch addr)    |        | (Control signals)
                              v        |        v
             +----------------+    +---+----+    +-------------------------------+
             | INSTRUCTION    |    |        |    |        REGISTER FILE          |
             |   CACHE (L1i)  |    |        |    |  - RAX, RBX, RCX, RDX, ...     |
             +--------+-------+    |        |    |  - RSP, RBP, RDI, RSI, ...     |
                      |            |        |    |  - 16+ general-purpose regs   |
                      |            |        |    +---------------+---------------+
                      v            |        |                    |
        +----------------------+   |        |                    |
        | INSTRUCTION FETCH    |<--+        |                    |
        |  & SEQUENCER (IF)    |            |                    |
        +----------+-----------+            |                    |
                   |                        |                    |
                   v                        v                    v
        +----------------------+    +----------------+    +------------------+
        | INSTRUCTION DECODE   |    | BRANCH         |    | RESERVATION      |
        |       (ID)           |    | PREDICTION     |    | STATIONS (RS)    |
        | - Phân tích lệnh     |    | - BTB, RAS     |    | - Chờ operand    |
        +----------+-----------+    +--------+-------+    +--------+---------+
                   |                        |                     |
                   v                        |                     |
        +----------------------+            |                     |
        |    REORDER BUFFER    |<-----------+---------------------+
        |       (ROB)          |            | (Control & status)
        | - Commit lệnh đúng thứ tự |
        +----------+-----------+
                   |
                   v
        +----------------------+
        | EXECUTION UNITS      |
        |                      |
        |  +----------------+  |
        |  |     ALU x4     |  |  (Integer: ADD, SUB, AND, OR)
        |  +----------------+  |
        |  +----------------+  |
        |  |     FPU x2     |  |  (Floating-point & SIMD - SSE/AVX)
        |  +----------------+  |
        |  +----------------+  |
        |  | LOAD/STORE x2  |  |  (Truy cập bộ nhớ)
        |  +----------------+  |
        |  +----------------+  |
        |  |   BRANCH UNIT  |  |  (So sánh, nhảy)
        |  +----------------+  |
        +----------+---------+
                   |
                   v
        +----------------------+
        | DATA CACHE (L1d)     |
        | - 32–48KB, 8-way     |
        | - Truy cập: ~4 cycles|
        +----------+-----------+
                   |
                   v
        +----------------------+
        |    L2 CACHE (1–2MB)  |
        | - Riêng cho mỗi core |
        | - ~12 cycles         |
        +----------+-----------+
                   |
                   v
        +----------------------+
        |    L3 CACHE (LLC)    |
        | - Shared giữa các core|
        | - 10–100MB, ring bus |
        +----------+-----------+
                   |
                   v
        +----------------------+
        |   MEMORY CONTROLLER  |
        | (IMC - Integrated)   |
        | → Kết nối tới RAM    |
        +----------------------+
```