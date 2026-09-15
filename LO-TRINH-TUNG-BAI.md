# Lộ Trình Từng Bài — Giai Đoạn 1

> Bản thực thi của [lo-trinh-hoc-nhung-edge-ai.md](lo-trinh-hoc-nhung-edge-ai.md).
> File kia là **la bàn** (tại sao đi hướng này). File này là **bản đồ đường đi** (làm gì, theo thứ tự nào, xong khi nào).
> Khi hai file mâu thuẫn: la bàn thắng.

---

## Cách dùng repo này

```
new_world/
├── docker/              # Dockerfile Python + C++ + mosquitto.conf
├── docker-compose.yml   # py, cpp (mặc định) + mqtt, db, grafana (profile "ot")
├── dev.ps1              # cửa vào duy nhất trên Windows
├── Makefile             # bản tương đương khi ở Git Bash / WSL / trên Pi
├── lessons/NN-ten-bai/  # mỗi bài một thư mục
│   ├── README.md        #   đề bài + tiêu chí nghiệm thu + ô ghi chú của bạn
│   ├── python/
│   ├── cpp/
│   └── NHAT-KY.md       #   bạn viết: kẹt ở đâu, hiểu ra gì, số liệu đo được
└── docs/                # tài liệu bạn tự viết ra trong quá trình học
```

**Khởi động mỗi buổi học:**

```powershell
.\dev.ps1 up          # bật môi trường
.\dev.ps1 py          # vào shell Python
# hoặc
.\dev.ps1 cpp         # vào shell C++
```

Code bạn sửa trên Windows bằng VS Code → thấy ngay trong container (bind mount). Không cài Python/GCC lên Windows. Đây chính là "gu DBeaver" áp vào embedded: **một quy trình cho mọi target**.

---

## Bốn kỷ luật xuyên suốt (vi phạm là lộ trình hỏng)

**1. Mỗi bài kết thúc bằng một commit.** Không có commit = bài chưa xong. Commit message theo dạng `b07: doc nut bam chong nhieu bang debounce 50ms`.

**2. Bài nào có nhãn `[SO-SANH]` thì viết bằng CẢ Python và C++ trên CÙNG một bài toán.** Rồi điền bảng so sánh trong `NHAT-KY.md`. Hai ngôn ngữ trên hai bài toán khác nhau = song song rời rạc, vô giá trị.

**3. Phép thử tắt AI — cuối mỗi chặng.** Chọn một phần nhỏ đã làm, tắt AI, tự viết lại. Ghi kết quả trung thực vào nhật ký:
- *Hiểu từng bước, chỉ gõ chậm* → ổn, luyện thêm.
- *Nhìn mà không hiểu vì sao nó chạy* → quay lại bài đó. Đây là tín hiệu quan trọng nhất trong cả lộ trình.

**4. Mọi kết luận về hiệu năng phải có SỐ.** Không viết "C++ nhanh hơn". Viết "C++ 0.8ms/lần đọc vs Python 4.2ms/lần đọc, RAM 2MB vs 31MB, đo trên Pi 4 với 10000 lần lặp". Thói quen này là thứ phân biệt kỹ sư với người kể chuyện.

---

## Nhịp học

Quỹ giờ 20+ giờ/tuần → **~4 bài/tuần**, mỗi bài 4–6 giờ. Giai đoạn 1 gồm 38 bài ≈ **10 tuần lý tưởng, 14–16 tuần thực tế** (luôn trượt, đó là bình thường).

Đừng chạy nhanh hơn nhịp này bằng cách bỏ tiêu chí nghiệm thu. Bỏ tiêu chí = học xong không có gì chứng minh được.

---

# CHẶNG 0 — Bệ phóng công cụ (Bài 01–04, ~1 tuần)

*Mục tiêu chặng: không bao giờ phải nghĩ về môi trường nữa. Dựng một lần, dùng suốt 38 bài.*

### Bài 01 — Môi trường Docker + Git  `[đã dựng sẵn cho bạn]`

**Mục tiêu:** hiểu cái môi trường bạn sắp sống trong đó 4 tháng tới, chứ không phải copy lệnh.

**Làm gì:**
- Bật `.\dev.ps1 up`, vào cả hai container, chạy `python --version` và `g++ --version`.
- Sửa một file trên Windows → `cat` nó trong container. Hiểu **bind mount**.
- Sửa `docker/python/requirements.txt` → `.\dev.ps1 build`, đo thời gian. Rồi sửa một file `.py` → build lại, đo lại. Giải thích chênh lệch.
- `docker images` — xem image nặng bao nhiêu. **Ghi lại con số này**, bài 28 sẽ ép nó xuống.
- Đọc `docker-compose.yml` và trả lời: `profiles: [ot]` để làm gì? `volumes: py-cache` khác `.:/work` chỗ nào?

**Xong khi:** giải thích được bằng lời (viết vào nhật ký) 4 khái niệm **image / container / layer / volume**, và vì sao dòng `COPY requirements.txt` đứng TRƯỚC code trong Dockerfile.

**Bẫy:** đừng sa đà tối ưu Dockerfile lúc này. Chạy được là đủ. Bài 28 mới là lúc tối ưu.

---

### Bài 02 — Cùng một bài toán, hai ngôn ngữ  `[SO-SÁNH]`

**Mục tiêu:** cảm nhận khác biệt Python/C++ trên da thịt, không qua lý thuyết.

**Bài toán:** đọc `sensor_log.csv` (timestamp, nhiệt độ, độ ẩm — có dòng hỏng, có giá trị thiếu) → tính min/max/trung bình, phát hiện outlier (lệch hơn 3σ), in báo cáo.

**Làm gì:**
- Viết `python/analyze.py` và `cpp/analyze.cpp`. Cùng input, cùng output — `diff` hai output phải rỗng.
- Cả hai phải xử lý dòng hỏng mà không crash.
- Tự sinh file 1 triệu dòng, đo thời gian chạy.

**Xong khi:** có bảng trong nhật ký gồm 5 cột — *số dòng code · thời gian chạy · RAM đỉnh · thứ ngôn ngữ làm hộ bạn · thứ nó bắt bạn tự làm*.

**Câu hỏi bắt buộc trả lời được:** trong C++ ai giải phóng bộ nhớ của cái vector đó? Trong Python ai làm? Điều đó đổi cách bạn viết code thế nào?

---

### Bài 03 — CMake, pytest, và kỷ luật kỹ thuật

**Mục tiêu:** mỗi bên có một cách build/test chuẩn, dùng lại tới hết lộ trình.

**Làm gì:**
- Viết `CMakeLists.txt` cho bài 02: target, `Debug` vs `Release`, build ra `build/`.
- Đo lại bản `Release` (`-O2`) so với `Debug`. Con số sẽ làm bạn bất ngờ.
- Viết pytest cho `analyze.py`: test dòng hỏng, file rỗng, outlier biên.
- `make fmt`, `make lint`, `make test` chạy được.

**Xong khi:** `make test` xanh; cmake build ra binary; hiểu vì sao **đo hiệu năng trên bản Debug là vô nghĩa**.

---

### Bài 04 — Git: dàn dựng case khó

**Mục tiêu:** solo dev không tự gặp case khó, nên phải dựng ra mà tập.

**Làm theo đúng thứ tự:**
1. Quy ước nhánh `main` / `feat/*` / `fix/*` → viết vào `docs/git-convention.md`.
2. Tạo `feat/them-median` và `feat/them-percentile`, **cả hai cùng sửa một hàm** trong `analyze.py`.
3. Merge cái đầu. Merge cái sau → **conflict**. Giải bằng tay, hiểu `<<<<<<< HEAD`.
4. Đẩy lên GitHub, tạo Pull Request → tự review chính mình, để lại ít nhất 2 comment thật.
5. Commit một lỗi cố ý, push → **`git revert`** nó (KHÔNG `reset`). Giải thích khác biệt.
6. `git rebase -i` squash 3 commit vụn thành 1.
7. `git tag v0.1.0` + tạo release.

**Xong khi:** `git log --oneline --graph --all` cho thấy đủ: 1 merge có conflict đã giải, 1 revert, 1 nhánh đã squash, 1 tag.

**Ghi chú:** repo này nên **public từ bây giờ**. Lịch sử Git sạch là một phần của artifact cuối cùng.

---

# CHẶNG 1 — Embedded Linux trên Pi, Python dẫn (Bài 05–12, ~2 tuần)

*Mục tiêu chặng: Pi không còn là "máy tính nhỏ" mà là **bệ chạy AI có chân cắm ra thế giới vật lý**.*

### Bài 05 — Pi headless: SSH, user, quyền

**Làm gì:** flash OS (bản Lite, không desktop) → SSH bằng **key**, tắt đăng nhập mật khẩu → hiểu group `dialout` / `i2c` / `gpio` / `video`, và vì sao thiếu group thì "Permission denied" dù `sudo` vẫn chạy được.

**Xong khi:** đăng nhập không cần mật khẩu; user thường (không sudo) đọc được `/dev/i2c-1`; giải thích được vì sao **không nên** chạy mọi thứ bằng root.

**Bẫy:** đừng cài desktop lên Pi. Mọi thứ qua SSH — đó là cách edge thật vận hành.

---

### Bài 06 — Linux nền cho người làm nhúng

**Mục tiêu:** `/dev`, `/sys`, `/proc` là chỗ phần mềm chạm phần cứng. Không hiểu chúng thì mọi thứ về sau là phép thuật.

**Làm gì:**
- Soi `/dev/i2c-1`, `/dev/ttyUSB0`, `/dev/gpiochip0` — chúng là *file*, nhưng là loại file gì?
- Đọc nhiệt độ CPU từ `/sys/class/thermal/thermal_zone0/temp`. Không thư viện nào cả, chỉ đọc file.
- Viết script bắt `SIGTERM` → dọn dẹp (tắt LED, đóng file) → thoát với exit code đúng.
- Dùng thử `ps`, `top`, `lsof`, và `strace` trên một lệnh đơn giản.

**Xong khi:** giải thích được "mọi thứ là file" nghĩa là gì với người làm nhúng; script của bạn tắt sạch khi bị `systemctl stop`, không để LED sáng mãi.

---

### Bài 07 — GPIO bằng Python

**Làm gì:** LED nhấp nháy → nút bấm bật/tắt LED → **chống nhiễu (debounce)** → PWM đổi độ sáng.

**Xong khi:** bấm nút 20 lần, LED đổi trạng thái đúng 20 lần — không nhiều hơn. Đo được thời gian nhiễu của nút bằng oscilloscope-nhà-nghèo: log timestamp mỗi lần chân đổi mức.

**Vì sao bài này quan trọng hơn vẻ ngoài của nó:** debounce là bài học đầu tiên rằng **thế giới vật lý bẩn**. Mọi thứ về sau — cảm biến nhiễu, mạng chập chờn, AI đoán sai — đều là biến thể của bài này.

---

### Bài 08 — I2C/SPI: đọc cảm biến thật

**Làm gì:** `i2cdetect -y 1` tìm địa chỉ → **đọc datasheet** (thanh ghi nào, đơn vị gì, chờ bao lâu) → đọc giá trị → xử lý khi rút dây giữa chừng.

**Xong khi:** số đọc ra đúng thực tế (hà hơi vào cảm biến, số phải nhảy); rút dây → chương trình báo lỗi rõ ràng và **không chết**.

**Kỹ năng thật đang luyện:** đọc datasheet. Đây là thứ phân biệt người làm nhúng với người copy thư viện.

---

### Bài 09 — systemd: dịch vụ tự phục hồi

**Làm gì:** biến script bài 08 thành service — `Restart=always`, `RestartSec`, `After=network.target`, log qua `journalctl`, thử `WatchdogSec`.

**Xong khi:** `kill -9` tiến trình → vài giây sau tự sống lại. Reboot Pi → tự chạy. `journalctl -u <service> -f` thấy log.

Đây là lần đầu bạn chạm vào **vận hành** — thứ khách hàng thật quan tâm hơn cả tính năng.

---

### Bài 10 — Docker trên Pi: kiến trúc arm64

**Làm gì:** cài Docker trên Pi → build image ngay trên Pi (chậm, để thấy nó chậm) → rồi dùng `docker buildx` trên PC build **multi-arch** (amd64 + arm64), đẩy lên registry.

**Xong khi:** cùng một lệnh `docker run` chạy được cùng một image trên cả PC và Pi. Giải thích được vì sao image amd64 không chạy trên Pi, và QEMU đang làm gì trong buildx.

**Điểm nhấn CV:** multi-arch build là thứ dân web hiếm khi đụng. Ghi lại thời gian build của hai cách.

---

### Bài 11 — Truyền thiết bị vật lý vào container

**Mục tiêu:** đây là chỗ Docker gặp phần cứng — case Docker "sát nhúng" nhất.

**Làm gì:** chạy code bài 08 **bên trong container** và truy cập được `/dev/i2c-1`:
- Thử `--privileged` trước (chạy được — nhưng vì sao đó là ý tồi?).
- Rồi làm đúng: `--device=/dev/i2c-1`, `group_add`, khai báo `devices:` trong compose.
- Thêm luôn camera `/dev/video0` và serial `/dev/ttyUSB0` — hai thứ sẽ cần ở Chặng 2 và 3.

**Xong khi:** container đọc được cảm biến **không cần `--privileged`**; viết được vào nhật ký vì sao `--privileged` là nợ bảo mật.

---

### Bài 12 — C++ đọc cảm biến, đo hiệu năng  `[SO-SÁNH]`

**Làm gì:** viết lại bài 08 bằng C++ thuần — mở `/dev/i2c-1` bằng `open()`, nói chuyện bằng `ioctl()`, không thư viện cao cấp.

**Đo (10.000 lần đọc, trên Pi):** thời gian mỗi lần đọc · RAM đỉnh · CPU% · thời gian khởi động tiến trình · kích thước binary so với kích thước runtime Python.

**Xong khi:** có bảng số liệu + một kết luận có căn cứ: *"với bài này tôi chọn X vì Y"*. Không có đáp án đúng chung — chỉ có đáp án đúng **cho bài toán cụ thể**.

Đây là cây cầu sang C++: bạn không học C++ từ hello world, bạn học nó để làm lại thứ mình đã hiểu.

> **PHÉP THỬ TẮT AI #1** — tắt AI, tự viết lại bài 07 (nút + LED + debounce) từ đầu. Ghi kết quả trung thực vào nhật ký.

---

# CHẶNG 2 — ESP32-S3 và cây cầu OT (Bài 13–22, ~3 tuần)

*Mục tiêu chặng: **đây là phần đắt giá nhất của cả lộ trình.** Modbus/MQTT xuất hiện trong gần như mọi JD IoT/nhúng, và đây là chỗ nền sản xuất–kho của bạn phát huy. Không cần PLC — ESP32 đóng vai "thiết bị kiểu máy" là đủ để xây cây cầu thật.*

### Bài 13 — ESP-IDF: chọn chỗ đặt toolchain

**Quyết định phải ra trước khi gõ dòng nào:** ESP-IDF chạy trong Docker rất sạch, **nhưng Docker Desktop trên Windows không thấy cổng COM**. Bạn có ba đường:

| Đường | Build | Flash/Monitor | Ma sát |
|---|---|---|---|
| **A. Docker build + flash từ Windows** *(khuyến nghị để bắt đầu)* | trong container | `esptool.py` trên Windows | Thấp. Giữ được toolchain sạch, chấp nhận 1 bước thủ công. |
| **B. WSL2 + usbipd-win** | trong WSL | trong WSL | Trung bình. Phải `usbipd attach` mỗi lần cắm. Sạch nhất khi đã quen. |
| **C. ESP-IDF cài thẳng Windows** | host | host | Thấp nhất, nhưng bẩn máy — đi ngược gu của bạn. |

Chọn **A** trước. Nếu thấy bước thủ công phiền thì chuyển **B** ở bài 16. Nhắc lại nguyên tắc 3 của la bàn: *cái bạn đang học lúc này là con chip, không phải cái công cụ.* Đừng đốt hai ngày cho USB passthrough.

**Làm gì:** blink LED → `idf.py build` → flash → `monitor` thấy log. Đọc `sdkconfig` xem nó thật ra là gì.

**Xong khi:** chu trình sửa-code → build → flash → thấy kết quả mất dưới 60 giây và bạn không phải nghĩ về nó nữa. **Bỏ hẳn Arduino IDE.**

---

### Bài 14 — GPIO, ADC, timer trên ESP32

**Làm gì:** GPIO out/in với pull-up → ADC đọc điện áp (biến trở hoặc cảm biến analog) → **hiệu chuẩn ADC** (giá trị thô không phải volt!) → timer định kỳ.

**Xong khi:** ADC ra đúng volt đo bằng đồng hồ (sai số dưới 2%); giải thích được vì sao ADC của ESP32 phi tuyến ở hai đầu dải.

---

### Bài 15 — FreeRTOS: task, queue, mutex

**Mục tiêu:** đây là khác biệt lớn nhất giữa vi điều khiển và Linux. Không có OS đầy đủ, bạn tự quản lý thời gian.

**Làm gì:** tách 2 task — task đọc cảm biến (chu kỳ đều) và task gửi dữ liệu (chậm, có thể nghẽn). Nối bằng **queue**. Bảo vệ tài nguyên chung bằng **mutex**.

**Xong khi:** task gửi bị treo 5 giây → task đọc **vẫn đúng chu kỳ**. Giải thích được stack size chọn bao nhiêu và vì sao tràn stack ở đây làm thiết bị reboot.

**So với Pi:** viết vào nhật ký khác biệt giữa "task FreeRTOS" và "process Linux". Đây là câu hỏi phỏng vấn kinh điển.

---

### Bài 16 — WiFi và MQTT từ ESP32

**Làm gì:** WiFi station → **tự nối lại khi mất sóng** (exponential backoff, không spam) → MQTT publish lên Mosquitto chạy trong Docker.

```powershell
.\dev.ps1 up ot     # bật mqtt + db + grafana
```

**Xong khi:** Python trong container `py` subscribe và thấy dữ liệu; **rút WiFi 2 phút rồi cắm lại → ESP32 tự nối lại, không cần reset**.

---

### Bài 17 — Kiến trúc MQTT: topic, QoS, LWT

**Mục tiêu:** phần thiết kế, không phải phần code. Đây là chỗ kinh nghiệm hệ thống của bạn có giá.

**Làm gì:**
- Thiết kế cây topic: `nhamay/khuvuc/thietbi/phepdo` — vì sao không nhét tất cả vào một topic?
- QoS 0 vs 1 vs 2: thử mất gói thật (tắt broker giữa chừng) và quan sát.
- `retained` message — thiết bị mới kết nối thấy ngay trạng thái cuối.
- **LWT (Last Will and Testament)** — thiết bị chết đột ngột thì hệ thống tự biết.

**Xong khi:** rút điện ESP32 → trong vòng 30 giây có message `offline` xuất hiện, không cần ai hỏi thăm.

**Đây là bài dạy bạn nghĩ như người vận hành hệ thống, không phải người viết tính năng.**

---

### Bài 18 — Modbus TCP: ESP32 làm slave

**Mục tiêu:** Modbus là ngôn ngữ chung của thiết bị công nghiệp. Hiểu nó là hiểu cách máy móc nói chuyện.

**Làm gì:** ESP32 làm **Modbus TCP slave**, expose cảm biến qua holding register → Python (`pymodbus`) làm **master**, poll dữ liệu.

**Phải hiểu được:** coil vs discrete input vs input register vs holding register; vì sao register là 16-bit và số thực phải ghép 2 register (và thứ tự byte/word có thể ngược — lỗi kinh điển ngoài hiện trường).

**Xong khi:** đọc holding register ra đúng giá trị cảm biến thật; thử đọc register không tồn tại → nhận đúng exception code.

---

### Bài 19 — Modbus RTU qua RS485

**Vì sao vẫn phải học dù đã có TCP:** phần lớn thiết bị trong nhà máy Việt Nam nói RTU qua dây RS485, không phải Ethernet. Đây là chỗ "chạm được thiết bị" trở thành thật.

**Làm gì:** cùng dữ liệu bài 18 nhưng qua serial → CRC, baudrate, parity, **timing giữa các frame** → nhiều slave trên một dây (địa chỉ slave).

**Xong khi:** poll được qua dây thật; cố tình sai baudrate → hiểu triệu chứng; giải thích được vì sao RTU nhạy cảm với timing còn TCP thì không.

**Docker:** truyền `/dev/ttyUSB0` vào container (đã học ở bài 11).

---

### Bài 20 — Thiết kế tag map và chiến lược polling

**Mục tiêu:** bài thiết kế thuần. Chỗ nền sản xuất/kho của bạn đáng tiền nhất.

**Làm gì:** viết `docs/tag-map.md` có version — mỗi tag: địa chỉ, kiểu dữ liệu, đơn vị, hệ số scale, dải hợp lệ, chu kỳ đọc.
- Polling vs event: khi nào chọn cái nào?
- **Deadband** — chỉ ghi khi thay đổi đủ lớn. Giảm dữ liệu rác 90%.
- **Timestamp của ai?** Thiết bị hay gateway? Đồng hồ ESP32 lệch thì sao?
- Poll 100 tag trong 1 giây có khả thi không — tính thử băng thông RTU.

**Xong khi:** tag map đủ để **người khác** viết gateway mà không cần hỏi bạn.

---

### Bài 21 — Lưu trữ và dashboard

**Làm gì:** Python gateway đọc Modbus/MQTT → ghi Postgres → Grafana vẽ. Tất cả trong compose.
- Schema time-series: index theo thời gian, tránh bảng phình.
- Xử lý mất kết nối DB — **buffer tại chỗ, không mất dữ liệu**.

**Xong khi:** chạy liên tục 24 giờ → biểu đồ liền mạch, không lỗ hổng; tắt DB 10 phút → dữ liệu vẫn về đủ sau khi bật lại.

---

### Bài 22 — docker-compose nhiều service cho ra hồn

**Làm gì (case Docker phải dàn dựng):**
- `healthcheck` cho từng service + `depends_on: condition: service_healthy`.
- `restart: unless-stopped` và thử giết service ngẫu nhiên.
- Tách config theo môi trường: `.env.dev` vs `.env.prod`, **không hardcode** mật khẩu.
- Network nội bộ: DB **không** expose ra ngoài, chỉ service trong mạng thấy.
- Tối ưu thứ tự layer để build lại nhanh.

**Xong khi:** một lệnh `docker compose --profile ot up -d` dựng cả hệ; `docker kill` bất kỳ service nào → hệ tự hồi phục trong 30 giây.

> **PHÉP THỬ TẮT AI #2** — tắt AI, tự viết lại phần MQTT publish trên ESP32 và phần subscribe bên Python.

**Đầu ra Chặng 2:** hệ thống ESP32 → Modbus/MQTT → Pi → DB → dashboard, chạy liên tục. **Riêng phần này đã đủ kể thành một câu chuyện phỏng vấn hoàn chỉnh.**

---

# CHẶNG 3 — AI lên edge (Bài 23–30, ~2–3 tuần)

*Mục tiêu chặng: giá trị KHÔNG nằm ở gõ Python. Nằm ở **phán đoán** — chọn bài toán đúng, ép model vừa thiết bị nhỏ, và biết khi nào model sai thì hệ thống phải làm gì.*

### Bài 23 — Đường ống camera

**Làm gì:** OpenCV đọc từ ba nguồn — webcam laptop (dev nhanh), **RTSP từ điện thoại** (app kiểu *IP Webcam*), và USB cam cắm Pi nếu có.
- Đo FPS thật, không phải FPS ghi trên hộp.
- Vấn đề **buffer**: đọc chậm hơn nguồn → bạn đang xử lý frame cũ 3 giây trước. Cực kỳ quan trọng khi ra quyết định điều khiển.
- Mất kết nối RTSP → tự nối lại.

**Xong khi:** đo được FPS và **độ trễ end-to-end** (mẹo: quay màn hình đang chạy đồng hồ mili-giây); xử lý được mất kết nối mà không crash.

**Vì sao RTSP quan trọng hơn USB:** nhà máy thật dùng camera IP. Tập bằng điện thoại là tập đúng giao thức thật — không phải giải pháp tạm bợ.

---

### Bài 24 — Chọn bài toán vision  `[BÀI PHÁN ĐOÁN — quan trọng nhất chặng]`

**Không viết code trong bài này.** Viết một trang `docs/problem-statement.md`.

**Chọn một bài toán nhà máy có thật:** đếm sản phẩm qua băng chuyền · phát hiện thiếu nhãn/nắp · nhận diện trạng thái đèn báo máy (xanh/vàng/đỏ) · phát hiện người vào vùng nguy hiểm · đọc số trên đồng hồ analog.

**Phải trả lời bằng số:**
- Sai sót nào đắt hơn — báo nhầm (false positive) hay bỏ sót (false negative)? Đắt hơn bao nhiêu?
- Ngưỡng chấp nhận được là bao nhiêu? (*"95% accuracy"* là câu trả lời lười — 95% trên tập nào, điều kiện ánh sáng nào?)
- Ánh sáng thay đổi thế nào trong ngày? Camera có bị rung không? Vật thể đi nhanh cỡ nào?
- **Nếu model chết thì dây chuyền phải làm gì?** Dừng, hay chạy tiếp và ghi log?

**Xong khi:** người khác đọc trang đó và biết chính xác phải xây gì, đo thế nào là đạt.

Đây là bài phân biệt kỹ sư giải pháp với người chạy notebook.

---

### Bài 25 — Chạy model có sẵn, đo cho ra số

**Làm gì:** lấy model pretrained (MobileNet / YOLO-nano / model phân loại nhỏ) → chạy trên PC → chạy trên Pi → đo.

**Bảng bắt buộc có:** latency p50 và **p95** (không chỉ trung bình!) · FPS thực · RAM · nhiệt độ CPU sau 30 phút · có bị **throttle** không.

**Xong khi:** có bảng số liệu hai nền tảng và một câu kết luận: *"model này chạy được/không chạy được trên Pi vì..."*.

**Bài học ẩn:** Pi nóng lên là giảm xung nhịp. Số đo 30 giây đầu là số đo dối.

---

### Bài 26 — Quantization và tối ưu cho thiết bị nhỏ

**Mục tiêu:** đây là kỹ năng "AI cho edge" thật sự, thứ mà người chỉ biết train model không có.

**Làm gì:** FP32 → FP16 → **INT8**, qua TFLite hoặc ONNX Runtime.
- Cần **calibration dataset** cho INT8 — hiểu vì sao.
- Đo lại **cả ba**: accuracy, latency, size. Vẽ biểu đồ đánh đổi.
- Thử thêm: giảm độ phân giải đầu vào, bỏ qua frame (frame skipping), chỉ xử lý vùng quan tâm (ROI).

**Xong khi:** chọn được một cấu hình và **biện hộ được bằng số**: *"INT8 mất 1.2% accuracy nhưng nhanh gấp 3.1 lần và nhỏ hơn 3.8 lần — với bài toán này đáng đổi vì..."*

---

### Bài 27 — Dataset của chính bạn và transfer learning

**Làm gì:** chụp dataset thật bằng chính camera/ánh sáng sẽ dùng khi chạy → label → augment (xoay, đổi sáng, nhiễu) → transfer learning từ model pretrained.

**Kỷ luật chia dữ liệu:** tập test phải chụp ở **buổi khác, ánh sáng khác**. Chia ngẫu nhiên từ cùng một buổi chụp là tự lừa mình — model học điều kiện chụp chứ không học vật thể.

**Xong khi:** model tự train **thắng baseline bài 25** trên tập test khó đó. Nếu thua — cũng là kết quả, ghi lại lý do, đó là phát hiện thật.

---

### Bài 28 — Đóng gói AI service: multi-stage image

**Làm gì:** Dockerfile multi-stage ép image nặng (OpenCV, ONNX Runtime) xuống nhỏ.
- Stage build (có compiler) tách khỏi stage runtime (không).
- Chạy **non-root**.
- Build cho **arm64**, chạy trên Pi.
- So với con số bạn ghi ở bài 01.

**Xong khi:** image nhỏ hơn bản ngây thơ ít nhất 3 lần, chạy được trên Pi, không chạy bằng root.

---

### Bài 29 — Khép kín vòng: AI ra lệnh xuống thiết bị

**Đây là khoảnh khắc cả lộ trình hội tụ.**

Camera → Pi (AI suy luận) → quyết định → MQTT/Modbus → ESP32 → relay/đèn/còi.

**Làm gì:** nối trọn chuỗi. Đo **độ trễ end-to-end**: từ lúc vật thể vào khung hình đến lúc relay kêu.

**Xong khi:** vật thể lỗi đi qua → thiết bị phản ứng dưới 1 giây; đo được từng chặng trễ ở đâu (camera bao nhiêu ms, inference bao nhiêu, mạng bao nhiêu, ESP32 bao nhiêu).

---

### Bài 30 — Độ tin cậy: ngưỡng, chống nháy, và cái giá của sai

**Mục tiêu:** model không bao giờ đúng 100%. Hệ thống tốt là hệ thống **sai một cách có kiểm soát**.

**Làm gì:**
- Confidence threshold — chỉnh và quan sát đánh đổi FP/FN.
- **Chống nháy:** N-of-M (chỉ báo khi 3/5 frame liên tiếp đồng ý), hysteresis.
- Chế độ degraded: model chết → hệ thống làm gì? Camera mất → làm gì?
- Ghi log mọi quyết định + lưu ảnh của ca sai, để về sau còn truy được.

**Xong khi:** chạy thật 1 giờ, đếm tay FP/FN, chỉnh ngưỡng **có căn cứ số liệu**, và ghi vào nhật ký vì sao chọn ngưỡng đó cho bài toán này.

> **PHÉP THỬ TẮT AI #3** — tắt AI, tự viết lại vòng đọc camera + tiền xử lý + gọi inference.

---

# CHẶNG 4 — C++ dẫn, hardening, và giao hàng (Bài 31–38, ~2–3 tuần)

*Mục tiêu chặng: biến "một demo chạy được" thành "một hệ thống có người dám cắm vào dây chuyền". Và học C++ ở chỗ nó thật sự đáng học — khi bạn đã hiểu bài toán.*

### Bài 31 — C++ hiện đại cho nhúng

**Làm gì:** RAII · `unique_ptr`/`shared_ptr` (và khi nào **không** dùng con trỏ nào cả) · `std::optional` cho giá trị có thể thiếu · `std::span` · **tránh cấp phát bộ nhớ trong vòng lặp nóng** · `constexpr`.

**Xong khi:** viết lại một module Python sang C++ sạch; `valgrind` không báo leak; giải thích được vì sao `new`/`delete` bằng tay là mùi code xấu trong C++ hiện đại.

**Ghi chú về ngữ cảnh nhúng:** trên vi điều khiển, exception và cấp phát heap động thường bị cấm. Hiểu **vì sao** — không phải vì chúng xấu, mà vì chúng làm thời gian thực thi khó đoán.

---

### Bài 32 — Viết lại phần nóng bằng C++  `[SO-SÁNH]`

**Làm gì:** chọn phần nặng nhất đã đo được (tiền/hậu xử lý ảnh, hoặc vòng polling Modbus) → viết lại bằng C++ → đo trước/sau.

**Xong khi:** có bảng số liệu và một kết luận trung thực — **kể cả khi kết luận là "không đáng viết lại"**. Đó cũng là phán đoán kỹ thuật, và là câu trả lời phỏng vấn tốt hơn nhiều so với "tôi viết lại mọi thứ bằng C++".

---

### Bài 33 — Cross-compile sang arm64

**Mục tiêu:** không cài compiler lên thiết bị production. Build ở nơi mạnh, chạy ở nơi nhỏ.

**Làm gì:** CMake toolchain file cho `aarch64-linux-gnu` → build trong container trên PC → copy binary sang Pi → chạy.

**Xong khi:** binary build trên Windows/Docker chạy được trên Pi, và trên Pi **không có** gcc/cmake nào cả. Hiểu `ldd` báo gì khi thiếu thư viện, và vì sao static link đôi khi đáng giá.

---

### Bài 34 — C++ trên ESP32 và bài toán điện năng

**Làm gì:** dùng C++ trong ESP-IDF → đo heap/stack còn lại lúc chạy → **deep sleep** → đo dòng tiêu thụ thật bằng đồng hồ (hoặc module INA219).

**Xong khi:** đo được mA ở chế độ chạy và chế độ ngủ; tính được thời gian sống nếu chạy pin; giảm được điện năng và **có số liệu chứng minh**.

**Vì sao có mặt trong lộ trình:** điện năng là ràng buộc bạn không gặp trong web. Biết nói chuyện về mAh và duty cycle là dấu hiệu người thật sự làm nhúng.

---

### Bài 35 — Hardening: mất điện, mất mạng, dữ liệu bẩn

**Mục tiêu:** đây là phần biến demo thành sản phẩm. Cũng là phần 90% dự án cá nhân bỏ qua — nên nó là chỗ bạn nổi bật.

**Làm gì, và phải thử thật:**
- Rút mạng 10 phút → buffer tại chỗ → gửi bù khi có mạng, **không trùng, không mất**.
- Rút điện Pi giữa lúc ghi file → bật lại, dữ liệu không hỏng (atomic write).
- Gửi dữ liệu rác vào Modbus/MQTT → hệ thống từ chối sạch sẽ, không crash.
- Đồng hồ nhảy lùi (NTP sync) → không làm hỏng chuỗi thời gian.
- Watchdog nhiều tầng: systemd cho service, hardware watchdog cho Pi, task watchdog cho ESP32.

**Xong khi:** hoàn thành một **bảng kiểm tra phá hoại** — mỗi dòng là một cách bạn cố tình phá và kết quả hệ thống chịu được. Bảng này đưa vào README.

---

### Bài 36 — CI trên GitHub Actions

**Mục tiêu:** chỗ Git + Docker + CI/CD gặp nhau. Trả luôn phần "cày CI/CD" mà không cần học riêng.

**Làm gì:** mỗi push → chạy pytest + ruff + build C++ → build Docker image **multi-arch** → push lên registry. Tag `v*` → tạo release tự động.

**Xong khi:** badge xanh trên README; một lần push tự ra image chạy được trên Pi mà bạn không làm gì thêm.

---

### Bài 37 — Đo lường và báo cáo

**Làm gì:** chạy hệ thống **liên tục nhiều ngày**, thu thập tự động: accuracy trên dữ liệu thật · latency p50/p95/p99 · FPS · uptime · số lần tự khởi động lại · điện năng · nhiệt độ.

Viết script sinh báo cáo từ log — không đo bằng tay.

**Xong khi:** có báo cáo số liệu của **ít nhất 72 giờ chạy liên tục**. Đây là thứ xóa sạch nghi ngờ "chỉ là lý thuyết", mạnh hơn mọi chứng chỉ.

---

### Bài 38 — Đóng gói artifact

**Làm gì:**
- README có: bài toán thật đang giải · sơ đồ kiến trúc · **bảng số liệu** · hướng dẫn tái lập từ số 0 · bảng kiểm tra phá hoại (bài 35).
- Video demo 2–3 phút: quay hệ thống chạy thật, không phải slide.
- Viết `docs/cv-bullets.md`: 5 gạch đầu dòng cho CV, mỗi dòng có **số liệu**.
- Dọn lịch sử Git, tag `v1.0.0`.

**Xong khi:** một người lạ clone repo về và chạy được mà không cần hỏi bạn câu nào.

> **PHÉP THỬ TẮT AI #4 (cuối cùng)** — tắt AI, giải thích toàn bộ kiến trúc bằng lời trong 10 phút, quay lại. Chỗ nào bạn ấp úng là chỗ bạn chưa thật sự sở hữu.

---

## Đầu ra Giai đoạn 1

Một hệ thống: **camera → Pi (AI) → Modbus/MQTT → ESP32 → thiết bị**. Đóng gói Docker, lịch sử Git sạch, CI xanh, có log và số liệu nhiều ngày, tự phục hồi khi mất điện/mạng, xử lý input bẩn thật. Public trên GitHub, README tử tế, video demo.

Một artifact chứng minh trọn combo hiếm: **phần mềm + chạm được thiết bị + AI + hiểu sản xuất**.

---

## Sau Giai đoạn 1 — đừng học tiếp ngay

Theo la bàn, Giai đoạn 2 (STM32 / C# / Cloud / PLC) **chỉ mở khi có JD cụ thể đòi**. Xong Giai đoạn 1, việc tiếp theo không phải học thêm, mà là:

1. Đổi tiêu đề CV thành **"IoT Engineer"** / **"Kỹ sư giải pháp Industry 4.0"**.
2. Apply và phỏng vấn ngay, khi còn lương — không đợi.
3. Tìm một job freelance nhỏ có thật, dù rẻ.
4. Xin reference sau mỗi việc.

JD bạn gặp sẽ nói cho bạn biết cần học gì tiếp. Đó là dữ liệu, không phải phỏng đoán.

---

## Bảng tra nhanh

| Bài | Tên | Thư mục | Nhãn |
|---|---|---|---|
| 01 | Môi trường Docker + Git | `lessons/01-moi-truong-docker-git` | |
| 02 | Cùng một bài toán, hai ngôn ngữ | `lessons/02-python-cpp-cung-bai-toan` | SO-SÁNH |
| 03 | CMake, pytest, kỷ luật kỹ thuật | `lessons/03-cmake-pytest-ky-luat` | |
| 04 | Git: dàn dựng case khó | `lessons/04-git-case-kho` | |
| 05 | Pi headless: SSH, user, quyền | `lessons/05-pi-headless-ssh-quyen` | |
| 06 | Linux nền cho người làm nhúng | `lessons/06-linux-nen-cho-nhung` | |
| 07 | GPIO bằng Python | `lessons/07-gpio-python` | |
| 08 | I2C/SPI: đọc cảm biến thật | `lessons/08-i2c-spi-cam-bien-that` | |
| 09 | systemd: dịch vụ tự phục hồi | `lessons/09-systemd-tu-phuc-hoi` | |
| 10 | Docker trên Pi: arm64 | `lessons/10-docker-pi-arm64` | |
| 11 | Truyền thiết bị vào container | `lessons/11-truyen-thiet-bi-vao-container` | |
| 12 | C++ đọc cảm biến, đo hiệu năng | `lessons/12-cpp-cam-bien-do-hieu-nang` | SO-SÁNH |
| 13 | ESP-IDF: chọn chỗ đặt toolchain | `lessons/13-esp-idf-toolchain` | |
| 14 | GPIO, ADC, timer trên ESP32 | `lessons/14-esp32-gpio-adc-timer` | |
| 15 | FreeRTOS: task, queue, mutex | `lessons/15-freertos-task-queue` | |
| 16 | WiFi và MQTT từ ESP32 | `lessons/16-wifi-mqtt-esp32` | |
| 17 | Kiến trúc MQTT: topic, QoS, LWT | `lessons/17-mqtt-topic-qos-lwt` | |
| 18 | Modbus TCP: ESP32 làm slave | `lessons/18-modbus-tcp-esp32-slave` | |
| 19 | Modbus RTU qua RS485 | `lessons/19-modbus-rtu-rs485` | |
| 20 | Tag map và chiến lược polling | `lessons/20-tag-map-va-polling` | PHÁN ĐOÁN |
| 21 | Lưu trữ và dashboard | `lessons/21-luu-tru-va-dashboard` | |
| 22 | docker-compose nhiều service | `lessons/22-compose-nhieu-service` | |
| 23 | Đường ống camera | `lessons/23-duong-ong-camera` | |
| 24 | Chọn bài toán vision | `lessons/24-chon-bai-toan-vision` | PHÁN ĐOÁN |
| 25 | Chạy model có sẵn, đo cho ra số | `lessons/25-chay-model-do-so-lieu` | |
| 26 | Quantization và tối ưu | `lessons/26-quantization-toi-uu` | |
| 27 | Dataset riêng và transfer learning | `lessons/27-dataset-transfer-learning` | |
| 28 | AI service: multi-stage image | `lessons/28-ai-service-multi-stage` | |
| 29 | Khép kín vòng AI → thiết bị | `lessons/29-khep-kin-vong-ai-thiet-bi` | |
| 30 | Ngưỡng, chống nháy, giá của sai | `lessons/30-nguong-chong-nhay` | PHÁN ĐOÁN |
| 31 | C++ hiện đại cho nhúng | `lessons/31-cpp-hien-dai-cho-nhung` | |
| 32 | Viết lại phần nóng bằng C++ | `lessons/32-cpp-viet-lai-phan-nong` | SO-SÁNH |
| 33 | Cross-compile sang arm64 | `lessons/33-cross-compile-arm64` | |
| 34 | C++ trên ESP32 và điện năng | `lessons/34-esp32-cpp-dien-nang` | |
| 35 | Hardening: mất điện, mất mạng | `lessons/35-hardening-mat-dien-mang` | |
| 36 | CI trên GitHub Actions | `lessons/36-ci-github-actions` | |
| 37 | Đo lường và báo cáo | `lessons/37-do-luong-va-bao-cao` | |
| 38 | Đóng gói artifact | `lessons/38-dong-goi-artifact` | |
