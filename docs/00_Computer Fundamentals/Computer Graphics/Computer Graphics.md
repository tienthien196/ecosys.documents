---
title: Computer Graphics
sidebar_position: 1
---


```
==========================================================================================================
             ĐỒ HỌA MÁY TÍNH TOÀN DIỆN – BẢN CHẤT TỪ 3D MODEL ĐẾN PIXEL TRÊN MÀN HÌNH
==========================================================================================================

+---------------------------------------------------------------------------------------------------------+
|                                         APPLICATION (User Code)                                         |
|                                                                                                         |
|   // Ví dụ: OpenGL / Vulkan / Unity / Unreal Engine                                                     |
|   glVertex3f(0.0, 1.0, 0.0);  // Đỉnh tam giác                                                          |
|   glColor3f(1.0, 0.0, 0.0);   // Màu đỏ                                                                  |
|   drawMesh(model);            // Vẽ mô hình 3D                                                           |
|                                                                                                         |
|  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐  |
|  │        High-level API: OpenGL, DirectX, Vulkan, WebGL, Metal (Apple)                           │  |
|  └─────────────────────────────────────────────────────────────────────────────────────────────────┘  |
|                                                                                                         |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Graphics API Call)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                      GRAPHICS DRIVER (Kernel/OS)                                        |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  |   OpenGL / Vulkan    |     |   System Call        |     |   GPU Driver                |           |
|  |   Runtime Library    | --> |   (syscall)          | --> |   (NVIDIA, AMD, Intel)      |           |
|  |   (User Space)       |     |                      |     |   (Kernel Module)           |           |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|                                                                                                         |
|  ✅ Chuyển lệnh đồ họa từ ứng dụng → GPU                                                                 |
|  ✅ Quản lý context, bộ nhớ, đồng bộ hóa                                                               |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Command Buffer → GPU)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                           GPU PIPELINE (Hardware)                                       |
|                                                                                                         |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  |   VERTEX SHADER      |     |   TESSELLATION       |     |   GEOMETRY SHADER             |           |
|  | - Xử lý từng đỉnh     | --> |   (Optional)         | --> |   (Optional)                  |           |
|  | - Transform:          |     | - Chia nhỏ primitive |     | - Tạo/sửa geometry            |           |
|  |   Model → World →     |     |   (patch, triangle)  |     |   (vd: tạo cỏ, tia lửa)       |
|  |   View → Clip Space   |     |                      |     |                               |
|  +----------+-----------+     +----------+-----------+     +---------------+---------------+           |
|            |                            |                                 |                           |
|            v                            v                                 v                           |
|  +---------------------------------------------------------------------------------------------+      |
|  |                                PRIMITIVE ASSEMBLY & CLIPPING                                |      |
|  | - Gom đỉnh thành primitive (tam giác, line, point)                                          |      |
|  | - Cắt (clip) nếu ngoài vùng nhìn (view frustum)                                             |      |
|  +---------------------------------------------------------------------------------------------+      |
|                                          |                                                            |
|                                          v                                                            |
|  +----------------------+     +----------------------+     +-------------------------------+           |
|  |   RASTERIZATION      | --> |   FRAGMENT SHADER    | --> |   TEXTURE SAMPLING            |           |
|  | - Chuyển thành pixel  |     | - Xử lý từng pixel   |     | - Lấy màu từ texture          |           |
|  |   (scan conversion)   |     |   (fragment)         |     | - Filtering: nearest, bilinear|           |
|  | - Interpolate:        |     | - Tính màu cuối cùng |     |   trilinear, anisotropic      |           |
|  |   position, color, UV |     |   (phong, normal map)|     |                               |           |
|  +----------+-----------+     +----------+-----------+     +-------------------------------+           |
|            |                            |                                 |                           |
|            +----------------------------+---------------------------------+                           |
|                                         |                                                            |
|                                         v                                                            |
|  +---------------------------------------------------------------------------------------------+      |
|  |                                   PER-FRAGMENT OPERATIONS                                 |      |
|  | - Depth Test (Z-Buffer): chỉ giữ pixel gần nhất                                            |      |
|  | - Stencil Test: mask vùng vẽ (bóng, reflection)                                            |      |
|  | - Blending: alpha transparency (giao nhau)                                                 |      |
|  | - Dithering: giảm banding                                                                |      |
|  +---------------------------------------------------------------------------------------------+      |
|                                         |                                                            |
|                                         v                                                            |
|  +----------------------+                                                                      |
|  |   FRAMEBUFFER        | <--------------------------------------------------------------------+
|  | - Color Buffer       |                                                                      |
|  | - Depth Buffer (Z)   |                                                                      |
|  | - Stencil Buffer     |                                                                      |
|  +----------------------+                                                                      |
+---------------------------------------------------------------------------------------------------------+
                                          |
                                          | (Swap Buffers – Double Buffering)
                                          v
+---------------------------------------------------------------------------------------------------------+
|                                          DISPLAY OUTPUT                                                 |
|                                                                                                         |
|  +---------------------+     +----------------------+     +-------------------------------+           |
|  |   Back Buffer       | --> |   Front Buffer       | --> |   MONITOR (VGA, HDMI, DP)     |           |
|  | (Rendering)         |     | (Displayed)          |     |                               |           |
|  |                     |     |                      |     |  Refresh Rate: 60Hz, 144Hz... |           |
|  | double/triple       |     | vsync → avoid tearing|     |  Pixel: RGB subpixel          |           |
|  | buffering           |     |                      |     |                               |           |
|  +---------------------+     +----------------------+     +-------------------------------+           |
|                                                                                                         |
|  ✅ V-Sync: đồng bộ với tần số quét màn hình để tránh xé hình (tearing)                                 |
+---------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Data Flow)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          3D DATA FLOW & MEMORY LAYOUT                                        |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   CPU (Main Memory)  |     |   GPU Memory (VRAM)  |     |   Texture / Shader Storage    |                   |
|  |                      | --> |                      | --> |                               |                   |
|  | - Model: vertices,   | DMA | - Vertex Buffer      |     | - .dds, .ktx (texture)        |                   |
|  |   normals, UVs       |     | - Index Buffer       |     | - .glsl, .hlsl (shader)       |                   |
|  | - Animation data     |     | - Uniforms (MVP)     |     |                               |                   |
|  |                      |     | - Framebuffer        |     |                               |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|                                                                                                                  |
|  ✅ DMA: GPU tự sao chép dữ liệu từ RAM → VRAM (không qua CPU)                                                   |
+------------------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Math & Transformation)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          3D MATHEMATICS & PIPELINE                                           |
|                                                                                                                  |
|  Model Space → World Space → View Space → Clip Space → NDC → Window Space                                        |
|                                                                                                                  |
|  [Model] → × Model Matrix → [World] → × View Matrix → [Camera] → × Projection → [Clip] → Perspective Divide → [NDC] → Viewport Transform → [Screen]  
|                                                                                                                  |
|  - MVP = Model × View × Projection (gửi vào shader qua Uniform)                                                   |
|  - NDC: Normalized Device Coordinates (-1 → 1)                                                                   |
|  - Viewport: ánh xạ NDC → pixel (0 → width, 0 → height)                                                          |
+------------------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Advanced Techniques)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          MODERN GRAPHICS TECHNIQUES                                            |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   SHADING MODELS     |     |   GLOBAL ILLUMINATION|     |   POST-PROCESSING             |                   |
|  | - Phong, Blinn-Phong  |     | - Ray Tracing        |     | - Bloom, DOF, SSAO, FXAA      |                   |
|  | - PBR (Physically     |     | - Path Tracing       |     | - HDR, Tone Mapping           |                   |
|  |   Based Rendering)    |     | - Ambient Occlusion  |     | - Motion Blur                 |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|                                                                                                                  |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
|  |   MESH PROCESSING    |     |   ANIMATION          |     |   COMPUTE SHADERS             |                   |
|  | - LOD (Level of Detail|     | - Skinning,          |     | - GPGPU: physics, AI,         |                   |
|  | - Instancing         |     |   keyframe,          |     |   image processing            |                   |
|  | - Culling (frustum,  |     |   morph targets      |     |                               |                   |
|  |   occlusion)         |     |                      |     |                               |                   |
|  +----------------------+     +----------------------+     +-------------------------------+                   |
+------------------------------------------------------------------------------------------------------------------+

                                                                 ^
                                                                 | (Real-Time vs Offline)
                                                                 |
+------------------------------------------------------------------------------------------------------------------+
|                                          RENDERING PARADIGMS                                                   |
|                                                                                                                  |
|  +-----------------------------+                                 +------------------------------------+         |
|  |   REAL-TIME RENDERING       |                                 |   OFFLINE RENDERING (Ray Tracing)  |         |
|  | - Game Engine (Unity, UE)   |                                 | - Blender Cycles, Arnold, V-Ray    |         |
|  | - 30–120 FPS                |                                 | - Không realtime (giờ → ngày)      |         |
|  | - Rasterization-based       |                                 | - Tính chính xác ánh sáng, phản xạ |         |
|  | - Tối ưu hiệu suất          |                                 | - Dùng trong phim, quảng cáo       |         |
|  +-----------------------------+                                 +------------------------------------+         |
+------------------------------------------------------------------------------------------------------------------+
```
---

GHI CHÚ:
- **Vertex Shader**: Chạy trên mỗi đỉnh → chuyển đổi vị trí, truyền dữ liệu khác (màu, UV)
- **Fragment Shader**: Còn gọi là Pixel Shader → tính màu cuối cùng của mỗi pixel
- **Z-Buffer (Depth Buffer)**: Lưu độ sâu → đảm bảo vật gần che vật xa
- **Double Buffering**: Vẽ ở back buffer → swap khi xong → tránh nhấp nháy
- **V-Sync**: Đồng bộ với tần số màn hình → tránh tearing
- **PBR**: Dùng albedo, roughness, metalness map → vật liệu thực tế
- **Compute Shader**: Không để vẽ, mà để tính toán (physics, AI, post-process)
- **Ray Tracing**: Tính ánh sáng chính xác hơn → nhưng chậm → cần RTX, Vulkan RT
- **APIs**: OpenGL (cross-platform), DirectX (Windows), Vulkan/Metal (hiệu suất cao)
- **GPU VRAM**: Bộ nhớ siêu nhanh, riêng cho đồ họa → càng nhiều → texture càng lớn



---
```
                      ┌──────────────────────┐
                      │   COMPUTER GRAPHICS  │
                      └──────────────────────┘
                                 │
         ┌───────────────────────┼────────────────────────┐
         ▼                       ▼                        ▼
   [1] Graphics Pipeline   [2] Core Concepts       [3] Rendering Techniques
         │                       │                        │
         ├─▶ 3D Pipeline         ├─▶ Coordinate Systems    ├─▶ Rasterization
         │   ├─ Model            │   ├─ Object Space      ├─▶ Ray Tracing
         │   ├─ View (Camera)    │   ├─ World Space        ├─▶ Path Tracing
         │   ├─ Projection       │   ├─ View Space         ├─▶ Global Illumination
         │   ├─ Clip             │   ├─ Clip/Screen Space  └─▶ Real-time vs Offline
         │   ├─ Rasterize        │   └─ NDC (Normalized)
         │   └─ Fragment (Pixel) │
         │                       ├─▶ Color & Light         [4] GPU & APIs
         │                       │   ├─ RGB, Alpha         │
         │                       │   ├─ Lighting Models    ├─▶ OpenGL
         │                       │   │  ├─ Ambient         ├─▶ Vulkan
         │                       │   │  ├─ Diffuse         ├─▶ DirectX
         │                       │   │  └─ Specular        ├─▶ Metal
         │                       │   └─ Textures           └─▶ Shaders (Vertex/Fragment)
         │                       │
         │                       └─▶ Transformations
         │                           ├─ Translation
         │                           ├─ Rotation
         │                           ├─ Scaling
         │                           └─ Matrices (4x4)
         │
   [5] 2D vs 3D Graphics
         ├─▶ 2D: Sprites, UI, Canvas, Orthographic
         └─▶ 3D: Meshes, Cameras, Perspective, Depth

         │
         ▼
   [6] Applications
         ├─▶ Game Engines (Unreal, Godot, Unity)
         ├─▶ 3D Modeling (Blender, Maya)
         ├─▶ VFX & Animation
         ├─▶ VR/AR
         └─▶ Scientific Visualization
```


## 1. COMPUTER GRAPHICS  
### 1.1. Graphics Pipeline  
- Application Stage  
  - CPU xử lý: input, animation, physics, scene management  
- Geometry Stage  
  - Vertex Processing (Vertex Shader)  
  - Projection (Perspective / Orthographic)  
  - Clipping (frustum culling)  
  - Screen Mapping (viewport transform)  
- Rasterization Stage  
  - Triangle Setup  
  - Fragment Processing (Fragment Shader)  
  - Depth Test (Z-buffer)  
  - Blending (alpha, transparency)  
- Output Merging  
  - Ghi kết quả vào Framebuffer  

### 1.2. Coordinate Systems  
- Object Space → World Space → View Space → Clip Space → NDC → Screen Space  
- Transformations:  
  - Model Matrix: Object → World  
  - View Matrix: World → Camera (LookAt)  
  - Projection Matrix: 3D → 2D (FOV, aspect, near/far)  
  - MVP = Projection × View × Model  

### 1.3. Rendering Techniques  
- Rasterization (real-time): Dùng trong game, GPU  
- Ray Tracing (offline/real-time): Chính xác, bóng thật, phản xạ  
- Path Tracing: Mô phỏng ánh sáng tự nhiên  
- Global Illumination (GI): Bounced light, ambient occlusion  
- Forward vs Deferred Rendering  
- Real-time vs Offline Rendering  

### 1.4. Lighting & Shading  
- Lighting Models:  
  - Ambient: Ánh sáng nền  
  - Diffuse: Phản xạ đều (Lambert)  
  - Specular: Phản xạ gương (Phong, Blinn-Phong)  
- Shading Techniques:  
  - Flat Shading  
  - Gouraud Shading (vertex interpolation)  
  - Phong Shading (per-pixel)  
- PBR (Physically Based Rendering):  
  - Albedo, Normal, Metallic, Roughness maps  
  - Energy conservation, Fresnel, microfacets  

### 1.5. Textures & Materials  
- Texture Mapping: UV coordinates (0–1)  
- Types:  
  - Diffuse, Normal, Specular, Emission, Height, Occlusion  
- Filtering:  
  - Nearest, Bilinear, Trilinear, Anisotropic  
- Mipmapping: Giảm aliasing khi xa  
- UV Unwrapping: Mapping 3D → 2D  

### 1.6. Cameras  
- Types:  
  - Perspective (FOV, depth)  
  - Orthographic (2D, UI)  
- Parameters:  
  - Position, Target, Up vector  
  - Near/Far plane, Aspect ratio  
- View Frustum: Volume nhìn thấy (culling)  
- Projection Matrix:  
  - Perspective: glm::perspective()  
  - Orthographic: glm::ortho()  

### 1.7. GPU & Graphics APIs  
- APIs:  
  - OpenGL (cross-platform, older)  
  - Vulkan (low-level, high performance)  
  - DirectX (Windows, Xbox)  
  - Metal (Apple)  
- Shaders:  
  - Vertex Shader: Xử lý đỉnh  
  - Fragment (Pixel) Shader: Xử lý màu pixel  
  - Geometry / Compute Shaders (tùy chọn)  
- Pipeline State:  
  - Blending, Depth Test, Culling, Stencil  

### 1.8. 2D vs 3D Graphics  
- 2D:  
  - Canvas, UI, sprites  
  - Orthographic projection  
  - No depth (or Z-index)  
- 3D:  
  - Meshes, cameras, lighting  
  - Perspective projection  
  - Depth buffer, normals, materials  

### 1.9. Optimization & Culling  
- Frustum Culling: Loại bỏ ngoài tầm nhìn  
- Occlusion Culling: Không render vật bị che  
- Level of Detail (LOD): Dùng model đơn giản khi xa  
- Instancing: Vẽ nhiều object giống nhau nhanh hơn  
- Batching: Giảm draw calls (static, dynamic batching)  

### 1.10. Applications  
- Game Engines: Unreal, Unity, Godot  
- 3D Modeling: Blender, Maya, 3ds Max  
- VFX & Animation: Pixar, Unreal Engine films  
- VR/AR: Oculus, HoloLens  
- Scientific Visualization: Medical imaging, simulations  

---

:::note Computer Graphics
Computer graphics is the field of generating visual content using computers. It involves creating, manipulating, and 
rendering images and models in both 2D and 3D. At its core, it transforms mathematical descriptions of geometry, lighting, 
and materials into pixel-based images displayed on screen.

Key components:
- **Rendering Pipeline**: The sequence from 3D scene to 2D image.
- **GPU**: Specialized processor for parallel graphics computation.
- **Shaders**: Programs that run on GPU to control vertex and pixel behavior.
- **Textures & Materials**: Define surface appearance.
- **Lighting Models**: Simulate how light interacts with surfaces.

Modern graphics relies on:
- **Real-time rendering** for games and interactive apps.
- **Physically Based Rendering (PBR)** for photorealism.
- **Ray tracing** for accurate lighting (now in real-time with RTX).

Computer graphics bridges art and science, enabling everything from UI design to blockbuster movies and virtual worlds.
:::

## Formulas
```

                        COMPUTER GRAPHICS
                                 |
        ---------------------------------------------------------
        |                        |                              |
    RENDERING PIPELINE       LIGHTING & COLOR             TEXTURES & MATERIALS
        |                        |                              |
   ---------------       -------------------         ---------------------
   |      |      |       |        |        |         |         |         |
Vertex  Raster  Output  Ambient  Diffuse  Specular   UV Map   Mipmap   Normal Map
Shader  Stage   Blending  Light    Light    Light     Filtering  LOD     PBR Maps
        |               (Phong / Blinn-Phong)
        |
     TRANSFORMATIONS
        |
   ---------------------
   |         |         |
Model    View     Projection
Matrix   Matrix     Matrix
         |
      CAMERA & VIEW
         |
   ---------------------
   |         |         |
Perspective  Ortho   Frustum
Projection  Project   Culling
```
1. **MVP Transformation**  
   $$
   \vec{v}_{clip} = \mathbf{P} \times \mathbf{V} \times \mathbf{M} \times \vec{v}_{model}
   $$

2. **Phong Lighting Model**  
   $$
   I = I_{\text{ambient}} + I_{\text{diffuse}} + I_{\text{specular}}
   $$
   $$
   I_{\text{diffuse}} = k_d \cdot (\vec{L} \cdot \vec{N}) \cdot I_{\text{light}}
   $$
   $$
   I_{\text{specular}} = k_s \cdot (\vec{R} \cdot \vec{V})^n \cdot I_{\text{light}}
   $$

3. **Field of View (FOV) to Projection**  
   $$
   \text{top} = \tan\left(\frac{\text{FOV}}{2}\right) \times \text{near}
   $$
   $$
   \text{aspect} = \frac{\text{width}}{\text{height}}
   $$

4. **Mipmap Level (LOD)**  
   $$
   \text{LOD} = \log_2\left(\max\left(\frac{\partial u}{\partial x}, \frac{\partial v}{\partial y}\right) \times \text{texture\_size}\right)
   $$

5. **Frame Rate (FPS)**  
   $$
   \text{FPS} = \frac{1}{\text{Frame Time (seconds)}}
   $$

6. **Draw Calls & Batching**  
   $$
   \text{Batched Objects} = \frac{\text{Total Objects}}{\text{Average Batch Size}}
   $$
   Lower draw calls → better performance.

7. **Z-Buffer Depth Value**  
   $$
   z_n = \frac{z_v (f + n) + 2fn}{z_v (f - n)}
   $$
   where \( z_v \) = view space depth, \( n \)=near, \( f \)=far.

---

## Rules of Thumb

### The 90/10 Rule (Rendering)
> 90% of rendering time is spent on 10% of the scene — optimize draw calls and overdraw.

### GPU Fill Rate Rule
> If your game is GPU-bound, it's often due to **too many fragments** (overdraw), not triangles.

### Texture Size Rule
> Never use texture larger than needed. A 4K texture on a small UI element wastes memory and bandwidth.

### The 300 Draw Calls Limit
> For real-time games on average hardware, aim for **< 300 draw calls/frame** to maintain 60 FPS.

### LOD Rule
> Use at least 3 LOD levels for complex models visible at varying distances.

### Alpha Blending Cost
> Transparent objects are expensive: they disable depth optimization and require sorting.

### Vulkan vs OpenGL
> Vulkan gives 10–20% better performance but takes 3–5x more code. Use only when necessary.

### PBR Material Rule
> In PBR, **specular is controlled by metalness**, not a separate map. Dielectrics use fixed F0 (~0.04).