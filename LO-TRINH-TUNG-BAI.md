# Lộ Trình Từng Bài — CHẶNG 1

> Bản thực thi của [lo-trinh-hoc-nhung-edge-ai.md](lo-trinh-hoc-nhung-edge-ai.md).
> File kia là **la bàn** (tại sao đi hướng này). File này là **bản đồ đường đi** (làm gì, theo thứ tự nào, xong khi nào).
> Khi hai file mâu thuẫn: la bàn thắng.

---

## Cách gọi tên — đọc một lần cho khỏi lẫn

| Cấp | Nghĩa |
|---|---|
| **CHẶNG** | Giai đoạn lớn của sự nghiệp. Chặng 1 = 64 bài trong file này. Chặng 2 = [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md) |
| **KHỐI** | Nhóm bài bên trong một chặng. Chặng 1 có 7 khối (Khối 0 → Khối 6) |
| **BÀI** | Đơn vị nhỏ nhất, 4–6 giờ, kết thúc bằng một commit |

---

## Cách dùng repo này

```
new_world/
├── docker/              # Dockerfile Python + C++ + mosquitto.conf
├── docker-compose.yml   # py, cpp (mặc định) + mqtt, db, grafana (profile "ot")
├── dev.ps1              # cửa vào duy nhất trên Windows
├── Makefile             # bản tương đương khi ở Git Bash / WSL / trên Pi
├── docs/cach-hoc.md     # giao thức học mỗi buổi — đọc trước khi vào bài đầu
├── lessons/NN-ten-bai/  # mỗi bài một thư mục
│   ├── LY-THUYET.md     #   TÔI viết — nền lý thuyết tối thiểu, đọc trước khi làm
│   ├── README.md        #   đề bài + tiêu chí nghiệm thu
│   └── NHAT-KY.md       #   BẠN viết — kẹt ở đâu, hiểu ra gì, số liệu đo được
└── docs/                # tài liệu bạn tự viết ra trong quá trình học
```

**Khởi động mỗi buổi học:**

```powershell
.\dev.ps1 up          # bật môi trường
.\dev.ps1 py          # vào shell Python
.\dev.ps1 cpp         # vào shell C++
```

---

## Mỗi bài có ba file, ba vai

| File | Ai viết | Khi nào |
|---|---|---|
| `LY-THUYET.md` | **Tôi viết** | Đọc **đầu tiên**, trước khi gõ dòng nào |
| `README.md` | Tôi viết | Đọc sau lý thuyết — đề bài và tiêu chí xong |
| `NHAT-KY.md` | **Bạn viết** | Trong và sau khi làm |

Quy tắc phân chia:

- Khái niệm nền (layer là gì, staging area là gì, Modbus register là gì) → **tôi đưa cho bạn**. Đây không phải chỗ để mò.
- Cách áp dụng, cách gỡ lỗi, cách đo, chọn phương án nào → **bạn tự vật lộn**. Đây mới là chỗ sinh ra kỹ sư.

---

## Bốn kỷ luật xuyên suốt (vi phạm là lộ trình hỏng)

**1. Mỗi bài kết thúc bằng một commit.** Không có commit = bài chưa xong.

**2. Bài có nhãn `[SO-SÁNH]` phải viết bằng CẢ hai ngôn ngữ trên CÙNG một bài toán**, rồi điền bảng so sánh. Hai ngôn ngữ trên hai bài toán khác nhau = song song rời rạc, vô giá trị.

**3. Phép thử tắt AI — cuối mỗi khối.** Chọn một phần đã làm, tắt AI, tự viết lại. Ghi kết quả trung thực:
- *Hiểu từng bước, chỉ gõ chậm* → ổn, luyện thêm.
- *Nhìn mà không hiểu vì sao nó chạy* → quay lại bài đó. Tín hiệu quan trọng nhất trong cả lộ trình.

**4. Mọi kết luận về hiệu năng phải có SỐ.** Không viết "C++ nhanh hơn". Viết "C++ 0.8ms/lần đọc vs Python 4.2ms, RAM 2MB vs 31MB, trên Pi 4, 10000 lần lặp".

**5. Mỗi bài ghi thuật ngữ mới vào [docs/tu-vung.md](docs/tu-vung.md) — Việt · English · 日本語.** ~10 phút/bài. Học tên gọi *ngay lúc vừa hiểu khái niệm* rẻ hơn học ngôn ngữ tách rời rất nhiều. Tiếng Anh để đọc datasheet và paper; tiếng Nhật vì mảng **検査装置** đang được offshore từ Nhật về Việt Nam.

---

## Nhịp học và thời lượng

64 bài, 20+ giờ/tuần, ~4 bài/tuần → **16 tuần lý tưởng, 22–24 tuần thực tế** (~5.5–6 tháng). Luôn trượt, đó là bình thường.

| Khối | Nội dung | Bài | Số bài |
|---|---|---|---|
| 0 | Nền tảng công cụ: Docker, Git, hai ngôn ngữ | 00–09 | 10 |
| 1 | Embedded Linux trên Pi | 10–18 | 9 |
| 2 | ESP32-S3 và cây cầu OT | 19–29 | 11 |
| 3 | Thị giác máy và AI trên edge | 30–41 | 12 |
| 4 | C++ vào cuộc | 42–45 | 4 |
| 5 | Viết ứng dụng thật (C#) | 46–50 | 5 |
| 6 | Chịu lỗi, CI, giao hàng | 51–55 | 5 |

---

# KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ (Bài 00–13, ~3.5 tuần)

*Sau khối này bạn không phải nghĩ về môi trường nữa, **và có nền thật ở cả Python lẫn C++** — không còn đọc code mình viết mà không hiểu vì sao nó chạy.*

### Bài 00 — Bức tranh tổng thể  `[ĐỌC — không gõ code]`

**Mục tiêu:** thấy cái máy hoàn chỉnh trước khi học từng con ốc. Không có bước này thì 43 bài sau là 43 mảnh rời.

**Làm gì:** đọc hết `LY-THUYET.md` của bài này. Nó trả lời:
- Tầng IT và tầng OT là gì, ranh giới nằm ở đâu, **bạn đứng chỗ nào**.
- Hệ thống cuối cùng gồm những nhân vật nào (camera, Pi, ESP32, broker, database, dashboard), mỗi nhân vật làm gì, dữ liệu chảy theo hướng nào.
- Vì sao cần Docker. Vì sao cần Git. Vì sao cần cả Python lẫn C++.
- Mỗi chặng lắp thêm mảnh nào vào bức tranh.

**Xong khi:** lấy tờ giấy trắng, **vẽ lại sơ đồ hệ thống cuối cùng bằng tay, không nhìn tài liệu**. Rồi khoanh lên đó: chỗ nào tôi đã biết, chỗ nào hoàn toàn mù. Chụp ảnh bỏ vào `NHAT-KY.md`.

Cuối Chặng 1 bạn sẽ vẽ lại lần nữa và so hai bức. Đó là thước đo tiến bộ thật nhất bạn có.

---

---

---

### Bài 01 — Docker: vì sao container tồn tại

**Lý thuyết cần đọc trước:** máy ảo khác container chỗ nào · image khác container chỗ nào · vòng đời một container · vì sao "chạy được trên máy tôi" là một vấn đề có thật.

**Làm gì:** sống với container chứ chưa build gì cả.
- `docker run` một image có sẵn (`alpine`, `python:3.12-slim`) — chạy một lệnh rồi container tự chết. Vì sao nó chết?
- `docker run -it` — vào trong, ngó nghiêng, `exit`. Container còn sống không?
- `docker ps` vs `docker ps -a` — khác nhau chỗ nào, và điều đó nói gì về vòng đời?
- `docker exec`, `docker logs`, `docker stop`, `docker rm`.
- Tạo file trong container rồi `rm` container → tạo lại → file còn không?

**Xong khi:** giải thích được bằng lời — container khác máy ảo chỗ nào, một image đẻ ra được mấy container, và **cái gì mất khi container chết**.

**Bẫy:** đừng đụng Dockerfile ở bài này. Chưa tới lượt.

---

---

---

### Bài 02 — Docker: image, layer, và cache

**Lý thuyết cần đọc trước:** Dockerfile là công thức · mỗi lệnh sinh một layer · cache key được tính thế nào · vì sao cache hỏng một layer thì **mọi layer phía sau hỏng theo**.

**Làm gì:**
- `docker history new_world-py` — nhìn thấy từng layer và kích thước của nó.
- `docker images` — **ghi lại size** của `new_world-py` và `new_world-cpp`. Bài 44 sẽ ép con số này xuống, cần mốc để so.
- Thí nghiệm cache: sửa `requirements.txt` → build → đo. Sửa một file `.py` → build → đo. Giải thích chênh lệch.
- **Đọc `docker/python/Dockerfile` và trả lời: có dòng nào COPY file `.py` vào image không?** Nếu không — thí nghiệm trên thật sự đang đo cái gì?
- `docker images -a` trước và sau khi build lại: image cũ có **biến mất** không?
- Tự viết một Dockerfile bé xíu (3–4 dòng), cố tình đặt sai thứ tự lệnh, đo, rồi sắp lại cho đúng.

**Xong khi:** **dự đoán đúng TRƯỚC khi chạy** — "tôi sửa dòng này thì build lại sẽ mất khoảng bao lâu, vì sao". Đoán đúng ba lần liên tiếp là bạn đã hiểu cache.

---

---

---

### Bài 03 — Docker: dữ liệu, mạng, và compose

**Lý thuyết cần đọc trước:** filesystem của container là tạm · bind mount khác volume · network bridge và DNS theo tên service · compose là gì và `profiles` để làm gì.

**Làm gì:**
- Bind mount **cả hai chiều**: tạo file trên Windows → tìm trong container. Tạo trong container → tìm trên Windows.
- `docker compose down` rồi `up` — file trong `/work` còn không? File trong volume `py-cache` còn không? Vì sao khác nhau?
- `.\dev.ps1 nuke` — giờ cái gì mất?
- Mạng: từ container `py` ping container `cpp` **bằng tên**. Vì sao gọi được bằng tên mà không cần IP?
- Đọc `docker-compose.yml` của repo, giải thích từng khối cho chính mình.

**Xong khi:** vẽ được bảng "dữ liệu nào sống sót qua `down` / qua `nuke` / qua `docker rm`", và trả lời không do dự: mất điện máy tính thì mất gì?

---

---

---

### Bài 04 — Git: mô hình tư duy

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

### Bài 05 — Git: nhánh, merge, và conflict

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

### Bài 06 — Git: lưới an toàn — cách sửa sai

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

### Bài 07 — Git: remote, GitHub, và quy trình làm việc

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

### Bài 08 — Python: cốt lõi  `[ĐỆM]`

*Bài đệm. Bạn đã viết Python nhưng chủ yếu bằng AI. Bài này lấp lại nền để đọc code Python lạ mà không phải đoán.*

**Lý thuyết:** Python chạy thế nào (thông dịch qua bytecode, và vì sao nó chậm hơn C++) · **mutable và immutable** · biến là **nhãn dán vào object**, không phải cái hộp · list/dict/set/tuple khác nhau chỗ nào và khi nào dùng cái nào.

**Làm gì:**
- Kiểu dữ liệu, chuỗi và f-string · `list` / `dict` / `set` / `tuple` thao tác thật
- **Comprehension** — viết được và đọc được
- Hàm: tham số mặc định, `*args`/`**kwargs`, và **cái bẫy mutable default argument**
- `a = b = [1,2]` rồi sửa `a` → `b` đổi theo. Vì sao? Đây là gốc của rất nhiều bug im lặng
- `copy` vs `deepcopy`
- Module, package, `import` — và vì sao `if __name__ == "__main__"` tồn tại
- `venv` và `pip`: vì sao trong container vẫn cần hiểu chúng

**Xong khi:** giải thích được vì sao `def f(x, lst=[])` là bug; đọc một file Python lạ mà không phải tra cú pháp từng dòng.

---

### Bài 09 — Python: đủ dùng cho hệ thống thật  `[ĐỆM]`

**Lý thuyết:** exception và triết lý EAFP (*xin lỗi dễ hơn xin phép*) · context manager · **iterator/generator và vì sao "lười" lại quan trọng** khi xử lý luồng dữ liệu không có điểm dừng · type hint để làm gì khi Python không ép kiểu.

**Làm gì:**
- `try`/`except`/`else`/`finally` đúng cách · **đừng bao giờ `except:` trần** · tự định nghĩa exception
- `with` và **tự viết một context manager** (mở/đóng cổng serial chẳng hạn)
- **Generator** đọc file 1GB mà không nạp hết vào RAM — so RAM đỉnh với cách đọc thường
- `dataclass`
- Type hint + `ruff` bắt lỗi
- **`logging` thay cho `print`** — mức log, handler, format. Từ bài này trở đi không dùng `print` trong code thật nữa

**Xong khi:** viết được generator xử lý luồng cảm biến liên tục; mọi script của bạn dùng `logging`; giải thích được vì sao generator tiết kiệm RAM.

---

### Bài 10 — C++: mô hình biên dịch, kiểu, bộ nhớ  `[ĐỆM]`

*Bài đệm. C++ không khó vì cú pháp — khó vì nó bắt bạn nghĩ về những thứ Python giấu đi. Bài này bày hết ra.*

**Lý thuyết:** **tiền xử lý → biên dịch → liên kết**, và lỗi ở mỗi bước trông khác nhau thế nào (lỗi linker "undefined reference" là gì) · header và source tách làm gì · include guard · **stack và heap** · con trỏ và tham chiếu · **vì sao C++ không dọn bộ nhớ hộ bạn**.

**Làm gì:**
- Hello world tách `.h` / `.cpp`, biên dịch bằng tay từng bước để **thấy** ba giai đoạn
- Cố tình gây lỗi linker rồi đọc hiểu thông báo
- Các kiểu số, `int` tràn số, `size_t`, và vì sao `auto` hữu ích
- Con trỏ, tham chiếu, `nullptr` — vẽ ra giấy cái nào trỏ vào đâu
- Mảng C vs `std::vector`
- Truyền theo giá trị / tham chiếu / con trỏ — **đo chi phí sao chép** với một object lớn
- **Cố tình gây memory leak rồi bắt bằng `valgrind`**

**Xong khi:** đọc được thông báo lỗi của compiler và linker mà không hoảng; giải thích được stack khác heap chỗ nào và biến của bạn nằm ở đâu.

---

### Bài 11 — C++: class, STL, RAII  `[ĐỆM]`

**Lý thuyết:** class và struct · constructor/destructor · **RAII — ý tưởng trung tâm của C++** · `const` correctness · STL: `vector`, `string`, `map`, `<algorithm>` · template ở mức **dùng được**, chưa cần viết.

**Làm gì:**
- Viết một class quản lý tài nguyên (file handle hoặc cổng serial) — **destructor tự đóng**
- Chứng minh nó tự đóng kể cả khi có exception. Đây là thứ Python cần `with` mới làm được
- `std::vector`, `std::string`, `std::map` — thao tác thật
- `<algorithm>`: `sort`, `find_if`, `transform`
- `std::unique_ptr` và vì sao nó tốt hơn `new`/`delete`
- Biên dịch với `-Wall -Wextra` và **sửa hết cảnh báo**, không bỏ qua cái nào

**Xong khi:** viết được một class RAII chạy đúng; giải thích được vì sao C++ có destructor còn Python thì không cần.

---

### Bài 12 — Cùng một bài toán, hai ngôn ngữ  `[SO-SÁNH]`

**Lý thuyết cần đọc trước:** biên dịch khác thông dịch · kiểu tĩnh khác kiểu động · ai quản lý bộ nhớ trong mỗi ngôn ngữ.

**Bài toán:** đọc `sensor_log.csv` (timestamp, nhiệt độ, độ ẩm — có dòng hỏng, có giá trị thiếu) → tính min/max/trung bình, phát hiện outlier (lệch hơn 3σ), in báo cáo.

File sinh dữ liệu đã có sẵn: `python gen_data.py 1000000`.

**Làm gì:**
- Viết `python/analyze.py` và `cpp/analyze.cpp`. Cùng input, cùng output — `diff` hai output phải rỗng.
- Cả hai phải xử lý dòng hỏng mà không crash.
- Đo thời gian chạy trên file 1 triệu dòng.

**Xong khi:** có bảng 5 cột — *số dòng code · thời gian chạy · RAM đỉnh · thứ ngôn ngữ làm hộ bạn · thứ nó bắt bạn tự làm*.

**Câu bắt buộc trả lời được:** trong C++ ai giải phóng bộ nhớ của cái vector đó? Trong Python ai làm? Điều đó đổi cách bạn viết code thế nào?

---

---

---

### Bài 13 — CMake, pytest, và kỷ luật kỹ thuật

**Lý thuyết cần đọc trước:** vì sao C++ cần build system · biên dịch và liên kết là hai bước khác nhau · `Debug` khác `Release` chỗ nào · test tự động để làm gì khi chỉ có một mình.

**Làm gì:**
- `CMakeLists.txt` cho bài 12: target, `Debug` vs `Release`, build ra `build/`.
- Đo lại bản `Release` (`-O2`) so với `Debug`. Con số sẽ làm bạn bất ngờ.
- pytest cho `analyze.py`: test dòng hỏng, file rỗng, outlier biên.
- `make fmt`, `make lint`, `make test` chạy được.

**Xong khi:** `make test` xanh; cmake build ra binary; hiểu vì sao **đo hiệu năng trên bản Debug là vô nghĩa**.

> **PHÉP THỬ TẮT AI #1** — tắt AI, dựng lại từ đầu một repo Git nháp: init, 2 nhánh, 1 conflict, giải, tag. Không nhìn ghi chép.

---

---

---

# KHỐI 1 — Embedded Linux trên Pi (Bài 14–22, ~2.5 tuần)

*Sau khối này Pi không còn là "máy tính nhỏ" mà là **bệ chạy AI có chân cắm ra thế giới vật lý**.*

> **Về cái Pi đang chạy dự án của bạn:** bài 14 làm trên **thẻ SD hiện tại, chỉ đọc**. Từ bài 15 trở đi chuyển sang **thẻ SD mới**. Thẻ cũ cất đi, không đụng nữa. Một thẻ 32–64GB loại A2 khoảng 100–150k — rẻ hơn nhiều so với cái giá của việc làm hỏng hệ đang chạy.

### Bài 14 — Tiếp quản một hệ thống đang chạy  `[CHỈ ĐỌC]`

**Mục tiêu:** đây là kỹ năng mà một dự án cá nhân bình thường **không bao giờ dạy được** — bước vào hệ thống của người khác đang chạy, hiểu nó, mà không làm hỏng gì. Cái Pi của bạn tình cờ là một hệ thống như thế. Tận dụng.

**Luật của bài này: mọi lệnh phải là lệnh ĐỌC.** Không `install`, không `enable`, không sửa file cấu hình. Tự ép mình giữ kỷ luật đó chính là bài học.

**Làm gì:**
```bash
systemctl list-units --type=service --state=running   # cái gì đang chạy
systemctl cat <service>                                # nó được định nghĩa thế nào
ss -tulpn                                              # cổng nào bị chiếm, bởi ai
docker ps -a                                           # có container không
crontab -l; ls -la /etc/cron.d/                        # có job định kỳ không
df -h; free -h; vcgencmd measure_temp                  # đĩa, RAM, nhiệt
journalctl -u <service> --since "24 hours ago"         # nó có đang lỗi âm thầm không
ls -la /dev/i2c* /dev/tty* /dev/video*                 # thiết bị nào đang có
```

**Rồi sao lưu:** tạo ảnh toàn bộ thẻ SD (Win32DiskImager, hoặc `dd` trong WSL). Kiểm chứng ảnh đọc được.

**Xong khi:** có `docs/pi-hien-trang.md` — tài liệu bàn giao: service nào chạy, chiếm cổng nào, dùng thiết bị nào, còn bao nhiêu tài nguyên, rủi ro gì nếu cài thêm. Viết như thể sắp bàn giao cho người khác.

**Và một ảnh sao lưu đã kiểm chứng.** Có nó rồi thì mọi sai lầm về sau đều lùi được.

---

---

### Bài 15 — Dựng Pi học từ đầu (thẻ mới)

**Làm gì:** flash OS (bản Lite, không desktop) → SSH bằng **key**, tắt đăng nhập mật khẩu → hiểu group `dialout` / `i2c` / `gpio` / `video`, và vì sao thiếu group thì "Permission denied" dù `sudo` vẫn chạy được.

**Xong khi:** đăng nhập không cần mật khẩu; user thường (không sudo) đọc được `/dev/i2c-1`; giải thích được vì sao **không nên** chạy mọi thứ bằng root.

**Bẫy:** đừng cài desktop lên Pi. Mọi thứ qua SSH — đó là cách edge thật vận hành.

---

---

---

### Bài 16 — Linux nền cho người làm nhúng

**Mục tiêu:** `/dev`, `/sys`, `/proc` là chỗ phần mềm chạm phần cứng. Không hiểu chúng thì mọi thứ về sau là phép thuật.

**Làm gì:**
- Soi `/dev/i2c-1`, `/dev/ttyUSB0`, `/dev/gpiochip0` — chúng là *file*, nhưng là loại file gì?
- Đọc nhiệt độ CPU từ `/sys/class/thermal/thermal_zone0/temp`. Không thư viện nào cả, chỉ đọc file.
- Viết script bắt `SIGTERM` → dọn dẹp (tắt LED, đóng file) → thoát với exit code đúng.
- Dùng thử `ps`, `top`, `lsof`, và `strace` trên một lệnh đơn giản.

**Xong khi:** giải thích được "mọi thứ là file" nghĩa là gì với người làm nhúng; script của bạn tắt sạch khi bị `systemctl stop`, không để LED sáng mãi.

---

---

---

### Bài 17 — GPIO bằng Python

**Làm gì:** LED nhấp nháy → nút bấm bật/tắt LED → **chống nhiễu (debounce)** → PWM đổi độ sáng.

**Xong khi:** bấm nút 20 lần, LED đổi trạng thái đúng 20 lần — không nhiều hơn. Đo được thời gian nhiễu của nút bằng oscilloscope-nhà-nghèo: log timestamp mỗi lần chân đổi mức.

**Vì sao bài này quan trọng hơn vẻ ngoài của nó:** debounce là bài học đầu tiên rằng **thế giới vật lý bẩn**. Mọi thứ về sau — cảm biến nhiễu, mạng chập chờn, AI đoán sai — đều là biến thể của bài này.

---

---

---

### Bài 18 — I2C/SPI: đọc cảm biến thật

**Làm gì:** `i2cdetect -y 1` tìm địa chỉ → **đọc datasheet** (thanh ghi nào, đơn vị gì, chờ bao lâu) → đọc giá trị → xử lý khi rút dây giữa chừng.

**Xong khi:** số đọc ra đúng thực tế (hà hơi vào cảm biến, số phải nhảy); rút dây → chương trình báo lỗi rõ ràng và **không chết**.

**Kỹ năng thật đang luyện:** đọc datasheet. Đây là thứ phân biệt người làm nhúng với người copy thư viện.

---

---

---

### Bài 19 — systemd: dịch vụ tự phục hồi

**Làm gì:** biến script bài 18 thành service — `Restart=always`, `RestartSec`, `After=network.target`, log qua `journalctl`, thử `WatchdogSec`.

**Xong khi:** `kill -9` tiến trình → vài giây sau tự sống lại. Reboot Pi → tự chạy. `journalctl -u <service> -f` thấy log.

Đây là lần đầu bạn chạm vào **vận hành** — thứ khách hàng thật quan tâm hơn cả tính năng.

---

---

---

### Bài 20 — Docker trên Pi: kiến trúc arm64

**Làm gì:** cài Docker trên Pi → build image ngay trên Pi (chậm, để thấy nó chậm) → rồi dùng `docker buildx` trên PC build **multi-arch** (amd64 + arm64), đẩy lên registry.

**Xong khi:** cùng một lệnh `docker run` chạy được cùng một image trên cả PC và Pi. Giải thích được vì sao image amd64 không chạy trên Pi, và QEMU đang làm gì trong buildx.

**Điểm nhấn CV:** multi-arch build là thứ dân web hiếm khi đụng. Ghi lại thời gian build của hai cách.

---

---

---

### Bài 21 — Truyền thiết bị vật lý vào container

**Mục tiêu:** đây là chỗ Docker gặp phần cứng — case Docker "sát nhúng" nhất.

**Làm gì:** chạy code bài 18 **bên trong container** và truy cập được `/dev/i2c-1`:
- Thử `--privileged` trước (chạy được — nhưng vì sao đó là ý tồi?).
- Rồi làm đúng: `--device=/dev/i2c-1`, `group_add`, khai báo `devices:` trong compose.
- Thêm luôn camera `/dev/video0` và serial `/dev/ttyUSB0` — hai thứ sẽ cần ở Chặng 2 và 3.

**Xong khi:** container đọc được cảm biến **không cần `--privileged`**; viết được vào nhật ký vì sao `--privileged` là nợ bảo mật.

---

---

---

### Bài 22 — C++ đọc cảm biến, đo hiệu năng  `[SO-SÁNH]`

**Làm gì:** viết lại bài 18 bằng C++ thuần — mở `/dev/i2c-1` bằng `open()`, nói chuyện bằng `ioctl()`, không thư viện cao cấp.

**Đo (10.000 lần đọc, trên Pi):** thời gian mỗi lần đọc · RAM đỉnh · CPU% · thời gian khởi động tiến trình · kích thước binary so với kích thước runtime Python.

**Xong khi:** có bảng số liệu + một kết luận có căn cứ: *"với bài này tôi chọn X vì Y"*. Không có đáp án đúng chung — chỉ có đáp án đúng **cho bài toán cụ thể**.

Đây là cây cầu sang C++: bạn không học C++ từ hello world, bạn học nó để làm lại thứ mình đã hiểu.

> **PHÉP THỬ TẮT AI #2** — tắt AI, tự viết lại bài 17 (nút + LED + debounce) từ đầu. Ghi kết quả trung thực vào nhật ký.

---

---

---

# KHỐI 2 — ESP32-S3 và cây cầu OT (Bài 23–33, ~3.5 tuần)

*Khối đắt giá nhất của Chặng 1. Modbus/MQTT/OPC UA xuất hiện trong gần như mọi JD IoT, và đây là chỗ nền sản xuất–kho của bạn phát huy. Không cần PLC — ESP32 đóng vai "thiết bị kiểu máy" là đủ.*

## Khung tư duy: gateway có hai mặt

```
        ┌──────────── MẶT BẮC (hướng IT) ────────────┐
        │   MQTT · OPC UA · database · dashboard     │
        └────────────────────┬───────────────────────┘
                     ┌───────▼────────┐
                     │    GATEWAY     │  ← Pi, Python
                     │  (người dịch)  │
                     └───────┬────────┘
        ┌────────────────────▼───────────────────────┐
        │   MẶT NAM (hướng OT) — Modbus TCP / RTU    │
        │            thiết bị: ESP32                 │
        └────────────────────────────────────────────┘
```

Bài 23–26 xây **mặt nam**. Bài 31–29 xây **mặt bắc**. Nghề bắc cầu IT↔OT chính là nghề đứng ở cái hộp giữa.

### Bài 23 — ESP-IDF: chọn chỗ đặt toolchain

**Quyết định phải ra trước khi gõ dòng nào:** ESP-IDF chạy trong Docker rất sạch, **nhưng Docker Desktop trên Windows không thấy cổng COM**. Bạn có ba đường:

| Đường | Build | Flash/Monitor | Ma sát |
|---|---|---|---|
| **A. Docker build + flash từ Windows** *(khuyến nghị để bắt đầu)* | trong container | `esptool.py` trên Windows | Thấp. Giữ được toolchain sạch, chấp nhận 1 bước thủ công. |
| **B. WSL2 + usbipd-win** | trong WSL | trong WSL | Trung bình. Phải `usbipd attach` mỗi lần cắm. Sạch nhất khi đã quen. |
| **C. ESP-IDF cài thẳng Windows** | host | host | Thấp nhất, nhưng bẩn máy — đi ngược gu của bạn. |

Chọn **A** trước. Nếu thấy bước thủ công phiền thì chuyển **B** ở bài 26. Nhắc lại nguyên tắc 3 của la bàn: *cái bạn đang học lúc này là con chip, không phải cái công cụ.* Đừng đốt hai ngày cho USB passthrough.

**Làm gì:** blink LED → `idf.py build` → flash → `monitor` thấy log. Đọc `sdkconfig` xem nó thật ra là gì.

**Xong khi:** chu trình sửa-code → build → flash → thấy kết quả mất dưới 60 giây và bạn không phải nghĩ về nó nữa. **Bỏ hẳn Arduino IDE.**

---

---

---

### Bài 24 — GPIO, ADC, timer trên ESP32

**Làm gì:** GPIO out/in với pull-up → ADC đọc điện áp (biến trở hoặc cảm biến analog) → **hiệu chuẩn ADC** (giá trị thô không phải volt!) → timer định kỳ.

**Xong khi:** ADC ra đúng volt đo bằng đồng hồ (sai số dưới 2%); giải thích được vì sao ADC của ESP32 phi tuyến ở hai đầu dải.

---

---

---

### Bài 25 — FreeRTOS: task, queue, mutex

**Mục tiêu:** đây là khác biệt lớn nhất giữa vi điều khiển và Linux. Không có OS đầy đủ, bạn tự quản lý thời gian.

**Làm gì:** tách 2 task — task đọc cảm biến (chu kỳ đều) và task gửi dữ liệu (chậm, có thể nghẽn). Nối bằng **queue**. Bảo vệ tài nguyên chung bằng **mutex**.

**Xong khi:** task gửi bị treo 5 giây → task đọc **vẫn đúng chu kỳ**. Giải thích được stack size chọn bao nhiêu và vì sao tràn stack ở đây làm thiết bị reboot.

**So với Pi:** viết vào nhật ký khác biệt giữa "task FreeRTOS" và "process Linux". Đây là câu hỏi phỏng vấn kinh điển.

---

---

---

### Bài 26 — WiFi và MQTT từ ESP32

**Làm gì:** WiFi station → **tự nối lại khi mất sóng** (exponential backoff, không spam) → MQTT publish lên Mosquitto chạy trong Docker.

```powershell
.\dev.ps1 up ot     # bật mqtt + db + grafana
```

**Xong khi:** Python trong container `py` subscribe và thấy dữ liệu; **rút WiFi 2 phút rồi cắm lại → ESP32 tự nối lại, không cần reset**.

---

---

---

### Bài 27 — Kiến trúc MQTT: topic, QoS, LWT

**Mục tiêu:** phần thiết kế, không phải phần code. Đây là chỗ kinh nghiệm hệ thống của bạn có giá.

**Làm gì:**
- Thiết kế cây topic: `nhamay/khuvuc/thietbi/phepdo` — vì sao không nhét tất cả vào một topic?
- QoS 0 vs 1 vs 2: thử mất gói thật (tắt broker giữa chừng) và quan sát.
- `retained` message — thiết bị mới kết nối thấy ngay trạng thái cuối.
- **LWT (Last Will and Testament)** — thiết bị chết đột ngột thì hệ thống tự biết.

**Xong khi:** rút điện ESP32 → trong vòng 30 giây có message `offline` xuất hiện, không cần ai hỏi thăm.

**Đây là bài dạy bạn nghĩ như người vận hành hệ thống, không phải người viết tính năng.**

---

---

---

### Bài 28 — Modbus TCP: ESP32 làm slave

**Mục tiêu:** Modbus là ngôn ngữ chung của thiết bị công nghiệp. Hiểu nó là hiểu cách máy móc nói chuyện.

**Làm gì:** ESP32 làm **Modbus TCP slave**, expose cảm biến qua holding register → Python (`pymodbus`) làm **master**, poll dữ liệu.

**Phải hiểu được:** coil vs discrete input vs input register vs holding register; vì sao register là 16-bit và số thực phải ghép 2 register (và thứ tự byte/word có thể ngược — lỗi kinh điển ngoài hiện trường).

**Xong khi:** đọc holding register ra đúng giá trị cảm biến thật; thử đọc register không tồn tại → nhận đúng exception code.

---

---

---

### Bài 29 — Modbus RTU qua RS485

**Vì sao vẫn phải học dù đã có TCP:** phần lớn thiết bị trong nhà máy Việt Nam nói RTU qua dây RS485, không phải Ethernet. Đây là chỗ "chạm được thiết bị" trở thành thật.

**Làm gì:** cùng dữ liệu bài 28 nhưng qua serial → CRC, baudrate, parity, **timing giữa các frame** → nhiều slave trên một dây (địa chỉ slave).

**Xong khi:** poll được qua dây thật; cố tình sai baudrate → hiểu triệu chứng; giải thích được vì sao RTU nhạy cảm với timing còn TCP thì không.

**Docker:** truyền `/dev/ttyUSB0` vào container (đã học ở bài 21).

---

---

---

### Bài 30 — Thiết kế tag map và chiến lược polling

**Mục tiêu:** bài thiết kế thuần. Chỗ nền sản xuất/kho của bạn đáng tiền nhất.

**Làm gì:** viết `docs/tag-map.md` có version — mỗi tag: địa chỉ, kiểu dữ liệu, đơn vị, hệ số scale, dải hợp lệ, chu kỳ đọc.
- Polling vs event: khi nào chọn cái nào?
- **Deadband** — chỉ ghi khi thay đổi đủ lớn. Giảm dữ liệu rác 90%.
- **Timestamp của ai?** Thiết bị hay gateway? Đồng hồ ESP32 lệch thì sao?
- Poll 100 tag trong 1 giây có khả thi không — tính thử băng thông RTU.

**Xong khi:** tag map đủ để **người khác** viết gateway mà không cần hỏi bạn.

---

---

---

### Bài 31 — Lưu trữ và dashboard

**Làm gì:** Python gateway đọc Modbus/MQTT → ghi Postgres → Grafana vẽ. Tất cả trong compose.
- Schema time-series: index theo thời gian, tránh bảng phình.
- Xử lý mất kết nối DB — **buffer tại chỗ, không mất dữ liệu**.

**Xong khi:** chạy liên tục 24 giờ → biểu đồ liền mạch, không lỗ hổng; tắt DB 10 phút → dữ liệu vẫn về đủ sau khi bật lại.

---

---

---

### Bài 32 — OPC UA: mặt bắc của gateway

**Lý thuyết:** vì sao OPC UA khác Modbus về **bản chất** — Modbus chỉ có *một con số ở một địa chỉ*; OPC UA có **mô hình thông tin có ngữ nghĩa**: đối tượng, thuộc tính, kiểu dữ liệu, quan hệ. Máy tự mô tả chính nó.

**Làm gì:** Pi dựng **OPC UA server** (`asyncua`) phơi chính các tag đã gom từ Modbus → kết nối bằng client (UaExpert) duyệt address space → hiểu node, NodeId, kiểu dữ liệu → bảo mật cơ bản (chế độ bảo mật, chứng chỉ tự ký).

Đúng cách gateway công nghiệp thật hoạt động: **Modbus đi vào, OPC UA đi ra.**

**Xong khi:** mở UaExpert duyệt được cây thiết bị của bạn và đọc giá trị realtime; giải thích được một tag Modbus "nhiệt độ ở địa chỉ 40001" trở thành cái gì trong mô hình OPC UA.

**Không đụng:** companion specification, PubSub, redundancy — để Chặng 2 (khối G2).

---

---

### Bài 33 — docker-compose nhiều service cho ra hồn

**Làm gì (case Docker phải dàn dựng):**
- `healthcheck` cho từng service + `depends_on: condition: service_healthy`.
- `restart: unless-stopped` và thử giết service ngẫu nhiên.
- Tách config theo môi trường: `.env.dev` vs `.env.prod`, **không hardcode** mật khẩu.
- Network nội bộ: DB **không** expose ra ngoài, chỉ service trong mạng thấy.
- Tối ưu thứ tự layer để build lại nhanh.

**Xong khi:** một lệnh `docker compose --profile ot up -d` dựng cả hệ; `docker kill` bất kỳ service nào → hệ tự hồi phục trong 30 giây.

> **PHÉP THỬ TẮT AI #3** — tắt AI, tự viết lại phần MQTT publish trên ESP32 và phần subscribe bên Python.

**Đầu ra Khối 2:** hệ thống ESP32 → Modbus/MQTT → Pi → DB → OPC UA + dashboard, chạy liên tục. **Riêng phần này đã đủ kể thành một câu chuyện phỏng vấn hoàn chỉnh.**

---

---

---

# KHỐI 3 — Thị giác máy và AI trên edge (Bài 34–45, ~4 tuần)

*Định hướng khối này do bạn chốt: **OpenCV tương đối sâu (cả Python lẫn C++), YOLO ở mức ứng dụng, khái niệm AI/DL đi sơ, nén/lượng tử hoá ở mức gọi thư viện.** Chiều sâu machine learning để dành Chặng 2 (khối F). Ở đây làm cho **chạy được và đo được**, không đào lý thuyết.*

### Bài 34 — Ảnh số là gì · OpenCV nền  `[SO-SÁNH]`

**Lý thuyết:** pixel · kênh màu và **thứ tự BGR của OpenCV** (nguồn lỗi kinh điển) · không gian màu RGB/HSV/Gray và khi nào dùng cái nào · ảnh **là một ma trận số**, không hơn · kiểu `uint8` và chuyện tràn số.

**Làm gì:** đọc/ghi/hiển thị ảnh · truy cập pixel · cắt, ghép, đổi không gian màu · **tự viết hàm đổi sang ảnh xám bằng vòng lặp**, so với `cvtColor` — cả thời gian lẫn kết quả. Làm bằng **cả Python lẫn C++**.

**Xong khi:** giải thích được vì sao ảnh xám nhẹ hơn 3 lần; vì sao lặp pixel bằng Python chậm thảm hại còn C++ thì không.

---

---

### Bài 35 — OpenCV: xử lý ảnh nền tảng

**Lý thuyết:** nhân tích chập (kernel) · làm mờ và vì sao nó khử nhiễu · ngưỡng cố định vs thích nghi · hình thái học: giãn, co, mở, đóng.

**Làm gì:** resize (các phép nội suy khác nhau ra sao) · blur/Gaussian/median · threshold + **Otsu** · morphology dọn nhiễu · Canny tìm biên.

**Xong khi:** lấy một ảnh chụp thật trong điều kiện ánh sáng xấu, qua chuỗi xử lý ra được ảnh nhị phân sạch. **Giải thích được từng bước làm gì** — không copy chuỗi phép từ trên mạng.

---

---

### Bài 36 — OpenCV: contour, phát hiện và đếm vật thể — **không cần AI**

**Lý thuyết:** contour là gì · diện tích, chu vi, bounding box, tỉ lệ khung · lọc theo hình dạng.

Bài này quan trọng hơn vẻ ngoài: **rất nhiều bài toán nhà máy dừng ở đây là đủ.** Đếm sản phẩm, kiểm tra có/không có nắp, đo kích thước, phát hiện lệch vị trí — không cần model nào, chạy nhanh hơn AI hàng chục lần, và **giải thích được vì sao nó quyết định thế** (điều AI không làm được).

**Làm gì:** tìm contour → lọc theo diện tích/hình dạng → đếm vật thể trên nền đơn giản → vẽ kết quả → đo độ chính xác trên 100 ảnh thật.

**Xong khi:** đếm đúng ≥95% trên bộ ảnh tự chụp; biết **khi nào cách này gãy** (nền phức tạp, vật chồng nhau, ánh sáng đổi) — và đó chính là lúc cần AI.

---

---

### Bài 37 — Camera pipeline thật

**Lý thuyết:** luồng video là gì · vì sao có **buffer** và vì sao nó làm bạn xử lý ảnh của 3 giây trước · FPS nguồn khác FPS xử lý.

**Làm gì:** đọc từ ba nguồn — webcam laptop (dev nhanh), **RTSP từ điện thoại** (app kiểu *IP Webcam*), USB cam cắm Pi · đo FPS thật · xử lý buffer để luôn lấy frame mới nhất · mất kết nối RTSP → tự nối lại.

**Xong khi:** đo được FPS **và độ trễ end-to-end** (mẹo: quay màn hình đang chạy đồng hồ mili-giây); rớt mạng không làm crash.

**Vì sao RTSP quan trọng hơn USB:** nhà máy thật dùng camera IP. Tập bằng điện thoại là tập đúng giao thức thật.

---

---

### Bài 38 — OpenCV C++ trên Pi, đo hiệu năng  `[SO-SÁNH]`

**Làm gì:** build OpenCV C++ trên Pi (hoặc dùng gói có sẵn — đo cả thời gian build) → viết lại pipeline bài 35–32 bằng C++ → đo.

**Đo:** thời gian mỗi frame · RAM · CPU% · mức chiếm dụng khi chạy liên tục 30 phút · nhiệt độ.

**Xong khi:** bảng số liệu Python vs C++ trên **cùng pipeline, cùng ảnh, cùng máy**, và kết luận có căn cứ về việc phần nào đáng viết bằng C++.

---

---

### Bài 39 — Khái niệm CV/AI/DL **đi sơ** + metric

**Lý thuyết (mức đủ để gỡ lỗi, không đào sâu):** học máy khác lập trình thường chỗ nào · train và inference là hai việc khác nhau · mạng nơ-ron và CNN ở mức ý tưởng · model là cái gì khi nằm trên đĩa · vì sao **tiền xử lý lúc chạy phải khớp với lúc train** (sai chỗ này thì accuracy tụt mà không báo lỗi gì).

**Metric — phần này phải chắc, không được sơ:** **FP/FN** · precision, recall, F1 · confusion matrix · vì sao "95% accuracy" là câu trả lời lười.

**Làm gì:** tự tính tay confusion matrix từ 20 kết quả · tính precision/recall bằng tay · dựng lại bằng code và so.

**Xong khi:** cho một bài toán cụ thể, nói được **sai kiểu nào đắt hơn và đắt hơn bao nhiêu lần**.

> Chiều sâu thật của phần này (tự code từ linear regression tới CNN, tính tay backprop) nằm ở **Chặng 2, khối F**. Ở đây chỉ cần đủ để không mù mờ khi dùng.

---

---

### Bài 40 — YOLO ở mức ứng dụng

**Lý thuyết:** phát hiện đối tượng khác phân loại ảnh chỗ nào · đầu vào/đầu ra của YOLO thật sự là gì · **confidence không phải xác suất đúng** · NMS để làm gì · IoU.

**Làm gì:** chạy YOLO trên PC → trên Pi → đo latency p50/**p95** (không chỉ trung bình!), FPS, nhiệt độ sau 30 phút, **có bị giảm xung nhịp không** · vẽ box · đếm/phân loại theo vùng quan tâm · so với cách contour ở bài 36 trên cùng bộ ảnh.

**Xong khi:** bảng số liệu hai nền tảng; nói được YOLO thắng contour ở đâu và **thua ở đâu**.

**Bài học ẩn:** Pi nóng lên là giảm xung nhịp. Số đo 30 giây đầu là số đo dối.

---

---

### Bài 41 — Chọn bài toán vision  `[PHÁN ĐOÁN]`

**Không viết code.** Viết một trang `docs/problem-statement.md`.

**Chọn một bài toán nhà máy có thật:** đếm sản phẩm qua băng chuyền · phát hiện thiếu nhãn/nắp · nhận diện trạng thái đèn báo máy · phát hiện người vào vùng nguy hiểm · đọc số trên đồng hồ analog.

**Phải trả lời bằng số:**
- Sai kiểu nào đắt hơn — báo nhầm hay bỏ sót? Đắt hơn bao nhiêu?
- Ngưỡng chấp nhận là bao nhiêu, **trên tập nào, điều kiện ánh sáng nào**?
- Ánh sáng đổi thế nào trong ngày? Camera có rung? Vật đi nhanh cỡ nào?
- **Bài này giải bằng contour (bài 36) được không?** Nếu được thì đừng dùng AI.
- Nếu model chết thì dây chuyền làm gì — dừng, hay chạy tiếp và ghi log?

**Xong khi:** người khác đọc trang đó và biết chính xác phải xây gì, đo thế nào là đạt.

Đây là bài phân biệt kỹ sư giải pháp với người chạy notebook.

---

---

### Bài 42 — Nén và lượng tử hoá **ở mức gọi thư viện**

**Lý thuyết:** FP32/FP16/INT8 khác nhau ra sao ở mức biểu diễn · lượng tử hoá đổi cái gì · vì sao cần calibration dataset.

**Làm gì:** chuyển model qua ONNX Runtime hoặc TFLite · FP32 → FP16 → **INT8** · đo **cả ba**: accuracy, latency, kích thước · vẽ biểu đồ đánh đổi · thử thêm: giảm độ phân giải đầu vào, bỏ bớt frame, chỉ xử lý vùng quan tâm.

**Xong khi:** chọn một cấu hình và **biện hộ bằng số**: *"INT8 mất 1.2% accuracy nhưng nhanh gấp 3.1 lần và nhỏ hơn 3.8 lần — với bài toán này đáng đổi vì..."*

**Không đụng:** tự cài đặt thuật toán lượng tử hoá, pruning thủ công, distillation — Chặng 2.

---

---

### Bài 43 — Ngưỡng, chống nháy, và cái giá của sai  `[PHÁN ĐOÁN]`

**Mục tiêu:** model không bao giờ đúng 100%. Hệ thống tốt là hệ thống **sai một cách có kiểm soát**.

**Làm gì:** chỉnh confidence threshold, quan sát đánh đổi FP/FN · **chống nháy**: N-of-M (chỉ báo khi 3/5 frame liên tiếp đồng ý), hysteresis · chế độ suy giảm — model chết thì sao, camera mất thì sao · ghi log mọi quyết định + lưu ảnh của ca sai để về sau truy được.

**Xong khi:** chạy thật 1 giờ, **đếm tay FP/FN**, chỉnh ngưỡng có căn cứ số liệu, ghi vào nhật ký vì sao chọn ngưỡng đó cho bài toán này.

---

---

### Bài 44 — Đóng gói AI service: multi-stage image

**Làm gì:** Dockerfile multi-stage ép image nặng (OpenCV, ONNX Runtime) xuống nhỏ · stage build (có compiler) tách khỏi stage runtime · chạy **non-root** · build cho **arm64**, chạy trên Pi · so với con số bạn ghi ở **bài 02**.

**Xong khi:** image nhỏ hơn bản ngây thơ ít nhất 3 lần, chạy trên Pi, không chạy bằng root.

---

---

### Bài 45 — Dự án nhỏ trên Pi: khép kín vòng

**Đây là khoảnh khắc Khối 1–3 hội tụ.**

```
Camera → Pi (OpenCV/YOLO) → quyết định → MQTT/Modbus → ESP32 → relay/đèn
```

**Làm gì:** nối trọn chuỗi bằng chính bài toán đã chọn ở bài 41 · đo **độ trễ end-to-end** từ lúc vật vào khung hình đến lúc relay kêu · **tách nhỏ độ trễ ra từng chặng** (camera bao nhiêu ms, inference bao nhiêu, mạng bao nhiêu, ESP32 bao nhiêu).

**Xong khi:** vật thể lỗi đi qua → thiết bị phản ứng dưới 1 giây; có bảng phân rã độ trễ; chạy liên tục 4 giờ không cần can thiệp.

> **PHÉP THỬ TẮT AI #4** — tắt AI, tự viết lại vòng đọc camera + tiền xử lý + gọi inference.

---

---

# KHỐI 4 — C++ vào cuộc (Bài 46–49, ~2 tuần)

*Học C++ ở chỗ nó thật sự đáng học: khi bạn đã hiểu bài toán và muốn làm nó tốt hơn.*

### Bài 46 — C++ hiện đại cho nhúng

**Làm gì:** RAII · `unique_ptr`/`shared_ptr` (và khi nào **không** dùng con trỏ nào cả) · `std::optional` cho giá trị có thể thiếu · `std::span` · **tránh cấp phát bộ nhớ trong vòng lặp nóng** · `constexpr`.

**Xong khi:** viết lại một module Python sang C++ sạch; `valgrind` không báo leak; giải thích được vì sao `new`/`delete` bằng tay là mùi code xấu trong C++ hiện đại.

**Ghi chú về ngữ cảnh nhúng:** trên vi điều khiển, exception và cấp phát heap động thường bị cấm. Hiểu **vì sao** — không phải vì chúng xấu, mà vì chúng làm thời gian thực thi khó đoán.

---

---

---

### Bài 47 — Viết lại phần nóng bằng C++  `[SO-SÁNH]`

**Làm gì:** chọn phần nặng nhất đã đo được (tiền/hậu xử lý ảnh, hoặc vòng polling Modbus) → viết lại bằng C++ → đo trước/sau.

**Xong khi:** có bảng số liệu và một kết luận trung thực — **kể cả khi kết luận là "không đáng viết lại"**. Đó cũng là phán đoán kỹ thuật, và là câu trả lời phỏng vấn tốt hơn nhiều so với "tôi viết lại mọi thứ bằng C++".

---

---

---

### Bài 48 — Cross-compile sang arm64

**Mục tiêu:** không cài compiler lên thiết bị production. Build ở nơi mạnh, chạy ở nơi nhỏ.

**Làm gì:** CMake toolchain file cho `aarch64-linux-gnu` → build trong container trên PC → copy binary sang Pi → chạy.

**Xong khi:** binary build trên Windows/Docker chạy được trên Pi, và trên Pi **không có** gcc/cmake nào cả. Hiểu `ldd` báo gì khi thiếu thư viện, và vì sao static link đôi khi đáng giá.

---

---

---

### Bài 49 — C++ trên ESP32 và bài toán điện năng

**Làm gì:** dùng C++ trong ESP-IDF → đo heap/stack còn lại lúc chạy → **deep sleep** → đo dòng tiêu thụ thật bằng đồng hồ (hoặc module INA219).

**Xong khi:** đo được mA ở chế độ chạy và chế độ ngủ; tính được thời gian sống nếu chạy pin; giảm được điện năng và **có số liệu chứng minh**.

**Vì sao có mặt trong lộ trình:** điện năng là ràng buộc bạn không gặp trong web. Biết nói chuyện về mAh và duty cycle là dấu hiệu người thật sự làm nhúng.

---

---

> **PHÉP THỬ TẮT AI #5** — tắt AI, tự viết lại một module C++ nhỏ đã làm, kể cả CMakeLists.

---

---

# KHỐI 5 — Viết ứng dụng thật: C# (Bài 50–58, ~4.5 tuần)

*Khối này trả lời câu "chưa có cái nào viết ứng dụng hết". Và nó dựa trên dò thị trường thật, không phải cảm tính:*

- *Nhật: JD 制御ソフト開発 cho **半導体製造装置** và **電子部品検査装置** ghi rõ **GUI + C#/C++**. Mảng **検査装置 + C# + OpenCV** đang được các công ty offshore Việt Nam nhận từ Nhật.*
- *Việt Nam: JD SCADA/HMI ghi thẳng **"C#, asp.net"** bên cạnh WinCC/InTouch.*

**Khung chặt, có chủ ý:**
- ✅ C# nền tảng · WinForms/WPF · Blazor · OpenCvSharp
- ❌ **Không đi sâu ASP.NET như một hướng nghề** — đó mới là "vùng nổ" la bàn cảnh báo. Ở đây chỉ dùng đúng một màn hình giám sát
- ❌ Không Entity Framework, không kiến trúc doanh nghiệp
- ❌ **Không Qt** — trùng chỗ với C# ở hai thị trường này, giá gấp ba. Điều kiện lật lại: nếu rẽ sang HMI **y tế hoặc ô tô**

### Bài 50 — C# cốt lõi cho người đã biết PHP  `[ĐỆM]`

*Bài đệm. Bạn có nền OOP từ PHP nên đi nhanh được — nhưng **không bỏ qua**. Lao thẳng vào Blazor khi chưa nắm C# là công thức tạo vibe code.*

**Lý thuyết:** **kiểu tĩnh đổi cách bạn viết thế nào** (compiler bắt lỗi thay vì runtime) · `class` vs `struct` vs `record` · `interface` và vì sao C# dựa vào nó nhiều hơn PHP · property so với getter/setter · `enum` · **nullable reference types** — thứ PHP không có và nó cứu bạn khỏi cả một lớp bug.

**Làm gì:**
- `dotnet new console` bằng **CLI**, không click chuột trong Visual Studio
- Kiểu, biến, `var`, chuyển kiểu
- Class, property, constructor, kế thừa, `interface`, `abstract`
- Generic ở mức dùng: `List<T>`, `Dictionary<K,V>`
- **Bảng đối chiếu PHP ↔ C#** viết vào nhật ký: cái gì giống, cái gì khác, cái gì PHP không có

**Xong khi:** đọc được code C# lạ mà không tra cú pháp liên tục; nói được ba thứ kiểu tĩnh bắt được mà PHP để lọt tới lúc chạy.

---

### Bài 51 — C#: async, LINQ, và quản lý tài nguyên  `[ĐỆM]`

**Lý thuyết:** **`async`/`await` — và nó KHÔNG phải đa luồng** (đây là hiểu lầm phổ biến nhất về C#) · `Task` · LINQ · `IDisposable` và `using` · exception trong C#.

**Làm gì:**
- Chương trình `async` đọc nhiều nguồn cùng lúc, đo thời gian so với đọc tuần tự
- **Cố tình chặn luồng bằng `.Result`** để thấy deadlock — rồi sửa
- LINQ: `Where`, `Select`, `GroupBy`, `OrderBy` trên dữ liệu cảm biến thật
- `IDisposable` + `using` — so sánh với `with` của Python và RAII của C++
- `CancellationToken` — dừng một tác vụ đang chạy cho tử tế

**Xong khi:** giải thích được `async/await` thật ra làm gì; viết được vòng lặp đọc dữ liệu có thể huỷ giữa chừng.

**Ba ngôn ngữ, một khái niệm:** giải phóng tài nguyên — C++ dùng **destructor/RAII**, Python dùng **`with`**, C# dùng **`using`/`IDisposable`**. Viết so sánh ba cái vào nhật ký. Đây là lúc học song song sinh giá trị thật.

---

### Bài 52 — .NET và hệ sinh thái: công cụ để làm app thật  `[ĐỆM]`

*Biết ngôn ngữ chưa đủ để làm ứng dụng. Bài này là phần "xung quanh" mà mọi dự án .NET thật đều có.*

**Lý thuyết:** solution và project khác nhau thế nào · NuGet · **dependency injection** và vì sao .NET dựa vào nó · cấu hình theo môi trường (`appsettings.json`) · `ILogger`.

**Làm gì:**
- `dotnet new sln`, thêm nhiều project, tham chiếu chéo — tất cả bằng CLI
- Thêm gói NuGet (MQTTnet, NModbus) và hiểu file `.csproj`
- **DI container**: đăng ký service, inject qua constructor, hiểu vòng đời singleton/scoped/transient
- `IConfiguration` đọc `appsettings.json` + biến môi trường, **không hardcode**
- `ILogger` — nối tiếp thói quen logging từ bài 09
- `dotnet test` với xUnit

**Xong khi:** dựng được một solution nhiều project, chạy bằng CLI, có test, có cấu hình theo môi trường, không có chuỗi kết nối nào nằm trong code.

---

### Bài 53 — Kiến trúc ứng dụng: tách lõi khỏi vỏ

**Đây mới là "viết ứng dụng" theo nghĩa nhà tuyển dụng hiểu.** Không phải làm ra một cửa sổ có nút bấm — mà là tách được phần lõi ra khỏi phần hiển thị.

Và đây là lần đầu bạn tự tay làm **nguyên tắc 4 của la bàn** ("tách lõi khỏi vỏ") với code của chính mình, chứ không phải với công cụ của người khác.

```
        ┌────────────────────┐   ┌────────────────────┐
        │  Blazor web HMI    │   │  WPF desktop app   │
        └─────────┬──────────┘   └─────────┬──────────┘
                  └───────────┬────────────┘
                     ┌────────▼─────────┐
                     │  Core library    │  ← C#, dùng chung
                     │  MQTT · Modbus   │
                     │  · model dữ liệu │
                     └──────────────────┘
```

**Làm gì:** class library chứa model dữ liệu + client MQTT + client Modbus · **cấu hình theo môi trường** (không hardcode) · **logging có cấu trúc** · vòng đời: khởi động, tắt êm, xử lý lỗi kết nối · viết test cho core mà **không cần UI nào**.

**Xong khi:** core library chạy được và test được **hoàn toàn không có giao diện**. Nếu phải sửa UI mới test được core thì bạn chưa tách xong.

---

---

### Bài 54 — Web .NET từ số 0: ASP.NET Core và Blazor  `[ĐỆM]`

*Bài đệm quan trọng nhất của khối. **Bạn chưa từng biết Blazor**, nên bài này chỉ để hiểu nó, chưa xây HMI thật.*

**Lý thuyết:**
- ASP.NET Core xử lý một request thế nào · **middleware pipeline** · routing
- **Razor** — cú pháp trộn C# vào HTML. Đối chiếu thẳng với PHP trộn vào HTML mà bạn đã quen
- **Component** là gì, khác một trang PHP chỗ nào
- **Blazor Server vs Blazor WebAssembly** — và vì sao HMI của chúng ta chọn **Server** (state nằm trên máy chủ, gần dữ liệu thiết bị, tải trang nhẹ, phù hợp mạng nội bộ nhà máy)
- Vòng đời component, binding một chiều và hai chiều

**Làm gì:** `dotnet new blazor` → đọc từng file sinh ra, hiểu file nào làm gì · viết vài component nhỏ: hiển thị danh sách, nhận input, truyền tham số cha–con · binding · gọi một service từ DI vào component · cập nhật giao diện khi dữ liệu đổi.

**Xong khi:** giải thích được **Blazor Server giữ kết nối SignalR và render ở đâu**; viết được một component từ đầu không copy mẫu.

**Đối chiếu bắt buộc viết vào nhật ký:** một trang PHP và một component Blazor — cái gì tương đương, cái gì khác hẳn về mô hình.

---

### Bài 55 — Blazor web HMI

**Làm gì:** trang hiển thị dữ liệu realtime từ core · **nút gửi lệnh xuống ESP32** qua MQTT/Modbus · cập nhật realtime (SignalR/WebSocket) · đóng gói Docker.

**Xong khi:** mở bằng trình duyệt trên điện thoại cùng mạng, thấy số liệu cập nhật, bấm nút → **relay ngoài kia kêu**.

---

---

### Bài 56 — WPF và XAML từ số 0  `[ĐỆM]`

*Bài đệm. Desktop khác web ở chỗ căn bản, và XAML lạ mắt với người quen HTML.*

**Lý thuyết:** **XAML là gì** — mô tả giao diện bằng đánh dấu, đối chiếu với HTML bạn đã biết · hệ thống layout (`Grid`, `StackPanel`, `DockPanel`) so với flexbox/grid của CSS · **data binding và `DataContext`** — trái tim của WPF · `INotifyPropertyChanged` · **MVVM ở mức tối thiểu** (đừng đào sâu, chỉ cần đủ dùng) · vòng lặp sự kiện giao diện và vì sao **không được chặn nó**.

**Làm gì:** `dotnet new wpf` → cửa sổ đầu tiên · layout với `Grid` · binding một property vào `TextBlock`, đổi property → giao diện tự đổi · `ObservableCollection` cho danh sách · nút bấm gọi lệnh · **cố tình chặn luồng UI bằng `Thread.Sleep`** để thấy app đơ, rồi sửa bằng `async`.

**Xong khi:** binding chạy đúng mà không gọi tay hàm cập nhật nào; giải thích được vì sao chặn luồng UI làm app đơ và `async` sửa nó thế nào.

---

### Bài 57 — WPF desktop app

**Làm gì:** cùng core library, mặt tiền desktop · hiển thị **khung hình camera + kết quả AI** (OpenCvSharp) · data binding và MVVM ở mức cơ bản · điều khiển thiết bị.

**Xong khi:** app chạy trên Windows, xem được camera + kết quả nhận dạng + điều khiển được thiết bị — **dùng lại core library, không copy code**.

---

---

### Bài 58 — So sánh hai mặt tiền và triển khai  `[SO-SÁNH]`

**Đo và so, bằng số:**

| Tiêu chí | Blazor web | WPF desktop |
|---|---|---|
| Độ trễ hiển thị | ? | ? |
| Khi mất mạng | ? | ? |
| Cập nhật phiên bản | ? | ? |
| Chạy trên tablet ngoài xưởng | ? | ? |
| Chi phí triển khai 10 máy | ? | ? |

**Xong khi:** điền đủ bảng bằng số đo thật, và trả lời được: *"với nhà máy X thì tôi chọn cái nào, vì sao"*. Đây đúng là câu người phỏng vấn cho vị trí kỹ sư thiết bị sẽ hỏi.

> **PHÉP THỬ TẮT AI #6** — tắt AI, tự thêm một màn hình mới vào cả hai mặt tiền, dùng lại core.

---

---

# KHỐI 6 — Chịu lỗi, CI, giao hàng (Bài 59–63, ~2.5 tuần)

*Biến "một demo chạy được" thành "một hệ thống có người dám cắm vào dây chuyền". Đây là phần 90% dự án cá nhân bỏ qua — nên nó là chỗ bạn nổi bật.*

### Bài 59 — Hardening: mất điện, mất mạng, dữ liệu bẩn

**Mục tiêu:** đây là phần biến demo thành sản phẩm. Cũng là phần 90% dự án cá nhân bỏ qua — nên nó là chỗ bạn nổi bật.

**Làm gì, và phải thử thật:**
- Rút mạng 10 phút → buffer tại chỗ → gửi bù khi có mạng, **không trùng, không mất**.
- Rút điện Pi giữa lúc ghi file → bật lại, dữ liệu không hỏng (atomic write).
- Gửi dữ liệu rác vào Modbus/MQTT → hệ thống từ chối sạch sẽ, không crash.
- Đồng hồ nhảy lùi (NTP sync) → không làm hỏng chuỗi thời gian.
- Watchdog nhiều tầng: systemd cho service, hardware watchdog cho Pi, task watchdog cho ESP32.

**Xong khi:** hoàn thành một **bảng kiểm tra phá hoại** — mỗi dòng là một cách bạn cố tình phá và kết quả hệ thống chịu được. Bảng này đưa vào README.

---

---

---

### Bài 60 — Bảo mật tối thiểu

**Lý thuyết:** vì sao mặc định của mọi thứ trong lộ trình này đều **không an toàn** (Mosquitto `allow_anonymous true`, Postgres mật khẩu `nw`, Grafana `admin/admin`) — có chủ ý, để giờ bạn thấy rõ sự khác biệt.

**Làm gì:** bật xác thực MQTT (user/password), rồi **TLS** với chứng chỉ tự ký · đổi mật khẩu DB, không để trong Git · quản lý secret theo môi trường · nguyên tắc đặc quyền tối thiểu: service nào cần quyền gì · rà lại `--privileged` và cổng đang phơi ra ngoài.

**Xong khi:** không còn mật khẩu nào trong Git; MQTT từ chối client không có chứng chỉ; giải thích được ba rủi ro lớn nhất còn lại của hệ thống bạn.

---

---

### Bài 61 — CI trên GitHub Actions

**Mục tiêu:** chỗ Git + Docker + CI/CD gặp nhau. Trả luôn phần "cày CI/CD" mà không cần học riêng.

**Làm gì:** mỗi push → chạy pytest + ruff + build C++ → build Docker image **multi-arch** → push lên registry. Tag `v*` → tạo release tự động.

**Xong khi:** badge xanh trên README; một lần push tự ra image chạy được trên Pi mà bạn không làm gì thêm.

---

---

---

### Bài 62 — Đo lường và báo cáo

**Làm gì:** chạy hệ thống **liên tục nhiều ngày**, thu thập tự động: accuracy trên dữ liệu thật · latency p50/p95/p99 · FPS · uptime · số lần tự khởi động lại · điện năng · nhiệt độ.

Viết script sinh báo cáo từ log — không đo bằng tay.

**Xong khi:** có báo cáo số liệu của **ít nhất 72 giờ chạy liên tục**. Đây là thứ xóa sạch nghi ngờ "chỉ là lý thuyết", mạnh hơn mọi chứng chỉ.

---

---

---

### Bài 63 — Đóng gói artifact

**Làm gì:**
- README có: bài toán thật đang giải · sơ đồ kiến trúc · **bảng số liệu** · hướng dẫn tái lập từ số 0 · bảng kiểm tra phá hoại (bài 59).
- Video demo 2–3 phút: quay hệ thống chạy thật, không phải slide.
- Viết `docs/cv-bullets.md`: 5 gạch đầu dòng cho CV, mỗi dòng có **số liệu**.
- Dọn lịch sử Git, tag `v1.0.0`.

**Xong khi:** một người lạ clone repo về và chạy được mà không cần hỏi bạn câu nào.

> **PHÉP THỬ TẮT AI #7 (cuối cùng)** — tắt AI, giải thích toàn bộ kiến trúc bằng lời trong 10 phút, quay lại. Chỗ nào bạn ấp úng là chỗ bạn chưa thật sự sở hữu.

---

---

---

## Đầu ra Chặng 1

**Camera → Pi (OpenCV/AI) → Modbus/MQTT/OPC UA → ESP32 → thiết bị**, cộng **HMI web + app desktop dùng chung core library**. Đóng gói Docker, lịch sử Git sạch, CI xanh, có log và số liệu nhiều ngày, tự phục hồi khi mất điện/mạng, xử lý input bẩn thật. Public trên GitHub, README tử tế, video demo.

**Bạn KHÔNG thành** kỹ sư nhúng giỏi hay kỹ sư AI — cả hai cần nhiều năm.

**Bạn thành:** một kỹ sư phần mềm nhiều kinh nghiệm, **chạm được thiết bị, ghép được AI vào hệ thống thật, viết được ứng dụng có giao diện, và hiểu sản xuất.** Xét riêng từng trục thì không đứng đầu trục nào. Xét cả bốn trục cùng lúc thì rất ít người ở Việt Nam đứng được.

**Và nhớ:** 64 bài cho bạn **năng lực**, không cho bạn **kinh nghiệm**. Thứ chúng không bù được — khách đổi yêu cầu, thiết bị đời 2009 không tài liệu, hệ thống cũ của người khác, sự cố 3 giờ sáng — chỉ có việc thật mới cho. Vì vậy **từ Khối 2 trở đi, bắt đầu nhận một job freelance nhỏ, dù rẻ**, chạy song song. Đừng để nó thành "việc làm sau khi học xong".

---

# CHẶNG 2 — xem file riêng

Bản đồ Chặng 2 (khối A–G, thứ tự ưu tiên, lý do, chi phí) nằm ở [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md).

Nó là **bản đồ, chưa phải danh sách bài** — khi tới nơi bạn chọn 2–3 khối, không làm hết.

---

## Bảng tra nhanh

| Bài | Tên | Thư mục | Nhãn |
|---|---|---|---|
| 00 | Bức tranh tổng thể | `lessons/00-buc-tranh-tong-the` | ĐỌC |
| 01 | Docker: vì sao container tồn tại | `lessons/01-docker-vi-sao-container` |  |
| 02 | Docker: image, layer, và cache | `lessons/02-docker-image-layer-cache` |  |
| 03 | Docker: dữ liệu, mạng, và compose | `lessons/03-docker-du-lieu-mang-compose` |  |
| 04 | Git: mô hình tư duy | `lessons/04-git-mo-hinh-tu-duy` |  |
| 05 | Git: nhánh, merge, và conflict | `lessons/05-git-nhanh-merge-conflict` |  |
| 06 | Git: lưới an toàn — cách sửa sai | `lessons/06-git-luoi-an-toan` |  |
| 07 | Git: remote, GitHub, và quy trình làm việc | `lessons/07-git-remote-github-quy-trinh` |  |
| 08 | Python: cốt lõi | `lessons/08-python-cot-loi` | ĐỆM |
| 09 | Python: đủ dùng cho hệ thống thật | `lessons/09-python-du-dung` | ĐỆM |
| 10 | C++: mô hình biên dịch, kiểu, bộ nhớ | `lessons/10-cpp-bien-dich-kieu-bo-nho` | ĐỆM |
| 11 | C++: class, STL, RAII | `lessons/11-cpp-class-stl-raii` | ĐỆM |
| 12 | Cùng một bài toán, hai ngôn ngữ | `lessons/12-python-cpp-cung-bai-toan` | SO-SÁNH |
| 13 | CMake, pytest, và kỷ luật kỹ thuật | `lessons/13-cmake-pytest-ky-luat` |  |
| 14 | Tiếp quản một hệ thống đang chạy | `lessons/14-tiep-quan-he-thong-dang-chay` | CHỈ ĐỌC |
| 15 | Dựng Pi học từ đầu (thẻ mới) | `lessons/15-dung-pi-hoc-tu-dau` |  |
| 16 | Linux nền cho người làm nhúng | `lessons/16-linux-nen-cho-nhung` |  |
| 17 | GPIO bằng Python | `lessons/17-gpio-python` |  |
| 18 | I2C/SPI: đọc cảm biến thật | `lessons/18-i2c-spi-cam-bien-that` |  |
| 19 | systemd: dịch vụ tự phục hồi | `lessons/19-systemd-tu-phuc-hoi` |  |
| 20 | Docker trên Pi: kiến trúc arm64 | `lessons/20-docker-pi-arm64` |  |
| 21 | Truyền thiết bị vật lý vào container | `lessons/21-truyen-thiet-bi-vao-container` |  |
| 22 | C++ đọc cảm biến, đo hiệu năng | `lessons/22-cpp-cam-bien-do-hieu-nang` | SO-SÁNH |
| 23 | ESP-IDF: chọn chỗ đặt toolchain | `lessons/23-esp-idf-toolchain` |  |
| 24 | GPIO, ADC, timer trên ESP32 | `lessons/24-esp32-gpio-adc-timer` |  |
| 25 | FreeRTOS: task, queue, mutex | `lessons/25-freertos-task-queue` |  |
| 26 | WiFi và MQTT từ ESP32 | `lessons/26-wifi-mqtt-esp32` |  |
| 27 | Kiến trúc MQTT: topic, QoS, LWT | `lessons/27-mqtt-topic-qos-lwt` |  |
| 28 | Modbus TCP: ESP32 làm slave | `lessons/28-modbus-tcp-esp32-slave` |  |
| 29 | Modbus RTU qua RS485 | `lessons/29-modbus-rtu-rs485` |  |
| 30 | Thiết kế tag map và chiến lược polling | `lessons/30-tag-map-va-polling` | PHÁN ĐOÁN |
| 31 | Lưu trữ và dashboard | `lessons/31-luu-tru-va-dashboard` |  |
| 32 | OPC UA: mặt bắc của gateway | `lessons/32-opcua-mat-bac-gateway` |  |
| 33 | docker-compose nhiều service cho ra hồn | `lessons/33-compose-nhieu-service` |  |
| 34 | Ảnh số là gì · OpenCV nền | `lessons/34-anh-so-opencv-nen` | SO-SÁNH |
| 35 | OpenCV: xử lý ảnh nền tảng | `lessons/35-opencv-xu-ly-anh` |  |
| 36 | OpenCV: contour, phát hiện và đếm vật thể — **không cần AI** | `lessons/36-opencv-contour-dem-vat-the` |  |
| 37 | Camera pipeline thật | `lessons/37-camera-pipeline` |  |
| 38 | OpenCV C++ trên Pi, đo hiệu năng | `lessons/38-opencv-cpp-tren-pi` | SO-SÁNH |
| 39 | Khái niệm CV/AI/DL **đi sơ** + metric | `lessons/39-khai-niem-cv-ai-dl-metric` |  |
| 40 | YOLO ở mức ứng dụng | `lessons/40-yolo-ung-dung` |  |
| 41 | Chọn bài toán vision | `lessons/41-chon-bai-toan-vision` | PHÁN ĐOÁN |
| 42 | Nén và lượng tử hoá **ở mức gọi thư viện** | `lessons/42-nen-va-luong-tu-hoa` |  |
| 43 | Ngưỡng, chống nháy, và cái giá của sai | `lessons/43-nguong-chong-nhay` | PHÁN ĐOÁN |
| 44 | Đóng gói AI service: multi-stage image | `lessons/44-dong-goi-ai-service` |  |
| 45 | Dự án nhỏ trên Pi: khép kín vòng | `lessons/45-du-an-nho-tren-pi` |  |
| 46 | C++ hiện đại cho nhúng | `lessons/46-cpp-hien-dai-cho-nhung` |  |
| 47 | Viết lại phần nóng bằng C++ | `lessons/47-cpp-viet-lai-phan-nong` | SO-SÁNH |
| 48 | Cross-compile sang arm64 | `lessons/48-cross-compile-arm64` |  |
| 49 | C++ trên ESP32 và bài toán điện năng | `lessons/49-esp32-cpp-dien-nang` |  |
| 50 | C# cốt lõi cho người đã biết PHP | `lessons/50-csharp-cot-loi` | ĐỆM |
| 51 | C#: async, LINQ, và quản lý tài nguyên | `lessons/51-csharp-async-linq` | ĐỆM |
| 52 | .NET và hệ sinh thái: công cụ để làm app thật | `lessons/52-dotnet-he-sinh-thai` | ĐỆM |
| 53 | Kiến trúc ứng dụng: tách lõi khỏi vỏ | `lessons/53-kien-truc-tach-loi-vo` |  |
| 54 | Web .NET từ số 0: ASP.NET Core và Blazor | `lessons/54-web-dotnet-blazor-nen` | ĐỆM |
| 55 | Blazor web HMI | `lessons/55-blazor-web-hmi` |  |
| 56 | WPF và XAML từ số 0 | `lessons/56-wpf-xaml-nen` | ĐỆM |
| 57 | WPF desktop app | `lessons/57-wpf-desktop-app` |  |
| 58 | So sánh hai mặt tiền và triển khai | `lessons/58-so-sanh-hai-mat-tien` | SO-SÁNH |
| 59 | Hardening: mất điện, mất mạng, dữ liệu bẩn | `lessons/59-hardening-mat-dien-mang` |  |
| 60 | Bảo mật tối thiểu | `lessons/60-bao-mat-toi-thieu` |  |
| 61 | CI trên GitHub Actions | `lessons/61-ci-github-actions` |  |
| 62 | Đo lường và báo cáo | `lessons/62-do-luong-va-bao-cao` |  |
| 63 | Đóng gói artifact | `lessons/63-dong-goi-artifact` |  |
