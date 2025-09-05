---
title: Compiler
sidebar_position: 1
---


```
==========================================================================================================
                  TRÌNH BIÊN DỊCH TOÀN DIỆN – BẢN CHẤT TỪ MÃ NGUỒN ĐẾN MÃ MÁY
==========================================================================================================

+---------------------------------------------------------------------------------------------------------+
|                                         SOURCE CODE (User)                                            |
|                                                                                                         |
|   int factorial(int n) {                                                                                |
|       if (n <= 1) return 1;                                                                             |
|       return n * factorial(n - 1);                                                                      |
|   }                                                                                                     |
|                                                                                                         |
|  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐  |
|  │            HIGH-LEVEL LANGUAGE (C, Rust, Java...) → Human-readable, portable                    │  |
|  └─────────────────────────────────────────────────────────────────────────────────────────────────┘  |
|                                                                                                         |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Compilation Pipeline)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                        COMPILER FRONTEND                                              |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  |   LEXICAL ANALYSIS   |     |   SYNTAX ANALYSIS    |     |   SEMANTIC ANALYSIS           |           |
|  | (Scanner / Lexer)    |     | (Parser)             |     |                               |           |
|  |                      |     |                      |     |  +--------------------------+ |           |
|  | Input: char stream   | --> | Input: tokens        | --> |  | Symbol Table             | |           |
|  | Output: tokens       |     | Output: AST          |     |  | - n: int, scope: global  | |           |
|  |                      |     |                      |     |  | - factorial(): int(int)  | |           |
|  | Example:             |     | Grammar:             |     |  +------------+-------------+ |           |
|  | int → KEYWORD        |     | S → func_def         |     |               |               |           |
|  | n   → IDENTIFIER     |     | func_def → type ID(…) |     |  +------------v-------------+ |           |
|  | =   → OPERATOR       |     |                      |     |  | Type Checking            | |           |
|  | ;   → SEPARATOR      |     | Uses: CFG, LL/LR     |     |  | - int * int → int        | |           |
|  +----------------------+     +----------+-----------+     |  | - No undeclared vars     | |           |
|                                          |                 |  +--------------------------+ |           |
|                                          v                 +-------------------------------+           |
|                                +------------------+                                                  |
|                                |   ABSTRACT SYNTAX  |                                                 |
|                                |   TREE (AST)       |                                                 |
|                                |                    |                                                 |
|                                |   Function: "factorial"                                               |
|                                |     Params: n (int)                                                   |
|                                |     Body:                                                               |
|                                |       If (n <= 1)                                                       |
|                                |         Return 1                                                        |
|                                |       Else                                                              |
|                                |         Return n * factorial(n-1)                                       |
|                                +--------------------+                                                  |
+------------------------------------------------------+--------------------------------------------------+
                                                       |
                                                       | (Intermediate Representation)
                                                       v
+---------------------------------------------------------------------------------------------------------+
|                                     INTERMEDIATE REPRESENTATION (IR)                                    |
|                                                                                                         |
|  +-----------------------------+     +----------------------------+     +------------------------+     |
|  | Three-Address Code (TAC)    |     | Control Flow Graph (CFG)   |     | LLVM IR / Bytecode     |     |
|  |                             |     |                            |     |                        |     |
|  | t1 = n <= 1                 |     |       +--------+         |     | define i32 @factorial   |     |
|  | if t1 goto L1               |     |       | Entry  |         |     | (i32 %n) {              |     |
|  | t2 = n - 1                  | --> |       +--------+         | --> |   %cmp = icmp sle i32   |     |
|  | t3 = call factorial(t2)     |     |         |                |     |   %n, 1                 |     |
|  | t4 = n * t3                 |     |         v                |     |   br i1 %cmp, label %if,|     |
|  | return t4                   |     |   +-------------+        |     |       label %else       |     |
|  | L1: return 1                |     |   | if (n<=1) |        |     | }                       |     |
|  +-----------------------------+     |   +-------------+        |     +------------------------+     |
|                                     |         |                |                                     |
|                                     |         v                |                                     |
|                                     |   +-------------+        |                                     |
|                                     |   | return 1    |        |                                     |
|                                     |   +-------------+        |                                     |
|                                     |         ^                |                                     |
|                                     |         |                |                                     |
|                                     |   +-------------+        |                                     |
|                                     |   | n * fact(...) |        |                                     |
|                                     |   +-------------+        |                                     |
|                                     |         |                |                                     |
|                                     |       +--------+         |                                     |
|                                     |       | Exit   |         |                                     |
|                                     |       +--------+         |                                     |
|                                     +----------------------------+                                     |
|                                                                                                         |
|  ✅ IR: Độc lập ngôn ngữ & kiến trúc → dễ tối ưu và tái sử dụng                                         |
+---------------------------------------------------------------------------------------------------------+
                                                       |
                                                       | (Optimization Passes)
                                                       v
+---------------------------------------------------------------------------------------------------------+
|                                         OPTIMIZATION ENGINE                                             |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  | Local Optimization   |     | Global Optimization  |     | Loop & Inter-procedural       |           |
|  | (Basic Block)        |     | (Function-wide)      |     | Optimization                  |           |
|  | - Constant Folding   |     | - Live Variable      |     | - Loop Invariant Motion       |           |
|  |   2+3 → 5            |     |   Analysis           |     | - Function Inlining           |           |
|  | - Dead Code Removal  |     | - Available Exprs    |     | - Devirtualization            |           |
|  |   if(0) → remove     |     | - Reaching Defs      |     |                               |           |
|  +----------+-----------+     +----------+-----------+     +---------------+---------------+           |
|            |                            |                                 |                           |
|            +----------------------------+---------------------------------+                           |
|                                         | (Optimized IR)                                                |
|                                         v                                                             |
|  +-----------------------------+                                                                      |
|  | Optimized TAC / LLVM IR     |                                                                      |
|  |                             |                                                                      |
|  | t1 = n <= 1                 |                                                                      |
|  | br t1, L1, L2                 |                                                                      |
|  | L2:                         |                                                                      |
|  |   t2 = n - 1                |                                                                      |
|  |   t3 = factorial(t2)        |                                                                      |
|  |   t4 = n * t3               |                                                                      |
|  |   return t4                 |                                                                      |
|  | L1: return 1                |                                                                      |
|  +-----------------------------+                                                                      |
+---------------------------------------------------------------------------------------------------------+
                                                       |
                                                       | (Code Generation)
                                                       v
+---------------------------------------------------------------------------------------------------------+
|                                          CODE GENERATION (BACKEND)                                    |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  | Instruction Selection|     | Register Allocation  |     | Instruction Scheduling        |           |
|  | - Chọn lệnh máy phù  |     | - Gán biến vào thanh|     | - Sắp xếp lệnh để pipeline     |           |
|  |   hợp: add, mul, call| --> |   ghi (register)      | --> |   hiệu quả (avoid stalls)      |           |
|  | - Dùng pattern       |     | - Nếu không đủ: spill|     | - Ví dụ: di chuyển load lên   |           |
|  |   matching (LLVM)    |     |   ra bộ nhớ (stack)   |     |   trước khi dùng               |           |
|  +----------+-----------+     +----------+-----------+     +-------------------------------+           |
|            |                            |                                                             |
|            +----------------------------+                                                             |
|                                         |                                                             |
|                                         v                                                             |
|  +---------------------------------------------------------------------------------------------+      |
|  |                                   MACHINE CODE (x86-64)                                   |      |
|  |                                                                                           |      |
|  |   factorial:                                                                            |      |
|  |     cmp edi, 1        ; so sánh n với 1                                                 |      |
|  |     jle .L1           ; nếu n<=1 → nhảy                                               |      |
|  |     push rbx          ; lưu thanh ghi                                                 |      |
|  |     mov ebx, edi      ; ebx = n                                                       |      |
|  |     dec edi           ; n-1                                                           |      |
|  |     call factorial    ; đệ quy                                                       |      |
|  |     imul eax, ebx     ; n * kết quả                                                  |      |
|  |     pop rbx           ; phục hồi                                                    |      |
|  |     ret               ; trả về                                                      |      |
|  |   .L1:                                                                              |      |
|  |     mov eax, 1        ; return 1                                                    |      |
|  |     ret                                                                             |      |
|  |                                                                                           |      |
|  |  → Output: Object file (.o) → liên kết (linker) → executable                           |      |
|  +---------------------------------------------------------------------------------------------+      |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Linking)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                           LINKER & LOADER                                             |
|                                                                                                         |
|  +----------------------+     +----------------------+                                                 |
|  | Static Linker        |     | Dynamic Loader       |                                                 |
|  | - Ghép nhiều .o file  |     | - Nạp executable vào|                                                 |
|  | - Giải quyết symbol   | --> |   memory tại runtime |                                                 |
|  |   (printf, malloc)    |     | - Nạp shared library |                                                 |
|  | - Tạo executable      |     |   (.so, .dll)        |                                                 |
|  +----------------------+     +----------------------+                                                 |
|                                                                                                         |
|  Output: a.out (Linux), .exe (Windows)                                                                  |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Execution)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                         RUNTIME ENVIRONMENT                                           |
|                                                                                                         |
|  +---------------------+     +----------------------+     +----------------------+                    |
|  |    Call Stack       |     |       Heap           |     |   Runtime System     |                    |
|  | (Activation Records)|     | (malloc, new, GC)    |     | - Garbage Collector  |                    |
|  |                     |     |                      |     | - JIT Compiler (V8)  |                    |
|  | +---------------+   |     | +------------------+ |     | - Exception Handler  |                    |
|  | | Return addr   |<--+-----+>| Objects          | |     | - Type System        |                    |
|  | +---------------+   |     | | int x = 5;       | |     +----------------------+                    |
|  | | Args: n=5     |   |     | | List lst;        | |                              |                    |
|  | +---------------+   |     | +------------------+ |                              |                    |
|  | | Local vars    |   |     |                      |                              |                    |
|  | | (none)        |   |     |                      |                              |                    |
|  | +---------------+   |     +----------------------+                              |                    |
|  | | Saved RBP     |   |                                                           |                    |
|  | +---------------+   |                                                           |                    |
|  |        |            |                                                           |                    |
|  |        v            |                                                           |                    |
|  | +---------------+   |                                                           |                    |
|  | | Previous frame|   |                                                           |                    |
|  | +---------------+   |                                                           |                    |
|  +---------------------+                                                           |                    |
|                                                                                     |                    |
|  ← Mỗi lần gọi hàm: tạo frame mới trên stack ← Trả về: giải phóng frame            |                    |
+-------------------------------------------------------------------------------------+--------------------+

                                          |
                                          | (Hardware Execution)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                         CPU EXECUTION                                                   |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  | Instruction Fetch    | --> | Decode               | --> | Execute (ALU, FPU, Branch)    |           |
|  | (from .text section) |     | (opcode → micro-op)  |     |                               |           |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|                                                                                                         |
|  → Kết quả: chương trình chạy, in ra: factorial(5) = 120                                              |
+---------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (JIT Compilation – Alternative Path)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          JUST-IN-TIME (JIT) COMPILATION                                        |
|                                                                                                                  |
|   Source (JavaScript) → AST → Bytecode (V8) → Hot Code Detected → Compile to Machine Code → Cache                |
|                                                                                                                  |
|   Ví dụ: V8 (Chrome), HotSpot (Java), .NET CLR                                                                   |
|   ✅ Ưu điểm: tối ưu theo hành vi thực tế                                                                          |
|   ❌ Nhược điểm: thời gian khởi động, tốn CPU lúc chạy                                                           |
+------------------------------------------------------------------------------------------------------------------+
```

GHI CHÚ:
- **Frontend**: Ngôn ngữ cụ thể (C, Python) → IR
- **Backend**: Kiến trúc cụ thể (x86, ARM) ← IR
- **IR (Intermediate Representation)**: Cầu nối giữa frontend và backend
- **Symbol Table**: Lưu thông tin biến, hàm, kiểu, scope – dùng xuyên suốt
- **Register Allocation**: Dùng Graph Coloring hoặc Linear Scan
- **Optimization**: Càng muộn → càng hiệu quả (nhưng phải đúng)
- **GC**: Chỉ có trong ngôn ngữ quản lý bộ nhớ tự động (Java, Go, Python)
- **Static vs Dynamic Linking**: .a vs .so (Linux), .lib vs .dll (Windows)
- **Activation Record**: Frame trên stack khi gọi hàm
- **LLVM**: Framework compiler hiện đại – frontend (Clang) + backend (LLVM IR → x86/ARM)


> ``` Source → Lexer → Parser → AST → Semantic → IR → Optimize → Code Gen → Object → Link → Executable → Run ```

## 1. COMPILER  
### 1.1. Introduction to Compilers  
- Definition:  
  Chương trình chuyển đổi mã nguồn (source code) viết bằng ngôn ngữ cấp cao (C++, Java, Rust…)  
  thành mã máy (machine code) hoặc mã trung gian (intermediate code).  

- Phân biệt với Interpreter:  
  - **Compiler**: dịch toàn bộ → mã máy → chạy nhanh.  
  - **Interpreter**: đọc và thực thi từng dòng → chậm hơn, nhưng debug dễ.  
  - **Just-In-Time (JIT)**: kết hợp cả hai (ví dụ: Java JVM, V8 JavaScript engine).  

- Các giai đoạn của Compiler:  
  1. **Frontend**: Phân tích mã nguồn.  
  2. **Middle-end**: Tối ưu hóa.  
  3. **Backend**: Sinh mã mục tiêu.  

- Mục tiêu của Compiler:  
  - Chính xác (correctness)  
  - Hiệu suất (fast execution, low memory)  
  - Báo lỗi rõ ràng  
  - Tối ưu hóa tốt  

### 1.2. Compiler Phases (Các giai đoạn)  
1. **Lexical Analysis (Scanner)**  
   - Input: Chuỗi ký tự (source code)  
   - Output: Chuỗi **token** (identifier, keyword, operator, literal)  
   - Công cụ: **Regular expressions**, **Finite Automata**  
   - Ví dụ: `int x = 5;` → `int`, `x`, `=`, `5`, `;`  

2. **Syntax Analysis (Parser)**  
   - Input: Tokens  
   - Output: **Cây cú pháp (Parse Tree / AST)**  
   - Công cụ: **Context-Free Grammar (CFG)**, **Parsers (LL, LR, LALR)**  
   - Phát hiện lỗi cú pháp: `x == 5 )` → missing `(`  

3. **Semantic Analysis**  
   - Kiểm tra ngữ nghĩa: kiểu dữ liệu, khai báo biến, scope  
   - Xây dựng **Symbol Table** (lưu tên biến, kiểu, scope, địa chỉ)  
   - Kiểm tra:  
     - Type checking (int + string?)  
     - Undeclared variables  
     - Function signature mismatch  

4. **Intermediate Code Generation**  
   - Tạo mã trung gian:  
     - **Three-Address Code (TAC)**: `t1 = a + b`  
     - **Abstract Syntax Tree (AST)**  
     - **Control Flow Graph (CFG)**  
   - Độc lập với kiến trúc máy → dễ tối ưu và porting  

5. **Optimization**  
   - Mục tiêu: Tăng tốc độ, giảm bộ nhớ, giảm năng lượng  
   - Loại:  
     - Local (trong một basic block)  
     - Global (toàn hàm, dùng CFG)  
     - Loop optimization  
     - Inter-procedural (giữa các hàm)  
   - Kỹ thuật:  
     - Constant Folding: `x = 2 + 3` → `x = 5`  
     - Dead Code Elimination  
     - Common Subexpression Elimination  
     - Loop Invariant Code Motion  
     - Strength Reduction (e.g., `x*2` → `x<<1`)  

6. **Code Generation**  
   - Chuyển mã trung gian → mã máy (assembly hoặc object code)  
   - Gán biến vào thanh ghi (Register Allocation)  
   - Instruction Selection: chọn lệnh máy phù hợp  
   - Instruction Scheduling: tối ưu thứ tự lệnh để pipeline hiệu quả  

7. **Symbol Table Management**  
   - Được dùng xuyên suốt các giai đoạn  
   - Lưu: tên, kiểu, scope, kích thước, địa chỉ, thuộc tính  

8. **Error Handling**  
   - Phát hiện và báo lỗi ở mọi giai đoạn  
   - Recovery: tiếp tục phân tích sau lỗi (để phát hiện nhiều lỗi)  

### 1.3. Runtime Environment  
- Activation Record (Stack Frame):  
  - Lưu thông tin khi hàm được gọi:  
    - Return address  
    - Parameters  
    - Local variables  
    - Temporary storage  
    - Previous frame pointer  
- Stack vs Heap Allocation:  
  - Stack: biến cục bộ, nhanh, tự động giải phóng  
  - Heap: `malloc`, `new` – quản lý thủ công hoặc GC  
- Parameter Passing:  
  - Call by Value  
  - Call by Reference  
  - Call by Name (rare)  

### 1.4. Parsing Techniques  
- **Top-down Parsing**  
  - Bắt đầu từ gốc cây cú pháp  
  - LL(1): Left-to-right, Leftmost derivation, 1 token lookahead  
  - Dễ triển khai bằng đệ quy (Recursive Descent)  
  - Yêu cầu: không left recursion, không ambiguity  

- **Bottom-up Parsing**  
  - Bắt đầu từ lá → xây cây lên  
  - LR(1), LALR(1): mạnh hơn LL, hỗ trợ nhiều ngữ pháp  
  - Dùng bảng parsing (action, goto)  
  - Công cụ: **Yacc, Bison, ANTLR**  

### 1.5. Code Optimization Techniques  
- **Local Optimizations**  
  - Constant Folding, Constant Propagation  
  - Copy Propagation  
  - Dead Code Elimination  

- **Global Optimizations**  
  - Available Expressions  
  - Live Variable Analysis  
  - Reaching Definitions  

- **Loop Optimizations**  
  - Loop Invariant Code Motion  
  - Induction Variable Elimination  
  - Loop Unrolling (giảm overhead)  

- **Inter-procedural Optimization (IPO)**  
  - Inline expansion (function inlining)  
  - Devirtualization  
  - Whole-program optimization  

### 1.6. Register Allocation  
- Mục tiêu: Gán biến vào thanh ghi (nhanh hơn bộ nhớ)  
- Vấn đề: Số thanh ghi hữu hạn → cần **spill** (đưa biến ra memory)  
- Phương pháp:  
  - **Graph Coloring**:  
    - Xây dựng **interference graph** (biến A và B không thể dùng chung thanh ghi)  
    - Tô màu đồ thị → mỗi màu là một thanh ghi  
  - **Linear Scan** (dùng trong JIT)  

### 1.7. Garbage Collection (GC)  
- Dùng trong ngôn ngữ có quản lý bộ nhớ tự động (Java, Python, Go)  
- Mục tiêu: Tự động giải phóng bộ nhớ không dùng  
- Các loại:  
  - **Mark & Sweep**: đánh dấu + dọn dẹp  
  - **Stop-and-Copy**: sao chép vùng sống sang nơi khác  
  - **Generational GC**: chia heap theo tuổi (trẻ/dễ chết)  
  - **Reference Counting**: đơn giản, nhưng không xử lý cyclic reference  

### 1.8. Compiler Frontend & Backend  
- **Frontend**:  
  - Ngôn ngữ cụ thể (C++, Python)  
  - Lexical, syntax, semantic analysis  
  - Output: Intermediate Representation (IR)  

- **Backend**:  
  - Kiến trúc cụ thể (x86, ARM, RISC-V)  
  - Code generation, register allocation, optimization  
  - Output: Machine code  

- **IR (Intermediate Representation)**:  
  - Độc lập ngôn ngữ và kiến trúc  
  - Ví dụ: LLVM IR, Java bytecode, Three-Address Code  

### 1.9. Tools & Frameworks  
- **Lex/Flex**: Tạo lexer từ regex  
- **Yacc/Bison**: Tạo parser từ CFG  
- **ANTLR**: Parser generator mạnh, hỗ trợ nhiều ngôn ngữ  
- **LLVM**: Framework compiler hiện đại (dùng bởi Clang, Swift, Rust)  
  - IR mạnh, tối ưu hóa tốt, hỗ trợ đa nền tảng  
- **GCC (GNU Compiler Collection)**: Hỗ trợ nhiều ngôn ngữ (C, C++, Fortran…)  

### 1.10. Just-In-Time (JIT) Compilation  
- Dịch tại thời điểm chạy (runtime)  
- Dùng trong:  
  - Java (JVM + HotSpot)  
  - JavaScript (V8 engine)  
  - .NET (CLR)  
- Ưu điểm:  
  - Tối ưu hóa dựa trên hành vi thực tế (profile-guided)  
  - Linh hoạt, hiệu suất cao hơn interpreter  
- Nhược điểm:  
  - Thời gian khởi động lâu hơn  
  - Tốn CPU để biên dịch lúc chạy  

---

:::note Compiler
A compiler is a sophisticated program that translates high-level source code into executable machine code.  
It bridges the gap between human-readable programs and hardware execution.

Key components:
- **Frontend**: Analyzes syntax and semantics.
- **Intermediate Representation (IR)**: Language- and machine-agnostic form.
- **Optimizer**: Improves code efficiency.
- **Backend**: Generates target-specific machine code.

Modern compilers emphasize:
- **Correctness** and **portability**.
- **Aggressive optimization** for performance.
- **Rich error reporting** for developer experience.

Understanding compilers helps in writing efficient code, debugging low-level issues, and designing programming languages.
:::

## Formulas

                        COMPILER
                                 |
        ---------------------------------------------------------
        |                        |                              |
    FRONTEND (Analysis)     OPTIMIZATION               BACKEND (Code Gen)
        |                        |                              |
   ---------------       -------------------         ---------------------
   |      |      |       |        |        |         |         |         |
Lexer  Parser  Semantic  Constant  Dead Code  Loop     Register  Instruction  Target
       (AST)   Analysis  Folding   Elimination  Unrolling  Allocation  Scheduling  Code

1. **Speedup from Optimization**  
   $$
   \text{Speedup} = \frac{T_{\text{before}}}{T_{\text{after}}}
   $$

2. **Register Pressure**  
   $$
   \text{Pressure} = \frac{\text{Number of live variables}}{\text{Available registers}}
   $$
   > 1 → cần spill

3. **Available Expressions**  
   Một biểu thức `a + b` là "available" tại điểm P nếu:  
   - Được tính trước P  
   - Không thay đổi giữa đó và P  

4. **Live Variable**  
   Biến `x` là "live" tại điểm P nếu:  
   - Sẽ được dùng sau P  
   - Và chưa được gán lại  

5. **Loop Invariant Cost**  
   Nếu biểu thức trong vòng lặp không đổi → di chuyển ra ngoài:  
   $$
   \text{Savings} = (\text{Iterations} - 1) \times \text{Cost per evaluation}
   $$

---

## Rules of Thumb

### The 90/10 Rule (Optimization)
> 90% of execution time is spent in 10% of the code. Optimize hotspots.

### Premature Optimization Rule (Donald Knuth)
> "Premature optimization is the root of all evil."  
> → Tối ưu hóa chỉ khi cần, sau khi đo hiệu suất.

### Parse Table Size Rule
> LR(1) tables lớn hơn LALR(1). Dùng LALR hoặc SLR nếu đủ.

### Register Allocation Rule
> Nếu số biến sống > số thanh ghi → phải spill. Giảm biến cục bộ.

### Three-Address Code Rule
> Mỗi lệnh có tối đa 3 toán hạng: `x = y op z`

### AST vs Parse Tree
> AST loại bỏ token không cần thiết (dấu chấm phẩy, ngoặc thừa).

### GC Pause Rule
> Trong ứng dụng real-time, tránh GC lớn → dùng incremental hoặc real-time GC.

### LLVM Rule
> Nếu bạn viết ngôn ngữ mới, hãy dùng LLVM làm backend.