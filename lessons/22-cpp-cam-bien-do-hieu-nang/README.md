# Bài 22 — C++ đọc cảm biến, đo hiệu năng
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: SO-SÁNH**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** viết lại bài 18 bằng C++ thuần — mở `/dev/i2c-1` bằng `open()`, nói chuyện bằng `ioctl()`, không thư viện cao cấp.

**Đo (10.000 lần đọc, trên Pi):** thời gian mỗi lần đọc · RAM đỉnh · CPU% · thời gian khởi động tiến trình · kích thước binary so với kích thước runtime Python.

**Xong khi:** có bảng số liệu + một kết luận có căn cứ: *"với bài này tôi chọn X vì Y"*. Không có đáp án đúng chung — chỉ có đáp án đúng **cho bài toán cụ thể**.

Đây là cây cầu sang C++: bạn không học C++ từ hello world, bạn học nó để làm lại thứ mình đã hiểu.

> **PHÉP THỬ TẮT AI #2** — tắt AI, tự viết lại bài 17 (nút + LED + debounce) từ đầu. Ghi kết quả trung thực vào nhật ký.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b22: <việc đã làm>"`
- [ ] Có bảng so sánh hai ngôn ngữ **trên cùng một bài toán**

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
