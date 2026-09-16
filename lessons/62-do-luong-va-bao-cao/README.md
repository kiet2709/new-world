# Bài 62 — Đo lường và báo cáo
> KHỐI 6 — Chịu lỗi, CI, giao hàng  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** chạy hệ thống **liên tục nhiều ngày**, thu thập tự động: accuracy trên dữ liệu thật · latency p50/p95/p99 · FPS · uptime · số lần tự khởi động lại · điện năng · nhiệt độ.

Viết script sinh báo cáo từ log — không đo bằng tay.

**Xong khi:** có báo cáo số liệu của **ít nhất 72 giờ chạy liên tục**. Đây là thứ xóa sạch nghi ngờ "chỉ là lý thuyết", mạnh hơn mọi chứng chỉ.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b62: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
