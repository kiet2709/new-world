# Bài 45 — Dự án nhỏ trên Pi: khép kín vòng
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Đây là khoảnh khắc Khối 1–3 hội tụ.**

```
Camera → Pi (OpenCV/YOLO) → quyết định → MQTT/Modbus → ESP32 → relay/đèn
```

**Làm gì:** nối trọn chuỗi bằng chính bài toán đã chọn ở bài 41 · đo **độ trễ end-to-end** từ lúc vật vào khung hình đến lúc relay kêu · **tách nhỏ độ trễ ra từng chặng** (camera bao nhiêu ms, inference bao nhiêu, mạng bao nhiêu, ESP32 bao nhiêu).

**Xong khi:** vật thể lỗi đi qua → thiết bị phản ứng dưới 1 giây; có bảng phân rã độ trễ; chạy liên tục 4 giờ không cần can thiệp.

> **PHÉP THỬ TẮT AI #4** — tắt AI, tự viết lại vòng đọc camera + tiền xử lý + gọi inference.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b45: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
