# new_world — Lộ trình Kỹ sư Bắc cầu IT↔OT + Edge AI

Repo học tập và là **artifact cuối cùng**: camera → Pi (OpenCV/AI) → Modbus/MQTT/OPC UA → ESP32 → thiết bị, cộng HMI web và app desktop dùng chung một core library.

## Tài liệu trong repo

| File | Vai trò | Khi nào đọc |
|---|---|---|
| [lo-trinh-hoc-nhung-edge-ai.md](lo-trinh-hoc-nhung-edge-ai.md) | **La bàn** — tại sao đi hướng này, nguyên tắc tự quyết | Khi phân vân ngã rẽ, khi mất động lực |
| [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md) | **Bản đồ Chặng 1** — 64 bài, làm gì, xong khi nào | Mỗi lần bắt đầu một bài |
| [docs/cach-hoc.md](docs/cach-hoc.md) | **Giao thức học** — vòng lặp một buổi, cách dùng AI | Trước bài đầu tiên, đọc lại mỗi khi thấy trôi |
| [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md) | **Bản đồ Chặng 2** — khối A–G, lấp lỗ hổng còn lại | **Khi sắp xong Chặng 1, không phải trước đó** |
| [CHANG-3-BAN-DO.md](CHANG-3-BAN-DO.md) | **Bản đồ Chặng 3** — chuyên gia và đường nghiên cứu: TinyML, 3D vision, PLC/HMI | **Khi sắp xong Chặng 2** |
| [CHANG-4-BAN-DO.md](CHANG-4-BAN-DO.md) | **Bản đồ Chặng 4** — FPGA và nền tảng sâu; có phần **chuyển sớm** về Chặng 2–3 | Đọc mục 0 **ngay bây giờ** — nó đổi vị trí vài thứ |
| [docs/tu-vung.md](docs/tu-vung.md) | **Từ vựng Việt · English · 日本語** — kỷ luật xuyên suốt, ~10 phút mỗi bài | Mỗi bài |

Khi la bàn và bản đồ mâu thuẫn: **la bàn thắng**.

## Cách gọi tên

**CHẶNG** = giai đoạn lớn của sự nghiệp · **KHỐI** = nhóm bài trong một chặng · **BÀI** = đơn vị nhỏ nhất, 4–6 giờ, kết thúc bằng một commit.

## Bắt đầu

```powershell
.\dev.ps1 up          # bật môi trường (py + cpp)
.\dev.ps1 py          # vào shell Python
.\dev.ps1 cpp         # vào shell C++
.\dev.ps1             # xem toàn bộ lệnh
```

Trên Git Bash / WSL / trên Pi thì dùng `make` thay cho `dev.ps1` (`make help`).

Yêu cầu duy nhất trên máy Windows: **Docker Desktop + Git**. Không cài Python, không cài GCC lên host — toàn bộ toolchain nằm trong container. Đó là chủ ý, không phải tiện tay.

## Môi trường

| Service | Dùng cho | Profile |
|---|---|---|
| `py` | Python 3.12 — pytest, ruff, paho-mqtt, pymodbus | mặc định |
| `cpp` | GCC 12, CMake, Ninja, GDB, valgrind | mặc định |
| `mqtt` | Mosquitto broker (cổng 1883) | `ot` |
| `db` | Postgres 16 (cổng 5432) | `ot` |
| `grafana` | Dashboard (cổng 3000, admin/admin) | `ot` |

Từ Khối 2 trở đi: `.\dev.ps1 up ot`.

## Tiến độ Chặng 1 — 56 bài, ~5 tháng

Đánh dấu khi xong một khối. Xong = đạt tiêu chí "Xong khi" **và** đã commit.

- [ ] **Khối 0** — Nền tảng công cụ: Docker, Git, hai ngôn ngữ (00–09)
- [ ] **Khối 1** — Embedded Linux trên Pi (10–18)
- [ ] **Khối 2** — ESP32-S3 và cây cầu OT (19–29)
- [ ] **Khối 3** — Thị giác máy và AI trên edge (30–41)
- [ ] **Khối 4** — C++ vào cuộc (42–45)
- [ ] **Khối 5** — Viết ứng dụng thật: C# (46–50)
- [ ] **Khối 6** — Chịu lỗi, CI, giao hàng (51–55)

## Tiện ích

```bash
bash scripts/scaffold-lessons.sh   # sinh lại thư mục bài từ bảng tra trong LO-TRINH-TUNG-BAI.md
                                   # (chạy lại được, không ghi đè file đã có)
```
