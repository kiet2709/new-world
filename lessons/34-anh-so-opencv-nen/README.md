# Bài 34 — Ảnh số là gì · OpenCV nền
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: SO-SÁNH**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** pixel · kênh màu và **thứ tự BGR của OpenCV** (nguồn lỗi kinh điển) · không gian màu RGB/HSV/Gray và khi nào dùng cái nào · ảnh **là một ma trận số**, không hơn · kiểu `uint8` và chuyện tràn số.

**Làm gì:** đọc/ghi/hiển thị ảnh · truy cập pixel · cắt, ghép, đổi không gian màu · **tự viết hàm đổi sang ảnh xám bằng vòng lặp**, so với `cvtColor` — cả thời gian lẫn kết quả. Làm bằng **cả Python lẫn C++**.

**Xong khi:** giải thích được vì sao ảnh xám nhẹ hơn 3 lần; vì sao lặp pixel bằng Python chậm thảm hại còn C++ thì không.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b34: <việc đã làm>"`
- [ ] Có bảng so sánh hai ngôn ngữ **trên cùng một bài toán**

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
