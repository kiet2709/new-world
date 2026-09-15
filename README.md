# new_world — Lộ trình Kỹ sư Bắc cầu IT↔OT + Edge AI

Repo học tập và là **artifact cuối cùng**: một hệ thống camera → Pi (AI) → Modbus/MQTT → ESP32 → thiết bị.

## Ba tài liệu, ba vai trò

| File | Vai trò | Khi nào đọc |
|---|---|---|
| [lo-trinh-hoc-nhung-edge-ai.md](lo-trinh-hoc-nhung-edge-ai.md) | **La bàn** — tại sao đi hướng này, nguyên tắc tự quyết | Khi phân vân ngã rẽ, khi mất động lực |
| [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md) | **Bản đồ** — 38 bài, làm gì, xong khi nào | Mỗi lần bắt đầu một bài |
| `lessons/NN-*/NHAT-KY.md` | **Nhật trình** — bạn viết, không ai viết hộ | Mỗi lần kết thúc một bài |

Khi la bàn và bản đồ mâu thuẫn: **la bàn thắng**.

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

Từ Chặng 2 trở đi: `.\dev.ps1 up ot`.

## Tiến độ

Đánh dấu khi xong một bài. Xong = đạt tiêu chí "Xong khi" **và** đã commit.

- [ ] **Chặng 0** — Bệ phóng công cụ (01–04)
- [ ] **Chặng 1** — Embedded Linux trên Pi (05–12)
- [ ] **Chặng 2** — ESP32-S3 và cây cầu OT (13–22)
- [ ] **Chặng 3** — AI lên edge (23–30)
- [ ] **Chặng 4** — C++ dẫn, hardening, giao hàng (31–38)

## Tiện ích

```bash
bash scripts/scaffold-lessons.sh   # sinh lại thư mục bài từ bảng trong LO-TRINH-TUNG-BAI.md
                                   # (chạy lại được, không ghi đè file đã có)
```
