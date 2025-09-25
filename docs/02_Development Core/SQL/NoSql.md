```
NOSQL — HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU PHI QUAN HỆ
│
├─── 1. BẢN CHẤT TỔNG QUÁT
│    │
│    ├─── Không phải là "không SQL" → mà là "Not Only SQL"
│    ├─── Là nhóm hệ thống CSDL **không tuân thủ mô hình quan hệ (Relational Model)** của E.F. Codd
│    ├─── Ra đời để giải quyết **giới hạn của RDBMS trong kỷ nguyên Big Data & Distributed Systems**
│    └─── Mục tiêu: SCALE OUT (phân tán), LINH HOẠT, HIỆU NĂNG CAO → hy sinh một phần ACID hoặc tính toàn vẹn chặt chẽ
│
├─── 2. ĐỘNG LỰC RA ĐỜI — VÌ SAO CẦN NOSQL?
│    │
│    ├─── 📉 Giới hạn của RDBMS truyền thống:
│    │    ├─── Scale UP đắt đỏ: tăng CPU/RAM máy chủ → có giới hạn vật lý
│    │    ├─── JOIN phức tạp → chậm trên dữ liệu phân tán
│    │    ├─── Schema cứng → khó thay đổi khi yêu cầu thay đổi nhanh
│    │    └─── ACID toàn cục → giảm hiệu năng trên cluster
│    │
│    └─── 🚀 Yêu cầu mới từ web 2.0 / mobile / IoT:
│         ├─── Dữ liệu phi cấu trúc (JSON, log, sensor, media metadata)
│         ├─── Tốc độ đọc/ghi cực cao (millions req/s)
│         └─── Khả năng chịu lỗi, sẵn sàng cao (high availability) → không thể dừng service
│
├─── 3. PHÂN LOẠI CHÍNH THEO MÔ HÌNH DỮ LIỆU (DATA MODEL)
│    │
│    ├─── A. DOCUMENT STORE — Lưu dữ liệu dạng tài liệu
│    │    │
│    │    ├─── Cấu trúc: Tài liệu (document) = JSON/BSON/XML — tự mô tả, schema linh hoạt
│    │    ├─── Ví dụ: MongoDB, CouchDB
│    │    │
│    │    ├─── Lý thuyết nền: Không phải quan hệ → là tập hợp các đối tượng mang ngữ nghĩa
│    │    ├─── Ưu điểm:
│    │    │    ├─── Không cần JOIN → dữ liệu liên quan được nhúng (embedded) trong một tài liệu
│    │    │    └─── Schema dynamic: thêm field mới → không cần ALTER TABLE
│    │    │
│    │    └─── Nhược điểm lý thuyết:
│    │         ├─── Không đảm bảo toàn vẹn tham chiếu (referential integrity) giữa tài liệu
│    │         └─── Giao dịch đa tài liệu (multi-document ACID) khó thực hiện → thường chỉ ACID trong 1 document
│    │
│    ├─── B. KEY-VALUE STORE — Lưu cặp khóa-giá trị
│    │    │
│    │    ├─── Cấu trúc: K → V (Key → Value) — giá trị hoàn toàn vô cấu trúc (blob, string, binary, serialized object)
│    │    ├─── Ví dụ: Redis, DynamoDB, Riak, etcd
│    │    │
│    │    ├─── Lý thuyết nền: Là một hàm ánh xạ (mapping function) từ tập khóa (key space) sang tập giá trị
│    │    │    └─── Tương đương với `HashMap` hoặc `Dictionary` ở cấp hệ thống
│    │    │
│    │    ├─── Ưu điểm:
│    │    │    ├─── Truy xuất O(1) — nhanh nhất trong tất cả các loại DB
│    │    │    ├─── Dễ phân tán (sharding theo key)
│    │    │    └─── Phù hợp cache, session, queue, leaderboards
│    │    │
│    │    └─── Nhược điểm:
│    │         ├─── Không truy vấn theo nội dung (no query by value)
│    │         └─── Không hỗ trợ range scan nếu không dùng ordered key (Redis ZSET除外)
│    │
│    ├─── C. COLUMN-FAMILY STORE — Lưu dữ liệu theo cột (thay vì hàng)
│    │    │
│    │    ├─── Cấu trúc: Table → Column Family → Column → Timestamped Value
│    │    │    └─── Mỗi hàng có thể có hàng trăm nghìn cột, nhưng mỗi hàng chỉ chứa một tập con
│    │    ├─── Ví dụ: Cassandra, HBase
│    │    │
│    │    ├─── Lý thuyết nền: Tối ưu hóa cho **đọc/write khối lượng lớn theo cột**
│    │    │    └─── Giống như bảng thưa (sparse matrix) — tiết kiệm không gian
│    │    │
│    │    ├─── Ưu điểm:
│    │    │    ├─── Scale ngang cực tốt (phân mảnh theo row key)
│    │    │    ├─── Hiệu năng cao khi truy vấn một vài cột trên triệu hàng
│    │    │    └─── Tối ưu cho time-series, log, analytics
│    │    │
│    │    └─── Nhược điểm:
│    │         ├─── Không hỗ trợ JOIN
│    │         ├─── Không có query language chuẩn (dùng CQL — gần SQL nhưng hạn chế)
│    │         └─── Khó xử lý truy vấn đa chiều (ad-hoc queries)
│    │
│    └─── D. GRAPH DATABASE — Lưu mối quan hệ như đối tượng đầu tiên
│         │
│         ├─── Cấu trúc: Node (đỉnh) + Edge (cạnh) + Property (thuộc tính)
│         ├─── Ví dụ: Neo4j, Amazon Neptune, ArangoDB
│         │
│         ├─── Lý thuyết nền: Dựa trên **Lý thuyết đồ thị (Graph Theory)**
│         │    ├─── Mỗi edge là một mối quan hệ có tên và hướng (ví dụ: USER →[FOLLOWS]→ USER)
│         │    └─── Không dùng JOIN — dùng traversal (duyệt) qua cạnh
│         │
│         ├─── Ưu điểm:
│         │    ├─── Truy vấn mối quan hệ sâu (kết nối bậc 5, 6...) cực nhanh
│         │    └─── Tự nhiên với mạng xã hội, đề xuất sản phẩm, fraud detection
│         │
│         └─── Nhược điểm:
│              ├─── Không tối ưu cho truy vấn đơn giản (VD: tìm user có email = X)
│              └─── Chi phí lưu trữ cao do lưu edge riêng biệt
│
├─── 4. CÁC NGUYÊN TẮC THIẾT KẾ CỐT LÕI (CAP THEOREM & BASE)
│    │
│    ├─── 🧩 CAP THEOREM (Brewer, 2000)
│    │    │
│    │    ├─── Trong hệ thống phân tán, chỉ có thể đạt tối đa 2 trong 3 tính chất:
│    │    │    ├─── Consistency (Tính nhất quán): Tất cả node thấy dữ liệu giống nhau tại cùng thời điểm
│    │    │    ├─── Availability (Tính sẵn sàng): Mọi request đều nhận được phản hồi (không lỗi)
│    │    │    └─── Partition Tolerance (Chịu lỗi phân vùng): Hệ thống vẫn hoạt động dù mạng bị chia cắt
│    │    │
│    │    └─── NoSQL thường chọn: **AP** (Availability + Partition Tolerance) → hy sinh Consistency nghiêm ngặt
│    │         → Dùng eventual consistency (tính nhất quán cuối cùng)
│    │
│    └─── ⚖️ BASE — Alternative to ACID
│         │
│         ├─── Basically Available — Hệ thống luôn sẵn sàng trả lời (không down)
│         ├─── Soft state — Trạng thái có thể thay đổi theo thời gian (không đồng bộ tức thì)
│         └─── Eventual Consistency — Dữ liệu sẽ nhất quán sau một khoảng thời gian (không đảm bảo ngay lập tức)
│              └─── Ví dụ: Bạn like bài viết → hiển thị 0 like → 1 phút sau mới hiện 1 like → đó là eventual consistency
│
├─── 5. SO SÁNH LÝ THUYẾT NOSQL VS RDBMS
│    │
│    ├─── | Tiêu chí               | RDBMS (MySQL)             | NoSQL                          |
│    │     |----------------------|----------------------------|--------------------------------|
│    │     | Mô hình dữ liệu       | Quan hệ (bảng, FK, JOIN)   | Document / Key-Value / Graph / Column |
│    │     | Schema                | Cứng, định nghĩa trước    | Linh hoạt, dynamic, schema-on-read |
│    │     | Scalability           | Scale Up (đắt)            | Scale Out (dễ, phân tán tự nhiên) |
│    │     | Transaction           | ACID mạnh                  | ACID yếu (thường chỉ trong 1 document) → BASE |
│    │     | Query Language        | SQL chuẩn                  | Không chuẩn (MongoDB QL, CQL, Gremlin…) |
│    │     | Join                  | Được hỗ trợ đầy đủ         | Hầu như không hỗ trợ (hoặc rất chậm) |
│    │     | Consistency           | Strong (ngay lập tức)      | Eventual (chậm, nhưng sẵn sàng) |
│    │     | Use Case              | Giao dịch, ngân hàng, ERP  | Social, IoT, log, cache, real-time analytics |
│    │     | Storage Engine        | B+Tree, WAL                 | SSTable, LSM-Tree, Hash Table, Graph Index |
│    │
│    └─── 💡 Nhận xét lý thuyết:  
│         → RDBMS tối ưu cho **tính chính xác và toàn vẹn**  
│         → NoSQL tối ưu cho **tính sẵn sàng và khả năng mở rộng**
│
├─── 6. CƠ CHẾ LƯU TRỮ VÀ TỐI ƯU (PHÍA SAU NOSQL)
│    │
│    ├─── 🗃️ STORAGE ENGINE PHỔ BIẾN:
│    │    │
│    │    ├─── LSM-Tree (Log-Structured Merge Tree) — Dùng trong Cassandra, LevelDB, RocksDB
│    │    │    ├─── Viết: ghi tuần tự vào memtable → flush ra SSTable (sorted string table)
│    │    │    └─── Đọc: kết hợp nhiều SSTable + bloom filter → tối ưu write-heavy
│    │    │
│    │    ├─── Hash Table — Dùng trong Redis (key-value in-memory)
│    │    │    └─── Truy xuất O(1) — không có index, không sắp xếp
│    │    │
│    │    └─── Graph Index — Dùng trong Neo4j: lưu node + edge trực tiếp, duyệt bằng pointer
│    │
│    └─── 🔄 REPLICATION & SHARDING:
│         ├─── Replication: Dữ liệu được sao chép qua nhiều node → tăng availability
│         ├─── Sharding: Chia dữ liệu theo hash key → mỗi node phụ trách một shard
│         └─── Không dùng master-slave truyền thống → dùng consensus protocol (Raft, Paxos) để đồng bộ
│
└─── 7. KHI NÀO DÙNG NOSQL? — QUYẾT ĐỊNH LÝ THUYẾT
     │
     ├─── ✅ Dùng NoSQL khi:
     │    ├─── Dữ liệu có cấu trúc thay đổi liên tục (user profile, product variants)
     │    ├─── Cần scale ngang để phục vụ millions of concurrent users
     │    ├─── Có tải write cực lớn (log, telemetry, sensor data)
     │    └─── Mối quan hệ giữa các thực thể là phức tạp, đa chiều (social graph, recommendation)
     │
     └─── ❌ Không dùng NoSQL khi:
          ├─── Bạn cần giao dịch xuyên suốt nhiều bảng (bank transfer)
          ├─── Bạn cần ràng buộc toàn vẹn tham chiếu nghiêm ngặt (FK)
          ├─── Bạn cần truy vấn linh hoạt, ad-hoc, nhiều JOIN
          └─── Bạn đang xây dựng hệ thống tài chính, y tế, pháp lý — nơi sai một bit là thảm họa
```
NOSQL
— Không phải “không SQL” → mà là “Not Only SQL”.
— Là nhóm hệ thống CSDL được thiết kế để **phá vỡ mô hình quan hệ truyền thống**, vì nó không phù hợp với quy mô, tốc độ và tính linh hoạt của thời đại phân tán.

DOCUMENT STORE (MongoDB, CouchDB)
— Dữ liệu lưu dưới dạng tài liệu (JSON/BSON) — tự mô tả, không schema cứng.
— Bạn không tạo bảng, bạn tạo “đối tượng” — ví dụ: một user = 1 tài liệu chứa name, email, address, orders...
— Đánh đổi: Không có JOIN → dữ liệu liên quan được nhúng (embedded) vào cùng 1 tài liệu.
— Lợi ích: Linh hoạt, nhanh cho read/write đơn lẻ, dễ thay đổi cấu trúc khi phát triển nhanh.

KEY-VALUE STORE (Redis, DynamoDB)
— Mỗi dữ liệu là một cặp: Key → Value.
— Value là blob: string, JSON, binary, serialized object — hoàn toàn vô cấu trúc.
— Không truy vấn nội dung, không lọc, không join — chỉ tìm bằng key.
— Lợi ích: Truy xuất O(1) — nhanh nhất trong mọi DB.
— Ứng dụng: Cache, session, leaderboard, queue — nơi bạn chỉ cần “lấy ra cái này” hoặc “lưu cái này”.

COLUMN-FAMILY STORE (Cassandra, HBase)
— Dữ liệu tổ chức theo cột, không theo hàng — mỗi hàng có thể có hàng ngàn cột, nhưng chỉ vài cột được dùng.
— Tương đương với “bảng thưa” (sparse matrix): tiết kiệm không gian, tối ưu cho analytics/time-series.
— Không hỗ trợ JOIN, không có query language chuẩn — chỉ dùng CQL (gần SQL nhưng hạn chế).
— Lợi ích: Scale ngang cực tốt, ghi cực nhanh, chịu lỗi cao — dành cho log, sensor, IoT.

GRAPH DATABASE (Neo4j, Neptune)
— Dữ liệu là Node (đỉnh) + Edge (cạnh) + Property (thuộc tính).
— Mối quan hệ là đối tượng đầu tiên — không phải kết quả của JOIN.
— Truy vấn: “Tìm tất cả bạn bè của bạn bè của bạn” — duyệt qua cạnh, không qua bảng.
— Lợi ích: Nhanh gấp trăm lần RDBMS khi truy vấn mối quan hệ đa bậc.
— Ứng dụng: Mạng xã hội, đề xuất sản phẩm, phát hiện gian lận, kiến trúc hệ thống.

SCHEMA-LESS / DYNAMIC SCHEMA
— Không cần định nghĩa cấu trúc trước khi lưu dữ liệu.
— Thêm field mới? Chỉ cần ghi thêm vào document — không ALTER TABLE.
— Đánh đổi: Không có kiểm tra kiểu dữ liệu ở cấp độ DB — lỗi do ứng dụng xử lý.
— Lý do tồn tại: Thế giới thực thay đổi nhanh — yêu cầu phần mềm thay đổi còn nhanh hơn.

EVENTUAL CONSISTENCY
— Dữ liệu sẽ nhất quán… sau một khoảng thời gian.
— Khi bạn like bài viết → hiển thị 0 like → 5 giây sau mới hiện 1 like → đó là eventual consistency.
— Đánh đổi: Hy sinh tính nhất quán tức thì để đổi lấy khả năng sẵn sàng (availability) và phân tán.
— Là nền tảng của hầu hết NoSQL — trái ngược với ACID.

CAP THEOREM
— Trong hệ thống phân tán, bạn chỉ có thể chọn 2 trong 3:
   • Consistency (nhất quán)
   • Availability (sẵn sàng)
   • Partition Tolerance (chịu lỗi mạng)
— NoSQL thường chọn AP → hy sinh Strong Consistency để luôn trả lời request, dù mạng bị chia cắt.
— MySQL chọn CA → không chạy phân tán tốt → nên không scale ngang.

BASE (vs ACID)
— Basically Available: Hệ thống luôn phản hồi (không down).
— Soft State: Trạng thái có thể thay đổi theo thời gian (không đồng bộ ngay).
— Eventual Consistency: Dữ liệu sẽ nhất quán sau một thời gian.
— BASE là triết lý của NoSQL — ACID là triết lý của RDBMS.
— Bạn không cần “tức thì chính xác” — bạn cần “luôn hoạt động”.

LSM-TREE (Log-Structured Merge Tree)
— Cấu trúc lưu trữ tối ưu cho write-heavy: ghi tuần tự vào đĩa, không overwrite.
— Dữ liệu được ghi vào memtable → flush thành SSTable (sorted file) → merge định kỳ.
— Tại sao Cassandra ghi nhanh gấp 10x MySQL? Vì MySQL ghi ngẫu nhiên (random I/O), Cassandra ghi tuần tự (sequential I/O).
— Đánh đổi: Đọc chậm hơn — vì phải hợp nhất nhiều file.

SHARDING
— Chia dữ liệu thành nhiều mảnh (shard), mỗi shard nằm trên một node khác nhau.
— Phân chia theo hash key (VD: user_id % 10) → mỗi node phụ trách một phần.
— Không cần master-slave phức tạp — mỗi shard độc lập.
— Lợi ích: Scale ngang vô hạn — thêm máy là tăng capacity.

REPLICATION
— Sao chép dữ liệu lên nhiều node để đảm bảo sẵn sàng.
— Không phải backup — là đồng bộ trực tiếp, liên tục.
— Dùng giao thức consensus (Raft, Paxos) để đồng thuận giữa các node — tránh xung đột.

NO JOIN
— Không hỗ trợ phép toán kết hợp bảng (JOIN).
— Vì JOIN đòi hỏi đồng bộ dữ liệu từ nhiều node — trái với mục tiêu hiệu năng và phân tán.
— Giải pháp: Nhúng dữ liệu (embedding) hoặc xử lý JOIN ở ứng dụng — chậm hơn, nhưng kiểm soát được.
— Đây là sự hy sinh có chủ ý để đạt tốc độ và khả năng mở rộng.

HIGH AVAILABILITY
— Hệ thống luôn sẵn sàng phục vụ request — ngay cả khi 1 vài node sập.
— Không có điểm hỏng duy nhất (single point of failure).
— Là mục tiêu số 1 của NoSQL — không phải “tính toàn vẹn tuyệt đối”.
— Bạn chấp nhận dữ liệu hơi “lệch” tạm thời — để dịch vụ không bao giờ down.