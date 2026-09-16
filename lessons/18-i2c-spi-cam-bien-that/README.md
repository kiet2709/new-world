# Bài 18 — I2C/SPI: đọc cảm biến thật
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** `i2cdetect -y 1` tìm địa chỉ → **đọc datasheet** (thanh ghi nào, đơn vị gì, chờ bao lâu) → đọc giá trị → xử lý khi rút dây giữa chừng.

**Xong khi:** số đọc ra đúng thực tế (hà hơi vào cảm biến, số phải nhảy); rút dây → chương trình báo lỗi rõ ràng và **không chết**.

**Kỹ năng thật đang luyện:** đọc datasheet. Đây là thứ phân biệt người làm nhúng với người copy thư viện.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b18: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
