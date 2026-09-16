# CHẶNG 2 — Bản đồ định hướng

> **Ghi lại dự định, không phải cam kết.** Chặng 1 nằm ở [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md).
> Mở file này khi **sắp xong Chặng 1**, không phải trước đó.

---

## Vì sao đây là bản đồ chứ không phải danh sách bài

Bạn chốt: không chờ JD nữa, phủ đầu. Lý do bạn đưa ra — *"JD nó rời rạc, mỗi nơi một ít"* — là quan sát đúng.

Nhưng kết luận cần chỉnh một nửa: **"JD rời rạc" là lý do để CHỌN LỌC, không phải để phủ hết.** Nếu mỗi JD đòi một thứ khác nhau thì phủ hết là bất khả thi, và đuổi theo chúng chính là cách rơi vào "mớ học cho đủ bộ" mà la bàn cảnh báo.

Cái đúng là: phủ đầu những thứ **lặp lại ở gần như mọi JD**, bỏ phần đuôi tản mát.

**Và một cảnh báo thật:** sau 5 tháng của Chặng 1, bạn sẽ là người khác — đã đi phỏng vấn vài chỗ, có thể đã nhận một job freelance, và biết thị trường trả tiền cho cái gì rõ hơn bất kỳ lần dò nào hôm nay. **Bạn-lúc-đó chọn giỏi hơn bạn-lúc-này.** Khi tới nơi, chọn 2–3 khối, đừng làm hết.

Cả gói bảy khối ≈ **8–9 tháng**. Đó là con số thật, không phải hù.

---

## Bảy khối, xếp theo độ đòn bẩy

| Khối | Nội dung | Bịt lỗ hổng nào | Thời lượng |
|---|---|---|---|
| **C** | **Gỡ lỗi phần cứng**: logic analyzer (~500k–1tr), oscilloscope cơ bản, đọc schematic — **kèm mạch điện tối thiểu**, xem mục dưới | Uy tín phần cứng. **Rẻ nhất, hiệu quả/chi phí cao nhất** | ~2 + 1 tuần |
| **F** | **Machine learning từ gốc** (chi tiết bên dưới) | "Chỉ biết dùng model có sẵn" | ~11 tuần |
| **A** | **STM32 bare-metal**: thanh ghi, ngắt, DMA, timer, debug ST-Link, RTOS sâu — **đi sau kiến trúc máy tính + hợp ngữ**, xem mục dưới | Lỗ **"nhúng thuần"** — hiện bạn trượt JD đòi bare-metal | ~2 + 6 tuần |
| **B** | **Embedded Linux thật**: Yocto/Buildroot, device tree, u-boot, tự dựng image | Lỗ **"Embedded Linux Engineer"** — ranh giới giữa "biết dùng Pi" và "kỹ sư Linux nhúng" | ~5 tuần |
| **E** | **E0 Cloud nền tảng** → **E1 AWS IoT Core** | Xuất hiện dày trong JD IoT | ~2 + 3 tuần |
| **D** | **Phía OT thật**: PLC đọc hiểu (ladder cơ bản), một sản phẩm SCADA — **Ignition** (bản dùng thử đầy đủ chức năng, không tốn license như WinCC) | Uy tín với dân tự động hoá | ~4 tuần |
| **G** | **Ba nhánh rẽ theo ngành** (chi tiết bên dưới) | Tuỳ ngành | tuỳ |

## Nền tảng chuyển sớm từ Chặng 4 xuống — đọc trước khi lên lịch

Bản phác ban đầu để toán, kiến trúc máy tính, hợp ngữ, mạch điện ở **Chặng 4**. Sai vị trí: chúng không phải phần thưởng sau, mà là **điều kiện để làm tốt chính Chặng 2 này**. Lý do đầy đủ ở [CHANG-4-BAN-DO.md](CHANG-4-BAN-DO.md) mục 0.

Ba mảnh phải chèn vào Chặng 2:

| Chèn vào đâu | Nội dung (bản **vừa đủ**, không phải bản sâu) | Thời lượng |
|---|---|---|
| **Đầu khối C** | Định luật Ohm · phân áp · RC · trở kháng · mức logic và ngưỡng · nhiễu và nối đất · vì sao 3.3V và 5V không nối thẳng được | ~1 tuần |
| **Trước khối A** | Mô hình von Neumann · thanh ghi · phân cấp bộ nhớ và cache · **đọc hiểu ARM assembly do compiler sinh ra** (`-S`, `objdump`) | ~2 tuần |
| **Đầu khối F** | F1 đã có bản tối thiểu (vector/ma trận, đạo hàm, quy tắc chuỗi). **Đủ cho F, chưa đủ cho khối V ở Chặng 3** | trong F1 |

> **Hợp ngữ trước khối A làm khối A nhanh hơn, không chậm đi.** Bare-metal là viết vào thanh ghi; nếu chưa từng thấy CPU thật sự thực hiện lệnh thế nào thì thanh ghi vẫn là con số ma thuật. Đọc được assembly compiler sinh ra là lúc nó hết ma thuật.

Chặng 2 vì vậy dài thêm khoảng **3 tuần** so với ước lượng ban đầu.

## Thứ tự đề xuất: `C → F → A → B → E → D`

- **C đầu tiên** vì rẻ nhất mà đổi nhiều nhất — cầm được logic analyzer là đổi hẳn cách gỡ lỗi I2C/Modbus, và dùng ngược lại được cho Chặng 1.
- **F thứ hai** vì nó chữa đúng chỗ bạn thấy mù mờ nhất, **chỉ cần laptop** (làm được cả khi không có thiết bị trong tay), và nâng luôn giá trị của Khối 3 ở Chặng 1.
- *Ban đầu tôi xếp F cuối cùng vì nghĩ nó "ít cộng dồn". Bạn phản biện đúng: cái cần chữa không phải thiếu kiến thức AI, mà là **cảm giác mù mờ**.*

---

# Khối E — Cloud (tách đôi theo đề xuất của bạn)

Lao thẳng vào AWS IoT Core khi chưa biết cloud vận hành thế nào thì sẽ thành gõ theo tutorial rồi quên sạch — đúng cái bệnh mù mờ đang muốn chữa.

| | Nội dung | Thời lượng |
|---|---|---|
| **E0 — Cloud nền tảng** | Cloud thật ra là gì (máy của người khác, nhưng bán theo cách khác) · IaaS/PaaS/SaaS · bốn trụ: compute, storage, network, identity · **IAM và mô hình quyền** (chỗ gây tai nạn nhiều nhất) · một request đi từ trình duyệt tới server qua những chặng nào · **mô hình tính tiền** và cách không bị cháy ví · dựng tay một VM + một bucket + một hàng đợi, rồi xoá sạch | ~2 tuần |
| **E1 — AWS IoT Core** | Provisioning thiết bị, chứng chỉ X.509, device shadow, rules engine, OTA | ~3 tuần |

E0 **không** học riêng cho AWS — học khái niệm, vì Azure/GCP đổi tên nhưng cùng mô hình.

---

# Khối F — Machine learning từ gốc

*Thiết kế của bạn, tôi tinh chỉnh. Nguyên tắc xuyên suốt: **tự code bằng NumPy trước, rồi mới dùng thư viện, rồi giải thích chênh lệch.** Đây là cách duy nhất diệt được cảm giác mù mờ.*

| | Nội dung | Thời lượng |
|---|---|---|
| **F1** | **Nền:** vector/ma trận · đạo hàm và **quy tắc chuỗi** · **gradient descent tính tay trên giấy 3 vòng lặp** · MSE và cross-entropy, và **vì sao lại là hai hàm đó** chứ không phải hàm khác | ~1 tuần |
| **F2** | **Học có giám sát, tự code:** linear regression → logistic regression → **decision tree** (phải có trước random forest) → random forest → kNN. Mỗi cái: tự code → so với scikit-learn → **giải thích chênh lệch nếu có** | ~2.5 tuần |
| **F3** | **Đánh giá:** chia train/val/test đúng cách · **cross-validation** · confusion matrix, precision/recall/F1, ROC-AUC · overfitting/underfitting, bias-variance · regularization L1/L2 · **chuẩn hoá đặc trưng** và vì sao thiếu nó là model gãy | ~1 tuần |
| **F4** | **Không giám sát + tối ưu:** k-means (tự code, cả cách chọn k) · PCA · **genetic algorithm** | ~1.5 tuần |
| **F5** | **MLP:** tự code mạng 2 lớp bằng NumPy thuần · **lan truyền ngược tính tay trên giấy cho mạng 2-2-1** | ~2 tuần |
| **F6** | **CNN:** **tích chập một cửa sổ tính tay** · công thức kích thước đầu ra `(W − K + 2P)/S + 1` · **đếm tham số từng lớp** · trường tiếp nhận · pooling · ước lượng FLOPs | ~2 tuần |
| **F7** | **MobileNet:** **tự tính tỉ lệ giảm tham số và FLOPs của depthwise separable conv so với conv thường** | ~1 tuần |

**Ba ghi chú quan trọng:**

**F1 là nền của cả khối.** Gradient descent là động cơ nằm dưới linear regression, logistic regression **và** MLP. Tính tay nó một lần là gỡ mù mờ cho cả ba.

**F3 quan trọng ngang phần thuật toán.** Người biết train mà không biết đánh giá thì tự lừa mình mà không biết.

**Genetic algorithm đặt đúng chỗ:** nó **không cùng họ** với mấy thuật toán trên. Nó là phương pháp **tối ưu/tìm kiếm**, không phải bộ phân loại. Vẫn nên học, nhưng dùng để **dò siêu tham số** hoặc **chọn đặc trưng**. Hiểu sai chỗ này là một kiểu mù mờ khác.

**F5 là bài gỡ mù mờ mạnh nhất cả khối.** Làm được lan truyền ngược bằng tay thì deep learning hết huyền bí vĩnh viễn.

**F7 khép vòng về Chặng 1.** Tỉ lệ giảm tham số của depthwise separable conv chính là **lý do MobileNet tồn tại**. Sau bài này bạn giải thích được vì sao model chạy nổi trên Pi, và INT8 thật ra đang đổi cái gì.

---

# Khối G — Ba nhánh rẽ theo ngành

## G1 — CAN bus / CANopen

**Là gì:** bus nối tiếp Bosch làm ra năm 1986 cho xe hơi. Khác Modbus căn bản: Modbus có **chủ–tớ**, CAN thì **mọi node đều nói được**, và thông điệp không có địa chỉ người nhận — nó có **ID**, ai quan tâm thì nghe.

**Điều làm CAN đặc biệt:** khi hai node cùng phát, chúng **giành quyền theo từng bit mà không phá hỏng khung tin** — node có ID nhỏ hơn thắng, node kia tự lùi và phát lại. Nhờ vậy CAN **đoán trước được thời gian** ngay cả khi bus đông. Nó còn tự cô lập node hỏng (bus-off).

**Gặp ở đâu:** ô tô (thống trị) · máy nông nghiệp/công trình (J1939) · **CANopen** trong servo, điều khiển chuyển động, thiết bị y tế.

**Học ở đâu — STM32 làm node chính, ESP32 làm node phụ:**

```
   STM32 (bare-metal, tự tính bit timing)
        │
   ─────┴──────── CAN_H / CAN_L ────────┬─────
        │                               │
   transceiver                     transceiver
   SN65HVD230                      SN65HVD230
                                        │
                              ESP32-S3 (driver TWAI)
```

Vì sao chia thế:

1. **Bit timing** — lý do quan trọng nhất. ESP-IDF cho bạn chọn cấu hình dựng sẵn (`TWAI_TIMING_CONFIG_500KBITS()`), **giấu mất đúng thứ quan trọng nhất**. Trên STM32 bạn tự tính `prescaler`, `BS1`, `BS2`, `SJW` và tự đặt **điểm lấy mẫu**. 90% ca "bus không chạy" ngoài đời là do bit timing lệch hoặc sample point sai so với độ trễ lan truyền.
2. **CAN FD** — ESP32-S3 chỉ có CAN cổ điển. STM32 dòng mới có **FDCAN** (payload 64 byte, pha dữ liệu nhanh hơn). Ô tô đang chuyển sang FD.
3. **Cần ≥2 node** mới thấy giành quyền ưu tiên. Hai hãng khác nhau nói chuyện với nhau — tương thích là vấn đề thật của CAN.
4. Đúng kỷ luật `SO-SÁNH`: **driver mức cao (TWAI) vs thanh ghi mức thấp (bxCAN/FDCAN)**, cùng bus, cùng bài toán.

**Và đây là chỗ Khối C trả lãi:** cắm logic analyzer vào chân TX/RX, **nhìn thấy từng bit** lúc hai node giành nhau — node thua im lặng đúng lúc nào, khung tin của node thắng vẫn nguyên ra sao. Đọc mười trang lý thuyết không bằng nhìn một lần.

**Gắn G1 sau Khối A**, không đứng độc lập. Chi phí thêm: **2 transceiver ~60–100k**.

> ### Lưu ý mua sắm cho Khối A — quyết định từ bây giờ
>
> Chọn STM32 **có FDCAN**: họ **G4** (**Nucleo-G474RE**, ~$20–25, cộng đồng đã chạy thật tới 8 Mb/s) hoặc H7. Nucleo có **ST-LINK tích hợp**, không cần mua thêm mạch nạp, và đưa ra gần hết chân.
>
> **Đừng mua:** Blue Pill F103 / Black Pill F411 (chỉ bxCAN cổ điển, nhiều board không đưa chân CAN ra tử tế) · **F7 Discovery** (~$82 — đắt gấp 3–4 lần, chỉ có bxCAN, LCD/SDRAM chiếm gần hết chân, và Cortex-M7 có cache gây thêm hố mạch lạc DMA khi đang học bare-metal).
>
> F7/H7 Discovery vẫn đáng mua — nhưng là **board thứ hai**, khi bạn muốn làm HMI có màn hình ngay trên vi điều khiển hoặc chạy inference trên MCU.

## G2 — OPC UA sâu

Bài 28 ở Chặng 1 chỉ cho mức **dùng được**: dựng server, tạo node, đọc/ghi. "Sâu" là bốn thứ:

| | Nội dung |
|---|---|
| **Mô hình thông tin** | Linh hồn của OPC UA. Modbus chỉ có *một con số ở một địa chỉ*. OPC UA có **đối tượng**: một cái bơm có thuộc tính, có **phương thức** (Start/Stop), có quan hệ với thiết bị khác. Máy tự mô tả chính nó |
| **Companion specification** | Mô hình chuẩn hoá theo ngành — máy công cụ, robot, PackML, umati. Máy của hai hãng khác nhau phơi ra **cùng một cấu trúc**. Đây là lời hứa thật của Industry 4.0 |
| **Bảo mật** | Chứng chỉ X.509, security policy, danh sách tin cậy. Chỗ triển khai thật hay sa lầy nhất |
| **PubSub** | OPC UA chạy trên MQTT/UDP — ghép mô hình ngữ nghĩa của OPC UA với kiểu truyền của MQTT |

**Nếu chỉ được chọn một thứ trong G, chọn cái này.** CAN và an toàn chức năng đều bị khoá theo ngành, còn OPC UA **khuếch đại thẳng** vị trí "người bắc cầu IT↔OT" — không phụ thuộc bạn rơi vào nhà máy nào. ~3 tuần.

## G3 — An toàn chức năng (IEC 61508 / ISO 13849)

**Là gì:** bộ chuẩn cho hệ thống mà **hỏng là có người bị thương**. IEC 61508 là chuẩn gốc (mức SIL 1–4), ISO 13849 cho máy móc (mức PL a–e), ISO 26262 cho ô tô, IEC 62304 cho phần mềm y tế.

**Nó đổi cái gì:** không phải thêm kiến thức, mà **đổi cách bạn được phép viết phần mềm**. Đánh giá rủi ro trước → ra mức toàn vẹn cần đạt → rồi mới tới thiết kế: dư thừa, tự chẩn đoán, quy trình phát triển có hồ sơ, truy vết từ yêu cầu xuống tận test, MISRA C, **không được "code thông minh"**. Không `pip install` một thư viện lạ vào đường an toàn được.

Nó cũng giải thích vì sao code MFC đời cũ sống dai: **chi phí chứng nhận lại** đắt hơn chi phí bảo trì.

Học đầy đủ chỉ đáng khi vào y tế, ô tô, hoặc an toàn máy. ~3 tuần cho mức đọc-hiểu.

> ### Phần miễn phí của G3 — học ngay hôm nay, không tốn tuần nào
>
> Hệ thống AI của bạn **không bao giờ được nằm trong đường an toàn**. AI phân loại sản phẩm lỗi thì được. AI dừng máy để cứu tay người thì **không** — việc đó thuộc về relay an toàn hoặc PLC an toàn **đã được chứng nhận**.
>
> Nói đúng một câu đó trong phỏng vấn là tín hiệu trưởng thành rất mạnh.

---

## Những thứ vẫn nằm ngoài, kể cả Chặng 2

**MFC / Win32** — thị trường **bảo trì** phần mềm thiết bị cũ (nhiều ở Nhật), không phải thị trường mới. Chỉ cần đọc hiểu khi thấy trong JD.

**Qt** — ở ngành khác (panel Linux nhúng: ô tô, y tế). Không thay thế C#. Điều kiện lật lại: rẽ sang HMI y tế/ô tô.

**WinCC** — sản phẩm bản quyền đắt, vendor-lock. Chỉ mở khi có JD đòi đích danh. Nhưng nên **đọc được JD**: WinCC V7 dùng VBScript + ANSI-C · WinCC Comfort/Advanced dùng VBScript · **WinCC Unified dùng JavaScript** (thế hệ mới, nền HTML5) · WinCC OA dùng ngôn ngữ riêng **CTRL**.

**Profinet, EtherCAT** — cần phần cứng hãng và license.
