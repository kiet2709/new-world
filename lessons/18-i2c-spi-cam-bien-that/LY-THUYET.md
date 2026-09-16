# Lý thuyết — Bài 18: I2C/SPI và đọc datasheet

> **Nền điện tử:** bài này giả định bạn biết điện trở kéo, mức logic, và định luật Ohm. Chưa chắc thì đọc [docs/dien-tu-toi-thieu.md](../../docs/dien-tu-toi-thieu.md) trước — khoảng 30 phút, dùng lại cho bài 18, 20, 25 và khối C của Chặng 2.

## 1. Vì sao cần giao thức, không chỉ GPIO

Một cảm biến nhiệt độ cần trả về số 25.4. Qua GPIO trần thì phải mã hoá bằng tay từng bit, và cần rất nhiều chân. Giao thức nối tiếp giải quyết chuyện đó: **vài sợi dây, nhiều thiết bị, dữ liệu có cấu trúc.**

## 2. I2C và SPI

| | **I2C** | **SPI** |
|---|---|---|
| Số dây | **2** (SDA dữ liệu, SCL nhịp) | **4** (MOSI, MISO, SCK, CS) |
| Địa chỉ | Mỗi thiết bị có địa chỉ 7-bit | Mỗi thiết bị một chân CS riêng |
| Tốc độ | 100kHz–1MHz | 1–50MHz+ |
| Số thiết bị | Nhiều, chung 2 dây | Mỗi cái tốn thêm một chân |
| Dùng cho | Cảm biến chậm: nhiệt, ẩm, áp suất | Nhanh: màn hình, thẻ nhớ, ADC tốc độ cao |

**I2C cần điện trở kéo lên** trên cả SDA và SCL (thường 4.7kΩ). Phần lớn module bán sẵn đã hàn sẵn — nhưng nếu cắm 4 module vào cùng bus thì 4 cặp điện trở song song có thể làm tín hiệu méo. Đó là một lỗi thật ngoài đời.

## 3. Tìm thiết bị

```bash
i2cdetect -y 1        # quét bus 1
#      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
# 70: -- -- -- -- -- -- 76 --
```

`76` là địa chỉ thiết bị (hệ 16). Không thấy gì → kiểm tra theo thứ tự: dây nguồn, dây SDA/SCL có hoán đổi không, I2C đã bật trong `raspi-config` chưa, module có sống không.

Nhiều cảm biến có **hai địa chỉ tuỳ chân chọn** (0x76/0x77) — cho phép cắm hai con cùng loại trên một bus.

## 4. Đọc datasheet — kỹ năng thật của bài này

Đây là thứ phân biệt người làm nhúng với người copy thư viện. Với một cảm biến lạ, tìm năm thứ này trong datasheet:

| Cần tìm | Ví dụ |
|---|---|
| **Địa chỉ I2C** | 0x76, đổi được bằng chân SDO |
| **Bản đồ thanh ghi** | 0xD0 = chip ID, 0xF7..0xF9 = dữ liệu áp suất |
| **Cách khởi tạo** | ghi 0x27 vào 0xF4 để vào chế độ đo liên tục |
| **Thời gian chờ** | cần 8ms sau khi ra lệnh đo mới đọc được |
| **Công thức chuyển đổi** | giá trị thô × hệ số hiệu chuẩn → °C |

**Mục cuối hay bị bỏ sót và luôn gây sai.** Cảm biến trả về số nguyên thô, không phải độ C. Có con cần cả một công thức bù với hệ số hiệu chuẩn đọc từ chính chip đó.

Mẹo đọc datasheet 200 trang: đọc theo thứ tự **mục lục → sơ đồ khối → bảng thanh ghi → ví dụ mã (nếu có)**. Đừng đọc tuần tự từ trang 1.

Bài tập đáng làm: đọc thanh ghi **chip ID** trước tiên. Nếu nó trả đúng giá trị datasheet ghi, bạn đã chứng minh toàn bộ đường dây + địa chỉ + quyền truy cập đều đúng — trước khi lo tới dữ liệu thật.

## 5. Ba lớp trừu tượng

```
   Thư viện cảm biến (adafruit-circuitpython-bmp280)   ← dễ nhất, giấu hết
   Thư viện bus      (smbus2 — read_byte_data...)      ← bạn tự dịch thanh ghi
   ioctl thẳng       (open + ioctl trên /dev/i2c-1)    ← bài 22, bằng C++
```

Bài này dùng tầng giữa: `smbus2`. Lý do — tầng trên giấu mất khái niệm thanh ghi (bạn học được ít), tầng dưới quá rườm rà cho lần đầu. Tầng giữa bắt bạn đọc datasheet mà không bắt bạn viết `ioctl`.

```python
from smbus2 import SMBus
with SMBus(1) as bus:
    chip_id = bus.read_byte_data(0x76, 0xD0)
    bus.write_byte_data(0x76, 0xF4, 0x27)
```

`with` ở đây chính là context manager của bài 09 — bus được đóng kể cả khi có exception.

## 6. Thế giới vật lý vẫn bẩn

Rút dây giữa chừng thì chương trình phải làm gì?

```python
try:
    gia_tri = doc_cam_bien()
except OSError as e:          # I/O error — dây đứt, thiết bị biến mất
    logger.warning("mat cam bien: %s", e)
    gia_tri = None            # KHÔNG phải 0 — 0 là một nhiệt độ hợp lệ!
```

**Đừng bao giờ dùng 0 để biểu thị "không đọc được".** 0°C là giá trị thật. Dùng `None`, và ở bài 30 bạn sẽ thấy vì sao phân biệt "không có dữ liệu" với "dữ liệu bằng 0" là chuyện sống còn trong hệ thống công nghiệp.

Ba loại lỗi phải xử lý:

1. **Lỗi bus** (`OSError`) — dây đứt, thiết bị mất
2. **Giá trị vô lý** — cảm biến trả 200°C trong phòng. Kiểm tra dải hợp lệ!
3. **Giá trị đứng im** — cảm biến treo, trả mãi một số. Phát hiện bằng cách theo dõi độ biến thiên

Loại thứ ba nguy hiểm nhất vì **trông như bình thường**. Một cảm biến chết mà vẫn trả 25.0 mỗi giây thì không có exception nào bắt được.

## 7. Nghiệm thu

Hà hơi vào cảm biến → **số phải nhảy**. Nghe đơn giản, nhưng nó chứng minh: dây đúng, địa chỉ đúng, công thức chuyển đổi đúng, và bạn đang đọc thế giới thật chứ không phải một hằng số nào đó.

Rút dây → báo lỗi rõ ràng, **chương trình không chết**.
