# Bài 05 — Git: nhánh, merge, và conflict
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** branch chỉ là **một con trỏ tới commit** (rẻ tiền, không phải bản sao) · `HEAD` di chuyển thế nào · fast-forward khác merge commit · vì sao conflict xảy ra và vì sao Git không tự đoán được.

**Làm gì:** vẫn trong repo nháp.
- `git branch`, `git switch -c`, `git switch` — mỗi lần chuyển nhánh, `git log --oneline --graph --all` trông thế nào?
- Merge một nhánh không đụng độ → quan sát fast-forward.
- Tạo hai nhánh **cùng sửa một dòng** trong một file → merge → **conflict**.
- Đọc hiểu `<<<<<<< HEAD` / `=======` / `>>>>>>>` — mỗi phần là của ai?
- Giải bằng tay, commit.

**Xong khi:** vẽ được đồ thị commit trước và sau merge; giải conflict mà không cần ai đưa đáp án; giải thích được vì sao fast-forward không tạo commit mới.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b05: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
