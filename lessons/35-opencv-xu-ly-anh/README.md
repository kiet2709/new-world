# Bài 35 — OpenCV: xử lý ảnh nền tảng
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** nhân tích chập (kernel) · làm mờ và vì sao nó khử nhiễu · ngưỡng cố định vs thích nghi · hình thái học: giãn, co, mở, đóng.

**Làm gì:** resize (các phép nội suy khác nhau ra sao) · blur/Gaussian/median · threshold + **Otsu** · morphology dọn nhiễu · Canny tìm biên.

**Xong khi:** lấy một ảnh chụp thật trong điều kiện ánh sáng xấu, qua chuỗi xử lý ra được ảnh nhị phân sạch. **Giải thích được từng bước làm gì** — không copy chuỗi phép từ trên mạng.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b35: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
