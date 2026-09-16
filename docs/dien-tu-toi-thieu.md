# Điện tử tối thiểu cho người làm phần mềm

> **Bản vừa đủ, không phải giáo trình.** Đủ để không đốt board, không bị "chạy lúc được lúc không", và đọc hiểu được lý do sau mỗi con điện trở.
>
> Bản sâu (giải tích mạch, miền tần số, Laplace) nằm ở [CHANG-4-BAN-DO.md](../CHANG-4-BAN-DO.md).
>
---

## Đọc phần nào, khi nào — đừng đọc hết ngay

Phần lớn file này **không cần cho Chặng 1**. Đọc hết bây giờ là lãng phí.

| Lúc nào | Đọc gì | Thời gian |
|---|---|---|
| **Trước bài 17** | **Chỉ mục 10 — Bảy quy tắc sống còn.** Đó là phần chặn bạn đốt board | ~5 phút |
| Khi bài nào cần | Tra đúng mục đó: bài 17 → mục 3 · bài 18 → mục 4 · bài 20 → mục 2 · bài 25 → mục 7 · bài 41 → mục 9 | vài phút |
| **Khối C của Chặng 2** | Đọc trọn vẹn, cùng lúc cầm logic analyzer và đồng hồ | ~1 tuần |

### Và một quyết định mua sắm cắt được gần hết phần này

**Ở Chặng 1, mua module chứ đừng mua linh kiện rời.**

| Module | Đã lo sẵn cho bạn |
|---|---|
| Breakout cảm biến I2C | Điện trở kéo lên |
| Module relay | Opto-isolator + diode dập + transistor kích |
| Module MAX485 | Mạch thu phát RS485, đôi khi cả điện trở đầu cuối |
| Module LED | Điện trở hạn dòng |

Với module, thứ bạn thật sự phải nhớ ở Chặng 1 rút gọn còn **ba điều**: nối GND chung · không đưa 5V vào chân 3.3V · không kéo tải công suất thẳng từ GPIO.

Phần còn lại của file này — Ohm, phân áp, RC, trở kháng — trả lãi ở **khối C của Chặng 2**, khi bạn bắt đầu *nhìn* tín hiệu bằng logic analyzer thay vì chỉ *dùng* nó.

---

## 1. Ba đại lượng và một định luật

| | Ký hiệu | Đơn vị | Hiểu nôm na |
|---|---|---|---|
| Điện áp | V | volt | **Áp lực** đẩy điện đi |
| Dòng điện | I | ampere | **Lượng** điện chảy qua |
| Điện trở | R | ohm (Ω) | **Cản trở** dòng chảy |

**Định luật Ohm: `V = I × R`**

Ba dạng dùng hằng ngày:
- Biết V và R, muốn biết dòng: `I = V / R`
- Biết I và R, muốn biết sụt áp: `V = I × R`

**Công suất: `P = V × I`** — thành nhiệt. Điện trở nhỏ quá thì dòng lớn, và linh kiện nóng rồi chết.

### Ví dụ thật: điện trở cho LED

LED 2V, muốn chạy 10mA, nguồn 3.3V.

```
Điện áp rơi trên điện trở = 3.3V − 2V = 1.3V
R = V / I = 1.3 / 0.01 = 130Ω     → dùng 150Ω hoặc 220Ω cho an toàn
```

Nối LED thẳng vào chân 3.3V không qua điện trở: dòng chỉ bị giới hạn bởi nội trở, có thể vài trăm mA — **cháy LED, và có thể cháy cả chân GPIO**.

## 2. Phân áp — mạch bạn sẽ gặp nhiều nhất

```
   Vin ──[R1]──┬──[R2]── GND
               │
              Vout = Vin × R2 / (R1 + R2)
```

Dùng để: đưa tín hiệu 5V xuống mức 3.3V mà Pi/ESP32 chịu được, đọc điện áp pin bằng ADC, đọc cảm biến kiểu biến trở.

**Cảnh báo:** phân áp chỉ dùng cho **tín hiệu**, không dùng để cấp nguồn. Nối tải vào là tỉ lệ đổi ngay và điện áp tụt.

## 3. Điện trở kéo lên và kéo xuống

Chân input **không nối vào đâu** thì không phải 0, cũng không phải 1 — nó **nổi**, nhận nhiễu từ không khí, đọc ra ngẫu nhiên.

```
        3.3V
         │
        [R] 10kΩ  ← pull-up
         ├──────── chân MCU: mặc định HIGH
         │
        nút ── GND   ← bấm thì kéo xuống LOW
```

**Vì sao thường là 10kΩ:** đủ lớn để không tốn dòng (3.3V/10kΩ = 0.33mA), đủ nhỏ để kéo chân lên nhanh hơn nhiễu. Giá trị 4.7k–100k đều dùng được, tuỳ tốc độ tín hiệu.

Đây chính là lý do logic nút bấm thường **ngược**: bình thường HIGH, bấm thì LOW.

## 4. I2C và vì sao nó BẮT BUỘC có điện trở kéo

I2C dùng **open-drain**: thiết bị chỉ kéo được dây xuống LOW, **không đẩy lên HIGH được**. Muốn lên HIGH thì phải nhờ điện trở kéo.

```
        3.3V
         │  │
       [4.7k][4.7k]
         │  │
   SDA ──┴──┼────── tới mọi thiết bị trên bus
   SCL ─────┴──────
```

**Không có điện trở kéo → bus không hoạt động**, `i2cdetect` không thấy gì.

**Cắm nhiều module cùng lúc → hỏng theo kiểu khác:** phần lớn module bán sẵn đã hàn sẵn điện trở kéo. Cắm 4 module là 4 cặp điện trở **song song** → trở tương đương chỉ còn ~1.2kΩ → dòng lớn, sườn tín hiệu méo, bus chập chờn. Cách xử lý: tháo điện trở trên các module thừa, chỉ giữ một cặp.

Đây là một trong những lỗi I2C khó chịu nhất vì nó **lúc chạy lúc không** chứ không hỏng hẳn.

## 5. Mức logic — 3.3V và 5V

| | Pi / ESP32 / STM32 | Arduino UNO, nhiều module cũ |
|---|---|---|
| Mức logic | **3.3V** | 5V |
| Chịu được 5V ở chân input | **KHÔNG** | — |

> **Nối tín hiệu 5V thẳng vào chân GPIO 3.3V là hỏng chip, không sửa được.**

Ba cách nối an toàn:

| Cách | Dùng khi |
|---|---|
| **Phân áp** (2 điện trở) | Tín hiệu chậm, một chiều 5V→3.3V |
| **Mạch chuyển mức** (module level shifter) | Hai chiều, hoặc tín hiệu nhanh như I2C |
| **Chọn module 3.3V** | Tốt nhất — tránh vấn đề từ đầu |

Ngược lại: thiết bị 5V đọc tín hiệu 3.3V thường **vẫn hiểu** (3.3V vượt ngưỡng HIGH của phần lớn chip 5V), nên chiều này thường không cần gì.

## 6. Tụ điện và mạch RC

Tụ **chống lại thay đổi điện áp đột ngột**. Hai công dụng bạn sẽ gặp:

**Tụ lọc nguồn (decoupling).** Đặt sát chân nguồn của mỗi chip, thường 100nF. Khi chip đột ngột hút dòng, tụ cấp ngay tại chỗ thay vì để điện áp sụt. Thiếu nó thì mạch chạy "lúc được lúc không" — triệu chứng khó tìm nhất.

**Mạch RC làm hằng số thời gian.**

```
   τ = R × C        (giây, khi R tính bằng Ω và C bằng farad)
```

Sau `τ` thì tụ nạp được ~63%; sau `5τ` coi như đầy. Đây là nền của **chống nhiễu nút bấm bằng phần cứng**: chọn R và C sao cho τ lớn hơn thời gian nảy của nút.

Ví dụ: R = 10kΩ, C = 100nF → τ = 1ms. Nút nảy 20ms thì cần τ lớn hơn — tăng C lên 1µF (τ = 10ms).

## 7. Trở kháng và vì sao dây dài gây rắc rối

Ở tần số thấp và dây ngắn, dây điện là dây điện. Khi tín hiệu nhanh hoặc dây dài, dây trở thành **đường truyền** — có điện cảm, điện dung, và tín hiệu **dội ngược** ở đầu dây.

Đó là lý do **RS485 cần điện trở đầu cuối 120Ω** ở hai đầu bus (bài 25). Thiếu nó: tín hiệu dội, méo, và lỗi CRC ngẫu nhiên trên dây dài — chạy tốt trên bàn, hỏng khi kéo 50 mét.

**Quy tắc thực dụng:** dây tín hiệu càng ngắn càng tốt; dây dài thì dùng chuẩn vi sai (RS485, CAN) chứ không dùng tín hiệu đơn cực.

## 8. Nối đất — nguồn lỗi bị đánh giá thấp nhất

**Hai thiết bị muốn nói chuyện với nhau thì phải chung GND.** Không có GND chung thì "3.3V" của bên này không cùng mốc với bên kia, và tín hiệu vô nghĩa.

Nghe hiển nhiên, nhưng đây là lỗi rất hay gặp khi nối Pi với ESP32, hoặc nối cảm biến dùng nguồn riêng.

**Vòng lặp đất (ground loop):** khi có hai đường về đất khác nhau, dòng chạy vòng qua đất gây nhiễu. Trong nhà máy có động cơ và biến tần thì chuyện này rất thật — và là lý do người ta dùng **cách ly quang** (opto-isolator) giữa phần điều khiển và phần công suất.

## 9. Dòng tối đa của chân GPIO

| Chip | Mỗi chân | Tổng |
|---|---|---|
| Raspberry Pi | ~16mA | ~50mA toàn bộ |
| ESP32 | ~40mA | ~1200mA (nhưng đừng tới gần) |

**Không bao giờ nối thẳng động cơ, relay, hay dải LED vào chân GPIO.** Chúng ăn hàng trăm mA tới vài ampere. Phải qua **transistor, MOSFET, hoặc module relay**.

Và cuộn dây (relay, động cơ) khi ngắt sẽ sinh **xung điện áp ngược** phá chip — cần **diode dập** mắc ngược song song với cuộn. Module relay bán sẵn thường đã có sẵn diode và opto-isolator; đó là lý do nên mua module thay vì tự lắp relay trần.

---

## Bảy quy tắc sống còn

1. **Nối GND chung** trước khi nối bất cứ tín hiệu nào
2. **Không bao giờ 5V vào chân 3.3V**
3. **LED luôn có điện trở hạn dòng**
4. **Chân input luôn có điện trở kéo** (trong chip hoặc ngoài)
5. **I2C phải có điện trở kéo**, và chỉ một cặp trên cả bus
6. **Tải công suất luôn qua transistor/relay**, không bao giờ nối thẳng GPIO
7. **Rút điện trước khi đấu lại dây** — nghe thừa, nhưng phần lớn board chết là chết lúc đấu nóng

## Dụng cụ tối thiểu

| | Giá tham khảo | Dùng làm gì |
|---|---|---|
| Đồng hồ vạn năng | rẻ | Đo áp, thông mạch. **Mua trước mọi thứ khác** |
| Breadboard + dây | rẻ | Lắp thử không cần hàn |
| Bộ điện trở | rẻ | 220Ω, 1k, 4.7k, 10k là đủ 90% trường hợp |
| Logic analyzer | ~500k–1tr | **Khối C của Chặng 2** — nhìn thấy tín hiệu số thật |

Đồng hồ vạn năng là món đầu tiên. Một nửa số lỗi "code sai" hoá ra là dây chưa thông hoặc nguồn không tới.
