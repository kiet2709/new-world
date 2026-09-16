# Bài 06 — Git: lưới an toàn — cách sửa sai
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** ba loại "quay lại" hoàn toàn khác nhau — bỏ thay đổi chưa commit (`restore`) · dịch con trỏ nhánh (`reset`) · tạo commit phủ định (`revert`). Và `reflog`: vì sao Git gần như không bao giờ mất dữ liệu thật.

Bài này tồn tại vì một lý do: **sợ Git là do không biết cách lùi.** Biết lùi thì dám tiến.

**Làm gì — mỗi tình huống: tự gây ra, rồi tự cứu:**
- Lỡ sửa hỏng file chưa commit → `git restore`.
- Lỡ `git add` nhầm file → gỡ khỏi staging.
- Commit rồi mới thấy thiếu một file → `--amend`.
- `git reset --soft` vs `--mixed` vs `--hard` — làm cả ba, quan sát ba vùng đổi thế nào.
- **`git reset --hard` xoá mất commit → cứu lại bằng `git reflog`.** Làm bằng được bài này.
- Đang làm dở, sếp bảo sửa gấp việc khác → `git stash`.
- Commit đã push lên remote, phát hiện sai → `git revert`, và hiểu vì sao ở đây **không được** dùng `reset`.

**Xong khi:** có bảng trong `NHAT-KY.md` dạng *"tôi lỡ tay X → tôi dùng lệnh Y"*, ít nhất 7 dòng, mỗi dòng bạn đã tự làm thật.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b06: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
