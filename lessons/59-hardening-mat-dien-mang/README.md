# Bài 59 — Hardening: mất điện, mất mạng, dữ liệu bẩn
> KHỐI 6 — Chịu lỗi, CI, giao hàng  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** đây là phần biến demo thành sản phẩm. Cũng là phần 90% dự án cá nhân bỏ qua — nên nó là chỗ bạn nổi bật.

**Làm gì, và phải thử thật:**
- Rút mạng 10 phút → buffer tại chỗ → gửi bù khi có mạng, **không trùng, không mất**.
- Rút điện Pi giữa lúc ghi file → bật lại, dữ liệu không hỏng (atomic write).
- Gửi dữ liệu rác vào Modbus/MQTT → hệ thống từ chối sạch sẽ, không crash.
- Đồng hồ nhảy lùi (NTP sync) → không làm hỏng chuỗi thời gian.
- Watchdog nhiều tầng: systemd cho service, hardware watchdog cho Pi, task watchdog cho ESP32.

**Xong khi:** hoàn thành một **bảng kiểm tra phá hoại** — mỗi dòng là một cách bạn cố tình phá và kết quả hệ thống chịu được. Bảng này đưa vào README.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b59: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
