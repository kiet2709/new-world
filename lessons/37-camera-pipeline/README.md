# Bài 37 — Camera pipeline thật
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** luồng video là gì · vì sao có **buffer** và vì sao nó làm bạn xử lý ảnh của 3 giây trước · FPS nguồn khác FPS xử lý.

**Làm gì:** đọc từ ba nguồn — webcam laptop (dev nhanh), **RTSP từ điện thoại** (app kiểu *IP Webcam*), USB cam cắm Pi · đo FPS thật · xử lý buffer để luôn lấy frame mới nhất · mất kết nối RTSP → tự nối lại.

**Xong khi:** đo được FPS **và độ trễ end-to-end** (mẹo: quay màn hình đang chạy đồng hồ mili-giây); rớt mạng không làm crash.

**Vì sao RTSP quan trọng hơn USB:** nhà máy thật dùng camera IP. Tập bằng điện thoại là tập đúng giao thức thật.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b37: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
