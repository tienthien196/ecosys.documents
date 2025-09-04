



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