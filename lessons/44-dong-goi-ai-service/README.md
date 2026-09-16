# Bài 44 — Đóng gói AI service: multi-stage image
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** Dockerfile multi-stage ép image nặng (OpenCV, ONNX Runtime) xuống nhỏ · stage build (có compiler) tách khỏi stage runtime · chạy **non-root** · build cho **arm64**, chạy trên Pi · so với con số bạn ghi ở **bài 02**.

**Xong khi:** image nhỏ hơn bản ngây thơ ít nhất 3 lần, chạy trên Pi, không chạy bằng root.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b44: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
