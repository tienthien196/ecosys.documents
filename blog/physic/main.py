import pyperclip  # Cài bằng: pip install pyperclip

# Định nghĩa các ký tự Unicode cần thiết
def format_subscript(text):
    """Chuyển đổi _abc thành abc dưới dạng subscript"""
    sub_map = {
        '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄', '5': '₅',
        '6': '₆', '7': '₇', '8': '₈', '9': '₉', 'a': 'ₐ', 'b': '♭',
        'c': 'ꜰ', 'd': '𝒹', 'e': 'ₑ', 'f': '𝒻', 'g': '𝓰', 'h': 'ₕ',
        'i': 'ᵢ', 'j': 'ⱼ', 'k': 'ₖ', 'l': 'ₗ', 'm': 'ₘ', 'n': 'ₙ',
        'o': 'ₒ', 'p': 'ₚ', 'q': 'ԛ', 'r': 'ᵣ', 's': 'ₛ', 't': 'ₜ',
        'u': 'ᵤ', 'v': 'ᵥ', 'w': 'ʷ', 'x': 'ₓ', 'y': 'ᵧ', 'z': '₂'
    }
    result = ""
    i = 0
    while i < len(text):
        if text[i] == '_' and i + 1 < len(text):
            # Tìm chuỗi sau _
            j = i + 1
            while j < len(text) and text[j].isalnum():
                j += 1
            substr = text[i+1:j]
            # Thay thế từng ký tự
            converted = ""
            for char in substr:
                if char in sub_map:
                    converted += sub_map[char]
                else:
                    converted += char.lower()  # fallback
            result += converted
            i = j
        else:
            result += text[i]
            i += 1
    return result

# Hàm thay thế * bằng ×
def replace_mul(text):
    return text.replace('*', '×')

# Nội dung chính
content = """
Bậc tự do cơ cấu được tính theo công thức:
W = 3n - (2P_5 + P_4) + r_th - W_th
= 3 * 9 - (2 * 13 + 0) + 0 - 0 = 1

Chọn khâu 1 là khâu dẫn, nhóm tĩnh định được tách ra bao gồm 4 nhóm loại 2 (6,9; 7,8; 2,3; 4,5) như hình 1.1a.a. Đây là cơ cấu loại 2.

Công thức cấu tạo cơ cấu: 1 = 1 + 0 + 0 + 0 + 0

---

Bậc tự do cơ cấu được tính theo công thức:
W = 3n - (2P_5 + P_4) + r_th - W_th
= 3 * 11 - (2 * 16 + 0) + 0 - 0 = 1

Chọn khâu 1 là khâu dẫn, nhóm tĩnh định được tách ra bao gồm 1 nhóm loại 2 (2,3) và 2 nhóm loại 3 (4,5,6,7; 8,9,10,11) như hình 1.1b.b. Đây là cơ cấu loại 3.

Công thức cấu tạo cơ cấu: 1 = 1 + 0 + 0 + 0
"""

# Xử lý nội dung
processed_content = replace_mul(content)
processed_content = processed_content.replace('P_5', 'P₅')
processed_content = processed_content.replace('P_4', 'P₄')
processed_content = processed_content.replace('r_th', 'rₜₕ')
processed_content = processed_content.replace('W_th', 'Wₜₕ')

# In ra màn hình
print(processed_content)

# Copy vào clipboard (tùy chọn)
pyperclip.copy(processed_content)
print("\n✅ Đã sao chép vào clipboard!")