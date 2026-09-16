# Bài 23 — ESP-IDF: chọn chỗ đặt toolchain
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Quyết định phải ra trước khi gõ dòng nào:** ESP-IDF chạy trong Docker rất sạch, **nhưng Docker Desktop trên Windows không thấy cổng COM**. Bạn có ba đường:

| Đường | Build | Flash/Monitor | Ma sát |
|---|---|---|---|
| **A. Docker build + flash từ Windows** *(khuyến nghị để bắt đầu)* | trong container | `esptool.py` trên Windows | Thấp. Giữ được toolchain sạch, chấp nhận 1 bước thủ công. |
| **B. WSL2 + usbipd-win** | trong WSL | trong WSL | Trung bình. Phải `usbipd attach` mỗi lần cắm. Sạch nhất khi đã quen. |
| **C. ESP-IDF cài thẳng Windows** | host | host | Thấp nhất, nhưng bẩn máy — đi ngược gu của bạn. |

Chọn **A** trước. Nếu thấy bước thủ công phiền thì chuyển **B** ở bài 26. Nhắc lại nguyên tắc 3 của la bàn: *cái bạn đang học lúc này là con chip, không phải cái công cụ.* Đừng đốt hai ngày cho USB passthrough.

**Làm gì:** blink LED → `idf.py build` → flash → `monitor` thấy log. Đọc `sdkconfig` xem nó thật ra là gì.

**Xong khi:** chu trình sửa-code → build → flash → thấy kết quả mất dưới 60 giây và bạn không phải nghĩ về nó nữa. **Bỏ hẳn Arduino IDE.**

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b23: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
