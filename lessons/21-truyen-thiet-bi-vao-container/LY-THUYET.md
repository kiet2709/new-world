# Lý thuyết — Bài 21: Truyền thiết bị vật lý vào container

> Đây là chỗ Docker gặp phần cứng — case Docker "sát nhúng" nhất, và là thứ dân web gần như không bao giờ đụng.

## 1. Vì sao container không thấy thiết bị

Container bị cô lập bằng **namespace** (bài 01). Namespace thiết bị của nó gần như rỗng — chỉ có vài thứ cơ bản như `/dev/null`, `/dev/zero`. `/dev/i2c-1` **không có ở đó**.

Đây là chủ ý: một container tuỳ tiện không nên chạm được vào phần cứng.

## 2. Ba cách, từ tệ tới tốt

### `--privileged` — đừng dùng

```bash
docker run --privileged ...
```

Nó bỏ gần như **toàn bộ** cô lập: container thấy mọi thiết bị, có mọi capability của nhân, mount được hệ thống file chủ.

**Nó chạy được. Đó là lý do nó nguy hiểm** — bạn gõ nó một lần cho xong việc, rồi nó nằm lại trong `docker-compose.yml` mãi mãi.

Với container privileged, thoát ra chiếm quyền root trên máy chủ là chuyện đã được chứng minh nhiều lần. Trên một thiết bị nằm trong mạng nhà máy thì đó là lối vào.

Cứ thử nó trong bài **để thấy nó chạy**, rồi bỏ đi và làm cách đúng. Biết cái tệ trông thế nào cũng là kiến thức.

### `--device` — cách đúng

```bash
docker run --device=/dev/i2c-1 ...
```

Chỉ đưa **đúng một thiết bị** vào. Mọi thứ khác vẫn bị chặn.

```yaml
services:
  gateway:
    devices:
      - /dev/i2c-1:/dev/i2c-1
      - /dev/ttyUSB0:/dev/ttyUSB0
      - /dev/video0:/dev/video0
```

### Capability — khi cần quyền chứ không cần thiết bị

```yaml
cap_add:
  - SYS_RAWIO
```

Nhân Linux chia quyền của root thành khoảng 40 **capability** riêng lẻ. `--privileged` cấp hết; `cap_add` cấp đúng cái cần.

## 3. Quyền bên trong container

Đưa được thiết bị vào chưa đủ — vẫn có thể `Permission denied`. Vì quyền trên file thiết bị vẫn áp dụng, và **user trong container là một user khác**.

```bash
ls -l /dev/i2c-1
# crw-rw---- 1 root i2c 89, 1
```

Cần user trong container thuộc group **có cùng GID** với group `i2c` trên máy chủ.

```bash
getent group i2c        # i2c:x:993:pi   ← GID là 993
```

```yaml
group_add:
  - "993"        # dùng GID dạng số, không dùng tên
```

**Vì sao dùng số:** tên group được phân giải **bên trong** container. Image `python:3.12-slim` không có group tên `i2c`, nên tên vô nghĩa ở đó. GID thì là con số nhân Linux dùng, giống nhau ở cả hai phía.

Đây là một trong những lỗi tốn thời gian nhất khi chạy phần cứng trong container, và biết trước thì tránh được cả buổi chiều.

## 4. Thiết bị đổi tên — vấn đề có thật

`/dev/ttyUSB0` **không cố định**. Cắm lại theo thứ tự khác, hoặc thêm một thiết bị USB thứ hai, là nó thành `ttyUSB1`. Container cấu hình cứng `ttyUSB0` sẽ hỏng.

Giải pháp: **udev rule** tạo tên cố định dựa trên đặc điểm thiết bị.

```bash
udevadm info -a -n /dev/ttyUSB0 | grep -E "idVendor|idProduct|serial"
```

```
# /etc/udev/rules.d/99-modbus.rules
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", SYMLINK+="modbus0"
```

Giờ luôn có `/dev/modbus0` trỏ đúng thiết bị đó, bất kể thứ tự cắm.

```yaml
devices:
  - /dev/modbus0:/dev/modbus0
```

Đây là chi tiết nhỏ nhưng nó là dấu hiệu rõ ràng của người đã triển khai thật — hệ thống nào cắm nhiều hơn một thiết bị USB đều cần nó.

## 5. Tranh chấp thiết bị

Hai tiến trình cùng mở `/dev/ttyUSB0` thì **cả hai đều đọc được, và cả hai đều nhận dữ liệu rách**. Serial không có cơ chế khoá.

```bash
sudo lsof /dev/ttyUSB0      # ai đang giữ
sudo fuser -v /dev/ttyUSB0
```

Nếu Pi đang chạy dịch vụ cũ dùng cổng đó (bài 14 đã kiểm kê), bạn phải quyết: dừng cái cũ, hay dùng cổng khác. **Không có cách nào để hai bên dùng chung êm thấm.**

## 6. GPIO trong container

GPIO hiện đại đi qua `/dev/gpiochip0` (giao diện `libgpiod`), không phải `/sys/class/gpio` cũ.

```yaml
devices:
  - /dev/gpiochip0:/dev/gpiochip0
group_add:
  - "997"       # GID của group gpio, kiểm bằng getent group gpio
```

Tài liệu cũ trên mạng hay bảo mount cả `/sys` — **đừng**, đó là cách cũ đã lỗi thời và cấp quyền rộng không cần thiết.

## 7. Nghiệm thu

Container đọc được cảm biến thật **không cần `--privileged`**, và trong nhật ký bạn viết được ba câu:

1. Vì sao `--privileged` là nợ bảo mật
2. Vì sao `group_add` phải dùng GID số
3. Chuyện gì xảy ra nếu hai tiến trình cùng mở một cổng serial
