# Bài 29 — Modbus RTU qua RS485
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Vì sao vẫn phải học dù đã có TCP:** phần lớn thiết bị trong nhà máy Việt Nam nói RTU qua dây RS485, không phải Ethernet. Đây là chỗ "chạm được thiết bị" trở thành thật.

**Làm gì:** cùng dữ liệu bài 28 nhưng qua serial → CRC, baudrate, parity, **timing giữa các frame** → nhiều slave trên một dây (địa chỉ slave).

**Xong khi:** poll được qua dây thật; cố tình sai baudrate → hiểu triệu chứng; giải thích được vì sao RTU nhạy cảm với timing còn TCP thì không.

**Docker:** truyền `/dev/ttyUSB0` vào container (đã học ở bài 21).

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b29: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
