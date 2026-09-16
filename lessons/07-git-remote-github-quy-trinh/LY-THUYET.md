# Lý thuyết — Bài 07: Remote, GitHub, và quy trình làm việc

## 1. Local và remote là HAI repo độc lập

Đây là chỗ hiểu sai nhiều nhất về remote.

GitHub **không phải** "nơi lưu trữ đám mây của repo bạn". Nó là **một repo Git đầy đủ khác**, tình cờ đặt trên máy chủ của người khác. Repo của bạn và nó **hoàn toàn độc lập**, chỉ đồng bộ khi bạn ra lệnh.

```
   MÁY BẠN                          GITHUB
   ┌──────────────────┐             ┌──────────────────┐
   │  main    → c5    │  ──push──→  │  main    → c5    │
   │  origin/main→c5  │  ←─fetch──  │                  │
   └──────────────────┘             └──────────────────┘
```

**`origin/main` là gì:** nó không phải nhánh trên GitHub. Nó là **ghi chú cục bộ của bạn** về "lần cuối tôi nhìn, main trên GitHub đang ở đây". Nó chỉ cập nhật khi bạn `fetch` hoặc `pull`. Người khác push lên GitHub lúc 9 giờ, nhưng `origin/main` của bạn vẫn là thông tin cũ cho tới khi bạn fetch.

`origin` chỉ là **cái tên mặc định** cho remote đầu tiên. Không có gì thiêng liêng, đổi tên được.

## 2. fetch, pull, push

| Lệnh | Làm gì |
|---|---|
| `git fetch` | Tải commit mới về, **cập nhật `origin/*`**, KHÔNG đụng nhánh của bạn |
| `git pull` | `fetch` + `merge` — tải về **và** hợp vào nhánh hiện tại |
| `git push` | Đẩy commit của bạn lên remote |

**Thói quen tốt: `fetch` trước, xem, rồi mới quyết.**

```bash
git fetch
git log --oneline HEAD..origin/main     # trên đó có gì mà mình chưa có
git diff HEAD origin/main               # khác nhau thế nào
git merge origin/main                   # ok, giờ hợp vào
```

`pull` gộp hai bước nên nhanh, nhưng nó merge ngay khi bạn chưa kịp nhìn. Lúc làm nhóm, `fetch` trước là thói quen đáng có.

## 3. Vì sao push bị từ chối

```
! [rejected]        main -> main (fetch first)
```

Nghĩa là: remote có commit mà bạn **chưa có**. Git từ chối vì nhận push của bạn sẽ **xoá mất** commit đó.

```
   GitHub:  c1 ──→ c2 ──→ c3   (người khác đã push c3)
   Bạn:     c1 ──→ c2 ──→ c4   (bạn commit c4)
```

Cách đúng: kéo c3 về, hợp với c4, rồi push.

```bash
git pull            # hoặc: git fetch && git merge origin/main
git push
```

**`git push --force` thì sao?** Nó ghi đè, **xoá c3 của người khác**. Gần như luôn sai. Nếu buộc phải, dùng `--force-with-lease` — nó từ chối nếu remote đã đổi so với lần bạn nhìn.

## 4. Tracking branch

```bash
git push -u origin main    # -u = thiết lập liên kết theo dõi
```

Từ đó `git push` và `git pull` trống không biết phải nói chuyện với ai. Xem liên kết bằng `git branch -vv`.

## 5. `.gitignore` — và cái bẫy lớn nhất

`.gitignore` liệt kê những gì Git **không** theo dõi: file build, thư mục `__pycache__`, dữ liệu nặng, và **mật khẩu**.

> **Cái bẫy: `.gitignore` chỉ có tác dụng với file Git CHƯA theo dõi.**

Nếu bạn lỡ commit `.env` chứa mật khẩu rồi mới thêm nó vào `.gitignore` — **vô ích**. Git vẫn theo dõi nó.

```bash
git rm --cached .env      # bỏ theo dõi, giữ file trên đĩa
git commit -m "bo .env khoi git"
```

Và kể cả thế, **mật khẩu vẫn nằm trong lịch sử** — ai clone về cũng đọc được bằng `git log -p`. Xoá thật khỏi lịch sử rất phiền (`filter-repo`). Nên quy tắc là: **đổi mật khẩu đó đi, coi như đã lộ.**

Đây là lý do bài 60 có phần quản lý secret, và vì sao repo này có `.gitignore` ngay từ đầu.

## 6. Pull Request — và vì sao tự review chính mình

PR là một đề nghị: *"tôi muốn ghép nhánh này vào main, xem giúp."* Nó là nơi review code trước khi vào nhánh chính.

Làm một mình thì PR có vẻ vô nghĩa. Nhưng:

1. **Đọc code của mình ở giao diện khác thì thấy lỗi khác.** Nghe lạ nhưng đúng — đọc diff trên GitHub bắt được nhiều thứ mà đọc trong editor bỏ sót.
2. **Tập thói quen trước khi cần.** Vào công ty là PR mỗi ngày.
3. **Nó là hồ sơ.** Nhà tuyển dụng xem PR của bạn để biết bạn nghĩ thế nào, không chỉ code thế nào.

Tự review thì để lại comment thật: *"chỗ này chưa xử lý trường hợp danh sách rỗng"*, *"tên biến này không nói lên gì"*. Rồi sửa và push tiếp lên cùng nhánh.

## 7. `rebase -i` — dọn lịch sử trước khi cho người khác xem

Trong lúc làm, commit của bạn thường lộn xộn: `them ham`, `sua typo`, `sua lai`, `quen file`. Không ai muốn đọc lịch sử đó.

```bash
git rebase -i HEAD~3
```

Mở ra danh sách 3 commit gần nhất, bạn đánh dấu `squash` để gộp, `reword` để sửa message, `drop` để bỏ.

> **Quy tắc vàng của rebase: chỉ rebase nhánh CHƯA push, hoặc nhánh chỉ mình bạn dùng.**
>
> Rebase viết lại mã băm. Rebase một nhánh người khác đang dùng là gây hỗn loạn cho họ.

*Ghi chú môi trường: `rebase -i` mở trình soạn thảo tương tác, và trong terminal của Claude Code thì không dùng được. Làm nó trong terminal thường của bạn.*

## 8. Tag và release

```bash
git tag -a v0.1.0 -m "Xong Khối 0"
git push origin v0.1.0
```

Nhánh di chuyển, **tag thì không**. Tag đánh dấu vĩnh viễn một điểm: "đây là bản v0.1.0".

Trong lộ trình này, tag mỗi khi xong một khối. Sáu tháng nữa nhìn lại, tag cho bạn thấy tiến trình rõ hơn bất cứ thứ gì.

## 9. Từ bài này trở đi

Repo nên **public**. Lý do không phải khoe — mà là:

- Lịch sử commit 6 tháng là bằng chứng nghề nghiệp mạnh nhất bạn có
- Biết có người đọc được làm bạn viết cẩn thận hơn. Đó là áp lực tốt
- Nhà tuyển dụng thật sự có mở ra xem
