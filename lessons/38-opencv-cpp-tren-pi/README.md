# Bài 38 — OpenCV C++ trên Pi, đo hiệu năng
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: SO-SÁNH**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** build OpenCV C++ trên Pi (hoặc dùng gói có sẵn — đo cả thời gian build) → viết lại pipeline bài 35–32 bằng C++ → đo.

**Đo:** thời gian mỗi frame · RAM · CPU% · mức chiếm dụng khi chạy liên tục 30 phút · nhiệt độ.

**Xong khi:** bảng số liệu Python vs C++ trên **cùng pipeline, cùng ảnh, cùng máy**, và kết luận có căn cứ về việc phần nào đáng viết bằng C++.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b38: <việc đã làm>"`
- [ ] Có bảng so sánh hai ngôn ngữ **trên cùng một bài toán**

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
