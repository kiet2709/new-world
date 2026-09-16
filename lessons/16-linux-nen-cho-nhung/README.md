# Bài 16 — Linux nền cho người làm nhúng
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** `/dev`, `/sys`, `/proc` là chỗ phần mềm chạm phần cứng. Không hiểu chúng thì mọi thứ về sau là phép thuật.

**Làm gì:**
- Soi `/dev/i2c-1`, `/dev/ttyUSB0`, `/dev/gpiochip0` — chúng là *file*, nhưng là loại file gì?
- Đọc nhiệt độ CPU từ `/sys/class/thermal/thermal_zone0/temp`. Không thư viện nào cả, chỉ đọc file.
- Viết script bắt `SIGTERM` → dọn dẹp (tắt LED, đóng file) → thoát với exit code đúng.
- Dùng thử `ps`, `top`, `lsof`, và `strace` trên một lệnh đơn giản.

**Xong khi:** giải thích được "mọi thứ là file" nghĩa là gì với người làm nhúng; script của bạn tắt sạch khi bị `systemctl stop`, không để LED sáng mãi.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b16: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
