# Lý thuyết — Bài 05: Nhánh, merge, và conflict

## 1. Branch chỉ là một con trỏ — thật đấy

Nhiều người tưởng tạo nhánh là chép cả dự án ra một bản khác. **Không.**

> Một nhánh trong Git là **một file văn bản 41 byte** chứa mã băm của một commit.

Mở ra xem cho tin:

```bash
cat .git/refs/heads/main      # in ra đúng một dòng mã băm
```

Vì vậy tạo nhánh **tức thì**, và tốn gần như 0 byte. Đây là lý do văn hoá Git khuyến khích tạo nhánh thoải mái — nó rẻ đến mức không cần tiết kiệm.

```
                    ┌── feat/them-median ──→ c4
                    │
   c1 ──→ c2 ──→ c3 ─┤
                    │
                    └── main ──→ c5
```

Cả hai nhánh cùng dùng chung c1, c2, c3. Không có bản sao nào cả.

## 2. HEAD di chuyển thế nào

```
   HEAD ──→ main ──→ c3          (đang ở main)

   git switch -c feat/abc

   HEAD ──→ feat/abc ──→ c3      (nhánh mới, VẪN commit cũ)
                main ──→ c3
```

Tạo nhánh mới **không** thay đổi file nào trong thư mục. Nó chỉ tạo thêm một con trỏ và chuyển `HEAD` sang đó. Commit tiếp theo mới làm hai nhánh tách ra.

`git switch <nhánh>` làm hai việc: chuyển `HEAD`, và **trải nội dung ảnh chụp của nhánh đó ra thư mục làm việc**.

*Lệnh cũ là `git checkout`, làm quá nhiều việc khác nhau nên hay gây nhầm. Git hiện đại tách thành `switch` (đổi nhánh) và `restore` (khôi phục file). Dùng hai lệnh mới.*

## 3. Hai kiểu merge

### Fast-forward — khi không có gì phân kỳ

```
   main ──→ c1 ──→ c2
                    └── feat ──→ c3 ──→ c4
```

`main` không tiến thêm bước nào từ lúc tách. Git chỉ việc **đẩy con trỏ `main` tới c4**. Không tạo commit mới, lịch sử thẳng băng.

```
   main ─────────────────────────→ c4
```

### Merge commit — khi cả hai cùng tiến

```
   main ──→ c1 ──→ c2 ──→ c5
                    └── feat ──→ c3 ──→ c4
```

Giờ không đẩy con trỏ được nữa. Git tạo một commit mới có **hai cha**:

```
   main ──→ c1 ──→ c2 ──→ c5 ──→ M
                    └── c3 ──→ c4 ─┘
```

`M` là merge commit. Nó là commit duy nhất có hai parent, và đó là cách Git ghi lại "hai dòng công việc hợp lại ở đây".

Xem bằng mắt:

```bash
git log --oneline --graph --all
```

Lệnh này nên thành phản xạ. Chạy nó sau mỗi thao tác nhánh ở bài này.

## 4. Conflict — vì sao xảy ra và vì sao Git không tự đoán

Git hợp nhất theo **vùng dòng**. Hai nhánh sửa hai chỗ khác nhau trong cùng một file → Git tự ghép được. Hai nhánh sửa **cùng một vùng dòng** → Git dừng lại.

Nó dừng **không phải vì kém**. Nó dừng vì không có cách nào biết ý bạn:

```python
# nhánh A
def tinh(data):
    return sum(data) / len(data)

# nhánh B
def tinh(data):
    return statistics.median(data)
```

Giữ cái nào? Hay giữ cả hai đổi tên? Chỉ con người biết. Máy đoán ở đây là máy phá.

> **Conflict không phải lỗi.** Nó là Git nói: *"chỗ này cần người quyết."* Sợ conflict là sợ nhầm chỗ.

## 5. Đọc dấu conflict

```
<<<<<<< HEAD
    return sum(data) / len(data)
=======
    return statistics.median(data)
>>>>>>> feat/them-median
```

| Phần | Là gì |
|---|---|
| `<<<<<<< HEAD` → `=======` | Phiên bản ở **nhánh bạn đang đứng** |
| `=======` → `>>>>>>> tên` | Phiên bản ở **nhánh bạn đang merge vào** |

Giải xong phải **xoá cả ba dòng dấu**, giữ lại nội dung bạn muốn (có thể là cả hai, có thể là cái thứ ba bạn tự viết), rồi:

```bash
git add <file>        # báo Git: tôi giải xong rồi
git commit            # hoàn tất merge
```

`git merge --abort` huỷ toàn bộ, quay về trước khi merge. Biết có đường lùi thì đỡ hoảng.

## 6. Vì sao phải cố tình tạo conflict

Làm một mình thì hiếm khi gặp conflict — nhưng đi làm thì gặp mỗi tuần. Nếu lần đầu bạn gặp là lúc đang gấp trong việc thật thì rất tệ.

Nên bài này **dựng ra** tình huống: hai nhánh, cùng sửa một hàm, merge, giải. Làm 2–3 lần cho quen tay. Đây là "dàn dựng case khó" mà mục 6 của la bàn nói tới.

## 7. Quy ước đặt tên nhánh

```
main              nhánh chính, luôn ở trạng thái chạy được
feat/ten-viec     thêm tính năng
fix/ten-loi       sửa lỗi
exp/thu-nghiem    thử nghiệm, có thể vứt
```

Thói quen này miễn phí lúc làm một mình, và bắt buộc khi làm nhóm. Tập ngay từ giờ.
