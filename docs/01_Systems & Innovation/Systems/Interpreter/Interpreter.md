---
title: Interpreter
sidebar_position: 1
---

```
==========================================================================================================
        SO SÁNH TOÀN DIỆN: COMPILER vs INTERPRETER vs JIT – TỪ MÃ NGUỒN ĐẾN THỰC THI
==========================================================================================================

+---------------------------------------------------------------------------------------------------------+
|                                         SOURCE CODE (Python, JavaScript, Java...)                     |
|                                                                                                         |
|   def factorial(n):                                                                                     |
|       if n <= 1:                                                                                        |
|           return 1                                                                                      |
|       return n * factorial(n - 1)                                                                       |
|                                                                                                         |
+---------------------------------------------------------------------------------------------------------+
                                          |
          +-------------------------------+-------------------------------+
          |                               |                               |
          v                               v                               v
+-------------------------+   +-------------------------+   +-------------------------+
|       COMPILER          |   |      INTERPRETER        |   |         JIT             |
| (C, Rust, Go - ahead-of-time)| (Python, early JS)     |   | (V8, JVM, .NET)         |
+-------------------------+   +-------------------------+   +-------------------------+
          |                               |                               |
          v                               v                               v
| Tạo mã máy trước khi chạy |   | Đọc và thực thi từng dòng |   | Biên dịch tại thời điểm chạy |
| → nhanh khi chạy        |   | → chậm, nhưng linh hoạt   |   | → nhanh như compiled code  |
| → Tệp nhị phân (.exe)   |   | → Không tạo file riêng    |   | → Tối ưu theo hành vi thật |
          |                               |                               |
          v                               v                               v
+-------------------------+   +-------------------------+   +-------------------------+
|   MACHINE CODE (x86)    |   |   AST WALKER / BYTECODE |   |   MACHINE CODE (cached)   |
|   - Gọi trực tiếp CPU   |   |   - Duyệt AST hoặc      |   |   - Như compiler, nhưng  |
|   - Tốc độ cao          |   |     chạy bytecode       |   |     sinh lúc chạy        |
|                         |   |   - Không dùng CPU hiệu |   |   - Code "nóng" được tối |
|                         |   |     quả bằng mã máy     |   |     ưu mạnh              |
+-------------------------+   +-------------------------+   +-------------------------+
          |                               |                               |
          |                               |                               |
          +-------------------------------+-------------------------------+
                                          |
                                          v
                                +-------------------------+
                                |     EXECUTION           |
                                | - CPU chạy mã máy       |
                                | - OS cấp RAM, tài nguyên|
                                +-------------------------+

==========================================================================================================
                              CHI TIẾT: INTERPRETER (TRÌNH THÔNG DỊCH)
==========================================================================================================

+---------------------------------------------------------------------------------------------------------+
|                                         SOURCE CODE                                                     |
|   for i in range(5):                                                                                    |
|       print("Hello", i)                                                                                 |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          v
                                +-------------------------+
                                |   LEXER & PARSER        |
                                | → Tạo AST (Abstract Syntax Tree)                                         |
                                +------------+------------+
                                             |
                                             v
                                +-------------------------+
                                |    INTERPRETER LOOP     |
                                | Duyệt AST từng nút một  |
                                | (Recursive Descent)     |
                                +------------+------------+
                                             |
                   +------------------------+-------------------------+
                   |                                                  |
                   v                                                  v
        +---------------------+                           +---------------------+
        |   Built-in Functions  |                           |   Variable Lookup   |
        | - print() → system call|                          | - Tìm trong symbol  |
        | - len(), input(), ... |                           |   table (local/global)|
        +----------+----------+                           +----------+----------+
                   |                                                  |
                   +------------------------+-------------------------+
                                            |
                                            v
                                +-------------------------+
                                |     OUTPUT / EFFECT     |
                                | - In ra màn hình        |
                                | - Thay đổi biến         |
                                | - Gọi OS (file, network)|
                                +-------------------------+

GHI CHÚ:
- Interpreter **không sinh mã máy**, mà **duyệt AST hoặc bytecode** để thực thi.
- Mỗi lần chạy lại duyệt lại → **chậm hơn compiler**.
- Dễ báo lỗi rõ ràng, hỗ trợ debug tốt.
- Dùng trong: Python (CPython), Ruby, JavaScript (ban đầu), PHP.

==========================================================================================================
                              CHI TIẾT: JIT (JUST-IN-TIME COMPILER)
==========================================================================================================

+---------------------------------------------------------------------------------------------------------+
|                                         SOURCE CODE (JavaScript)                                        |
|   function hotFunction(x) {                                                                             |
|       let sum = 0;                                                                                      |
|       for (let i = 0; i < 10000; i++) sum += x;                                                         |
|       return sum;                                                                                       |
|   }                                                                                                     |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          v
                                +-------------------------+
                                |    AST / BYTECODE       |
                                | (e.g., V8 Ignition)     |
                                +------------+------------+
                                             |
                                             v
                                +-------------------------+
                                |   INTERPRET & PROFILE   |
                                | - Chạy nhanh bằng bytecode | 
                                | - Theo dõi: hàm nào chạy nhiều? |
                                +------------+------------+
                                             |
                                             v
                                +-------------------------+
                                |   JIT COMPILATION       |
                                | (e.g., V8 TurboFan)     |
                                | - Biên dịch `hotFunction` → mã máy |
                                | - Tối ưu: loop unrolling, inlining |
                                | - Cache lại để dùng sau |
                                +------------+------------+
                                             |
                                             v
                                +-------------------------+
                                |   MACHINE CODE (x86/ARM)|
                                | - Chạy như chương trình C++ |
                                | - Tốc độ gần native     |
                                +-------------------------+

GHI CHÚ:
- JIT = **Interpreter + Compiler** kết hợp.
- Ban đầu: chạy như interpreter (nhanh khởi động).
- Khi phát hiện code "nóng": biên dịch → tối ưu.
- Dùng trong: V8 (Chrome, Node.js), JVM (Java), .NET CLR, PyPy (Python).

==========================================================================================================
                              SO SÁNH TỔNG HỢP
==========================================================================================================

+------------------------+----------------------+------------------------+------------------------+
| Đặc điểm               |     COMPILER         |      INTERPRETER       |         JIT            |
+------------------------+----------------------+------------------------+------------------------+
| Thời gian dịch         | Trước khi chạy       | Không dịch (hoặc bytecode)| Lúc chạy (runtime)   |
| Tốc độ thực thi        | Rất nhanh            | Chậm                    | Rất nhanh (sau warm-up)|
| Khởi động              | Nhanh                | Rất nhanh               | Chậm hơn interpreter |
| Tối ưu hóa             | Mạnh (AOT)           | Hạn chế                 | Mạnh (dựa trên profile)|
| Debugging              | Khó hơn              | Dễ hơn                  | Trung bình             |
| Triển khai             | File nhị phân        | File nguồn + runtime    | File + runtime         |
| Ví dụ                  | C, C++, Rust, Go     | Python (CPython), Ruby  | Java, JavaScript (V8)  |
+------------------------+----------------------+------------------------+------------------------+

==========================================================================================================
                              KẾT LUẬN
==========================================================================================================

→ **Không có mô hình nào "tốt hơn" hoàn toàn** – mỗi cái phù hợp với mục đích khác nhau:

- **Compiler**: Tối ưu hiệu suất, dùng cho hệ thống, game, OS.
- **Interpreter**: Tối ưu phát triển, debug, dùng cho scripting, web.
- **JIT**: Cân bằng giữa hiệu suất và linh hoạt – lý tưởng cho môi trường runtime phức tạp.

💡 **Xu hướng hiện đại**:  
Hầu hết ngôn ngữ đều dùng **kết hợp**:  
- Python: CPython (interpreter) → PyPy (JIT)  
- JavaScript: Ban đầu interpreter → V8 dùng JIT  
- Java: Bytecode → JVM + JIT (HotSpot)  

→ **"Biên dịch hay thông dịch?"** không còn là câu hỏi nhị phân – mà là **"kết hợp như thế nào để tối ưu?"**
```