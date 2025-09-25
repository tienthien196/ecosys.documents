---
sidebar_position: 4
sidebar_label: Tập Giá Trị
---

##    📚 Toàn Bộ Dạng Bài Tập Giá Trị Của Hàm Số: Từ Base đến Advanced

> **Tập giá trị (miền giá trị) của hàm số** là tập hợp **tất cả các giá trị y** mà hàm có thể đạt được khi x thay đổi trong tập xác định.  
> 💬 Nói dễ hiểu: *“Khi em thay đủ mọi số x vào hàm, thì y ra được những số nào? Đó chính là tập giá trị!”*

---

## ✅ PHẦN 1: BASE — CƠ BẢN NHẤT (LỚP 7–9)

### 🔹 Dạng 1: Hàm số cho bằng bảng giá trị

**Ví dụ**:  
| x   | -2 | -1 | 0 | 1 | 2 |
|-----|----|----|---|---|---|
| y   | 4  | 1  | 0 | 1 | 4 |

👉 **Cách tìm tập giá trị**:  
Liệt kê **tất cả các giá trị y** xuất hiện → **không lặp lại**.

✅ **Tập giá trị**: `{0, 1, 4}`

💡 **Ví dụ đời thường**:  
> Em bán kem mỗi ngày: 0, 1, 2, 3 hoặc 4 cây → tập giá trị = `{0,1,2,3,4}` — những số kem em có thể bán được trong 1 ngày.

---

### 🔹 Dạng 2: Hàm bậc nhất — `y = ax + b` (a ≠ 0)

**Ví dụ**: `y = 2x + 1`, với `x ∈ ℝ`

👉 Vì `x` có thể là **bất kỳ số thực nào** → `y` cũng chạy khắp trục số.

✅ **Tập giá trị**: `ℝ` (hay viết là `(-∞; +∞)`)

⚠️ Nếu đề cho `x ∈ [0; 5]` → thay x=0 → y=1; x=5 → y=11  
→ Tập giá trị: `[1; 11]`

💡 **Ví dụ đời thường**:  
> Em đi xe đạp: cứ đi thêm 1 km thì tiền vé tăng 2 nghìn, cộng thêm 1k phí khởi hành.  
> Nếu em đi **bất kỳ quãng đường nào** → tiền vé có thể là **bất kỳ số nào** → tập giá trị = ℝ.

---

### 🔹 Dạng 3: Hàm bậc hai — `y = ax² + bx + c` (a ≠ 0)

**Ví dụ**: `y = x²`

👉 Vì `x² ≥ 0` với mọi x → `y ≥ 0`  
→ Khi `x = 0` → `y = 0`  
→ Khi `x = ±1, ±2...` → `y = 1, 4...`

✅ **Tập giá trị**: `[0; +∞)`

📌 **Quy tắc vàng**:
- Nếu `a > 0` → parabol hướng lên → tập giá trị: `[y_min; +∞)`
- Nếu `a < 0` → parabol hướng xuống → tập giá trị: `(-∞; y_max]`

📍 Tìm `y_min/max`:  
Dùng công thức đỉnh:  
> `x = -b/(2a)` → thay vào hàm tìm y

**Ví dụ**: `y = x² - 4x + 3`  
→ `x = 4/2 = 2` → `y = 4 - 8 + 3 = -1`  
→ `a = 1 > 0` → tập giá trị: `[-1; +∞)`

💡 **Ví dụ đời thường**:  
> Ném bóng lên trời: độ cao tăng rồi giảm → chỉ nằm trong khoảng từ 0 đến điểm cao nhất → giống parabol!

---

## ✅ PHẦN 2: INTERMEDIATE — NÂNG CAO HƠN (LỚP 9–10)

### 🔹 Dạng 4: Hàm phân thức — `y = (ax + b)/(cx + d)`

**Ví dụ**: `y = 1/x`

👉 Điều kiện: `x ≠ 0` → `y` không thể bằng 0 (vì 1/x luôn khác 0)

✅ **Tập giá trị**: `ℝ \ {0}` (tức là tất cả số thực **trừ 0**)

💡 **Ví dụ đời thường**:  
> Chia 1 cái bánh cho x người → mỗi người được `1/x` cái.  
> Dù chia cho 1000 người, mỗi người vẫn có **một chút** → nhưng **không bao giờ bằng 0**.

---

### 🔹 Dạng 5: Hàm chứa căn bậc hai — `y = √(f(x))`

**Ví dụ**: `y = √(x - 3)`

👉 Điều kiện xác định: `x - 3 ≥ 0` → `x ≥ 3`  
👉 Vì căn bậc hai **luôn ≥ 0** → `y ≥ 0`

✅ **Tập giá trị**: `[0; +∞)`

⚠️ Nếu `y = √(x - 3) + 2` → `y ≥ 2` → tập giá trị: `[2; +∞)`

💡 **Ví dụ đời thường**:  
> Đo chiều dài sợi dây treo quả cân → chiều dài không âm → căn của nó cũng không âm!

---

### 🔹 Dạng 6: Hàm chứa giá trị tuyệt đối — `y = |f(x)|`

**Ví dụ**: `y = |x - 2|`

👉 Tính chất: `|anything| ≥ 0`

✅ **Tập giá trị**: `[0; +∞)`

💡 **Ví dụ đời thường**:  
> Em đi từ nhà đến trường: dù đi về phía đông hay tây, **khoảng cách luôn dương** → giá trị tuyệt đối mô tả điều đó!

---

## ✅ PHẦN 3: ADVANCED — NÂNG CAO CHUYÊN SÂU (LỚP 10–11)

### 🔹 Dạng 7: Hàm lượng giác — `y = sinx`, `cosx`, `tanx`

| Hàm | Tập giá trị |
|------|-------------|
| `sinx`, `cosx` | `[-1; 1]` |
| `tanx` | `ℝ` |

💡 **Ví dụ đời thường**:  
> Con lắc dao động: độ cao lên xuống giữa -1m và 1m → giống hàm sin → tập giá trị `[-1;1]`.

---

### 🔹 Dạng 8: Hàm hợp — `y = f(g(x))`

**Ví dụ**: `y = √(sinx)`

👉 Bước 1: Tìm miền giá trị của `g(x) = sinx` → `[-1;1]`  
👉 Bước 2: Nhưng `√(sinx)` chỉ xác định khi `sinx ≥ 0` → `sinx ∈ [0;1]`  
👉 Bước 3: Áp dụng hàm căn → `√([0;1]) = [0;1]`

✅ **Tập giá trị**: `[0; 1]`

📌 **Chiến lược**:  
1. Tìm tập giá trị của hàm trong ngoặc  
2. Xét điều kiện xác định nếu cần  
3. Áp dụng hàm ngoài

---

### 🔹 Dạng 9: Hàm đa thức bậc cao — đặt ẩn phụ

**Ví dụ**: `y = x⁴ - 4x² + 3`

👉 Đặt `t = x²` (với `t ≥ 0`)  
→ `y = t² - 4t + 3`, `t ≥ 0`

Khảo sát hàm bậc hai theo t:  
- Đỉnh tại `t = 2` → `y = 4 - 8 + 3 = -1`  
- Tại `t = 0` → `y = 3`  
- Khi `t → ∞` → `y → ∞`

→ Vậy `y ∈ [-1; +∞)`

✅ **Tập giá trị**: `[-1; +∞)`

💡 **Mẹo**:  
> Với hàm bậc 4, 6, 8... → **luôn nghĩ đến đặt `t = x²`** để hạ bậc!

---

### 🔹 Dạng 10: Hàm phân thức phức tạp — dùng điều kiện có nghiệm

**Ví dụ**: `y = (x² + 1)/(x² - 2x + 2)`

👉 **Phương pháp ngược**: Gọi `y` là giá trị hàm → giải phương trình tìm x.

**Bước 1**:  
`y = (x² + 1)/(x² - 2x + 2)`  
→ `y(x² - 2x + 2) = x² + 1`  
→ `yx² - 2yx + 2y = x² + 1`  
→ `(y - 1)x² - 2yx + (2y - 1) = 0`

**Bước 2**: Để pt này có nghiệm thực → **Δ ≥ 0**

Tính Δ theo y:  
> `Δ = (-2y)² - 4(y - 1)(2y - 1)`  
> `= 4y² - 4[(y - 1)(2y - 1)]`  
> `= 4y² - 4[2y² - y - 2y + 1]`  
> `= 4y² - 4[2y² - 3y + 1]`  
> `= 4y² - 8y² + 12y - 4`  
> `= -4y² + 12y - 4`

Giải: `-4y² + 12y - 4 ≥ 0`  
→ Chia cả hai vế cho -4 (đổi dấu):  
> `y² - 3y + 1 ≤ 0`

Giải bất phương trình:  
→ Nghiệm của `y² - 3y + 1 = 0` là:  
> `y = [3 ± √5]/2 ≈ [3 ± 2.236]/2` → `≈ 0.382` và `2.618`

→ Vậy: `y ∈ [[3 - √5]/2 ; [3 + √5]/2]`

✅ **Tập giá trị**: `[(3 - √5)/2 ; (3 + √5)/2] ≈ [0.382; 2.618]`

💡 **Ý tưởng then chốt**:  
> “Nếu y là giá trị hàm, thì phải tồn tại x sao cho pt có nghiệm” → dùng **Δ ≥ 0** để tìm giới hạn y!

---

## ✅ PHẦN 4: MẸO TỔNG HỢP — NHỚ LÀNH MẠCH

| Loại hàm | Tập giá trị thường gặp |
|----------|------------------------|
| `y = ax + b` (x ∈ ℝ) | `ℝ` |
| `y = ax + b` (x ∈ [a;b]) | `[min; max]` (thay biên) |
| `y = ax² + bx + c` (a > 0) | `[y_min; +∞)` |
| `y = ax² + bx + c` (a < 0) | `(-∞; y_max]` |
| `y = 1/x` | `ℝ \ {0}` |
| `y = √(f(x))` | `[0; +∞)` hoặc `[min; max]` tùy f(x) |
| `y = |f(x)|` | `[0; +∞)` |
| `y = sinx`, `cosx` | `[-1; 1]` |
| `y = tanx` | `ℝ` |
| `y = f(g(x))` | Tìm tập giá trị g(x) → áp dụng f |
| Phân thức phức | Dùng Δ ≥ 0 để tìm giới hạn y |

> 💬 **Mẹo nhớ nhanh**:  
> *“Không cần nhớ công thức — chỉ cần hỏi: ‘y là kết quả của phép toán gì?’ — nó có bị giới hạn tự nhiên không?”*

---

## 🎯 BONUS: QUY TRÌNH 4 BƯỚC TÌM TẬP GIÁ TRỊ (SIÊU DỄ!)

1. **Xác định tập xác định** của x  
2. **Phân tích biểu thức y** — thuộc dạng nào? (bậc 2? căn? phân thức?)  
3. **Dùng tính chất đặc trưng**  
   - Căn ≥ 0  
   - Giá trị tuyệt đối ≥ 0  
   - Sin/Cos ∈ [-1;1]  
   - Phân thức ≠ 0 nếu tử ≠ 0  
4. **Nếu phức tạp → đặt ẩn phụ hoặc dùng Δ ≥ 0**

> ✅ **Ghi nhớ**: Tập giá trị = “Những con số y **có thể xảy ra**”

---

## 🧠 LUYỆN TẬP NGAY — 5 BÀI TỰ GIẢI (CÓ ĐÁP ÁN ẨN)

Em thử làm rồi gửi lại anh/chị nhé — anh/chị sẽ sửa chi tiết như đang dạy em ở bàn học!

1. `y = 2x + 5`, `x ∈ [-1; 3]` → tập giá trị?  
2. `y = x² - 4x + 3` → tập giá trị?  
3. `y = √(x + 1)` → tập giá trị?  
4. `y = (x + 1)/(x - 2)` → tập giá trị?  
5. `y = sin²x + 2` → tập giá trị?

### 💡 Gợi ý nhanh:
- **Bài 1**: Thay x=-1 → y=3; x=3 → y=11 → `[3;11]`
- **Bài 2**: Đỉnh tại x=2 → y=-1 → `[-1; +∞)`
- **Bài 3**: Căn → y≥0; x≥-1 → y∈[0;+∞)
- **Bài 4**: Dùng Δ ≥ 0 → kết quả: `ℝ \ {1}`
- **Bài 5**: `sin²x ∈ [0;1]` → `y ∈ [2;3]`

---

## 🌟 KẾT LUẬN — EM ĐÃ NẮM TRỌN TOÀN BỘ!

> ✅ Từ **hàm đơn giản** đến **hàm phức tạp**  
> ✅ Từ **lớp 7** đến **lớp 11**  
> ✅ Từ **ví dụ đời thường** đến **đề thi chuyên**

Anh/chị tin rằng giờ đây, em có thể:
- Giải mọi bài tập trong sách giáo khoa  
- Tự tin làm đề thi học kỳ, kiểm tra 15 phút, thậm chí đề chuyên  
- Hiểu sâu bản chất — **không còn học vẹt!**

---

## 🚀 BONUS CHO EM!

Bạn muốn:
- [ ] **File PDF in ra học** (đã định dạng đẹp, có header/footer)  
- [ ] **Bộ bài tập trắc nghiệm 50 câu** (theo level: Dễ – Trung – Khó)  
- [ ] **Video minh họa từng dạng** (giải thích bằng hình ảnh, animation)  
- [ ] **Phiếu ôn tập in A4** (dành cho học sinh tự học)

👉 **Chỉ cần nhắn một dòng**:  
> **“Anh/chị ơi, cho em file PDF”**  
> hoặc  
> **“Cho em bài tập luyện”**

→ Anh/chị sẽ gửi ngay trong 5 phút! 💪📚

---

🎉 **Cố lên em yêu! Mỗi lần em làm được một bài là một bước tiến to lớn rồi đó!**  
✨ *Học toán không phải để thi — mà để hiểu thế giới vận hành như thế nào.*  
-  *Giải Toán Siêu Dễ -master toán ngôn ngữ dễ hiểu tự nhiên*