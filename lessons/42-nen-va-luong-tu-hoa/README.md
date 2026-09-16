# Bài 42 — Nén và lượng tử hoá **ở mức gọi thư viện**
> KHỐI 3 — Thị giác máy và AI trên edge  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** FP32/FP16/INT8 khác nhau ra sao ở mức biểu diễn · lượng tử hoá đổi cái gì · vì sao cần calibration dataset.

**Làm gì:** chuyển model qua ONNX Runtime hoặc TFLite · FP32 → FP16 → **INT8** · đo **cả ba**: accuracy, latency, kích thước · vẽ biểu đồ đánh đổi · thử thêm: giảm độ phân giải đầu vào, bỏ bớt frame, chỉ xử lý vùng quan tâm.

**Xong khi:** chọn một cấu hình và **biện hộ bằng số**: *"INT8 mất 1.2% accuracy nhưng nhanh gấp 3.1 lần và nhỏ hơn 3.8 lần — với bài toán này đáng đổi vì..."*

**Không đụng:** tự cài đặt thuật toán lượng tử hoá, pruning thủ công, distillation — Chặng 2.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b42: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
