# Lý thuyết — Bài 16: Linux nền cho người làm nhúng

> `/dev`, `/sys`, `/proc` là ba chỗ phần mềm chạm phần cứng. Không hiểu chúng thì mọi thứ về sau là phép thuật — và phép thuật thì không gỡ lỗi được.

## 1. "Mọi thứ là file" nghĩa là gì

Trong Linux, gần như mọi thứ đều được truy cập qua cùng bốn thao tác: `open`, `read`, `write`, `close`. Bàn phím, cổng serial, ổ cứng, socket mạng, cảm biến I2C — cùng một giao diện.

Vì sao điều đó quan trọng với bạn: **bạn chỉ cần học một cách nói chuyện với thiết bị.** Đọc nhiệt độ CPU và đọc cảm biến I2C dùng chung cơ chế, chỉ khác đường dẫn.

## 2. `/dev` — cổng vào thiết bị

```bash
ls -l /dev/i2c-1 /dev/ttyUSB0 /dev/gpiochip0
# crw-rw---- 1 root i2c 89, 1 /dev/i2c-1
# ↑                       ↑   ↑
# c = character device    major minor
```

| Ký tự đầu | Loại | Nghĩa |
|---|---|---|
| `c` | character device | Dữ liệu chảy theo dòng, từng byte — serial, I2C, camera |
| `b` | block device | Truy cập theo khối, có đệm — ổ đĩa, thẻ SD |

**major/minor** là cách nhân Linux biết giao file này cho driver nào xử lý. `major 89` = driver I2C; `minor 1` = bus thứ hai.

Một file trong `/dev` **không chứa dữ liệu** — nó là một cái cửa. Ghi vào đó là gọi hàm trong driver của nhân.

## 3. `/sys` — cấu hình và trạng thái thiết bị

```bash
cat /sys/class/thermal/thermal_zone0/temp     # 47238  → 47.238 °C
cat /sys/class/net/eth0/address               # địa chỉ MAC
cat /sys/block/mmcblk0/size                   # kích thước thẻ SD
```

Đọc nhiệt độ CPU không cần thư viện nào — chỉ đọc một file text. Đây là cách giám sát nhẹ nhất có thể, và bạn sẽ dùng nó ở bài 40 và 64 để phát hiện Pi bị giảm xung nhịp vì nóng.

`/sys` **ghi được** nữa: bật/tắt LED, đổi chế độ CPU. Nhưng ghi vào `/sys` cần cẩn thận — nó tác động thẳng vào phần cứng.

## 4. `/proc` — trạng thái tiến trình và nhân

```bash
cat /proc/cpuinfo          # CPU gì, mấy nhân
cat /proc/meminfo          # RAM
cat /proc/<pid>/status     # tiến trình này đang thế nào
ls  /proc/<pid>/fd/        # nó đang mở những file nào  ← cực hữu ích
```

`/proc/<pid>/fd/` trả lời câu "chương trình của tôi có thật sự mở đúng cổng serial không". Nhìn thẳng, không đoán.

## 5. File descriptor

Khi tiến trình mở file, nhân trả về một số nguyên — **file descriptor (fd)**.

```
   0 = stdin      1 = stdout      2 = stderr
   3, 4, 5... = các file/thiết bị/socket bạn mở
```

```cpp
int fd = open("/dev/i2c-1", O_RDWR);   // bài 22 sẽ dùng đúng dòng này
```

Số `3` đó là toàn bộ "tay cầm" của bạn vào cảm biến. **Mỗi tiến trình có giới hạn số fd** (thường 1024); quên `close()` trong vòng lặp là hết fd và chương trình chết sau vài giờ — một kiểu rò rỉ không phải bộ nhớ.

Vì sao `2>/dev/null` chuyển hướng lỗi: nó nói "fd số 2, ghi vào hố đen".

## 6. Tín hiệu — và vì sao phải bắt SIGTERM

Tín hiệu là cách hệ điều hành gõ cửa tiến trình.

| Tín hiệu | Ai gửi | Bắt được? |
|---|---|---|
| `SIGTERM` (15) | `systemctl stop`, `kill` | **Có** — "làm ơn dừng cho tử tế" |
| `SIGINT` (2) | Ctrl+C | Có |
| `SIGKILL` (9) | `kill -9` | **KHÔNG** — chết ngay, không kịp dọn |
| `SIGHUP` (1) | mất terminal | Có — thường dùng để nạp lại cấu hình |

```python
import signal, sys

def tat_cho_tu_te(signum, frame):
    logger.info("nhan tin hieu %s, dang don dep", signum)
    led.off()
    cong.close()
    sys.exit(0)

signal.signal(signal.SIGTERM, tat_cho_tu_te)
signal.signal(signal.SIGINT, tat_cho_tu_te)
```

Vì sao bắt buộc với lộ trình này: `systemctl stop` gửi `SIGTERM`. Không bắt thì tiến trình chết đột ngột — **LED còn sáng, relay còn đóng, cổng serial còn khoá**. Với thiết bị vật lý, "chết đột ngột" có hậu quả vật lý.

## 7. Exit code

```bash
./ct; echo $?      # 0 = thành công, khác 0 = lỗi
```

systemd dùng exit code để quyết định có khởi động lại không (bài 19). Trả về 0 khi thực ra đã hỏng thì systemd tưởng bạn kết thúc bình thường và **không** khởi động lại.

## 8. Công cụ soi

| Lệnh | Dùng khi |
|---|---|
| `ps aux` | Xem toàn bộ tiến trình |
| `top` / `htop` | Cái gì đang ăn CPU/RAM |
| `lsof /dev/ttyUSB0` | **Ai đang giữ thiết bị này** |
| `strace -e trace=openat,read,write ./ct` | **Chương trình thật sự gọi gì xuống nhân** |
| `dmesg -w` | Nhân nói gì khi bạn cắm/rút thiết bị |

Hai dòng cuối đáng thử ngay trong bài. `strace` cho bạn thấy chương trình *thật sự* làm gì, không phải cái bạn nghĩ nó làm — nó giải quyết được những ca bí hiểm nhất. `dmesg -w` rồi cắm USB vào là thấy nhân nhận diện thiết bị theo thời gian thực.
