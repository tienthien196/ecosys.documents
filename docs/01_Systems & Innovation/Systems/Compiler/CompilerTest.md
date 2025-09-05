---
title: CompilerTest
sidebar_position: 1
---

```
==========================================================================================================
                  COMPILER TOÀN DIỆN – HÀNH TRÌNH TỪ MÃ NGUỒN ĐẾN MÃ MÁY (SINGLE PASS)
==========================================================================================================

+-----------------------------------------------------------------------------------------+
|                                 SOURCE CODE (input.c)                                   |
|                                                                                         |
|  int main() {                                                                           |
|      int a = 5;                                                                         |
|      int b = a + 3;                                                                     |
|      return b * 2;                                                                      |
|  }                                                                                      |
|                                                                                         |
+----------------------------------------+------------------------------------------------+
                                         |
                                         v
                        +----------------------------------+
                        |     LEXICAL ANALYSIS (Lexer)     |
                        | - Chia mã thành token            |
                        | - Dùng: Regex, Finite Automata   |
                        |                                 |
                        | Output:                         |
                        | [int][main][(][)][{]            |
                        | [int][a][=][5][;]                |
                        | [int][b][=][a][+][3][;]          |
                        | [return][b][*][2][;][}]          |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |     SYNTAX ANALYSIS (Parser)     |
                        | - Dùng CFG (Context-Free Grammar)|
                        | - Xây dựng cây cú pháp (AST)     |
                        |                                 |
                        |          Function: main()        |
                        |                 |                |
                        |            CompoundStmt           |
                        |            /      |      \       |
                        |     Decl(a=5)  Decl(b=a+3) Return |
                        |                             |    |
                        |                        BinOp(*, b, 2)
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |    SEMANTIC ANALYSIS & SYMBOL TABLE |
                        | - Kiểm tra kiểu, khai báo         |
                        | - Xây dựng Symbol Table           |
                        |                                 |
                        |  +-------------+------------------+ 
                        |  | Name | Type | Scope | Address  |
                        |  +-------------+------------------+
                        |  | main | func | global| 0x400500 |
                        |  | a    | int  | main  | R1 / [FP-4]|
                        |  | b    | int  | main  | R2 / [FP-8]|
                        |  +-------------+------------------+
                        | - Type checking: a + 3 → OK (int) |
                        | - Error: undeclared var, type mismatch |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |   INTERMEDIATE CODE GENERATION   |
                        | - Tạo mã trung gian (TAC, AST)   |
                        |                                 |
                        |  Three-Address Code (TAC):      |
                        |     t1 = 5                      |
                        |     a  = t1                     |
                        |     t2 = a + 3                  |
                        |     b  = t2                     |
                        |     t3 = b * 2                  |
                        |     return t3                   |
                        |                                 |
                        |  Control Flow Graph (CFG):      |
                        |     [Entry] → [Basic Block] → [Return]
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |          OPTIMIZATION            |
                        | - Xử lý trên IR (TAC hoặc CFG)   |
                        |                                 |
                        | 1. Constant Folding:             |
                        |     t1 = 5           → 5         |
                        |     t2 = 5 + 3       → 8         |
                        |     t3 = 8 * 2       → 16        |
                        |                                 |
                        | 2. Dead Code Elimination:        |
                        |     (nếu có code vô dụng)        |
                        |                                 |
                        | 3. Common Subexpression:         |
                        |     x = a + b; y = a + b → t = a+b; x=t; y=t |
                        |                                 |
                        | Output tối ưu:                   |
                        |     return 16                    |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |        CODE GENERATION           |
                        | - Chuyển IR → mã máy (x86-64)    |
                        | - Register Allocation            |
                        | - Instruction Selection          |
                        | - Instruction Scheduling         |
                        |                                 |
                        |  Ví dụ:                          |
                        |     mov eax, 16                   |
                        |     ret                           |
                        |                                 |
                        |  Register Allocation:            |
                        |     - a → R1 (spilled? no)        |
                        |     - b → R2 → nhưng bị tối ưu bỏ |
                        |     → Không cần thanh ghi!        |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |        ASSEMBLY OUTPUT           |
                        | - Mã hợp ngữ (assembly)          |
                        |                                 |
                        |     .text                        |
                        |     .globl main                  |
                        |  main:                           |
                        |     movl $16, %eax               |
                        |     ret                          |
                        |                                 |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |       ASSEMBLER (as)             |
                        | - Chuyển assembly → object code  |
                        |   (file.o – ELF format)           |
                        |                                 |
                        |   +-------------------------+    |
                        |   | ELF Header              |    |
                        |   | .text (machine code)    |    |
                        |   | .data (nếu có)          |    |
                        |   | Symbol Table (local)      |    |
                        |   +-------------------------+    |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |       LINKER (ld)                |
                        | - Gắn với thư viện (libc, etc.)  |
                        | - Giải quyết symbol chưa biết    |
                        | - Tạo executable (a.out)         |
                        |                                 |
                        |   +-------------------------+    |
                        |   | .text (main + libc)     |    |
                        |   | .data, .bss             |    |
                        |   | Entry Point: _start     |    |
                        |   +-------------------------+    |
                        +----------------+----------------+
                                         |
                                         v
                        +----------------------------------+
                        |        EXECUTABLE (a.out)        |
                        | - File nhị phân chạy được        |
                        | - Được OS nạp vào RAM khi chạy   |
                        |                                 |
                        |   OS:                             |
                        |     1. mmap .text vào memory     |
                        |     2. Cấp phát stack, heap      |
                        |     3. Jump đến điểm vào (_start)|
                        |     4. main() được gọi → return 16|
                        +----------------------------------+

+-----------------------------------------------------------------------------------------+
|                                RUNTIME ENVIRONMENT                                      |
|                                                                                         |
|  +---------------------+     +---------------------+     +---------------------+      |
|  |      Stack          |     |       Heap          |     |    Static Data      |      |
|  | - Activation Records|     | - malloc, new       |     | - Global variables  |      |
|  |   (Frame Pointer)   |     | - Garbage Collection|     | - String literals   |      |
|  |   [main: a=5, b=8]  |     |                     |     |                     |      |
|  +---------------------+     +---------------------+     +---------------------+      |
|                                                                                         |
|  +---------------------+                                                              |
|  |   CPU Registers     |                                                              |
|  | - RAX: return value | <--- mov eax, 16                                               |
|  | - RSP: stack ptr    |                                                              |
|  | - RIP: program counter|                                                            |
|  +---------------------+                                                              |
+-----------------------------------------------------------------------------------------+

GHI CHÚ:
- **Single-Pass Flow**: Mỗi giai đoạn xử lý xong → chuyển kết quả cho giai đoạn sau (không lặp lại).
- **Symbol Table**: Được dùng từ Parser đến Code Gen, lưu thông tin biến.
- **IR (Intermediate Representation)**: Là "ngôn ngữ chung" giữa frontend và backend.
- **Optimization**: Xảy ra trên IR → độc lập kiến trúc, dễ áp dụng.
- **Register Allocation**: Nếu biến không dùng → không cần cấp thanh ghi (spilled hoặc bỏ).
- **Dead Code Elimination**: Biến không dùng → xóa khỏi mã.
- **Constant Folding**: Tính toán tại thời điểm biên dịch → tăng tốc độ chạy.
- **Linker**: Gắn với hàm như `printf`, `malloc` trong libc.
- **Runtime**: Khi chương trình chạy, OS tạo stack, heap, nạp mã vào RAM.

```