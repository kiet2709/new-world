# CHẶNG 3 — Bản đồ định hướng: chuyên gia và đường nghiên cứu

> **Ghi lại dự định, không phải cam kết.**
> Chặng 1: [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md) · Chặng 2: [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md)
> Mở file này khi **sắp xong Chặng 2**, không phải trước đó.
>
> *Viết ngày 2026-09-16. Mọi thông tin về phương pháp và nguồn học ở đây sẽ cũ đi — khi tới nơi, dò lại trước khi tin.*

---

## 0. Mục tiêu kép

Chặng 1 và 2 xây **năng lực**. Chặng 3 xây **chỗ đứng**, và nó nhắm hai đích cùng lúc:

| Đích | Nghĩa là gì |
|---|---|
| **Chuyên gia trong công ty** | Người được gọi khi bài toán khó — không phải người làm được nhiều thứ, mà người giải được thứ ít ai giải |
| **Đường nghiên cứu / PhD** | Có câu hỏi mở của riêng mình, có công bố, có khả năng tạo ra cái chưa tồn tại |

Hai đích này **không xung đột** nếu chọn đúng chỗ: một PhD công nghiệp (part-time, hoặc do công ty tài trợ) ở đúng giao điểm bạn đang xây là con đường ít người đi mà rất hợp với hồ sơ của bạn.

**Lợi thế hiếm bạn sẽ có mà phần lớn nghiên cứu sinh không có:** truy cập vào **bài toán nhà máy thật, dữ liệu thật, ràng buộc thật**. Đa số PhD sinh viên làm trên dataset tải về. Bạn có dây chuyền, có thiết bị, có người vận hành để hỏi. Đó là **tài sản để chọn giáo sư**, không phải thứ đi xin.

---

## 1. Vì sao ba mục này chọn đúng

Chúng **xếp chồng** lên cái đã có, không bắt đầu từ số 0:

```
Chặng 1   ESP32-S3 · Pi · OpenCV · lượng tử hoá mức gọi thư viện (bài 38)
          Modbus/MQTT/OPC UA · Docker · CI
                        ↓
Chặng 2   CNN tính tay · MobileNet, tự tính depthwise separable (F6–F7)
          STM32 bare-metal · Yocto · logic analyzer
                        ↓
Chặng 3   T: MCUNet, pruning, NAS, on-device training — hiểu tận gốc
          V: 3D — từ epipolar geometry tới MASt3R
          P: PLC/HMI + băng chuyền thật — giàn thử nghiệm vật lý
          R: kỷ luật nghiên cứu — đọc, tái lập, viết, công bố
```

Không có mục nào trong Chặng 3 là "học lại từ đầu". Tất cả đều là **đào sâu chỗ đã chạm**.

---

## 2. Bốn khối và thứ tự đề nghị

**Thứ tự: `P → T → V`, với `R` chạy song song xuyên suốt.**

| Khối | Nội dung | Thời lượng | Vì sao ở vị trí này |
|---|---|---|---|
| **P** | PLC/HMI + băng chuyền thật | ~6–8 tuần | **Nhỏ nhất, đổi nhiều nhất.** Tạo ra giàn thử nghiệm vật lý cho T và V cắm vào |
| **T** | TinyML và Efficient AI | ~5–6 tháng | Xếp chồng thẳng lên khối F của Chặng 2 |
| **V** | 3D vision và multi-view geometry | ~6–8 tháng | Nặng nhất, học thuật nhất, hưởng lợi từ giàn của P |
| **R** | Kỷ luật nghiên cứu | xuyên suốt | Không phải một khối riêng — là cách bạn làm ba khối kia |

Tổng ≈ **12–16 tháng**.

> **Bạn xếp P cuối cùng và ghi "phần nhỏ thôi". Tôi đề nghị đưa nó lên đầu.** Lý do: nó biến toàn bộ Chặng 1+2 thành demo trông như production ngay lập tức, và nó tạo ra **chỗ để kiểm chứng thật** cho T và V. Học TinyML mà chạy trên dataset tải về thì khác hẳn học TinyML mà model phải điều khiển một cái cần gạt thật trên băng chuyền đang chạy.

---

# KHỐI P — PLC, HMI, và một băng chuyền thật

*Mục tiêu: hệ thống thôi là "demo trên bàn", trở thành thứ trông như ở xưởng.*

## Ranh giới — giữ cho chặt

| Làm | Không làm |
|---|---|
| Đọc hiểu ladder, viết được logic đơn giản | Trở thành kỹ sư lập trình PLC |
| Nối PLC với hệ của mình qua Modbus/OPC UA | Nhận việc tủ điện, đi dây, hiện trường |
| Thiết kế màn hình HMI cơ bản | Đuổi theo độ sâu vô tận của một hãng |

Đây là điều chỉnh có chủ ý so với la bàn (*"khoan mua PLC"*). Lý do đổi: bạn không muốn thành dân automation — bạn muốn **hệ thống của mình thật hơn**. Khác nhau, và cái sau thì đáng.

## Chọn hãng — quyết định thật, chỉ chọn MỘT

| | Hợp khi | Điểm cộng |
|---|---|---|
| **Siemens S7-1200 + KTP HMI** (TIA Portal) | Nhắm nhà máy đa quốc gia, hướng SCADA/MES | Nối thẳng vào **WinCC** — chính cái tên trong JD Việt Nam đã dò ở Chặng 1 |
| **Mitsubishi FX5U + GOT2000** | Nhắm nhà máy vốn Nhật ở VN, đường 検査装置 của Nhật | Thống trị ở nhà máy Nhật |

**Nếu phải chọn một: Siemens** — vì nối được với WinCC, và tài liệu tiếng Anh dày hơn. Đồ cũ ở VN rẻ hơn đáng kể so với hàng mới; kiểm giá trước khi mua.

## Nội dung

- Ladder logic cơ bản: contact, coil, timer, counter, latch
- Cấu trúc một chương trình PLC: scan cycle, và **vì sao nó khác vòng lặp phần mềm thường**
- An toàn: nút dừng khẩn, **và vì sao nó KHÔNG đi qua PLC thường** (xem khối G3 của Chặng 2)
- Thiết kế màn hình HMI: trạng thái, cảnh báo, thao tác tay
- **Nối PLC ↔ hệ của bạn** qua Modbus TCP hoặc OPC UA — đây là chỗ Chặng 1 trả lãi
- Băng chuyền thật: động cơ, biến tần hoặc driver, cảm biến tiệm cận, cần gạt/xi lanh

## Đầu ra

Một **giàn thử nghiệm vật lý**: băng chuyền chạy, PLC điều khiển, HMI hiển thị, và hệ thống vision của bạn nói chuyện được với nó. Đây là nền cho mọi thứ còn lại của Chặng 3 — và là thứ quay video demo trông thuyết phục hơn mọi biểu đồ.

---

# KHỐI T — TinyML và Efficient AI

*Chặng 1 bạn **gọi** thư viện lượng tử hoá. Ở đây bạn hiểu vì sao nó hoạt động, và tự ép được model vào 512KB SRAM. **Đây mới là edge AI thật.***

## Nguồn chính

**MIT 6.5940 — TinyML and Efficient Deep Learning Computing**, Song Han (MIT HAN Lab, kiêm distinguished scientist tại NVIDIA). Bài giảng và bài tập **công khai miễn phí**: `efficientml.ai` · `hanlab.mit.edu/courses`.

Đây là khoá chuẩn của mảng này. Không cần tìm nguồn khác trước khi làm hết nó.

## Nội dung khoá

| Nhóm | Chủ đề |
|---|---|
| Nén model | Pruning (có cấu trúc / không cấu trúc) · quantization (PTQ, **QAT**) · knowledge distillation |
| Thiết kế kiến trúc | **Neural Architecture Search** · thiết kế nhận biết phần cứng |
| Hệ thống | Engine suy luận · tối ưu toán tử · lập lịch bộ nhớ |
| Huấn luyện | Song song phân tán · nén gradient · **huấn luyện trên thiết bị** |
| Mở rộng | Hiệu quả cho LLM và diffusion |

## MCUNet — đích cụ thể

**MCUNet** là đồng thiết kế **TinyNAS** (tìm kiến trúc phù hợp ràng buộc bộ nhớ) + **TinyEngine** (engine suy luận nhẹ). Kết quả: **70.7% ImageNet top-1 trên một vi điều khiển thương mại**.

Con số đó đáng nhớ vì nó bác bỏ giả định "AI cần GPU". Và nó chạy được trên đúng loại chip bạn đã có.

## Phần cứng bạn đã có, dùng lại hết

| Thiết bị | Vai trò trong khối T |
|---|---|
| **ESP32-S3** | Đích chính. Có lệnh vector hỗ trợ AI, ~512KB SRAM + PSRAM — đúng hạng MCUNet nhắm |
| **STM32 (Chặng 2)** | So sánh: cùng model, hai kiến trúc MCU khác nhau |
| **Raspberry Pi** | Mốc so sánh "edge lớn" |
| **Băng chuyền (khối P)** | Chỗ kiểm chứng: model nén có còn đủ tốt để điều khiển thật không |

## Kỷ luật đo — giữ nguyên từ Chặng 1

Mọi kết luận phải có số: **accuracy · latency p50/p95 · kích thước model · RAM đỉnh · năng lượng mỗi lần suy luận**. Cột cuối là cột ít người đo nhất và là cột quan trọng nhất với thiết bị chạy pin.

## Ghi chú: mục 4 không bị gác hoàn toàn

Khoá 6.5940 **có phần hiệu quả cho LLM** (quantization, serving, tối ưu suy luận). Nên quyết định gác LLM/agent của bạn vẫn giữ — nhưng bạn chạm mảng đó ở **đúng góc có ích cho mình**: làm model chạy nhanh trên máy yếu, chứ không phải đu theo framework agent đổi mỗi quý.

---

# KHỐI V — 3D vision và multi-view geometry

*Mảng nặng nhất, học thuật nhất, và là chỗ đường PhD rõ nhất.*

## Điều kiện tiên quyết — đừng vào khối này thiếu nó

Multi-view geometry **không phải** một mảng thị giác máy có thêm toán. Nó **chính là toán**: hình học xạ ảnh và bình phương tối thiểu, mặc áo thị giác.

Phải có trước khi vào:

| Cần | Dùng vào đâu trong khối V |
|---|---|
| **SVD** | Giải hệ thuần nhất: ma trận cơ bản, ma trận thiết yếu, DLT cho homography |
| **Bình phương tối thiểu** (tuyến tính và phi tuyến) | Bundle adjustment — trái tim của SfM |
| **Phân rã trị riêng** | PCA trên point cloud, phân tích tư thế |
| **Hình học xạ ảnh** | Toạ độ thuần nhất, điểm ở vô cực, vì sao camera là phép chiếu xạ ảnh |
| **Nhóm Lie SO(3)/SE(3)** | Biểu diễn phép quay **đúng cách** — vì sao không tối ưu trực tiếp trên góc Euler |
| **RANSAC** hiểu tận gốc | Mọi thứ trong khối này đều có ngoại lai |

Bản tối thiểu ở F1 của Chặng 2 (vector, ma trận, đạo hàm) **không đủ cho khối này**. Dành khoảng **3–4 tuần toán** ngay trước khối V. Chi tiết ở [CHANG-4-BAN-DO.md](CHANG-4-BAN-DO.md) mục 0.

> **Bỏ qua phần này thì hậu quả cụ thể:** bạn gọi `cv2.findEssentialMat()`, nó chạy, ra kết quả trông hợp lý — và bạn không giải thích nổi nó làm gì, không biết khi nào nó sai, không debug được khi nó sai. **Đó là vibe code ở tầng cao hơn**, khó phát hiện hơn vì bạn tưởng mình đã qua giai đoạn đó rồi.

## Bản đồ đã đổi — SuperPoint/SuperGlue không còn đầu bảng

| Thế hệ | Phương pháp | Ghi chú |
|---|---|---|
| **Cổ điển** | SIFT/ORB · epipolar geometry · stereo · PnP · bundle adjustment · COLMAP | **Vẫn phải học.** Là nền toán, và công nghiệp vẫn chạy nó |
| **Sparse học sâu** | SuperPoint (2018) + SuperGlue (2020) → **LightGlue** (ICCV 2023) | LightGlue chính xác gần bằng LoFTR mà **nhanh gấp 8 lần**. Đây là cái thay thế SuperGlue |
| **Detector-free dense** | **LoFTR** | Vẫn dẫn đầu vài benchmark, chênh chỉ ~2% AUC@5° |
| **Mô hình mới** | **DUSt3R** → **MASt3R** (ECCV 2024) | Transformer **suy ra thẳng hình học dày đặc và tham số camera từ một cặp ảnh** — không matching tường minh, không cần hiệu chuẩn |

Dòng cuối là **đổi mô hình, không phải cải tiến**. Lối nghĩ "detect → match → tam giác hoá" đang bị thay bằng "đưa ảnh vào, ra hình học". Học cả hai: cổ điển để hiểu *vì sao*, thế hệ mới vì đó là chỗ ngành đang đi.

## Khoảng trống phải lấp: cảm biến chủ động

Multi-view từ ảnh RGB là **nhánh học thuật**. **3D công nghiệp thật** phần lớn dùng cảm biến chủ động:

- **Ánh sáng cấu trúc** (structured light)
- **ToF** (time of flight)
- **Tam giác hoá bằng laser line** — rẻ, tự dựng được, dạy được rất nhiều

Nếu nhắm nhà máy thì cần ít nhất một cảm biến chiều sâu thật: RealSense D435, Orbbec, hoặc tự dựng laser line + camera.

## 3D trong nhà máy nghĩa là gì

Đây là chỗ khối V gặp khối P:

| Ứng dụng | Mô tả |
|---|---|
| **Bin picking** | Gắp vật xếp lộn xộn trong thùng — bài toán kinh điển, chưa giải xong |
| **Dẫn đường robot** | Cánh tay biết vật ở đâu trong không gian |
| **Đo kích thước** | Kiểm tra dung sai không tiếp xúc |
| **Xếp/dỡ pallet** | Tự động hoá kho |
| **Kiểm tra khuyết tật bề mặt** | Vết lõm, cong vênh — thứ ảnh 2D không thấy |

---

# KHỐI R — Kỷ luật nghiên cứu

*Không phải một khối riêng. Là **cách** bạn làm ba khối kia, nếu đích có PhD.*

Đây là phần khác biệt lớn nhất giữa "học giỏi" và "làm được nghiên cứu".

## Bốn kỹ năng phải luyện

**1. Đọc paper có hệ thống.** Không đọc tuần tự. Đọc theo ba lượt: tiêu đề–tóm tắt–hình (5 phút, quyết định có đọc tiếp không) → phần phương pháp và kết quả (30 phút) → chi tiết và phụ lục (chỉ khi cần tái lập). Mỗi tuần **2–3 paper**, ghi lại: *nó giải bài toán gì, bằng ý tưởng gì, kết quả đo thế nào, chỗ nào tôi không tin*.

**2. Tái lập — kỹ năng cửa ải.** Chọn một paper, **tự chạy lại ra được số của nó**. Đây là thứ phân biệt người đọc paper với người làm nghiên cứu, và là thứ hội đồng tuyển PhD nhìn vào. Phần lớn người học AI chưa từng tái lập trọn vẹn một paper nào.

> Tái lập cũng dạy bạn một sự thật khó chịu và cực kỳ có giá: **rất nhiều paper không tái lập được**. Phát hiện được điều đó và chỉ ra được vì sao — đó đã là đóng góp.

**3. Viết.** Theo thang: ghi chú kỹ thuật → bài blog → báo cáo kỹ thuật (arXiv) → workshop paper → hội nghị. Mỗi bậc là một lần tập viết cho người lạ đọc. **Viết sớm, đừng đợi có kết quả lớn.**

**4. Chọn câu hỏi.** Đây là kỹ năng khó nhất, và nó không học được từ khoá học nào — chỉ từ việc sống trong một bài toán đủ lâu.

## Câu hỏi nghiên cứu ở đúng giao điểm của bạn

Giao điểm T × V × P gợi ra một hướng **đang sống và còn nhiều chỗ trống**:

> **Nhận thức 3D hiệu quả trên thiết bị biên cho kiểm tra công nghiệp.**

Dò thị trường nghiên cứu (2026) cho thấy mảng này đang chạy:

- Sinh **point cloud giả từ ảnh RGB đơn** (ước lượng chiều sâu đơn mắt + mạng point cloud nhẹ) để **né chi phí cảm biến 3D đắt tiền** — có công trình đạt 93.67% độ chính xác trên kiểm tra mối hàn
- **Kiến trúc point cloud nhẹ** với module chú ý kép
- **ESAM++** — nhận thức 3D trực tuyến cho thiết bị biên **không có GPU**, nhanh gấp 3 và nhỏ gấp đôi so với phương án cùng loại
- Hướng chung được nhấn mạnh: **thiết kế nhận biết phần cứng, toán tử hiệu quả, tối ưu suy luận đầu-cuối** — tức đúng nội dung khối T, áp vào đúng bài toán khối V

**Vì sao bạn có lợi thế bất thường ở đây:** hướng này đòi hỏi *cùng lúc* hiểu nén model (T), hiểu hình học 3D (V), và có bài toán công nghiệp thật với ràng buộc thật (P + nền sản xuất của bạn). Rất ít người có cả ba. Người giỏi TinyML thường không có nhà máy; người ở nhà máy thường không train được model.

---

## 3. LLM và agent — quyết định gác lại

**Giữ nguyên quyết định của bạn.** Và không phải vì chiều, mà vì ba lý lẽ:

**1. Chi phí trì hoãn bất đối xứng, nghiêng về phía bạn.** Kỹ năng LLM/agent **rẻ dần theo thời gian** — cái khó hôm nay thành một dòng API sang năm. Học sau 2 năm *tốn ít hơn*. Multi-view geometry và TinyML thì không rẻ đi; toán vẫn là toán.

**2. Đó là chỗ đông nhất.** Moat của bạn là **thế giới vật lý**. Agent/LLM là mảng đông và commodity hoá nhanh nhất — nhảy vào là tự nguyện rời chỗ mình hiếm.

**3. Marathon chạy bằng động lực.** Người bỏ cuộc ở tháng thứ 8 thường là người ép mình theo thứ mình không thích.

**Điều kiện lật lại:** nếu agent bắt đầu **điều khiển thiết bị vật lý** một cách nghiêm túc — tức trend đó đi vào lãnh địa của bạn — thì lúc đó nó không còn là trend xa lạ nữa, và bạn ở vị trí tốt hơn hầu hết mọi người để nhảy vào.

---

## 4. Sau Chặng 3 thì đào tới đâu

Câu hỏi này đổi bản chất. Nó không còn là *"học thêm gì"* mà là *"đóng góp cái gì"*.

### Thang độ sâu — tự định vị

| Bậc | Bạn làm được gì | Đạt ở đâu |
|---|---|---|
| 1. **Dùng** | Gọi thư viện, ghép được hệ chạy | Chặng 1 |
| 2. **Hiểu** | Biết bên trong nó làm gì, gỡ lỗi được khi nó sai | Chặng 2 |
| 3. **Tối ưu** | Chỉnh được cho vừa ràng buộc, ghép được cái mới từ cái có sẵn | Chặng 3 |
| 4. **Tạo ra** | Làm được thứ **chưa tồn tại**, và chứng minh được nó tốt hơn | Sau Chặng 3 |

**Bậc 4 không đạt được bằng thêm khoá học.** Nó đạt bằng: chọn **một câu hỏi mở**, sống với nó vài năm, công bố, và xây uy tín trong một cộng đồng cụ thể.

### Dấu hiệu bạn đã tới bậc 4

Không phải số chứng chỉ hay số công nghệ biết. Là ba thứ này:

1. Bạn **phát biểu được một bài toán mà ngành chưa giải**, và giải thích được **vì sao các phương pháp hiện có thất bại trên nó**
2. Có người **tìm tới bạn** vì đúng bài toán đó, không phải vì bạn đang tìm việc
3. Bạn **bất đồng được với một paper** và bảo vệ được lập luận của mình bằng số liệu

### Và hình dạng sự nghiệp thì hẹp lại

Sau Chặng 3 bề rộng của bạn đã đủ — **bề rộng thêm nữa là giảm giá trị**. Cái cần là **thu hẹp**:

- Từ "edge AI và 3D vision" → xuống một bài toán cụ thể trong đó
- Từ "làm được nhiều ngành" → xuống một ngành mà bạn biết sâu hơn người ngoài

Nghe như mất mát, nhưng đó chính là cách người ta được trả cao: **người giải được bài toán mà rất ít người giải được**, chứ không phải người làm được nhiều việc mà ai cũng làm được.

---

## 5. Điều kiện duy nhất — không thương lượng

Chặng 3 là thêm **12–16 tháng**. Cộng dồn: **~30 tháng** kể từ hôm nay.

> **Tới Chặng 3, bạn phải đang được trả tiền trong mảng này rồi** — đi làm, hoặc freelance đều đặn.

Ba mươi tháng học liên tục không thu nhập từ chính mảng đó là **cái bẫy**, dù nội dung học tốt tới đâu. Lý tưởng nhất: Chặng 3 được **kéo bởi công việc thật** — khách cần đếm hàng 3D thì bạn học 3D, chứ không phải học 3D xong đi tìm người cần.

Và với đích PhD thì điều này càng đúng: **kinh nghiệm công nghiệp thật làm hồ sơ PhD của bạn mạnh lên**, không yếu đi. Một ứng viên mang theo bài toán nhà máy thật và dữ liệu thật thì khác hẳn một ứng viên chỉ có điểm số.

Nếu tới lúc đó bạn vẫn đang "học để chuẩn bị" thì vấn đề không còn nằm ở kiến thức nữa.

---

## Nguồn (kiểm chứng ngày 2026-09-16, sẽ cũ đi — dò lại khi dùng)

**TinyML / Efficient AI**
- [MIT 6.5940 — TinyML and Efficient Deep Learning Computing (HAN Lab)](https://hanlab.mit.edu/courses/2024-fall-65940)
- [MCUNet: Tiny Deep Learning on IoT Devices](https://arxiv.org/pdf/2007.10319)

**3D vision**
- [LightGlue: Local Feature Matching at Light Speed (ICCV 2023)](https://github.com/cvg/lightglue)
- [MASt3R — Grounding Image Matching in 3D (ECCV 2024)](https://arxiv.org/pdf/2406.09756)

**Giao điểm efficient × 3D × công nghiệp**
- [ESAM++: Efficient Online 3D Perception on the Edge](https://arxiv.org/pdf/2605.29505)
- [Industrial Weld Defect Detection Based on Monocular Depth Estimation and Dual-Attention Point Cloud Network](https://doi.org/10.3390/s26113321)
- [Accelerating point cloud analytics on resource-constrained edge devices](https://www.sciencedirect.com/science/article/abs/pii/S1389128625003494)
