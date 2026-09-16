# Bài 30 — Thiết kế tag map và chiến lược polling
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** bài thiết kế thuần. Chỗ nền sản xuất/kho của bạn đáng tiền nhất.

**Làm gì:** viết `docs/tag-map.md` có version — mỗi tag: địa chỉ, kiểu dữ liệu, đơn vị, hệ số scale, dải hợp lệ, chu kỳ đọc.
- Polling vs event: khi nào chọn cái nào?
- **Deadband** — chỉ ghi khi thay đổi đủ lớn. Giảm dữ liệu rác 90%.
- **Timestamp của ai?** Thiết bị hay gateway? Đồng hồ ESP32 lệch thì sao?
- Poll 100 tag trong 1 giây có khả thi không — tính thử băng thông RTU.

**Xong khi:** tag map đủ để **người khác** viết gateway mà không cần hỏi bạn.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b30: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
