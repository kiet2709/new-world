# Bài 41 — Chọn bài toán vision
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: PHÁN ĐOÁN**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Không viết code.** Viết một trang `docs/problem-statement.md`.

**Chọn một bài toán nhà máy có thật:** đếm sản phẩm qua băng chuyền · phát hiện thiếu nhãn/nắp · nhận diện trạng thái đèn báo máy · phát hiện người vào vùng nguy hiểm · đọc số trên đồng hồ analog.

**Phải trả lời bằng số:**
- Sai kiểu nào đắt hơn — báo nhầm hay bỏ sót? Đắt hơn bao nhiêu?
- Ngưỡng chấp nhận là bao nhiêu, **trên tập nào, điều kiện ánh sáng nào**?
- Ánh sáng đổi thế nào trong ngày? Camera có rung? Vật đi nhanh cỡ nào?
- **Bài này giải bằng contour (bài 36) được không?** Nếu được thì đừng dùng AI.
- Nếu model chết thì dây chuyền làm gì — dừng, hay chạy tiếp và ghi log?

**Xong khi:** người khác đọc trang đó và biết chính xác phải xây gì, đo thế nào là đạt.

Đây là bài phân biệt kỹ sư giải pháp với người chạy notebook.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b41: <việc đã làm>"`
- [ ] Đã viết ra lựa chọn kèm **lý do bằng số**, không phải cảm tính

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
