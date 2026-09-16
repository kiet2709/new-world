# Lý thuyết — Bài 06: Lưới an toàn — cách sửa sai

> **Bài này tồn tại vì một lý do: sợ Git là do không biết cách lùi. Biết lùi thì dám tiến.**

## 1. Ba loại "quay lại" hoàn toàn khác nhau

Người mới thường chỉ biết một lệnh rồi dùng cho mọi tình huống — thường là `reset --hard`, và đó là cách mất việc.

| Muốn gì | Lệnh | Tác động |
|---|---|---|
| Bỏ sửa đổi **chưa commit** | `git restore` | Chỉ đụng file, không đụng lịch sử |
| **Dịch con trỏ nhánh** về commit cũ | `git reset` | Viết lại lịch sử cục bộ — **nguy hiểm nếu đã push** |
| **Tạo commit phủ định** commit cũ | `git revert` | Thêm commit mới, lịch sử giữ nguyên — an toàn |

Nhớ một câu: **`reset` xoá lịch sử, `revert` thêm vào lịch sử.**

## 2. `git restore` — bỏ cái chưa commit

```bash
git restore <file>              # vứt sửa đổi trong working dir
git restore --staged <file>     # bỏ file khỏi staging (vẫn giữ sửa đổi)
git restore --source=HEAD~2 <file>   # lấy lại file từ 2 commit trước
```

Cảnh báo: `git restore <file>` **không lùi lại được**. Sửa đổi đó chưa bao giờ vào Git nên Git không có gì để cứu. Đây là thao tác nguy hiểm nhất trong bài, dù trông vô hại nhất.

## 3. `git reset` — ba mức, khác nhau ở chỗ dừng lại

Cả ba đều **dịch con trỏ nhánh** về commit bạn chỉ định. Khác nhau ở chỗ nó làm gì với staging và working dir:

```
                   Repository   Staging   Working Dir
   --soft              lùi       giữ         giữ        ← sửa đổi vào staging
   --mixed (mặc định)  lùi       xoá         giữ        ← sửa đổi về working dir
   --hard              lùi       xoá         XOÁ        ← mất sạch
```

Thực dụng:

```bash
git reset --soft HEAD~1    # gộp/sửa commit vừa rồi, giữ nguyên thay đổi
git reset HEAD~1           # bỏ commit, thay đổi quay về chưa-add
git reset --hard HEAD~1    # xoá commit VÀ mọi thay đổi. Cẩn thận.
```

**Làm cả ba trong repo nháp và quan sát `git status` sau mỗi lần.** Đó là cách duy nhất để nhớ chúng khác nhau chỗ nào.

## 4. `git revert` — cách đúng khi đã push

Commit đã lên remote và người khác đã lấy về. Giờ `reset` là **viết lại lịch sử chung** → người khác kéo về sẽ xung đột, hoặc bạn phải `push --force` và làm hỏng việc của họ.

`revert` tạo một commit mới có nội dung **ngược lại** commit cũ:

```
   c1 ──→ c2 ──→ c3(lỗi) ──→ c4 ──→ c5(revert c3)
```

c3 vẫn còn trong lịch sử — ai cũng thấy đã có lỗi và đã sửa. Đó là điều tốt: **lịch sử trung thực**.

> **Quy tắc vàng:** commit **chưa** push thì `reset` thoải mái. Commit **đã** push thì luôn `revert`.

Tình huống thật: *"production lỗi, rollback ngay"*. Đáp án là `revert`, không phải `reset`.

## 5. `git stash` — cất tạm

Đang làm dở, có việc gấp phải sửa chỗ khác, mà chưa muốn commit thứ dang dở:

```bash
git stash                  # cất hết, thư mục về sạch
git stash list             # xem đang cất những gì
git stash pop              # lấy ra và xoá khỏi kho cất
git stash apply            # lấy ra nhưng vẫn giữ trong kho
git stash -u               # cất cả file chưa được Git theo dõi
```

Cạm bẫy: stash dễ bị quên. Cất ba tuần rồi `pop` thì conflict tùm lum. Dùng cho việc ngắn hạn thôi.

## 6. `git reflog` — mạng lưới cuối cùng

**Đây là thứ đáng giá nhất bài này.** Git ghi lại **mọi lần `HEAD` di chuyển** — kể cả những commit bạn tưởng đã xoá.

```bash
git reflog
# a3f5c91 HEAD@{0}: reset: moving to HEAD~1
# 9d2e1f0 HEAD@{1}: commit: them tinh nang X     ← commit "đã mất"
```

Cứu lại:

```bash
git reset --hard 9d2e1f0        # hoặc
git branch cuu-lai 9d2e1f0      # an toàn hơn: tạo nhánh mới trỏ vào nó
```

Vì sao được: `reset --hard` chỉ **dịch con trỏ**. Commit vẫn nằm nguyên trong kho, chỉ là không còn nhánh nào trỏ tới. Git giữ nó khoảng 90 ngày trước khi dọn.

> **Làm bằng được bài tập này:** cố ý `reset --hard` mất một commit, rồi cứu lại bằng reflog. Làm một lần là bạn hết sợ Git vĩnh viễn. Đó là mục đích thật của cả bài.

## 7. `--amend` — sửa commit vừa xong

```bash
git commit --amend                    # sửa message
git add <file-quen>; git commit --amend --no-edit   # thêm file quên
```

`--amend` **tạo commit mới thay thế** commit cũ (băm đổi). Nên: chỉ amend khi **chưa push**.

## 8. Bảng tra cứu — tự viết vào nhật ký

Mục tiêu bài này là bạn có bảng riêng, ít nhất 7 dòng, **mỗi dòng đã tự làm thật**:

| Tôi lỡ tay... | Dùng |
|---|---|
| Sửa hỏng file, chưa commit | `git restore <file>` |
| `add` nhầm file | `git restore --staged <file>` |
| Commit thiếu file | `git add ...` + `git commit --amend --no-edit` |
| Commit sai, chưa push | `git reset --soft HEAD~1` |
| Commit sai, **đã push** | `git revert <hash>` |
| Đang dở, cần chuyển việc gấp | `git stash` |
| Lỡ `reset --hard`, mất commit | `git reflog` → `git branch cuu-lai <hash>` |
