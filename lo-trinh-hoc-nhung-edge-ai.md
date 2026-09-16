# Lộ Trình Học: Kỹ Sư Bắc Cầu IT↔OT + Edge AI

> Tài liệu này tổng hợp toàn bộ hướng đi đã thống nhất. Đọc phần "Căn cước & Nguyên tắc" trước — nó là la bàn để bạn tự quyết mọi ngã rẽ về sau mà không cần hỏi ai.

---

## 0. Căn cước nghề nghiệp (đọc trước khi làm bất cứ gì)

**Bạn KHÔNG phải:** web dev thuần, kỹ sư nhúng thuần, kỹ sư AI/agent thuần, hay dân automation/PLC thuần.

**Bạn LÀ:** người bắc cầu giữa tầng IT (phần mềm, AI, dashboard) và tầng OT (thiết bị, máy móc sàn nhà máy) — đứng ở tầng trên với phần mềm/AI/Python, *chạm* xuống tầng dưới qua giao thức công nghiệp. Web là công cụ giao hàng (đã giỏi, giữ nguyên). Khả năng chạm thiết bị + hiểu sản xuất/kho là căn cước. AI (vision/edge cho bài toán nhà máy) là chất nhân giá trị gắn lên trên.

**Vì sao hướng này:** đây là chỗ duy nhất trong hồ sơ của bạn neo vào *thế giới vật lý* + *domain cụ thể* — hai thứ AI và outsourcing không ăn được. Web/backend thuần đang bị nén lương và bị AI thay dần vì nó thuần số, ít ngữ cảnh, nguồn cung đông. Đừng "làm mới" sang một kỹ năng thuần-số khác (C#, cloud thuần, AI-app thuần) — đó chỉ là đổi ghế trong cùng vùng nổ.

**Combo hiếm của bạn:** phần mềm + chạm được thiết bị + hiểu sản xuất/kho. Đa số dân phần mềm ngại phần cứng; đa số dân phần cứng yếu phần mềm. Bạn đứng được cả hai.

---

## 1. Nguyên tắc xuyên suốt (dùng để tự ra quyết định)

1. **Học ở giao điểm, không học rời rạc.** Mỗi thứ học ở bên nhúng, hỏi: "cái này giúp tôi triển khai AI lên thiết bị thế nào?" Và ngược lại. Giá trị nằm ở chỗ nhúng và AI *gặp nhau*.

2. **Tài sản > số năm.** Không đầu tư vào thứ bắt đầu từ số 0 mà không cộng dồn với thứ bạn đã có. Đầu tư vào thứ *khuếch đại* combo hiếm.

3. **Học chip, không học toolchain (trừ khi toolchain là mục tiêu).** Câu hỏi mỗi lần phân vân IDE/CLI: "cái tôi đang cố học lúc này là con chip, hay cái công cụ?" Nếu học chip → chọn đường ít ma sát nhất để chạm chip nhanh. Cái sai duy nhất: tưởng đang học nhúng nhưng thật ra tiêu hết giờ để cài đặt.

4. **Tách lõi khỏi vỏ — nhưng hỏi trước: lĩnh vực này đã được thiết kế để tách chưa?**
   - Đã tách sẵn (database, ESP-IDF, web server, hạ tầng) → tung hết triết lý Docker/CLI/công-cụ-thống-nhất ra, nó sẽ thắng như DBeaver đã thắng.
   - Chưa tách / tách nửa vời (STM32 CubeMX, vài công cụ vendor) → tách *dần*, mượn vỏ ở giai đoạn học lõi, gỡ sau. Ép tách sạch ngay = rơi vào đúng hố "cài và lỗi".

5. **Giáo trình tự thiết kế mạnh ở cái nó dám CẮT, không phải cái nó gom vào.** Đừng để danh sách phình thành bản sao dài dòng của khóa bạn đang chê.

6. **Đừng cược nghề vào việc đoán trend nào thắng (agent hay edge).** Đứng ở chỗ trend nào thắng cũng dùng được: "người ghép được AI vào hệ thống thật, chạm được thiết bị."

---

## 2. Phân bổ đầu tư

| Mảng | Tỷ trọng | Ghi chú quan trọng |
|---|---|---|
| Nhúng (C/C++, Embedded Linux, STM32) | ~70% | Embedded Linux **ưu tiên** vì là bệ chạy AI. STM32 là nợ có kế hoạch trả, không xóa. |
| AI (Python, vision/edge) | ~30% | Giá trị KHÔNG ở gõ Python (cái đó rẻ, để AI phụ). Giá trị ở *phán đoán*: chọn bài toán, tối ưu model cho thiết bị nhỏ, deploy. |
| Docker / Git / Cloud | Song song (không tính %) | Là công cụ, học *qua dùng* + *dàn dựng case khó*. Cloud chỉ đủ deploy. |
| Giao thức công nghiệp (Modbus/MQTT) | Nhét vào phần nhúng | Xuất hiện trong MỌI JD IoT/nhúng. Chìa khóa cho Làn 1. Chỗ domain sản xuất phát huy. |

**Về "công nghiệp không dùng Python":** đúng ở tầng OT (PLC chạy ladder/C), nhưng SAI khi kết luận học Modbus/MQTT bằng Python là "mô phỏng dỏm". Trong kiến trúc IoT có 2 tầng: OT (dưới, sát máy, không Python) và IT/edge (trên, xử lý/AI/dashboard, rất nhiều Python). Modbus/MQTT là *cây cầu*. Python nói Modbus/MQTT rất tốt (`pymodbus`, `paho-mqtt`) — đó chính xác là công việc thật của tầng bạn nhắm tới.

---

## 3. Cách học C++ và Python (song song, nhưng có kỷ luật)

Học song song để có **cái nhìn so sánh** — hợp lý vì bạn đã có nền lập trình, không phải người mới toàn tập.

**Quy tắc vàng:** luôn so sánh trên **cùng một bài toán**. Viết cùng một chức năng bằng cả hai, rồi mổ xẻ khác biệt (quản lý bộ nhớ, tốc độ, kiểu dữ liệu, khi nào chọn cái nào). Học hai ngôn ngữ trên hai bài toán khác nhau = song song rời rạc (cái đáng lo). Cùng bài toán = so sánh sinh giá trị.

**Về "vibe code":** bạn viết code bằng AI, nhưng phần nền tảng (hiểu bài toán, phán đoán hệ thống, ghép nối, biết đúng/sai) là thật và AI không thay được. Cái mỏng là lớp bề mặt (tự tay gõ). Mục tiêu không phải bỏ AI khi code — mà đủ hiểu để: đọc code AI viết và biết đúng/sai, sửa được khi kẹt, giải thích được tại sao chọn cách này. Đó là ranh giới giữa "vibe coder" và "kỹ sư dùng AI".

*Phép thử sức mạnh nền:* lấy một phần nhỏ đã làm, tắt AI, tự làm lại. Hiểu từng bước, chỉ gõ chậm → bạn ở mức "hiểu nhưng chưa nhuyễn tay", lấp bằng luyện tập tính bằng tuần. Nhìn mà không hiểu tại sao chạy → đó là chỗ cần học, và giờ biết chính xác học gì.

---

## 4. Triết lý toolchain (Docker + VS Code + CLI)

Mục tiêu: tự dựng môi trường, nạp code qua CLI/VS Code, tránh IDE vendor nặng nề. Đây là cách dân embedded chuyên nghiệp hay làm, không kỳ cục.

- **ESP32-S3:** LÀM ĐƯỢC NGAY, sạch đẹp. ESP-IDF vốn chạy CLI (`idf.py build/flash/monitor`), VS Code chỉ gọi lại. Bỏ hẳn Arduino IDE. Toolchain trong Docker được. → Ở đây tung hết cái "gu DBeaver" ra.
- **STM32 (giai đoạn sau):** làm được nhưng khó hơn, đi **2 bước**:
  - *Bước 1 — học chip trước:* chấp nhận mượn **CubeMX** (chỉ để sinh cấu hình clock/chân/ngoại vi) + build/flash qua CLI (`arm-none-eabi-gcc`, OpenOCD/`st-flash`/`pyocd`) trong VS Code. Vẫn giữ ~80% cái "gu kiểm soát" mà không sa lầy OpenOCD.
  - *Bước 2 — sau khi hiểu chip:* nếu muốn, gỡ CubeMX, tự cấu hình bare-metal thuần CLI. Lúc này nó là bài học sâu về thanh ghi, không phải rào cản. Đây đúng là phần bare-metal mà ESP32 giấu đi.

**Mặt phẳng điều khiển thống nhất:** giống DBeaver là một cửa cho mọi DB, hãy nhắm "một quy trình cho mọi target" — Docker cho toolchain, VS Code làm mặt tiền, CLI làm xương sống, cho cả ESP32/Pi/STM32. Cái gu cá nhân này, làm có chủ đích, chính là kỹ năng "biết dựng môi trường/CI cho embedded" — hiếm và đáng tiền, thành một dòng mạnh trong CV.

---

## 5. CHẶNG 1 — Xây combo lõi (thiết bị hiện có: ESP32-S3 + Pi)

> **Bản chi tiết: [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md) — 7 khối, 56 bài, ~5 tháng.** Phần dưới đây chỉ là phác thảo gốc, giữ lại để nhớ ý định ban đầu.
>
> *Cách gọi tên: **CHẶNG** = giai đoạn lớn của sự nghiệp · **KHỐI** = nhóm bài trong một chặng · **BÀI** = đơn vị nhỏ nhất.*

Nguyên tắc: nhúng và AI bổ trợ nhau; C++/Python lệch pha (Python dẫn trước, C++ theo sau); Docker/Git học qua dùng ngay từ đầu.

### Khối nền (Python dẫn)
- Dựng môi trường **Docker + Git flow** từ ngày đầu (học qua dùng).
- Trên **Pi**: làm chủ Embedded Linux cơ bản — GPIO/I2C/SPI, chạy service, đọc cảm biến.
- Ngôn ngữ: **Python dẫn** (sân gần nhất, ra kết quả nhanh, giữ động lực).

### Khối cầu nối OT (Modbus/MQTT)
- Cho **ESP32-S3** đóng vai thiết bị "kiểu máy" — nói **Modbus/MQTT**.
- **Pi (Python)** đọc dữ liệu từ ESP32 qua giao thức đó.
- Đây là lúc thật sự xây cây cầu IT↔OT — không cần PLC. Phần đắt giá nhất cho Làn 1.

### Khối AI lên edge
- Chạy một model **vision** trên Pi (đọc camera) → xử lý → ra quyết định → gửi lệnh xuống ESP32 điều khiển thiết bị.
- Luận văn tái sinh dưới dạng "production-looking".
- Trọng tâm: *phán đoán* (chọn bài toán, tối ưu model — quantization, pruning cho thiết bị nhỏ), KHÔNG phải gõ Python.

### Khối C++ vào cuộc (C++ dẫn, theo sau)
- Lấy một phần đã làm bằng Python (đọc cảm biến, hoặc phần cần nhanh) và **viết lại bằng C++** trên ESP32-S3/Linux.
- Học C++ *có ngữ cảnh*: đã hiểu bài toán, giờ học ngôn ngữ để làm tốt/nhanh hơn.
- Chạm gần bare-metal → cầu tự nhiên để cuối khối này (hoặc đầu Chặng 2) **mua STM32** lấp lỗ hổng bare-metal.

### Đầu ra Chặng 1 (artifact quan trọng nhất)
**Một hệ thống hoàn chỉnh:** camera → Pi (AI) → Modbus/MQTT → ESP32 → thiết bị. Đóng gói Docker, lịch sử Git sạch, có log + số liệu (độ chính xác, độ trễ, FPS, điện năng). Chạy liên tục nhiều ngày, tự phục hồi khi mất điện/mạng, xử lý input xấu thật. Public GitHub + README tử tế + video demo.

> Một artifact chứng minh trọn combo hiếm. Đáng giá hơn mười chứng chỉ, và xóa đúng nghi ngờ "chỉ là lý thuyết".

---

## 6. Docker & Git — "học qua dùng" + "dàn dựng case khó"

Sự thật: dự án cá nhân **không tự đẻ ra** các case khó nhất của doanh nghiệp (chúng sinh từ nhiều người + hệ thống lớn). Nên phải **chủ động dàn dựng** case để tập.

### Docker — case dự án tự nhiên tặng bạn (tận dụng làm điểm nhấn)
- **Multi-arch build** (amd64 vs arm64) — vì Pi là ARM. Dân web hiếm gặp.
- **Multi-stage build** để ép nhỏ image nặng (OpenCV, TF Lite).
- **Truyền thiết bị vật lý vào container** (camera, GPIO, cổng serial cho Modbus) — rất sát nhúng.

### Docker — case phải dàn dựng
- **docker-compose nhiều service:** AI-service + MQTT broker + database + dashboard cùng chạy, network nội bộ.
- **Tối ưu thời gian build** (layer caching, thứ tự lệnh).
- **Secret/config theo môi trường** (dev vs prod, không hardcode).
- **Healthcheck + auto-restart** khi service chết.

### Git — case phải dàn dựng (solo dev sẽ không tự có)
- **Giả lập làm việc nhóm:** hai nhánh feature sửa cùng file → *cố tình tạo merge conflict* → giải.
- **Feature branch + Pull Request + self-review.**
- **Sửa lịch sử an toàn:** interactive rebase, squash, và **revert một commit đã đẩy** (khác reset) — tình huống "production lỗi, rollback ngay".
- **Tag + release** cho từng cột mốc.
- **Bonus sát nhất:** CI đơn giản trên **GitHub Actions** — mỗi push tự chạy test + build Docker image. Chỗ Git + Docker + CI/CD gặp nhau; trả luôn phần "cày CI/CD".

*Kỷ luật:* mỗi chặng dự án gắn 2–3 case, tích lũy dần. Đừng biến Docker/Git thành môn riêng nuốt mất thời gian của phần lõi. Case nâng cao nhất (compose phức tạp, CI hoàn chỉnh) để cuối.

---

## 7. CHẶNG 2 — Đừng đụng bây giờ, nhưng đã có bản đồ

> **Sửa ngày 2026-09-16.** Điều khoản cũ là *"chỉ mở khi có JD cụ thể đòi"*. Đã đổi: bạn quan sát rằng **JD ở VN rời rạc, mỗi nơi đòi một ít**, nên chờ JD là chờ một tín hiệu không bao giờ rõ. Quyết định: **phủ đầu có chọn lọc**.
>
> Nhưng chỉnh lại một nửa: *"JD rời rạc"* là lý do để **CHỌN LỌC**, không phải để phủ hết. Phủ hết chính là cái bẫy "học cho đủ bộ". Phủ đầu những thứ **lặp lại ở gần như mọi JD**, bỏ phần đuôi tản mát.
>
> **Bản đồ đầy đủ: [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md)** — 7 khối A–G, có thứ tự ưu tiên, lý do, chi phí. Nó là **bản đồ, chưa phải danh sách bài**: khi tới nơi chọn 2–3 khối, không làm hết. Cả gói ≈ 8–9 tháng.
>
> **Vẫn giữ nguyên tinh thần cũ:** mở file đó khi **sắp xong Chặng 1**, không phải trước đó. Bạn-lúc-đó — đã phỏng vấn vài chỗ, có thể đã nhận job freelance — chọn giỏi hơn bạn-lúc-này.

Thứ tự đề xuất: **C (gỡ lỗi phần cứng) → F (machine learning từ gốc) → A (STM32 bare-metal) → B (Embedded Linux thật) → E (cloud) → D (phía OT thật)**, cộng **G** là ba nhánh rẽ theo ngành.

- **STM32 (khối A):** lấp lỗ hổng bare-metal. Học tới mức *hiểu và điều khiển được thiết bị*, đừng đuổi độ sâu vô tận. **Khi mua, chọn board có FDCAN** (họ G4, ví dụ Nucleo-G474RE ~$20–25) — đừng mua F7 Discovery (đắt gấp 3–4 lần, chỉ có bxCAN cổ điển, chân bị LCD/SDRAM chiếm, M7 có cache gây thêm hố DMA).
- **C#:** xem mục dưới — điều khoản này đã đổi.
- **Cloud (khối E):** **E0 cloud nền tảng trước, E1 AWS IoT sau.** Lao thẳng vào AWS IoT khi chưa hiểu cloud vận hành thế nào thì thành gõ theo tutorial rồi quên sạch.
- **PLC (khối D):** **khoan mua.** Dùng ESP32 sẵn có + Modbus simulator để luyện cầu nối. Nếu học thì học **đọc hiểu ladder + một sản phẩm SCADA** — chọn **Ignition** (bản dùng thử đầy đủ chức năng) thay vì WinCC (license đắt). Chỉ để biết-đọc-hiểu — không để thành dân automation (lệch tạng + dính việc điện/hiện trường).

---

## 8. Đã LOẠI / KHÔNG làm

- **Java** — no-hope ở VN, đường Nhật cần tiếng Nhật + xa hướng nhúng. Bỏ hẳn.
- **Đổi PHP → C# để làm WEB** — tàn dư tư duy cũ "mình là web dev chọn framework". Đã bước ra khỏi nó rồi. **Điều khoản này vẫn đúng và vẫn giữ.**

> ### Sửa ngày 2026-09-16 — tách bạch hai loại C#
>
> Điều khoản trên từng bị hiểu là "loại C# nói chung". Sau khi **dò thị trường thật**, phải tách đôi:
>
> | | Quyết định |
> |---|---|
> | **C# để làm web / thành .NET web dev** | ❌ **Vẫn LOẠI.** Đúng là đổi ghế trong cùng vùng nổ |
> | **C# để viết ứng dụng điều khiển thiết bị có UI** | ✅ **NHẬN.** Vào Chặng 1, Khối 5 (bài 46–50) |
>
> **Bằng chứng thị trường (dò 2026-09-16):**
> - **Nhật:** JD 制御ソフト開発 cho **半導体製造装置** (thiết bị sản xuất bán dẫn) và **電子部品検査装置** (thiết bị kiểm tra linh kiện) ghi rõ **GUI + điều khiển robot/băng tải, dùng C++ và C#**. Mảng **検査装置 + C# + OpenCV** đang được công ty offshore Việt Nam nhận từ Nhật — gần như đúng hồ sơ đang xây.
> - **Việt Nam:** JD SCADA/HMI ghi thẳng *"ưu tiên có kinh nghiệm SCADA WinCC, intouch hoặc ATSCADA, **C#, asp.net**, database"*, lương 15–35tr.
>
> **Khung chặt:** C# nền tảng · WinForms/WPF · Blazor (đúng **một** màn hình giám sát) · OpenCvSharp. **Không** đi sâu ASP.NET như một hướng nghề, không Entity Framework, không kiến trúc doanh nghiệp.
>
> **Và không học Qt** — nó trùng chỗ với C# ở đúng hai thị trường này, giá gấp ba, và so sánh WPF/Qt chỉ ra kiến thức framework chứ không phải bản chất ngôn ngữ. **Điều kiện lật lại:** nếu rẽ sang HMI **y tế hoặc ô tô** — ở đó Qt trên Linux nhúng thống trị thật.
>
> **MFC/Win32 cũng không học** — đó là thị trường **bảo trì** phần mềm thiết bị cũ (nhiều ở Nhật), không phải thị trường mới. Chỉ cần đọc hiểu khi thấy trong JD.
- **CCNA / kéo dây mạng** — không đam mê + phần việc thể chất không kham nổi. Quyết định sai từ đầu.
- **All-in PLC/automation thuần** — lệch tạng phần mềm.
- **All-in cloud/big data** — rộng, đông, không dùng moat.
- **All-in AI research/edge thuần** — nhánh nhỏ ở VN (thị trường AI VN nghiêng về agent/LLM), quá rủi ro để đặt hết trứng. Giữ AI làm *lớp chuyên môn đắp lên nền*, không phải nghề chính đơn độc.

---

## 9. Song song với việc học — Chiến lược việc làm

*(Chạy song song ngay từ giờ, khi còn đang có lương — "đang có việc đi tìm việc" luôn ở thế mạnh.)*

- **Định vị CV:** tiêu đề là **"IoT Engineer / IoT Solutions"** hoặc **"Kỹ sư giải pháp Industry 4.0"**, KHÔNG để "PHP Developer". Recruiter search theo từ khóa đó và trả lương cao hơn.
- **Câu chuyện kể:** "làm hệ thống phần mềm sản xuất-kho + triển khai edge AI/ESP32 trên dây chuyền → tôi nối được phần thiết bị với phần phần mềm." Rất ít người kể được.
- **Làn nhắm (theo thứ tự hợp):**
  1. **Kỹ sư IoT** tại nhà máy / công ty giải pháp — hợp nhất (cần cả edge device lẫn phần mềm/dashboard, không đòi PCB).
  2. Nhúng thuần — hợp một nửa; đọc kỹ JD, né tin đòi Altium/PCB + bằng Điện-Điện tử.
  3. Dev/IT in-house cho nhà máy (backend, MES/WMS) — lưới an toàn, ăn thẳng kinh nghiệm thật.
- **Kiếm 1 job freelance/hợp đồng nhỏ có thật** (dù rẻ): thay thế "kinh nghiệm công ty" tốt nhất khi đang bị đóng băng. Giấy tờ/thuế KHÔNG liên quan đến việc nó "có tính" trên CV. Cái tính: (1) yêu cầu đến từ người khác, (2) sản phẩm được dùng thật, (3) có người xác nhận được. Dấu hiệu việc thật đọc được *trong lúc làm*: họ bắt sửa, họ lo mấy thứ vận hành (ổn định, bảo trì, bàn giao). Không kiểm soát được họ có deploy hay không — bỏ qua, đó ngoài tầm.
- **Reference > hợp đồng.** Sau mỗi việc: xin (1) lời nhận xét ngắn, (2) đồng ý cho ghi tên + để nhà tuyển dụng liên hệ, (3) ảnh/video/số liệu trước-sau. Nhà tuyển dụng tin người thật vouch, không tin con dấu.
- **Học qua khóa học có mentor:** nếu người dạy có *nhu cầu thật* (dự án của họ / khách của họ) và bạn làm ra thứ được dùng thật → vừa có mentor, vừa có reference, vừa vào được mạng lưới của họ. Hỏi thẳng: "anh có dự án thật nào cần làm không, em làm giúp?"
- **Apply & phỏng vấn NGAY**, đừng đợi layoff. Có 6-8 tháng runway = được quyền kén chọn và luyện phỏng vấn không áp lực.

---

## 10. Nhắc nhở cuối

- Cái làm bạn đáng tiền không phải 70% hay 30% riêng lẻ, mà là **chỗ chúng gặp nhau**.
- Đừng để sự trung thực ("chỉ là vibe code", "từ số 0") trượt thành tự phủ nhận. Bạn có thạc sĩ, có paper, có combo hiếm, và lo lắng một cách *có cấu trúc* — người thật sự ở số 0 không lo được như vậy.
- Học của khóa/giáo trình nào cũng được, nhưng **giữ la bàn riêng**: họ đào tạo kỹ sư nhúng thuần, còn bạn dùng nó làm nền để xây người-bắc-cầu-có-AI. Học của họ, lái về đích của mình.
