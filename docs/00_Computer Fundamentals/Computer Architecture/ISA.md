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