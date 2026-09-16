# Bài 39 — Khái niệm CV/AI/DL **đi sơ** + metric
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết (mức đủ để gỡ lỗi, không đào sâu):** học máy khác lập trình thường chỗ nào · train và inference là hai việc khác nhau · mạng nơ-ron và CNN ở mức ý tưởng · model là cái gì khi nằm trên đĩa · vì sao **tiền xử lý lúc chạy phải khớp với lúc train** (sai chỗ này thì accuracy tụt mà không báo lỗi gì).

**Metric — phần này phải chắc, không được sơ:** **FP/FN** · precision, recall, F1 · confusion matrix · vì sao "95% accuracy" là câu trả lời lười.

**Làm gì:** tự tính tay confusion matrix từ 20 kết quả · tính precision/recall bằng tay · dựng lại bằng code và so.

**Xong khi:** cho một bài toán cụ thể, nói được **sai kiểu nào đắt hơn và đắt hơn bao nhiêu lần**.

> Chiều sâu thật của phần này (tự code từ linear regression tới CNN, tính tay backprop) nằm ở **Chặng 2, khối F**. Ở đây chỉ cần đủ để không mù mờ khi dùng.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b39: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
