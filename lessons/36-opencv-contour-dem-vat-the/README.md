# Bài 36 — OpenCV: contour, phát hiện và đếm vật thể — **không cần AI**
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** contour là gì · diện tích, chu vi, bounding box, tỉ lệ khung · lọc theo hình dạng.

Bài này quan trọng hơn vẻ ngoài: **rất nhiều bài toán nhà máy dừng ở đây là đủ.** Đếm sản phẩm, kiểm tra có/không có nắp, đo kích thước, phát hiện lệch vị trí — không cần model nào, chạy nhanh hơn AI hàng chục lần, và **giải thích được vì sao nó quyết định thế** (điều AI không làm được).

**Làm gì:** tìm contour → lọc theo diện tích/hình dạng → đếm vật thể trên nền đơn giản → vẽ kết quả → đo độ chính xác trên 100 ảnh thật.

**Xong khi:** đếm đúng ≥95% trên bộ ảnh tự chụp; biết **khi nào cách này gãy** (nền phức tạp, vật chồng nhau, ánh sáng đổi) — và đó chính là lúc cần AI.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b36: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
