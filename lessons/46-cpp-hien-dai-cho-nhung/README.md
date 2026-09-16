# Bài 46 — C++ hiện đại cho nhúng
> KHỐI 4 — C++ vào cuộc  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** RAII · `unique_ptr`/`shared_ptr` (và khi nào **không** dùng con trỏ nào cả) · `std::optional` cho giá trị có thể thiếu · `std::span` · **tránh cấp phát bộ nhớ trong vòng lặp nóng** · `constexpr`.

**Xong khi:** viết lại một module Python sang C++ sạch; `valgrind` không báo leak; giải thích được vì sao `new`/`delete` bằng tay là mùi code xấu trong C++ hiện đại.

**Ghi chú về ngữ cảnh nhúng:** trên vi điều khiển, exception và cấp phát heap động thường bị cấm. Hiểu **vì sao** — không phải vì chúng xấu, mà vì chúng làm thời gian thực thi khó đoán.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b46: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
