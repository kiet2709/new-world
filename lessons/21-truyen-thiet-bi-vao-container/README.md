# Bài 21 — Truyền thiết bị vật lý vào container
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** đây là chỗ Docker gặp phần cứng — case Docker "sát nhúng" nhất.

**Làm gì:** chạy code bài 18 **bên trong container** và truy cập được `/dev/i2c-1`:
- Thử `--privileged` trước (chạy được — nhưng vì sao đó là ý tồi?).
- Rồi làm đúng: `--device=/dev/i2c-1`, `group_add`, khai báo `devices:` trong compose.
- Thêm luôn camera `/dev/video0` và serial `/dev/ttyUSB0` — hai thứ sẽ cần ở Chặng 2 và 3.

**Xong khi:** container đọc được cảm biến **không cần `--privileged`**; viết được vào nhật ký vì sao `--privileged` là nợ bảo mật.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b21: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
