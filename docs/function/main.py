import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# ========================
# 1. Thiết lập tham số
# ========================
fs = 200          # Tần số lấy mẫu (giảm để animation mượt hơn)
T = 5             # Thời gian mô phỏng (giây)
t = np.linspace(0, T, int(fs * T), endpoint=False)
s = np.exp(-0.3 * t) * np.sin(2 * np.pi * 2 * t)  # s(t) = e^{-0.3t} sin(4πt)

# Đạo hàm giải tích (để so sánh)
s_prime_exact = (-0.3 * np.exp(-0.3 * t) * np.sin(2 * np.pi * 2 * t) +
                 np.exp(-0.3 * t) * (4 * np.pi) * np.cos(2 * np.pi * 2 * t))

# ========================
# 2. Chuẩn bị figure và subplot
# ========================
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), sharex=True)

# Trục 1: Tín hiệu + cát tuyến
ax1.set_title('Động quá trình tính đạo hàm: Cát tuyến → Hệ số góc')
ax1.set_ylabel('s(t)')
ax1.grid(True, alpha=0.3)
ax1.set_xlim(0, T)
ax1.set_ylim(-1.2, 1.2)

line_s, = ax1.plot([], [], 'b-', linewidth=2, label='s(t)')
line_secant, = ax1.plot([], [], 'r--', linewidth=1.5, label='Cát tuyến (s(i+1)-s(i))')
point_current, = ax1.plot([], [], 'ro', markersize=6, label='Điểm hiện tại')
point_next, = ax1.plot([], [], 'go', markersize=6, label='Điểm kế tiếp')

# Trục 2: Đạo hàm đang được xây dựng dần
ax2.set_title('Đạo hàm s\'(t) được tính dần theo thời gian')
ax2.set_xlabel('Thời gian t (s)')
ax2.set_ylabel("s'(t)")
ax2.grid(True, alpha=0.3)
ax2.set_xlim(0, T)
ax2.set_ylim(-8, 8)

line_ds_dt, = ax2.plot([], [], 'r-', linewidth=2, label="s'(t) - Gradient")
line_exact, = ax2.plot(t, s_prime_exact, 'g--', linewidth=1.5, label="s'(t) - Giải tích")

ax1.legend(loc='upper right')
ax2.legend(loc='upper right')

plt.tight_layout()

# ========================
# 3. Hàm khởi tạo animation
# ========================
def init():
    line_s.set_data([], [])
    line_secant.set_data([], [])
    point_current.set_data([], [])
    point_next.set_data([], [])
    line_ds_dt.set_data([], [])
    return line_s, line_secant, point_current, point_next, line_ds_dt

# ========================
# 4. Hàm cập nhật animation
# ========================
def animate(i):
    if i >= len(t) - 1:
        return line_s, line_secant, point_current, point_next, line_ds_dt

    # Cập nhật tín hiệu s(t) đến thời điểm i
    line_s.set_data(t[:i+1], s[:i+1])

    # Vẽ cát tuyến từ điểm i đến i+1
    x_secant = [t[i], t[i+1]]
    y_secant = [s[i], s[i+1]]
    line_secant.set_data(x_secant, y_secant)

    # Vẽ điểm hiện tại và điểm kế tiếp
    point_current.set_data([t[i]], [s[i]])
    point_next.set_data([t[i+1]], [s[i+1]])

    # Tính đạo hàm tại điểm i: (s[i+1] - s[i]) / dt
    dt = 1/fs
    ds_dt_val = (s[i+1] - s[i]) / dt

    # Cập nhật đồ thị đạo hàm (chỉ đến điểm i)
    t_ds = t[:i+1]
    ds_dt_vals = [(s[j+1] - s[j]) / dt for j in range(i+1)]  # Dùng diff đơn giản
    line_ds_dt.set_data(t_ds, ds_dt_vals)

    return line_s, line_secant, point_current, point_next, line_ds_dt

# ========================
# 5. Tạo animation
# ========================
anim = FuncAnimation(fig, animate, frames=len(t)-1, init_func=init,
                     interval=50, blit=True, repeat=False)

# ========================
# 6. Hiển thị hoặc lưu animation
# ========================
plt.suptitle('🎬 Động quá trình tính đạo hàm s\'(t) bằng sai phân hữu hạn', fontsize=14)
plt.show()

# 🔽 Nếu muốn lưu thành video (uncomment nếu có ffmpeg):
# anim.save('dao_ham_dong.mp4', writer='ffmpeg', fps=20, dpi=100)