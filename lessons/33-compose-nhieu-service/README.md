# Bài 33 — docker-compose nhiều service cho ra hồn
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì (case Docker phải dàn dựng):**
- `healthcheck` cho từng service + `depends_on: condition: service_healthy`.
- `restart: unless-stopped` và thử giết service ngẫu nhiên.
- Tách config theo môi trường: `.env.dev` vs `.env.prod`, **không hardcode** mật khẩu.
- Network nội bộ: DB **không** expose ra ngoài, chỉ service trong mạng thấy.
- Tối ưu thứ tự layer để build lại nhanh.

**Xong khi:** một lệnh `docker compose --profile ot up -d` dựng cả hệ; `docker kill` bất kỳ service nào → hệ tự hồi phục trong 30 giây.

> **PHÉP THỬ TẮT AI #3** — tắt AI, tự viết lại phần MQTT publish trên ESP32 và phần subscribe bên Python.

**Đầu ra Khối 2:** hệ thống ESP32 → Modbus/MQTT → Pi → DB → OPC UA + dashboard, chạy liên tục. **Riêng phần này đã đủ kể thành một câu chuyện phỏng vấn hoàn chỉnh.**

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b33: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
