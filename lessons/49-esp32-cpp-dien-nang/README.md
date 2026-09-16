# Bài 49 — C++ trên ESP32 và bài toán điện năng
> KHỐI 4 — C++ vào cuộc  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** dùng C++ trong ESP-IDF → đo heap/stack còn lại lúc chạy → **deep sleep** → đo dòng tiêu thụ thật bằng đồng hồ (hoặc module INA219).

**Xong khi:** đo được mA ở chế độ chạy và chế độ ngủ; tính được thời gian sống nếu chạy pin; giảm được điện năng và **có số liệu chứng minh**.

**Vì sao có mặt trong lộ trình:** điện năng là ràng buộc bạn không gặp trong web. Biết nói chuyện về mAh và duty cycle là dấu hiệu người thật sự làm nhúng.

---

---

> **PHÉP THỬ TẮT AI #5** — tắt AI, tự viết lại một module C++ nhỏ đã làm, kể cả CMakeLists.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b49: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
