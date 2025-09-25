```
SOFTWARE (Chạy trên OS)
│
└─── DATABASE MANAGEMENT SYSTEM (DBMS) — Hệ quản trị CSDL (Phần mềm trung gian)
     │
     ├─── RELATIONAL DBMS (RDBMS) — Mô hình bảng (Table/Row/Column)
     │    │
     │    ├─── MySQL — Open-source, phổ biến, tối ưu cho Web (LAMP/LEMP)
     │    │    ├─── Ưu điểm: Nhanh, dễ dùng, cộng đồng lớn
     │    │    └─── Nhược điểm: Hạn chế về tính năng nâng cao (JSON, Window Func)
     │    │
     │    └─── PostgreSQL — “Object-Relational” (mạnh nhất RDBMS)
     │         ├─── Ưu điểm: Tính toàn vẹn cao, hỗ trợ JSON, GIS, hàm custom, mở rộng tốt
     │         ├─── Hỗ trợ SQL chuẩn gần như hoàn hảo
     │         └─── Phù hợp: Apps phức tạp, data integrity, analytics
     │
     └─── NON-RELATIONAL DBMS (NoSQL) — Không dùng bảng quan hệ
          │
          ├─── DOCUMENT STORE — Lưu dữ liệu dạng tài liệu (JSON/BSON)
          │    ├─── MongoDB — Đơn giản, linh hoạt, scale ngang tốt
          │    │    ├─── Ưu điểm: Schema-free, phát triển nhanh
          │    │    └─── Nhược điểm: Không có JOIN, khó đảm bảo ACID toàn diện
          │    └─── CouchDB — Đồng bộ hóa offline tốt
          │
          ├─── KEY-VALUE STORE — Chìa khóa → Giá trị (siêu nhanh)
          │    ├─── Redis — In-memory, cache, pub/sub, queue
          │    │    ├─── Ưu điểm: Tốc độ cực cao, hỗ trợ cấu trúc (list, set, zset)
          │    │    └─── Nhược điểm: Dữ liệu mất khi restart (nếu không persist)
          │    └─── DynamoDB (AWS) — Managed key-value, scale tự động
          │
          ├─── COLUMN-FAMILY STORE — Dữ liệu theo cột, tối ưu đọc lớn
          │    ├─── Cassandra — High availability, phân tán toàn cầu
          │    └─── HBase — Trên Hadoop, xử lý Big Data
          │
          └─── GRAPH DATABASE — Mô hình mối quan hệ (node + edge)
               ├─── Neo4j — Phân tích mạng xã hội, đề xuất, fraud detection
               └─── ArangoDB — Multi-model (document + graph + key-value)
```