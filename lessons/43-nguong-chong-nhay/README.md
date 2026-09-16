# Bài 43 — Ngưỡng, chống nháy, và cái giá của sai
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: PHÁN ĐOÁN**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** model không bao giờ đúng 100%. Hệ thống tốt là hệ thống **sai một cách có kiểm soát**.

**Làm gì:** chỉnh confidence threshold, quan sát đánh đổi FP/FN · **chống nháy**: N-of-M (chỉ báo khi 3/5 frame liên tiếp đồng ý), hysteresis · chế độ suy giảm — model chết thì sao, camera mất thì sao · ghi log mọi quyết định + lưu ảnh của ca sai để về sau truy được.

**Xong khi:** chạy thật 1 giờ, **đếm tay FP/FN**, chỉnh ngưỡng có căn cứ số liệu, ghi vào nhật ký vì sao chọn ngưỡng đó cho bài toán này.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b43: <việc đã làm>"`
- [ ] Đã viết ra lựa chọn kèm **lý do bằng số**, không phải cảm tính

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
