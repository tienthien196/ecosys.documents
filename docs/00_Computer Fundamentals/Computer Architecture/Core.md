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


