# Bài 12 — Cùng một bài toán, hai ngôn ngữ
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: SO-SÁNH**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** biên dịch khác thông dịch · kiểu tĩnh khác kiểu động · ai quản lý bộ nhớ trong mỗi ngôn ngữ.

**Bài toán:** đọc `sensor_log.csv` (timestamp, nhiệt độ, độ ẩm — có dòng hỏng, có giá trị thiếu) → tính min/max/trung bình, phát hiện outlier (lệch hơn 3σ), in báo cáo.

File sinh dữ liệu đã có sẵn: `python gen_data.py 1000000`.

**Làm gì:**
- Viết `python/analyze.py` và `cpp/analyze.cpp`. Cùng input, cùng output — `diff` hai output phải rỗng.
- Cả hai phải xử lý dòng hỏng mà không crash.
- Đo thời gian chạy trên file 1 triệu dòng.

**Xong khi:** có bảng 5 cột — *số dòng code · thời gian chạy · RAM đỉnh · thứ ngôn ngữ làm hộ bạn · thứ nó bắt bạn tự làm*.

**Câu bắt buộc trả lời được:** trong C++ ai giải phóng bộ nhớ của cái vector đó? Trong Python ai làm? Điều đó đổi cách bạn viết code thế nào?

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b12: <việc đã làm>"`
- [ ] Có bảng so sánh hai ngôn ngữ **trên cùng một bài toán**

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
