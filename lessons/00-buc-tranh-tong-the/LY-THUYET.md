# Lý thuyết — Bài 00: Bức tranh tổng thể

> Đọc hết file này trước khi gõ dòng code đầu tiên của cả lộ trình.
> Không cần nhớ hết. Cần **thấy được cái máy hoàn chỉnh** để 43 bài sau không còn là 43 mảnh rời.

---

## 1. Bạn đang xây cái gì

Một câu: **một hệ thống nhìn thấy vật thể bằng camera, tự quyết định, rồi ra lệnh cho thiết bị vật lý làm gì đó.**

Ví dụ cụ thể để bám vào suốt 4 tháng tới — cứ tưởng tượng một băng chuyền trong nhà máy:

> Sản phẩm chạy qua băng chuyền. Camera nhìn. Máy tính nhỏ (Raspberry Pi) chạy AI nhận ra sản phẩm này **thiếu nắp**. Nó gửi tín hiệu xuống một mạch điều khiển (ESP32). Mạch đó bật một cần gạt, đẩy sản phẩm lỗi ra khỏi băng chuyền. Đồng thời số liệu được ghi lại, và người quản lý xem được biểu đồ tỉ lệ lỗi theo giờ trên màn hình.

Mọi bài trong lộ trình đều là một mảnh của câu chuyện đó.

---

## 2. Hai tầng: IT và OT

Đây là khái niệm quan trọng nhất trong cả sự nghiệp bạn đang nhắm tới. Nắm nó rồi thì mọi thứ khác vào đúng chỗ.

Trong bất kỳ nhà máy nào cũng có hai thế giới, và chúng **nói hai ngôn ngữ khác nhau**:

### Tầng OT (Operational Technology) — thế giới của máy móc

Là tầng sát sàn nhà máy: động cơ, van, cảm biến, băng chuyền, PLC, biến tần.

Đặc tính của tầng này:

| | |
|---|---|
| **Quan tâm nhất** | Không được dừng. Một phút dừng dây chuyền = tiền thật. |
| **Thời gian** | Tính bằng mili-giây, và phải **đoán trước được**. Chậm đều còn hơn nhanh thất thường. |
| **Ngôn ngữ** | Ladder logic, C, giao thức Modbus/Profibus/CAN |
| **Vòng đời** | Thiết bị chạy 15–20 năm. Không ai "nâng cấp lên bản mới" giữa ca sản xuất. |
| **Sợ nhất** | Thay đổi |

### Tầng IT (Information Technology) — thế giới của phần mềm

Là tầng trên: server, database, dashboard, báo cáo, AI, cloud.

| | |
|---|---|
| **Quan tâm nhất** | Tính năng, dữ liệu, tốc độ phát triển |
| **Thời gian** | Tính bằng giây, và chậm một chút cũng không ai chết |
| **Ngôn ngữ** | Python, Java, JavaScript, SQL, HTTP/JSON |
| **Vòng đời** | Deploy mỗi tuần, có khi mỗi ngày |
| **Sợ nhất** | Đứng yên |

### Và giữa hai tầng là một cái hố

Hai thế giới này lịch sử không nói chuyện với nhau. Dân IT không biết Modbus là gì. Dân OT không biết Docker là gì. Nhà máy nào cũng cần dữ liệu từ tầng dưới đưa lên tầng trên để phân tích — nhưng rất ít người bắc được cầu.

**Đó chính xác là chỗ bạn đứng.** Không phải giỏi nhất tầng IT, cũng không phải giỏi nhất tầng OT. Mà là người **nói được cả hai thứ tiếng**.

```
        ┌──────────────────────────────────────────┐
        │   TẦNG IT — phần mềm, AI, dashboard      │
        │   Python, database, Docker, cloud        │
        └──────────────────────────────────────────┘
                          ▲
                          │   ←──  BẠN ĐỨNG Ở ĐÂY
                          │        (cây cầu: Modbus, MQTT)
                          ▼
        ┌──────────────────────────────────────────┐
        │   TẦNG OT — máy móc, cảm biến, PLC       │
        │   C, ladder logic, tín hiệu điện         │
        └──────────────────────────────────────────┘
```

Cây cầu đó tên là **Modbus** và **MQTT**. Bạn sẽ học cả hai ở Chặng 2. Đó là phần đắt giá nhất của lộ trình.

---

## 3. Sơ đồ hệ thống bạn sẽ xây

```
   ┌──────────┐
   │ Camera   │  (điện thoại qua RTSP, hoặc USB cam)
   └────┬─────┘
        │ hình ảnh
        ▼
   ┌─────────────────────────────────────────────┐
   │  RASPBERRY PI  — "bộ não biên"              │   ← TẦNG IT thu nhỏ
   │                                             │
   │   ┌─────────────┐   ┌──────────────┐        │
   │   │ AI service  │──▶│  Gateway     │        │
   │   │ (nhận dạng) │   │  (điều phối) │        │
   │   └─────────────┘   └──┬────────┬──┘        │
   │                        │        │           │
   │   ┌─────────────┐   ┌──▼────┐ ┌─▼────────┐  │
   │   │  Grafana    │◀──│ Data  │ │  MQTT    │  │
   │   │ (dashboard) │   │ base  │ │  broker  │  │
   │   └─────────────┘   └───────┘ └─┬────────┘  │
   └─────────────────────────────────┼───────────┘
                                     │
              MQTT / Modbus  ←── CÂY CẦU IT↔OT
                                     │
   ┌─────────────────────────────────▼───────────┐
   │  ESP32-S3  — "thiết bị kiểu máy"            │   ← TẦNG OT thu nhỏ
   │                                             │
   │   đọc cảm biến  ·  bật/tắt relay             │
   └────┬────────────────────────────┬───────────┘
        │                            │
   ┌────▼─────┐               ┌──────▼──────┐
   │ Cảm biến │               │ Relay / đèn │
   │ nhiệt/ẩm │               │ / cần gạt   │
   └──────────┘               └─────────────┘
```

**Toàn bộ phần trong khung Raspberry Pi chạy bằng Docker.** Mỗi khối là một container.

---

## 4. Từng nhân vật làm gì

| Nhân vật | Vai | Học ở chặng |
|---|---|---|
| **Camera** | Mắt của hệ thống | 3 |
| **Raspberry Pi** | Máy tính Linux nhỏ. Chạy AI, chứa database, chạy dashboard. Là "edge" — tính toán ngay tại chỗ thay vì gửi lên cloud | 1 |
| **AI service** | Nhìn ảnh, trả lời "cái này đạt hay lỗi" | 3 |
| **Gateway** | Người phiên dịch. Nói chuyện với ESP32 bằng Modbus/MQTT, nói chuyện với database bằng SQL | 2 |
| **MQTT broker** | Bưu điện. Thiết bị gửi tin vào đây, ai cần thì đăng ký nhận | 2 |
| **Database** | Trí nhớ. Lưu mọi số đo theo thời gian | 2 |
| **Grafana** | Bộ mặt. Biến số thành biểu đồ cho người xem | 2 |
| **ESP32-S3** | Vi điều khiển. Đóng vai "thiết bị công nghiệp" — đọc cảm biến, nhận lệnh, đóng/ngắt relay | 2 |

### Vì sao "edge" chứ không phải cloud?

Ba lý do, và cả ba đều là lý do thật ngoài đời:

1. **Độ trễ.** Gửi ảnh lên cloud rồi chờ trả lời mất 200–500ms. Băng chuyền đã chạy qua mất rồi.
2. **Mạng.** Nhà máy mất mạng là chuyện thường. Dây chuyền không được dừng vì Internet.
3. **Tiền và dữ liệu.** Đẩy video 24/7 lên cloud rất tốn, và nhiều nhà máy không cho hình ảnh dây chuyền ra ngoài.

---

## 5. Dữ liệu chảy theo hai chiều

Đây là chỗ nhiều người hiểu sót — họ chỉ nghĩ tới chiều đi lên.

**Chiều lên — đo đạc (monitoring):**
```
cảm biến → ESP32 → MQTT → Gateway → Database → Dashboard → mắt người
```
Trả lời câu: *"máy đang thế nào?"*

**Chiều xuống — điều khiển (control):**
```
AI quyết định → Gateway → Modbus/MQTT → ESP32 → relay → cần gạt động đậy
```
Trả lời câu: *"làm cái này đi."*

Chiều xuống **khó hơn nhiều** và đó là chỗ phân biệt người làm thật với người làm demo. Vì khi bạn ra lệnh cho thứ vật lý:

- Lệnh có tới không? Nếu mạng rớt giữa chừng thì sao?
- Gửi hai lần thì cần gạt gạt hai lần — có sao không?
- AI đoán sai thì vứt nhầm hàng tốt. Cái giá là bao nhiêu?
- Nếu Pi chết giữa lúc cần gạt đang mở thì nó nằm mở mãi à?

Những câu hỏi này là nội dung của Bài 35 và Bài 40. Nhớ rằng chúng tồn tại.

---

## 6. Vì sao cần Docker

Vấn đề rất thật: AI service của bạn cần OpenCV, ONNX Runtime, numpy — mỗi thứ một phiên bản. Gateway cần pymodbus. Database cần Postgres. Nếu cài tất cả thẳng lên Pi:

- Cài lộn xộn, phiên bản đụng nhau, gỡ ra không sạch.
- Máy bạn chạy được, Pi không chạy được (khác kiến trúc CPU!).
- Pi hỏng thẻ nhớ → cài lại từ đầu mất cả ngày, và **không ai nhớ đã cài những gì**.

Docker đóng gói mỗi phần mềm cùng **toàn bộ môi trường nó cần** thành một khối chạy được ở đâu cũng giống nhau. Cài lại Pi trở thành: cắm thẻ mới, chạy một lệnh.

Đó là lý do Docker nằm ngay đầu lộ trình chứ không phải cuối. Bạn dùng nó **mỗi ngày** trong 4 tháng tới.

## 7. Vì sao cần Git

Không phải để "lưu code". Ba lý do thật:

1. **Dám thử.** Biết mình luôn quay lại được thì mới dám sửa mạnh tay. Không có Git, bạn sẽ rón rén, và rón rén thì học chậm.
2. **Trả lời câu "hôm qua nó chạy mà?"** — `git diff` nói chính xác cái gì đã đổi.
3. **Là hồ sơ nghề nghiệp.** Nhà tuyển dụng đọc lịch sử commit của bạn. Nó cho thấy cách bạn nghĩ, trong 4 tháng, không nói dối được.

## 8. Vì sao cần cả Python lẫn C++

Không phải để "biết nhiều ngôn ngữ". Mà vì chúng ở **hai tầng khác nhau**:

| | Python | C++ |
|---|---|---|
| Ở đâu | Tầng IT — trên Pi | Tầng OT — trên ESP32, và phần nóng trên Pi |
| Mạnh | Viết nhanh, thư viện AI đầy đủ | Nhanh, ít RAM, chạy được trên chip bé tí |
| Ai dọn bộ nhớ | Ngôn ngữ tự dọn | **Bạn** |
| Khi nào chọn | Khi thời gian của bạn đắt hơn thời gian máy | Khi tài nguyên eo hẹp hoặc phải đúng nhịp |

ESP32-S3 có khoảng **512KB RAM**. Máy bạn có 16GB — gấp hơn 30.000 lần. Python không sống nổi ở đó. Đó là lý do C++ có mặt, không phải vì nó "xịn hơn".

---

## 9. Mỗi chặng lắp thêm mảnh nào

| Chặng | Lắp thêm | Cuối chặng bạn có |
|---|---|---|
| **0** (00–09) | Docker, Git, hai ngôn ngữ | Bộ đồ nghề. Chưa có hệ thống, nhưng có tay nghề dùng công cụ |
| **1** (10–17) | Raspberry Pi + cảm biến | Pi đọc được cảm biến thật, chạy như một dịch vụ tự phục hồi |
| **2** (18–27) | ESP32 + Modbus/MQTT + DB + dashboard | **Cây cầu IT↔OT hoàn chỉnh.** Riêng phần này đã đủ kể thành câu chuyện phỏng vấn |
| **3** (28–35) | Camera + AI + vòng điều khiển khép kín | Hệ thống nhìn thấy, quyết định, và ra lệnh |
| **4** (36–43) | C++ tối ưu, chịu lỗi, CI, đo lường | Từ "demo chạy được" thành "dám cắm vào dây chuyền" |

---

## 10. Từ vựng tối thiểu

Bạn sẽ gặp các từ này liên tục. Chưa cần hiểu sâu, cần **không hoảng khi thấy**.

| Từ | Nghĩa gọn |
|---|---|
| **Edge** | Tính toán ngay tại chỗ, gần thiết bị, thay vì gửi lên cloud |
| **Firmware** | Phần mềm nạp thẳng vào vi điều khiển (ESP32). Không có hệ điều hành đầy đủ |
| **Flash** | Động từ: nạp firmware vào chip |
| **GPIO** | General Purpose Input/Output — chân cắm điện của board, bật/tắt hoặc đọc mức điện |
| **I2C / SPI** | Hai giao thức để chip nói chuyện với cảm biến qua vài sợi dây |
| **UART / Serial** | Truyền dữ liệu nối tiếp qua dây. Nền của Modbus RTU |
| **RS485** | Chuẩn điện cho serial đi xa (hàng trăm mét) trong môi trường nhiễu. Rất phổ biến trong nhà máy |
| **Modbus** | Giao thức công nghiệp cổ (1979) nhưng vẫn thống trị. Đơn giản đến mức thô sơ, và đó là lý do nó sống dai |
| **MQTT** | Giao thức nhắn tin nhẹ kiểu đăng-tin/nhận-tin. Sinh ra cho IoT |
| **Broker** | Máy chủ trung gian của MQTT — nhận tin và phát lại cho ai đăng ký |
| **PLC** | Máy tính công nghiệp chuyên điều khiển máy móc. Bạn **không** cần mua; ESP32 đóng thế được |
| **SCADA** | Phần mềm giám sát điều khiển toàn nhà máy. Tầng trên của PLC |
| **RTOS** | Hệ điều hành thời gian thực. FreeRTOS chạy trên ESP32 |
| **Inference** | Chạy model AI để ra kết quả (khác với training — huấn luyện) |
| **Quantization** | Ép model AI từ số thực xuống số nguyên để chạy nhanh trên máy yếu |
| **Latency** | Độ trễ — từ lúc có việc đến lúc có phản hồi |
| **Throughput / FPS** | Bao nhiêu việc xử lý được mỗi giây |

---

## Việc phải làm để đóng bài 00

Lấy **tờ giấy trắng và bút**. Không dùng máy tính.

1. Vẽ lại sơ đồ hệ thống ở mục 3 **theo trí nhớ**. Vẽ xấu không sao.
2. Vẽ mũi tên hai chiều: chiều dữ liệu đi lên, chiều lệnh đi xuống.
3. Khoanh tròn những chỗ bạn **đã biết** (từ kinh nghiệm web/PHP/sản xuất của bạn).
4. Gạch chéo những chỗ bạn **hoàn toàn mù**.
5. Chụp ảnh, bỏ vào thư mục bài 00, ghi chú vào `NHAT-KY.md`.

Bức ảnh này quan trọng hơn bạn nghĩ. Cuối Giai đoạn 1 bạn vẽ lại lần nữa và so hai bức — đó là thước đo tiến bộ trung thực nhất bạn có, vì nó đo **cái bạn nắm được**, không đo số bài đã xong.
