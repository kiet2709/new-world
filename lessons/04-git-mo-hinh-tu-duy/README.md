# Bài 04 — Git: mô hình tư duy
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** Git lưu **ảnh chụp** chứ không lưu diff · ba vùng (working directory → staging area → repository) · commit thật ra là object gì · `HEAD` là gì.

Đây là bài quan trọng nhất trong bốn bài Git. Gần như mọi hiểu lầm về Git về sau đều bắt nguồn từ chỗ không có mô hình ba vùng trong đầu.

**Làm gì — làm CHẬM, quan sát từng bước:**
- Tạo một repo nháp riêng (`/tmp/git-tap`), không phải repo này.
- Sau **mỗi** lệnh, chạy `git status` và đọc kỹ nó đang nói gì.
- `git init` → `git add` → `git commit`: sau mỗi lệnh, file đang nằm ở **vùng nào**?
- `git diff` vs `git diff --staged` — vì sao có hai lệnh khác nhau?
- `git log`, `git log --oneline`, `git show <hash>`.
- Sửa file nhưng **chưa** add → `git status` nói gì? Add rồi sửa tiếp → giờ nó nói gì?

**Xong khi:** vẽ được ba vùng ra giấy và chỉ đúng mỗi lệnh chuyển gì từ đâu sang đâu. Đọc `git status` mà không thấy hoảng.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b04: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
