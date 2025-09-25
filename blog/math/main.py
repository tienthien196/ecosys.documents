import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# --- 1. Thiết lập bản đồ và mục tiêu ---
start_pos = np.array([1.0, 1.0])   # Vị trí bắt đầu của AI
treasure_pos = np.array([8.0, 6.0]) # Vị trí kho báu 💎
obstacles = [
    np.array([3.0, 4.0]),
    np.array([5.0, 2.0]),
    np.array([6.0, 5.0]),
]  # Danh sách chướng ngại vật

# --- 2. Định nghĩa HÀM CHI PHÍ (cost function) ---
# AI muốn: 
# - Gần kho báu → cost giảm
# - Xa vật cản → cost giảm
# → Tối ưu: cost càng nhỏ càng tốt!

def cost_function(pos):
    pos = np.array(pos)
    cost = 0.0
    
    # Chi phí 1: Khoảng cách đến kho báu (càng gần → càng tốt)
    dist_to_treasure = np.linalg.norm(pos - treasure_pos)
    cost += dist_to_treasure * 2.0  # hệ số 2 để ưu tiên kho báu
    
    # Chi phí 2: Tránh vật cản — càng gần vật cản → cost tăng mạnh
    for obs in obstacles:
        dist_to_obs = np.linalg.norm(pos - obs)
        if dist_to_obs < 1.5:  # chỉ tính nếu ở gần
            cost += 10.0 / (dist_to_obs + 0.1)  # +0.1 tránh chia 0
    
    return cost

# --- 3. Tính GRADIENT của hàm chi phí (đạo hàm riêng theo x, y) ---
# Dùng xấp xỉ đạo hàm số (numerical gradient) — dễ hiểu, không cần công thức!

def gradient(pos, h=1e-5):
    pos = np.array(pos, dtype=float)
    grad = np.zeros_like(pos)
    
    for i in range(len(pos)):
        pos_step = pos.copy()
        pos_step[i] += h
        grad[i] = (cost_function(pos_step) - cost_function(pos)) / h
    
    return grad

# --- 4. AI học bằng GRADIENT DESCENT ---
current_pos = start_pos.copy()
learning_rate = 0.05
max_steps = 300
path = [current_pos.copy()]
costs = [cost_function(current_pos)]

for step in range(max_steps):
    grad = gradient(current_pos)
    current_pos = current_pos - learning_rate * grad  # đi ngược gradient → giảm cost!
    path.append(current_pos.copy())
    costs.append(cost_function(current_pos))
    
    # Dừng nếu gần kho báu
    if np.linalg.norm(current_pos - treasure_pos) < 0.3:
        print(f"🎉 AI đã tìm thấy kho báu sau {step + 1} bước!")
        break

# --- 5. Vẽ hoạt ảnh quá trình AI tìm đường ---
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))

# Chuẩn bị vẽ
x_grid = np.linspace(0, 10, 100)
y_grid = np.linspace(0, 8, 80)
X, Y = np.meshgrid(x_grid, y_grid)
Z = np.zeros_like(X)

# Tính cost cho từng điểm trên lưới (để vẽ nền nhiệt)
for i in range(X.shape[0]):
    for j in range(X.shape[1]):
        Z[i, j] = cost_function([X[i, j], Y[i, j]])

def animate(frame):
    ax1.clear()
    ax2.clear()
    
    # --- Vẽ bản đồ + AI + kho báu + vật cản ---
    # Nền nhiệt: cost function
    contour = ax1.contourf(X, Y, Z, levels=50, cmap='plasma', alpha=0.7)
    if frame == 0:
        plt.colorbar(contour, ax=ax1, label='Cost (nhiệt độ: càng đỏ → càng nguy hiểm)')
    
    # Vật cản
    for obs in obstacles:
        ax1.plot(obs[0], obs[1], 'ks', markersize=12, label='Vật cản' if obs is obstacles[0] else "")
    
    # Kho báu
    ax1.plot(treasure_pos[0], treasure_pos[1], 'y*', markersize=20, label='Kho báu 💎')
    
    # Vẽ đường đi của AI đến bước hiện tại
    path_so_far = np.array(path[:frame+1])
    ax1.plot(path_so_far[:, 0], path_so_far[:, 1], 'b-', linewidth=2, label='Đường đi AI')
    ax1.plot(path_so_far[-1, 0], path_so_far[-1, 1], 'bo', markersize=10, label='Vị trí hiện tại AI')
    
    ax1.set_xlim(0, 10)
    ax1.set_ylim(0, 8)
    ax1.set_title(f'🤖 AI tìm kho báu — Bước {frame} (Cost: {costs[frame]:.2f})', fontsize=14)
    ax1.legend()
    ax1.grid(True, alpha=0.3)
    ax1.set_aspect('equal')
    
    # --- Vẽ đồ thị cost theo thời gian ---
    ax2.plot(range(len(costs)), costs, 'r-', linewidth=2, label='Cost theo bước')
    ax2.plot(frame, costs[frame], 'ro', markersize=8)
    ax2.set_title('📉 Cost giảm dần → AI đang học tốt!', fontsize=14)
    ax2.set_xlabel('Bước')
    ax2.set_ylabel('Cost')
    ax2.legend()
    ax2.grid(True)

# Tạo animation
ani = FuncAnimation(fig, animate, frames=len(path), interval=100, repeat=False)

plt.tight_layout()
plt.show()