# Lý thuyết — Bài 22: C++ đọc cảm biến và đo hiệu năng

> Cây cầu sang C++. Bạn **không** học C++ từ hello world — bạn học nó để làm lại thứ mình đã hiểu, và đo xem có đáng không.

## 1. Nói chuyện với I2C bằng syscall trần

Ở bài 18 bạn dùng `smbus2`. Giờ bỏ hết thư viện và làm bằng ba lệnh hệ thống:

```cpp
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/i2c-dev.h>

int fd = open("/dev/i2c-1", O_RDWR);          // 1. mở file thiết bị
if (fd < 0) throw std::runtime_error("khong mo duoc bus");

if (ioctl(fd, I2C_SLAVE, 0x76) < 0)           // 2. chọn địa chỉ thiết bị
    throw std::runtime_error("khong chon duoc dia chi");

uint8_t reg = 0xD0;
write(fd, &reg, 1);                            // 3. nói: tôi muốn thanh ghi này
uint8_t val;
read(fd, &val, 1);                             //    rồi đọc

close(fd);
```

`open`/`read`/`write`/`close` là **"mọi thứ là file"** của bài 16, giờ dùng thật. `ioctl` là cửa hậu cho những thao tác không hợp với mô hình đọc/ghi — ở đây là "đặt địa chỉ slave".

Đây chính xác là thứ `smbus2` làm bên dưới. Bạn không làm gì thấp hơn thư viện; bạn chỉ **nhìn thấy** cái thư viện đang giấu.

## 2. Bọc lại bằng RAII

Đoạn trên rò rỉ file descriptor nếu có exception giữa chừng. Dùng đúng bài 11:

```cpp
class BusI2C {
public:
    explicit BusI2C(const char* dev) : fd_(open(dev, O_RDWR)) {
        if (fd_ < 0) throw std::system_error(errno, std::generic_category(), dev);
    }
    ~BusI2C() { if (fd_ >= 0) close(fd_); }

    BusI2C(const BusI2C&) = delete;              // cấm sao chép — hai object
    BusI2C& operator=(const BusI2C&) = delete;   // cùng đóng một fd là hỏng

    uint8_t doc_thanh_ghi(uint8_t addr, uint8_t reg);
private:
    int fd_;
};
```

Hai dòng `= delete` quan trọng: nếu ai đó sao chép object này, cả hai bản sẽ gọi `close()` lên cùng một fd — **đóng hai lần**, và fd đó có thể đã được cấp lại cho file khác. Đây là loại bug C++ rất khó tìm, và cách chặn là cấm sao chép ngay từ đầu.

## 3. Đo cho đúng

Đây là bài `[SO-SÁNH]`, nên chất lượng phép đo quan trọng ngang kết quả.

```cpp
#include <chrono>
using clk = std::chrono::steady_clock;          // KHÔNG dùng system_clock

auto t0 = clk::now();
for (int i = 0; i < 10000; ++i) doc_mot_lan();
auto dt = clk::now() - t0;
```

**`steady_clock` chứ không phải `system_clock`:** đồng hồ hệ thống có thể nhảy khi NTP đồng bộ, làm phép đo ra số âm. `steady_clock` chỉ tiến, không bao giờ nhảy.

Năm nguyên tắc (nhắc lại từ bài 12, giờ áp dụng thật):

1. Build `Release` (`-O2`) — đo Debug là vô nghĩa
2. Bỏ lần chạy đầu
3. Lấy **trung vị**, không phải trung bình — trung bình bị một lần chậm bất thường kéo lệch
4. Ghi rõ điều kiện: Pi đời mấy, nhiệt độ, có gì khác đang chạy
5. Đo cả RAM và thời gian khởi động

```bash
/usr/bin/time -v ./doc_cam_bien
```

## 4. Cái bẫy: phép đo này đo cái gì?

Đọc I2C ở 100kHz mất khoảng **1 mili-giây cho phần truyền dây**. Đó là vật lý, không ngôn ngữ nào đổi được.

Nên nếu tổng thời gian một lần đọc là 1.1ms (C++) và 1.4ms (Python) thì bạn đang đo **1ms vật lý + phần mềm**. Khác biệt ngôn ngữ chỉ là 0.1ms vs 0.4ms — nhưng nó bị lấp trong tổng số.

> **Đây là bài học lớn nhất của bài này, lớn hơn cả con số:** khi phần lớn thời gian là chờ phần cứng, **viết lại bằng C++ gần như không cải thiện gì**. Tối ưu đúng chỗ đòi hỏi biết chỗ nào đang tốn thời gian.

Nên hãy đo **tách bạch**:

| Đo riêng | Cách |
|---|---|
| Chi phí phần mềm thuần | Lặp 10000 lần phần tính toán, **không đụng bus** |
| Chi phí giao tiếp bus | Lặp 10000 lần đọc thật |
| Thời gian khởi động | `time ./ct` với chương trình không làm gì |
| RAM | `/usr/bin/time -v`, xem `Maximum resident set size` |

Python mất ~30–50ms chỉ để khởi động interpreter, còn binary C++ mất <1ms. Với dịch vụ chạy nhiều ngày thì không đáng kể; với script gọi mỗi giây từ cron thì là tất cả.

## 5. Kết luận nào cũng được, miễn là có căn cứ

Kết quả rất có thể sẽ là: **"với bài toán này, Python đủ tốt."** Đó là một kết luận đúng và giá trị, không phải thất bại của bài.

Cái bài này dạy không phải "C++ nhanh hơn" — mà là **cách quyết định có nên viết lại hay không, dựa trên số liệu chứ không dựa trên cảm giác**. Kỹ năng đó bạn sẽ dùng lại ở bài 38 (OpenCV C++) và bài 47 (viết lại phần nóng), và nó chính là thứ nhà tuyển dụng gọi là "phán đoán kỹ thuật".

Câu trả lời tệ trong phỏng vấn: *"tôi viết lại mọi thứ bằng C++ cho nhanh."*
Câu trả lời tốt: *"tôi đo, thấy 90% thời gian là chờ I2C, nên viết lại không đáng — tôi để Python và dồn công sức vào chỗ khác."*
