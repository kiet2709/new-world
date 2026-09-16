# Lý thuyết — Bài 04: Git, mô hình tư duy

> Bài quan trọng nhất trong bốn bài Git. Gần như mọi hiểu lầm về Git về sau đều bắt nguồn từ chỗ không có mô hình này trong đầu.

## 1. Git KHÔNG lưu thay đổi — nó lưu ảnh chụp

Đây là hiểu lầm phổ biến nhất, và nó làm mọi thứ khác trở nên khó hiểu.

Nhiều hệ thống cũ (SVN, CVS) lưu: *"file A, dòng 12, đổi từ X sang Y"*. Git thì khác hẳn:

> **Mỗi commit là một ảnh chụp toàn bộ dự án tại một thời điểm.**

File nào không đổi thì Git không chép lại — nó chỉ trỏ vào bản cũ. Nhưng về mặt khái niệm, mỗi commit là **một trạng thái hoàn chỉnh**, không phải một mẩu thay đổi.

Nắm điều này thì các thứ sau trở nên hiển nhiên:
- Vì sao chuyển nhánh nhanh đến thế → chỉ việc trải một ảnh chụp khác ra
- Vì sao Git gần như không mất dữ liệu → ảnh chụp cũ vẫn còn nguyên đó
- Vì sao `git diff` phải **tính ra** chứ không phải đọc sẵn

## 2. Ba vùng — vẽ được cái này là xong bài

```
   Working Directory      Staging Area          Repository
   (thư mục làm việc)     (khu chờ)             (kho, .git/)

   file bạn đang sửa  ──→  ảnh chụp nháp  ──→   commit vĩnh viễn
                 git add              git commit

        ▲                                            │
        └──────────────── git checkout ──────────────┘
```

| Vùng | Là gì | Lệnh đưa vào |
|---|---|---|
| **Working Directory** | Thư mục thật, file bạn mở bằng VS Code | (sửa file) |
| **Staging Area** (index) | Bản nháp của commit kế tiếp | `git add` |
| **Repository** | Lịch sử vĩnh viễn trong `.git/` | `git commit` |

### Vì sao có vùng giữa?

Người mới hay thấy staging area thừa. Nó tồn tại để bạn **chọn** cái gì vào commit nào.

Bạn sửa 5 file: 3 file để sửa một lỗi, 2 file để thêm tính năng. Không có staging thì bạn buộc phải gộp cả 5 vào một commit lộn xộn. Có staging thì `add` 3 file, commit, rồi `add` 2 file, commit — hai commit sạch, mỗi cái kể một chuyện.

> Lịch sử Git là một **câu chuyện bạn kể cho người đọc sau này** — kể cả khi người đọc đó là chính bạn sáu tháng nữa, hoặc nhà tuyển dụng. Staging area là công cụ để kể cho gọn.

## 3. Commit thật ra là gì

Một commit chứa:

```
commit a3f5c91
├── tree      → ảnh chụp toàn bộ cây thư mục
├── parent    → commit trước nó (a3f5c91 sinh ra từ đâu)
├── author    → ai viết, khi nào
└── message   → bạn giải thích vì sao
```

**`parent` là mấu chốt.** Mỗi commit trỏ ngược về cha nó, tạo thành một chuỗi. Chuỗi đó chính là lịch sử.

Mã băm `a3f5c91...` được tính từ **toàn bộ nội dung** commit. Đổi một ký tự trong bất cứ file nào → băm khác → commit khác. Vì vậy lịch sử Git **không sửa được âm thầm** — sửa là mã băm đổi, và ai cũng thấy.

## 4. HEAD — bạn đang đứng ở đâu

`HEAD` là con trỏ nói: *"bạn đang ở commit nào"*. Bình thường nó trỏ vào một nhánh, và nhánh trỏ vào một commit.

```
HEAD ──→ main ──→ a3f5c91 ──→ 9d2e1f0 ──→ 4b8c3a2
                  (mới nhất)              (cũ nhất)
```

Gần như mọi lệnh Git đều nói về `HEAD`: `HEAD~1` là commit cha, `HEAD~3` là ba đời trước.

## 5. `git status` — đọc cho hiểu, đừng lướt

`status` là lệnh bạn sẽ gõ nhiều nhất. Nó nói chính xác **file đang ở vùng nào**:

```
Changes to be committed:        ← đang ở STAGING, sẽ vào commit tới
        modified:   analyze.py

Changes not staged for commit:  ← đang ở WORKING DIR, chưa add
        modified:   README.md

Untracked files:                ← Git chưa từng biết file này
        sensor_log.csv
```

Ba nhóm = ba vùng. Đọc được `status` là đọc được trạng thái ba vùng.

**Một tình huống hay làm người mới rối:** `add` một file rồi sửa tiếp file đó. Giờ nó xuất hiện ở **cả hai** nhóm đầu — phiên bản lúc `add` nằm ở staging, phiên bản mới hơn nằm ở working dir. Hoàn toàn hợp lý khi bạn có mô hình ba vùng.

## 6. Hai lệnh diff, vì hai khoảng cách

```
Working Dir  ←── git diff ──→  Staging  ←── git diff --staged ──→  Repository
```

- `git diff` — cái tôi vừa sửa mà **chưa** add
- `git diff --staged` — cái sắp đi vào commit tới
- `git diff HEAD` — tất cả thay đổi so với commit gần nhất

Thói quen tốt: **luôn `git diff --staged` trước khi commit**. Nó là lần đọc lại cuối cùng.

## 7. Viết commit message

Không phải hình thức. Sáu tháng nữa bạn `git log` để tìm "chỗ nào sửa cái debounce" — commit message là thứ duy nhất giúp bạn.

```
b13: doc nut bam chong nhieu bang debounce 50ms

Nut co thoi gian nhieu ~20ms do bang timestamp.
Chon 50ms de du bien an toan ma nguoi dung khong thay tre.
```

- Dòng đầu ngắn (dưới ~50 ký tự), nói **làm gì**
- Dòng sau (nếu cần) nói **vì sao**, không nói *thế nào* — code đã nói rồi
- Tránh "fix bug", "update", "abc" — vô nghĩa với bạn-tương-lai

Lộ trình này dùng tiền tố `bNN:` để commit tự xếp theo bài.

## 8. Tự tạo sân tập

Làm bài này trong một repo nháp, **không phải repo thật**:

```bash
mkdir -p /tmp/git-tap && cd /tmp/git-tap && git init
```

Ở đây bạn được phép làm hỏng mọi thứ. Đó chính là điều kiện để học nhanh.

**Sau MỖI lệnh, gõ `git status` và đọc.** Nghe máy móc, nhưng đó là cách xây mô hình ba vùng trong đầu nhanh nhất.
