# Bài 31 — Lưu trữ và dashboard
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** Python gateway đọc Modbus/MQTT → ghi Postgres → Grafana vẽ. Tất cả trong compose.
- Schema time-series: index theo thời gian, tránh bảng phình.
- Xử lý mất kết nối DB — **buffer tại chỗ, không mất dữ liệu**.

**Xong khi:** chạy liên tục 24 giờ → biểu đồ liền mạch, không lỗ hổng; tắt DB 10 phút → dữ liệu vẫn về đủ sau khi bật lại.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b31: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
