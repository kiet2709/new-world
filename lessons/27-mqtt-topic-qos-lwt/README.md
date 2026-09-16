# Bài 27 — Kiến trúc MQTT: topic, QoS, LWT
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** phần thiết kế, không phải phần code. Đây là chỗ kinh nghiệm hệ thống của bạn có giá.

**Làm gì:**
- Thiết kế cây topic: `nhamay/khuvuc/thietbi/phepdo` — vì sao không nhét tất cả vào một topic?
- QoS 0 vs 1 vs 2: thử mất gói thật (tắt broker giữa chừng) và quan sát.
- `retained` message — thiết bị mới kết nối thấy ngay trạng thái cuối.
- **LWT (Last Will and Testament)** — thiết bị chết đột ngột thì hệ thống tự biết.

**Xong khi:** rút điện ESP32 → trong vòng 30 giây có message `offline` xuất hiện, không cần ai hỏi thăm.

**Đây là bài dạy bạn nghĩ như người vận hành hệ thống, không phải người viết tính năng.**

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b27: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
