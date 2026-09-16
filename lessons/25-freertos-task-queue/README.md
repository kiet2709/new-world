# Bài 25 — FreeRTOS: task, queue, mutex
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** đây là khác biệt lớn nhất giữa vi điều khiển và Linux. Không có OS đầy đủ, bạn tự quản lý thời gian.

**Làm gì:** tách 2 task — task đọc cảm biến (chu kỳ đều) và task gửi dữ liệu (chậm, có thể nghẽn). Nối bằng **queue**. Bảo vệ tài nguyên chung bằng **mutex**.

**Xong khi:** task gửi bị treo 5 giây → task đọc **vẫn đúng chu kỳ**. Giải thích được stack size chọn bao nhiêu và vì sao tràn stack ở đây làm thiết bị reboot.

**So với Pi:** viết vào nhật ký khác biệt giữa "task FreeRTOS" và "process Linux". Đây là câu hỏi phỏng vấn kinh điển.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b25: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
