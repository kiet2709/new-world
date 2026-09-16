# Bài 07 — Git: remote, GitHub, và quy trình làm việc
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** local repo và remote repo là hai repo độc lập · `origin` là gì · tracking branch · vì sao push bị từ chối · fetch khác pull.

**Làm gì — giờ mới đụng vào repo thật `new_world`:**
- Tạo repo trên GitHub, `git remote add`, push lần đầu.
- `.gitignore` — hiểu vì sao file đã lỡ commit thì thêm vào `.gitignore` **không** làm nó biến mất.
- `git fetch` rồi `git log origin/main` — xem cái ở trên đó mà chưa lấy về.
- **Quy ước nhánh** `main` / `feat/*` / `fix/*` → viết vào `docs/git-convention.md`.
- Một nhánh `feat/*` → Pull Request → **tự review chính mình**, để lại ít nhất 2 comment thật → merge.
- `git rebase -i` squash 3 commit vụn thành 1 (làm trên nhánh chưa push).
- `git tag v0.1.0` + tạo release trên GitHub.

**Xong khi:** repo public, `git log --oneline --graph --all` cho thấy đủ: 1 merge có conflict đã giải, 1 revert, 1 nhánh đã squash, 1 tag, 1 PR đã merge.

**Từ đây trở đi, mọi bài đều kết thúc bằng commit — và bạn đã đủ Git để không sợ nó nữa.**

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b07: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
