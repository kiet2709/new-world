# CHẶNG 4 — Nền tảng sâu và FPGA

> **Ghi lại dự định, không phải cam kết.**
> Chặng 1: [LO-TRINH-TUNG-BAI.md](LO-TRINH-TUNG-BAI.md) · Chặng 2: [CHANG-2-BAN-DO.md](CHANG-2-BAN-DO.md) · Chặng 3: [CHANG-3-BAN-DO.md](CHANG-3-BAN-DO.md)
>
> *Viết ngày 2026-09-16.*

---

## 0. Một điều chỉnh quan trọng về vị trí

Bản phác ban đầu xếp vào Chặng 4: **kiến trúc máy tính · hợp ngữ · xác suất thống kê · đại số tuyến tính sâu · giải tích mạch điện · FPGA**.

Danh sách đúng. **Nhưng vị trí thì sai với ba trong bốn nhóm đầu** — chúng không phải phần thưởng sau 30 tháng, chúng là **điều kiện để làm tốt Chặng 2 và 3**.

| Nền tảng | Thật sự cần cho | Nếu để tới Chặng 4 |
|---|---|---|
| **Đại số tuyến tính + xác suất** | Chặng 2 khối F (ML từ gốc) · Chặng 3 khối V (multi-view geometry **chính là** hình học xạ ảnh + bình phương tối thiểu: SVD, phân rã trị riêng, bundle adjustment) | Bạn "làm được" F và V mà không hiểu vì sao — đúng cái mù mờ đang muốn chữa |
| **Kiến trúc máy tính + hợp ngữ** | Chặng 2 khối A (STM32 bare-metal) · Chặng 3 khối T (tối ưu theo cache, SIMD, phân cấp bộ nhớ) | Bare-metal không "sáng ra" được. Hợp ngữ là thứ làm thanh ghi hết trừu tượng |
| **Giải tích mạch điện** | **Ngay Chặng 1** (điện trở kéo, ADC, RS485, nguồn) · Chặng 2 khối C | Rẻ nhất, trả lãi sớm nhất, mà lại để cuối cùng |
| **FPGA** | — | ✅ Đây mới thật sự là Chặng 4 |

## Cách giải: vừa đủ lúc cần, sâu sau nếu đi tiếp

Đúng triết lý đã dùng cả lộ trình — không học trước cho đủ bộ, cũng không để muộn tới mức vô dụng.

| Nền tảng | Bản **vừa đủ**, đặt ở đâu | Bản **sâu**, ở Chặng 4 |
|---|---|---|
| Mạch điện | Vài buổi trong **khối C của Chặng 2**, cùng chỗ logic analyzer/oscilloscope: định luật Ohm, phân áp, RC, trở kháng, mức logic, nhiễu và nối đất | Giải tích mạch đầy đủ: miền tần số, biến đổi Laplace, đáp ứng quá độ |
| Kiến trúc máy tính + hợp ngữ | **Ngay trước khối A**: mô hình von Neumann, thanh ghi, phân cấp bộ nhớ, đọc hiểu ARM assembly do compiler sinh ra | Pipeline, dự đoán rẽ nhánh, cache coherency, SIMD, thiết kế tập lệnh |
| Đại số tuyến tính | **F1 của Chặng 2** đã có bản tối thiểu (vector/ma trận, đạo hàm, quy tắc chuỗi) | **Trước khối V**: SVD, phân rã trị riêng, bình phương tối thiểu, hình học xạ ảnh, **nhóm Lie cho phép quay** (SO(3), SE(3)) |
| Xác suất thống kê | **F3 của Chặng 2** (đánh giá model) | Suy luận Bayes, ước lượng hợp lý cực đại, lọc Kalman, RANSAC hiểu tận gốc |

> **Nói thẳng:** nếu bạn tới khối V mà chưa nắm SVD và hình học xạ ảnh, bạn sẽ gọi hàm `cv2.findEssentialMat()` rồi không giải thích nổi nó làm gì. Đó là vibe code ở tầng cao hơn — khó phát hiện hơn, và nguy hiểm hơn vì bạn tưởng mình đã qua giai đoạn đó rồi.

---

# FPGA — nội dung thật của Chặng 4

## Vì sao nó hợp với bạn hơn vẻ ngoài

FPGA thường bị coi là nhánh tách biệt. Với **hồ sơ của bạn thì không** — nó là phần mở rộng tự nhiên của ba thứ đã có:

```
Chặng 2  bare-metal, thanh ghi, tín hiệu số, logic analyzer
Chặng 3  TinyML — ép model vào ràng buộc phần cứng
Chặng 3  3D vision — xử lý ảnh tốc độ cao, độ trễ phải đoán trước được
                        ↓
Chặng 4  FPGA: tự thiết kế phần cứng cho đúng bài toán đó
```

## Ba chỗ FPGA thật sự thắng

| Ứng dụng | Vì sao FPGA chứ không phải CPU/GPU |
|---|---|
| **Tăng tốc suy luận AI** | Song song hoá theo đúng hình dạng mạng; hiệu năng trên watt cao. Nối thẳng vào khối T |
| **Xử lý ảnh tốc độ cao** | Kiểm tra trên dây chuyền chạy nhanh: xử lý **theo dòng pixel**, độ trễ tính bằng micro-giây và **đoán trước được** |
| **Điều khiển thời gian thực cứng** | Điều khiển chuyển động, EtherCAT, thu thập dữ liệu tốc độ cao. Không có hệ điều hành xen vào |

Cột giữa đáng chú ý: FPGA không nhanh hơn GPU về thông lượng thô, nhưng nó **đoán trước được thời gian** và **không cần đợi gom cả khung hình**. Với kiểm tra sản phẩm chạy 3 mét/giây, đó là khác biệt sống còn.

## Chọn board: Zynq

**AMD/Xilinx Zynq** — một chip có **lõi ARM chạy Linux + fabric FPGA**. Nghĩa là toàn bộ Chặng 1–3 của bạn (Linux, Docker, Python, OpenCV) chạy trên phần ARM, còn phần cần nhanh thì đẩy xuống FPGA.

| Board | Hợp cho |
|---|---|
| **Zybo Z7 / PYNQ-Z2** | Học, giá vừa. PYNQ cho phép điều khiển FPGA **từ Python** — cầu nối rất tốt cho người đến từ phần mềm |
| **Kria KV260** | Bộ kit hướng thị giác, có sẵn đường ống camera — hợp nếu đi theo khối V |

*Lattice iCE40/ECP5 rẻ hơn và có toolchain mã nguồn mở (Yosys/nextpnr), hợp nếu muốn hiểu tận đáy chuỗi công cụ. Nhưng không có lõi ARM, nên không nối được với phần Linux của bạn.*

## Lộ trình học

| Giai đoạn | Nội dung |
|---|---|
| 1. Nền số | Đại số Boole, mạch tổ hợp và tuần tự, flip-flop, máy trạng thái, **thời gian thiết lập/giữ** và vì sao timing là thứ khó nhất |
| 2. HDL | Verilog hoặc VHDL. **Mô phỏng trước khi nạp** — đây là thói quen bắt buộc, khác hẳn phần mềm |
| 3. Thiết kế thật | UART, PWM, bộ lọc ảnh theo dòng pixel, giao tiếp với cảm biến |
| 4. Zynq | Chia việc giữa ARM và FPGA, giao tiếp AXI, Linux trên phần ARM |
| 5. HLS | Viết C/C++ rồi tổng hợp ra phần cứng — cầu từ thế giới phần mềm sang |
| 6. Tăng tốc AI | Systolic array, dòng dữ liệu, lượng tử hoá cho phần cứng. **Đây là chỗ FPGA gặp khối T** |

Ước lượng: **~6–8 tháng** để tới bước 6 ở mức làm được, không phải mức chuyên gia.

## Cảnh báo trung thực

FPGA có **đường cong học dốc và chuỗi công cụ khó chịu** — tổng hợp lâu, thông báo lỗi tối nghĩa, timing closure gây nản. Nó cũng là kỹ năng **hẹp**: ít vị trí tuyển hơn nhiều so với nhúng hay AI.

Nên FPGA chỉ đáng khi bạn đã xác định **một bài toán cụ thể mà CPU/GPU không giải được** — chứ không phải để "biết thêm phần cứng". Nếu tới Chặng 4 mà chưa có bài toán đó, hãy hoãn.

---

# Chiều sâu học thuật — nếu đi đường PhD

Chặng 4 cũng là chỗ đặt phần toán và lý thuyết mà đường nghiên cứu đòi hỏi:

| Nhóm | Nội dung | Phục vụ |
|---|---|---|
| **Tối ưu hoá** | Lồi và không lồi, gradient bậc hai, nhân tử Lagrange | Hiểu tận gốc việc huấn luyện và bundle adjustment |
| **Hình học vi phân** | Đa tạp, nhóm Lie SO(3)/SE(3) | Biểu diễn phép quay đúng cách — nền của SLAM và ước lượng tư thế |
| **Xác suất nâng cao** | Bayes, đồ thị xác suất, lọc Kalman/hạt | Hợp nhất cảm biến, ước lượng trạng thái |
| **Lý thuyết thông tin** | Entropy, nén, giới hạn tốc độ–méo | Nền lý thuyết của nén model ở khối T |
| **Kiến trúc máy tính nâng cao** | Bộ tăng tốc, phân cấp bộ nhớ, đồng thiết kế phần cứng–thuật toán | **Chính là nền của MCUNet**: TinyNAS + TinyEngine là đồng thiết kế |

Dòng cuối đáng nhấn: khối T của Chặng 3 **là ứng dụng** của đồng thiết kế phần cứng–thuật toán. Chặng 4 là lúc bạn hiểu lý thuyết bên dưới đủ sâu để **tự đề xuất cái mới**, không chỉ áp dụng cái Song Han đã làm.

---

## Thứ tự và thời lượng

| | Nội dung | Thời lượng |
|---|---|---|
| **Đã chuyển sớm** | Mạch điện → khối C (Chặng 2) · Kiến trúc + hợp ngữ → trước khối A · Toán → trước F và V | nằm trong Chặng 2–3 |
| **Chặng 4 thật** | FPGA (6–8 tháng) + chiều sâu học thuật (song song, liên tục) | ~8–12 tháng |

Cộng dồn từ hôm nay: **~40 tháng**, tức hơn ba năm.

> Ở quy mô đó, "kế hoạch" không còn là thứ thực thi tuần tự. Nó là **la bàn cho các quyết định rẽ nhánh**. Rất có thể tới Chặng 3 bạn đã vào một lab, hoặc một công ty trả tiền cho bạn học đúng vài khối trong đây — và lúc đó cắt bớt là **thắng**, không phải bỏ dở.

---

## Kỷ luật xuyên suốt: từ vựng ba thứ tiếng

Từ Chặng 1 tới hết, mỗi bài ghi thuật ngữ mới vào [docs/tu-vung.md](docs/tu-vung.md) bằng **Việt · English · 日本語**.

Chi phí ~10 phút/bài, và nó compound: tới Chặng 4 bạn có một cuốn từ điển kỹ thuật ba thứ tiếng của riêng mình — thứ mà đọc paper, đọc datasheet Nhật, và phỏng vấn đều dùng tới.
