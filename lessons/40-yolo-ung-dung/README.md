# Bài 40 — YOLO ở mức ứng dụng
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** phát hiện đối tượng khác phân loại ảnh chỗ nào · đầu vào/đầu ra của YOLO thật sự là gì · **confidence không phải xác suất đúng** · NMS để làm gì · IoU.

**Làm gì:** chạy YOLO trên PC → trên Pi → đo latency p50/**p95** (không chỉ trung bình!), FPS, nhiệt độ sau 30 phút, **có bị giảm xung nhịp không** · vẽ box · đếm/phân loại theo vùng quan tâm · so với cách contour ở bài 36 trên cùng bộ ảnh.

**Xong khi:** bảng số liệu hai nền tảng; nói được YOLO thắng contour ở đâu và **thua ở đâu**.

**Bài học ẩn:** Pi nóng lên là giảm xung nhịp. Số đo 30 giây đầu là số đo dối.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b40: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
