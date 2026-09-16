# Bài 17 — GPIO bằng Python
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** LED nhấp nháy → nút bấm bật/tắt LED → **chống nhiễu (debounce)** → PWM đổi độ sáng.

**Xong khi:** bấm nút 20 lần, LED đổi trạng thái đúng 20 lần — không nhiều hơn. Đo được thời gian nhiễu của nút bằng oscilloscope-nhà-nghèo: log timestamp mỗi lần chân đổi mức.

**Vì sao bài này quan trọng hơn vẻ ngoài của nó:** debounce là bài học đầu tiên rằng **thế giới vật lý bẩn**. Mọi thứ về sau — cảm biến nhiễu, mạng chập chờn, AI đoán sai — đều là biến thể của bài này.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b17: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
