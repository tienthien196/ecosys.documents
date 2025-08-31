```
+------------------------------------------------------------------------------------------------------------+
|                                     GODOT STRING CHEATSHEET - 1 PAGE REFERENCE                             |
|                                      (Dành cho Godot Engine - GDScript String)                             |
+------------------------------------------------------------------------------------------------------------+
| [1] KHỞI TẠO               | [2] KIỂM TRA                            | [3] TÁCH & GHÉP                     |
|----------------------------|-----------------------------------------|-------------------------------------|
| String(123)     → int      | s.begins_with(x)        → bắt đầu?      | s.split(",")          → mảng ','    |
| String(3.14)    → float    | s.ends_with(x)          → kết thúc?     | s.rsplit(",",1)       → từ phải     |
| String([a,b])   → array    | s.empty()               → rỗng?         | s.split_floats(",",t) → số thực     |
| String({a:1})   → dict     | s.is_abs_path()         → tuyệt đối     | ", ".join(arr)        → nối mảng    |
|                            | s.is_rel_path()         → tương đối     | s.get_slice(",", i)   → phần i      |
|                            | s.is_valid_filename()                   |                                     |
|                            | s.is_valid_float/integer/hex/html/ip    |                                     |
|                            | s.is_valid_identifier()                 |                                     |
+----------------------------+-----------------------------------------+-------------------------------------+
| [4] TÌM & THAY THẾ         | [5] CHỈNH SỬA                           | [6] MÃ HÓA / GIẢI MÃ                |
|----------------------------|-----------------------------------------|-------------------------------------|
| s.find(x) / find_last(x)   | s.erase(pos, len)       → xóa đoạn      | s.c_escape() / c_unescape()         |
| s.findn(x) → no case       | s.insert(pos, "str")    → chèn          | s.http_escape() / http_unescape()   |
| s.rfind(x) → tìm ngược     | s.left(n)/right(n)      → lấy n ký tự   | s.json_escape()                     |
| s.replace(a,b)             | s.substr(pos, len)      → substring     | s.xml_escape()                      |
| s.replacen(a,b) → no case  | s.capitalize()          → viết hoa đầu  | s.percent_encode/decode()           |
| s.count(x) / countn(x)     | to_lower() / to_upper()                 | s.md5/sha1/sha256_text()            |
|                            | strip_edges()/lstrip()/rstrip()         |                                     |
|                            | strip_escapes()                         |                                     |
|                            | trim_prefix(x)/trim_suffix(x)           |                                     |
|                            | s.repeat(n)             → lặp n lần     |                                     |
+----------------------------+-----------------------------------------+-------------------------------------+
| [7] XỬ LÝ ĐƯỜNG DẪN        | [8] SO SÁNH & TƯƠNG ĐỒNG                | [9] CHUYỂN KIỂU                     |
|----------------------------|-----------------------------------------|-------------------------------------|
| s.get_base_dir() → thư mục | s.nocasecmp_to(t) → so sánh (no hoa)    | "123".to_int()        → số nguyên   |
| s.get_file() → tên file    | s.casecmp_to(t)  → có phân biệt hoa     | "12.3".to_float()     → số thực     |
| s.get_basename()           | s.naturalnocasecmp_to(t) → tự nhiên     | "0xff".hex_to_int()   → hex→int     |
| s.get_extension() → .png   | s.similarity(t)        → độ giống 0–1   | s.ord_at(i) → ASCII tại i           |
| s.plus_file("f.gd")        | s.is_subsequence_of(t)                  | s.to_ascii()/utf8()/wchar()         |
| s.simplify_path() → gọn    | s.is_subsequence_ofi(t) → no hoa        |                                     |
+----------------------------+-----------------------------------------+-------------------------------------+
| [10] ĐỊNH DẠNG & KÍCH THƯỚC              | [11] REGEX & BIGRAM             | [12] KHÁC                           |
|------------------------------------------|---------------------------------|-------------------------------------|
| "{0} la {1}".format([a,b]) → thay thế    | s.match("Xi*ao")   → regex      | s.length()      → độ dài chuỗi      |
| "123".pad_zeros(5) → "00123"             | s.matchn("XI*AO")  → no hoa     | s.hash()        → hash số           |
| "12.3".pad_decimals(4) → "12.3000"       | s.bigrams() → ["ab","bc"]       |                                     |
| String.humanize_size(bytes) → "1.2 MB"   |                                 |                                     |
| s.indent("> ") → thêm đầu dòng: "> ..."  |                                 |                                     |
+------------------------------------------+---------------------------------+-------------------------------------+

```