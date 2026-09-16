# Lý thuyết — Bài 17: GPIO bằng Python

## 1. GPIO là gì

**General Purpose Input/Output** — chân cắm mà phần mềm điều khiển được mức điện áp, hoặc đọc được mức điện áp bên ngoài.

Chỉ có hai trạng thái: **HIGH** (3.3V trên Pi) và **LOW** (0V). Từ hai trạng thái đó xây được mọi thứ: bật đèn, đóng relay, đọc nút, và cả giao thức phức tạp như I2C.

> **Cảnh báo phần cứng: Pi dùng 3.3V, KHÔNG chịu được 5V.** Nối thẳng tín hiệu 5V vào chân GPIO là hỏng chip, không sửa được. ESP32 cũng 3.3V. Thiết bị 5V thì phải qua mạch chuyển mức.

## 2. Chân thả nổi — và vì sao cần pull-up/pull-down

Chân GPIO đặt ở chế độ input mà **không nối vào đâu cả** thì đọc ra cái gì?

Không phải 0. Không phải 1. Nó **nổi** — nhận nhiễu điện từ không khí, từ dây điện gần đó, từ chính bàn tay bạn. Đọc ra ngẫu nhiên.

```
   Không có điện trở kéo:          Có pull-up:

      3.3V                            3.3V
                                       │
                                      [R] 10kΩ
       ?  ←── chân nổi, đọc bậy        ├──── chân: mặc định HIGH
                                       │
      nút ─── GND                     nút ─── GND   ← bấm thì kéo xuống LOW
```

**Pull-up** kéo chân về HIGH khi không có gì tác động. **Pull-down** kéo về LOW. Pi có sẵn điện trở kéo bên trong, bật bằng phần mềm.

Quy ước thông dụng: nút nối giữa chân và GND, bật pull-up → **bình thường HIGH, bấm thì LOW**. Logic ngược, nhưng đó là chuẩn và bạn sẽ gặp khắp nơi.

## 3. Chống nhiễu (debounce) — bài học lớn nhất của bài này

Nút bấm cơ khí không chuyển trạng thái sạch sẽ. Lá tiếp điểm **nảy** vài lần trong khoảng 1–50ms:

```
   Bạn nghĩ:      ────┐
                      └──────────

   Thực tế:       ────┐ ┌┐ ┌─┐
                      └─┘└─┘ └──────    ← 5 lần đổi mức chỉ trong 20ms
```

Phần mềm chạy nhanh hơn nhiều so với chuyện nảy đó, nên nó thấy **5 lần bấm**. Đây là lý do LED nhấp nháy loạn khi bạn bấm một cái.

Ba cách xử lý:

| Cách | Làm gì | Đánh đổi |
|---|---|---|
| Trễ theo thời gian | Sau lần đổi mức đầu, bỏ qua mọi thay đổi trong 50ms | Đơn giản, đủ dùng 95% trường hợp |
| Lấy mẫu N lần | Chỉ chấp nhận khi đọc được N lần liên tiếp giống nhau | Ổn định hơn, tốn CPU hơn |
| Phần cứng | Tụ + điện trở, hoặc trigger Schmitt | Không tốn CPU, tốn linh kiện |

```python
from gpiozero import Button
nut = Button(17, pull_up=True, bounce_time=0.05)   # 50ms
```

**Nhưng đừng chỉ đặt 0.05 rồi thôi.** Bài yêu cầu bạn **đo thời gian nảy của chính cái nút của bạn**: ghi timestamp mỗi lần chân đổi mức, in ra, xem nó nảy bao lâu. Nút rẻ nảy 30ms, nút tốt nảy 2ms. Chọn ngưỡng có căn cứ chứ không phải chép trên mạng.

> **Vì sao bài này quan trọng hơn vẻ ngoài của nó:** debounce là lần đầu bạn gặp chân lý **thế giới vật lý bẩn**. Mọi thứ về sau đều là biến thể: cảm biến nhiễu (bài 18), gói MQTT mất (bài 27), AI nháy kết quả (bài 43). Cùng một hình dạng vấn đề — tín hiệu thật không sạch như trong đầu bạn, và phần mềm phải lọc.
>
> Ở bài 43 bạn sẽ dùng lại đúng ý tưởng này với tên khác: **N-of-M**.

## 4. Polling và interrupt

```python
while True:                    # POLLING — hỏi liên tục
    if nut.is_pressed: ...
    time.sleep(0.01)

nut.when_pressed = xu_ly       # EVENT — hệ thống gọi bạn khi có chuyện
```

| | Polling | Event/Interrupt |
|---|---|---|
| CPU | Tốn, kể cả khi không có gì | Gần như 0 khi im |
| Độ trễ | Tới chu kỳ hỏi tiếp theo | Gần như tức thì |
| Bỏ sót | Có thể, nếu sự kiện ngắn hơn chu kỳ | Không |
| Độ phức tạp | Đơn giản, dễ hiểu | Phải nghĩ về đồng thời |

Đây là cặp khái niệm quay lại nhiều lần: bài 30 (polling Modbus vs event MQTT), bài 25 (task FreeRTOS).

## 5. PWM — tạo giá trị trung gian từ hai trạng thái

Chân chỉ có 0 và 3.3V. Muốn LED sáng 50% thì làm sao? **Bật tắt thật nhanh.**

```
   100%:  ████████████████
    50%:  ██  ██  ██  ██        ← duty cycle 50%
    10%:  █   █   █   █
```

Mắt người và động cơ đều "trung bình hoá" tín hiệu nhanh này thành một mức trung gian.

Hai tham số: **tần số** (bao nhiêu chu kỳ mỗi giây — LED cần >100Hz để không thấy nháy) và **duty cycle** (bao nhiêu phần trăm thời gian ở mức HIGH — đây là cái bạn điều chỉnh).

PWM trên Pi thường là **phần mềm** (CPU bật tắt chân) nên có thể giật khi máy bận. ESP32 có **PWM phần cứng** — ổn định hơn nhiều. Đó là một khác biệt thật giữa Linux và vi điều khiển mà bạn sẽ thấy ở bài 24.

## 6. Thư viện

`gpiozero` là lựa chọn của bài này: API sạch, có debounce sẵn, chạy trên nền `lgpio`/`libgpiod` hiện đại.

*Bỏ qua `RPi.GPIO` — thư viện cũ, không hoạt động đúng trên Pi 5 và nhân mới.*

Bên dưới `gpiozero` là `libgpiod`, giao tiếp với `/dev/gpiochip0` — chính là cái file thiết bị bạn đã soi ở bài 16. Ở bài 21 bạn sẽ phải truyền file đó vào container, và lúc đó sẽ rõ vì sao.

## 7. Nghiệm thu

Bấm nút **20 lần**, LED đổi trạng thái **đúng 20 lần** — không phải 23, không phải 47. Đếm bằng tay.

Đây là lần đầu tiêu chí nghiệm thu của bạn là một con số đếm được trong thế giới vật lý, không phải một dòng log.
