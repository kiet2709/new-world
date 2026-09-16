# Bài 28 — Modbus TCP: ESP32 làm slave
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** Modbus là ngôn ngữ chung của thiết bị công nghiệp. Hiểu nó là hiểu cách máy móc nói chuyện.

**Làm gì:** ESP32 làm **Modbus TCP slave**, expose cảm biến qua holding register → Python (`pymodbus`) làm **master**, poll dữ liệu.

**Phải hiểu được:** coil vs discrete input vs input register vs holding register; vì sao register là 16-bit và số thực phải ghép 2 register (và thứ tự byte/word có thể ngược — lỗi kinh điển ngoài hiện trường).

**Xong khi:** đọc holding register ra đúng giá trị cảm biến thật; thử đọc register không tồn tại → nhận đúng exception code.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b28: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
