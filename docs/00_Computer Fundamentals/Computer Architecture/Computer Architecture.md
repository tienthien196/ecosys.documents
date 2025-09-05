---
sidebar_position: 4
sidebar_label: Computer Architecture
---

# Computer Architecture
---

```
==========================================================================================================
                  KIẾN TRÚC MÁY TÍNH TOÀN DIỆN – BẢN CHẤT TỪ PHẦN CỨNG ĐẾN PHẦN MỀM
==========================================================================================================

+---------------------+     +----------------------------+
|                     |     |                            |
|   Input Devices     |<--->|       I/O Controller       |
| (Keyboard, Mouse,   | IRQ | (USB, SATA, PCIe, Network) |
|  Webcam, Scanner)   |---->|                            |
|                     |     +-------------+--------------+
+---------------------+                   |  System I/O Bus
                                          |
+---------------------+                   |                   +---------------------+
|                     |     +-----------------------------+   |                     |
|   Output Devices    |<--->|         GPU (Graphics       |<->|    Display /        |
| (Monitor, Printer,  | Bus |       Processing Unit)      |   |    Audio Devices    |
|  Speakers)          |<--->|                             |   |                     |
|                     |     +-----------------------------+   +---------------------+
|                     |                   |  PCIe / HDMI / DP
+---------------------+                   |
                                          |
                                          | PCIe / DMI
                                          v
                                +----------------------+
                                |       CPU CORE       |
                                | +------------------+ |
                                | |  Instruction     | |
                                | |    Fetch (IF)    | | ← Lấy lệnh từ L1i
                                | +--------+---------+ |
                                |          |           |
                                | +--------v---------+ |
                                | |  Decode (ID)     | | ← Giải mã → µops
                                | +--------+---------+ |
                                |          |           |
                                | +--------v---------+     +-------------------------+
                                | |  Scheduler &     | --> |   EXECUTION UNITS (×N)  |
                                | |  Out-of-Order    |     | - ALU × 4               |
                                | |  Engine          |     | - FPU × 2               |
                                | +--------+---------+     | - Load/Store × 2        |
                                |          |               | - Branch Unit           |
                                |          v               +------------+------------+
                                | +------------------+                  |
                                | |  Execute (EX)    |<-----------------+
                                | +--------+---------+
                                |          |
                                | +--------v---------+     +----------------------+
                                | |  Memory Access   | --> |    DATA CACHE (L1d)  |
                                | |  (MEM)           |     +-----------+----------+
                                | +--------+---------+                 |
                                |          |                           | L2 Cache (per-core)
                                | +--------v---------+                 v
                                | |  Write Back (WB) |       +-----------------------+
                                | |                  |       |       REGISTER FILE   |
                                | +--------+---------+       | (Rename, Bypass Logic)|
                                +-----------+----------+     +-----------------------+
                                            |                           ^
                                            | High-Speed Interconnect   |
                                            v                           |
                       +------------------------------------------+     |
                       |                L3 Cache                  |<----+ (Cache Coherence:
                       | (Shared, inclusive, ring/mesh)           |     giữa các core)
                       +-------------------+--------------------+
                                           |
                                           | Memory Bus (IMC)
                                           v
                       +------------------------------------------+
                       |                Main Memory               |
                       | (RAM - DDR4/DDR5)                        |
                       | +--------------------------------------+ |
                       | |         User Space (Ring 3)          | |
                       | |                                      | |
                       | |  +----------------+                  | |
                       | |  |  App Code      |                   | |
                       | |  |  (MOV, ADD)    | syscall --------->|->| System Call Handler
                       | |  +----------------+                   | | (kernel trap)
                       | |  |  App Data      |                   | |
                       | |  |  (variables)   |                   | |
                       | |  +----------------+                   | |
                       | |                                      | |
                       | +--------------------------------------+ |
                       | |       Kernel Space (Ring 0)          | |
                       | |                                      | |
                       | |  +------------------------+          | |
                       | |  | Kernel Code & Data     |          | |
                       | |  | - Process Table        |          | |
                       | |  | - Page Tables          |          | |
                       | |  | - Driver Code          |          | |
                       | |  | - Interrupt Handlers   |          | |
                       | |  +------------------------+          | |
                       | +--------------------------------------+ |
                       +------------------------------------------+
                                            ^
                                            | Memory Bus
                                            |
                                            v
                     +---------------------------------------------+
                     |                Motherboard                  |
                     | +-----------------+  +--------------------+ |
                     | |   PCH / I/O Hub |  |   Clock Generator  | |
                     | | (SATA, USB,     |  | (CPU Clock, Timer) | |
                     | |  Audio, LAN)    |  +----------+---------+ |
                     | +--------+--------+             |           |
                     |   | PCIe | SATA | USB           | Timer IRQ
                     |   | lanes|      |               v           |
                     |   v      v      v         +-----------------+
                     | +--------------------------------------------------+
                     | |                   DMA Controller                 |
                     | | (Cho phép I/O ghi trực tiếp vào RAM, bypass CPU) |
                     | +--------------------------------------------------+
                     +----------------------------------------------------+
                                          |
                  +------------+         | PCIe / SATA / USB
                  |            |         |
                  |  Storage   |<--------+
                  | Devices    |
                  | (SSD, HDD, |<--------+ USB / Thunderbolt
                  |  Flash)    |
                  |            |
                  +------------+

+-------------------------+
|        ROM (BIOS/UEFI)  |
| (Firmware, khởi động OS)|
+-------------------------+
       ^ (boot từ đây)
       |
+------+
| Power On → CPU reset → BIOS/UEFI → Bootloader → OS kernel
+--------------------------------------------------------+

GHI CHÚ:
- DMI: CPU ↔ PCH (không nối RAM)
- Memory Bus (IMC): CPU ↔ RAM
- GPU: kết nối qua PCIe, xử lý đồ họa độc lập
- Cache Coherence: giữa L1/L2/L3 của các core
- System Call: dùng lệnh `syscall` → trap → kernel
- DMA: thiết bị I/O ghi trực tiếp vào RAM
- IRQ: thiết bị gửi ngắt khi sẵn sàng
- Timer: tạo interrupt định kỳ → OS lập lịch tiến trình
```
---



## Bản chất nó nằm ở chỗ nào ?

- Cái đầu tiên cần giải quyết là cầu nối ***hardware*** và ***software*** ?

🔥  "Chỉ có dữ liệu trong bộ nhớ  -> CPU vật lý xử lí -> Cập nhật lại vào bộ nhớ"
🔥 

---
### Không có "OS", chỉ có kernel là chương trình đặc biệt

🔹 OS không "tồn tại" như thực thể siêu nhiên:
   - Kernel là một file nhị phân trên ổ cứng
   - Được bootloader nạp vào RAM khi ***khởi động*** 
   - CPU bắt đầu thực thi từ entry point của kernel

🔹 Kernel chạy ở **kernel mode (Ring 0)**:
   - Toàn quyền: truy cập phần cứng, quản lý bộ nhớ, ngắt
   - Nhưng vẫn là: chuỗi lệnh máy → được CPU thực thi

👉 Bản chất:
   "OS không phải là 'người điều khiển' – mà là một chương trình đặc biệt 
    được nạp sớm và chạy ở chế độ đặc quyền."


### Không có APP , chỉ có chuỗi lệnh bin được OS nạp vào RAM 


🔹 Khi mở file nhị phân (.exe, ELF):
   - OS nạp một phần hoặc toàn bộ vào RAM (dùng demand paging)
   - Tạo tiến trình: không gian bộ nhớ ảo, stack, heap, thanh ghi, danh sách tài nguyên (file, network, v.v.)
   - Giao PC cho lệnh đầu tiên của app

🔹 CPU thực thi:
   - **Đọc lệnh từ ***RAM*** → giải mã → thực thi** ⚠️⚠️ĐÂY LÀ ĐIỂM THEN CHỐT⚠️⚠️
   - Không quan tâm đây là Chrome, Notepad hay game
   - Chỉ biết: "lệnh này là MOV, ADD, JMP..."

👉 Bản chất: 
   "Không có app nào hết – chỉ có một chuỗi lệnh máy nhị phân của app đc OS nạp vào RAM đang được CPU thực thi."



### Mối liên kết CPU , RAM , dữ liệu ❓

🔥 CPU không biết: Đây là ứng dụng gì ?


💡 CPU chỉ biết: 
Đọc byte tại địa chỉ do Program Counter (PC) trỏ đến
Giải mã byte đó theo ISA (x86, ARM, RISC-V…)
Thực thi → cập nhật PC → lặp lại

👉 Như vậy: CPU không phân biệt "OS" hay "app" – nó chỉ đọc và thực thi lệnh từ RAM. 


- Bản chất là CPU đang thực thi một chuỗi các lệnh máy (machine instructions). 
- Mỗi lệnh là một số nhị phân (ví dụ: 0xB8 0x01 0x00 0x00 0x00 – lệnh MOV trên x86).
- CPU đọc lệnh từ RAM (từ vùng text của tiến trình), giải mã (decode), rồi thực thi.
- CPU không "biết" đó là ứng dụng gì (Chrome, Word, v.v.) – nó chỉ biết đọc và thực thi lệnh.
- 👉 Như vậy: "Ứng dụng" không tồn tại ở cấp độ phần cứng.
    - Điều tồn tại là một chuỗi lệnh máy đang được CPU thực thi trong bối cảnh của một tiến trình do OS quản lý. 

-> ✅ CPU không biết nó đang chạy Chrome hay Notepad – nó chỉ biết thực thi lệnh.



✅ CPU là một cỗ máy trạng thái ***-> CPU "ngu ngốc" nhưng trung thành***:
   - Không "hiểu" gì cả.
      - Đây là hệ điều hành hay ứng dụng người dùng ?
      - Đây là dữ liệu hay lệnh ?
      - Đây là "thế giới ảo" hay "thế giới thực" ?


   - Chỉ biết: 
        1. Đọc byte tại địa chỉ do PC (Program Counter) trỏ đến
        2. Giải mã theo ISA (x86, ARM, RISC-V)
        3. Thực thi → cập nhật PC → lặp lại

✅ RAM là nơi lưu:
   - Lệnh (machine code)
   - Dữ liệu (biến, chuỗi, cấu trúc)
   → Nhưng CPU không phân biệt: "đây là lệnh hay dữ liệu"

✅ Transistor là bản chất cuối cùng:
   - Dữ liệu = điện áp (0V = 0, 5V = 1)
   - Lệnh = chuỗi bit → điều khiển các cổng logic (AND, OR, NOT)
   - ALU, thanh ghi, bus = mạng lưới transistor được điều khiển

👉 Tóm lại: 
   "Mọi thứ đều là dữ liệu được CPU thực thi – 
    OS, app, driver, file, màn hình... chỉ là tên do con người đặt."





"Sau khi CPU thực thi 1 lệnh thông thường thì nó sẽ cập nhật lại giá trị vào thanh ghi hoặc RAM. Logic lúc này là OS sẽ thêm lệnh để hiển thị nó lên màn hình, làm chúng ta ảo giác phần cứng và phần mềm – chứ thực ra chỉ là data được xử lý qua CPU thực và lưu trong RAM thôi." 

🔍 Bản chất: Chỉ có dữ liệu và CPU thực thi
✅ Không có "phần mềm", "phần cứng", "OS", "app" nào tồn tại ở cấp độ vật lý. 

Có chỉ là:

CPU vật lý đang chạy vòng lặp fetch → decode → execute
RAM chứa các byte: có thể là lệnh, có thể là dữ liệu
Transistor đóng/mở theo tín hiệu điều khiển
Dữ liệu di chuyển dưới dạng điện áp
👉 Tất cả những khái niệm như "ứng dụng", "hệ điều hành", "màn hình", "file"… là do con người đặt tên để quản lý và hiểu hệ thống.


***❓ "CPU chạy app, OS, thì rốt cuộc ai thực thi? Có thật sự có 'phần mềm' không?"***

→ Sau hành trình phân tích, ta đi đến một chân lý đơn giản:

🔥 "Không có phần mềm. Không có phần cứng. 
     Chỉ có dữ liệu của mem, storage  và CPU thực thi lệnh nhị phân  – mọi thứ còn lại là trừu tượng."


### Phân biệt Ring 0 (Kernel Mode) và Ring 3 (User Mode)
1. Tất cả các lệnh đều chạy trên CPU, nhưng không phải lệnh nào cũng chạy trực tiếp như nhau. 

   🔹 Lệnh của ứng dụng: chạy trên CPU, ở user mode. Ứng dụng không thể tự do gọi phần cứng → phải qua OS (thông qua system call).
   
   🔹 Lệnh của OS: chạy trên CPU, ở kernel mode – khi được ứng dụng "kêu gọi" hoặc do ngắt (interrupt).
👉 Tức là: cả hai đều là lệnh chạy trên CPU, nhưng qua hai "cổng" khác nhau về quyền hạn.

Vậy tức là chuỗi lệnh trong app mà CPU đang thực thi nếu cần truy vấn đến hệ điều hành thì gọi là system call, tức là CPU phải từ ring 3 trỏ đến chuỗi lệnh của OS; còn nếu đơn giản CPU có thể thực thi luôn thì nó là lệnh thông thường." 


| Đặc điểm          | User Mode (Ring 3)        | Kernel Mode (Ring 0)         |
|-------------------|----------------------------|-------------------------------|
| Quyền hạn         | Hạn chế                    | Toàn quyền                    |
| Chạy bởi          | Ứng dụng (Chrome, Word...) | Hệ điều hành (kernel)         |
| Truy cập phần cứng| ❌ Không được               | ✅ Được                        |
| Vị trí trong RAM  | User space                 | Kernel space                  |
| Cách chuyển đổi   | Qua system call            | Qua interrupt / system call   |

🔹 Vòng đời một system call:
   App (Ring 3) → gọi `syscall` → CPU chuyển sang Ring 0 → kernel thực thi → trả kết quả → trở về Ring 3

👉 Bản chất:
   "Phân biệt mode không phải để phân chia 'thế giới', 
    mà để bảo vệ hệ thống: ngăn app độc hại làm sập máy."


### System call cửa thoát từ User Mode sang Kernel Mode


🔹 Khi app cần tài nguyên hệ thống (file, mạng, màn hình):
   - Không thể tự làm (bị giới hạn ở Ring 3)
   - Phải gọi OS qua **system call**

🔹 CPU xử lý:
   - Nhận lệnh `syscall` → chuyển sang kernel mode
   - Kernel kiểm tra:
        - Tham số có hợp lệ?
        - Tiến trình có quyền không?
   - Nếu hợp lệ: thực hiện hành động
   - Nếu không: trả về lỗi (errno), không làm gì cả

👉 Bản chất:
   "System call không phải là 'hàm', mà là yêu cầu dịch vụ.
    Kernel không 'huỷ lệnh' – mà từ chối phục vụ nếu không an toàn."

