```
+----------------------------------------------------------------------------------------------------------------------------------------------------+
|                                                       GODOT STRING & ARRAY CHEATSHEET                                                             |
+----------------------------------------------------------------------------------------------------------------------------------------------------+
| [STRING - 1] KHỞI TẠO                | [STRING - 2] KIỂM TRA                      | [ARRAY - 1] KHỞI TẠO                                           |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| String(123)      → int               | s.begins_with(x)     → bắt đầu?            | var arr = ["Mot", 2, 3]                                       |
| String(3.14)     → float             | s.ends_with(x)       → kết thúc?           | Pool Arrays: PoolColor/Vector2/Vector3/String/Real/Int/Byte   |
| String([a,b])    → array             | s.empty()            → rỗng?               |                                                                |
| String({a:1})    → dict              | s.is_abs_path()      → tuyệt đối           |                                                                |
|                                      | s.is_rel_path()      → tương đối           |                                                                |
|                                      | s.is_valid_filename()                      |                                                                |
|                                      | s.is_valid_float/int/hex/html/ip           |                                                                |
|                                      | s.is_valid_identifier()                    |                                                                |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [STRING - 3] TÁCH & GHÉP             | [STRING - 4] TÌM & THAY THẾ                | [ARRAY - 2] THÊM & GỘP                                         |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| s.split(",")     → mảng ','          | s.find(x) / find_last(x)                   | arr.append(x)       → thêm cuối                               |
| s.rsplit(",",1)  → tách từ phải      | s.findn(x)             → no case           | arr.append_array(b)  → gộp mảng                                |
| s.split_floats() → mảng số thực      | s.rfind(x)             → tìm ngược         | arr.push_back(x)    → thêm cuối                               |
| ", ".join(arr)   → nối mảng          | s.replace(a,b)                             | arr.push_front(x)   → thêm đầu                                |
| s.get_slice(i)   → phần tử i         | s.replacen(a,b)        → no case           | arr.insert(i, x)    → chèn tại vị trí                          |
|                                      | s.count(x) / countn(x)                     |                                                                |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [STRING - 5] CHỈNH SỬA               | [STRING - 6] MÃ HÓA / GIẢI MÃ              | [ARRAY - 3] XÓA & CHỈNH SỬA                                    |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| s.erase(pos,len)   → xóa             | s.c_escape() / c_unescape()                | arr.erase(x)   → xóa giá trị                                   |
| s.insert(pos,str)  → chèn            | s.http_escape()/http_unescape()            | arr.remove(i)  → xóa tại index                                 |
| s.left(n)/right(n) → lấy n ký tự     | s.json_escape()                            | arr.clear()    → xóa toàn bộ                                   |
| s.substr(pos,len)  → substring       | s.xml_escape()                             | arr.fill(v)    → gán toàn bộ = v                               |
| s.capitalize()     → viết hoa đầu    | s.percent_encode/decode()                  | arr.resize(n)  → đổi kích thước                                |
| to_lower()/upper()                   | s.md5/sha1/sha256_text()                   |                                                                |
| strip_edges()/lstrip()/rstrip()      |                                            |                                                                |
| strip_escapes()                      |                                            |                                                                |
| trim_prefix()/trim_suffix()          |                                            |                                                                |
| s.repeat(n)        → lặp n lần       |                                            |                                                                |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [STRING - 7] ĐƯỜNG DẪN               | [STRING - 8] SO SÁNH & TƯƠNG ĐỒNG          | [ARRAY - 4] TRUY CẬP & KIỂM TRA                                |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| s.get_base_dir()   → thư mục         | s.nocasecmp_to(t)   → so sánh no hoa       | arr.front()    → phần tử đầu                                   |
| s.get_file()       → tên file        | s.casecmp_to(t)     → phân biệt hoa        | arr.back()     → phần tử cuối                                  |
| s.get_basename()   → tên không đuôi  | s.naturalnocasecmp_to(t) → tự nhiên        | arr.has(x)     → có chứa x?                                    |
| s.get_extension()  → .png            | s.similarity(t)     → độ giống 0–1         | arr.empty()    → rỗng?                                         |
| s.plus_file("f.gd")→ nối             | s.is_subsequence_of(t)                     | arr.size()     → số phần tử                                    |
| s.simplify_path()  → gọn             | s.is_subsequence_ofi(t) → no hoa           | arr.find(x)    → tìm từ đầu                                    |
|                                      |                                            | arr.find_last(x)→ tìm từ cuối                                  |
|                                      |                                            | arr.rfind(x)   → tìm ngược                                     |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [STRING - 9] CHUYỂN KIỂU             | [STRING - 10] ĐỊNH DẠNG & KÍCH THƯỚC       | [ARRAY - 5] SẮP XẾP & TÌM KIẾM                                  |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| "123".to_int()     → int             | "{0} la {1}".format([a,b]) → thay thế      | arr.sort()           → sắp xếp tăng                           |
| "12.3".to_float()  → float           | "123".pad_zeros(5) → "00123"               | arr.bsearch(x)       → tìm vị trí chèn                         |
| "0xff".hex_to_int()→ hex→int         | "12.3".pad_decimals(4) → "12.3000"         | arr.sort_custom(o,f) → sắp xếp tùy chỉnh                       |
| s.ord_at(i)        → ASCII           | String.humanize_size(bytes) → "1.2 MB"     | arr.bsearch_custom(x,o,f) → tìm tùy chỉnh                      |
| s.to_ascii()/utf8()/wchar()          | s.indent("> ") → thêm tiền tố              |                                                                |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [STRING - 11] REGEX & BIGRAM         | [STRING - 12] KHÁC                         | [ARRAY - 6] LẤY & XÓA PHẦN TỬ                                   |
|--------------------------------------|--------------------------------------------|----------------------------------------------------------------|
| s.match("Xi*ao")   → regex đơn giản  | s.length()  → độ dài                       | arr.pop_front() → lấy+xóa đầu                                  |
| s.matchn("XI*AO")  → no hoa          | s.hash()    → mã hash số                   | arr.pop_back()  → lấy+xóa cuối                                 |
| s.bigrams()        → cặp ký tự       |                                            | arr.pop_at(i)   → lấy+xóa tại i                                |
+--------------------------------------+--------------------------------------------+----------------------------------------------------------------+
| [ARRAY - 7] KHÁC                                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------------|
| arr.invert() → đảo ngược | arr.pick_random() → chọn ngẫu nhiên | arr.max()/min() → lớn nhất/nhỏ nhất | arr.shuffle() → xáo trộn | 
| arr.count(x) → đếm số lần | arr.hash() → mã hash | arr.slice(a,b) → cắt [a..b] | arr.duplicate() → copy | arr.duplicate(true) → deep copy |
+------------------------------------------------------------------------------------------------------------------------------------------------+

```