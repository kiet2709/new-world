# Lý thuyết — Bài 19: systemd và dịch vụ tự phục hồi

> Đây là lần đầu bạn chạm vào **vận hành** — thứ khách hàng thật quan tâm hơn cả tính năng. Một hệ thống chạy 99% thời gian mà không ai phải sờ vào thì quý hơn một hệ thống nhiều tính năng mà tuần nào cũng phải khởi động lại bằng tay.

## 1. systemd là gì

Là tiến trình đầu tiên Linux khởi động (PID 1), và là thứ quản lý mọi dịch vụ khác: khởi động theo đúng thứ tự, theo dõi, khởi động lại khi chết, thu log.

Bạn cần nó vì: chạy `python doc_cam_bien.py &` rồi đóng SSH là **chương trình chết theo**. Và mất điện bật lại thì chẳng có gì tự chạy.

## 2. Unit file

```ini
# /etc/systemd/system/doc-cam-bien.service
[Unit]
Description=Doc cam bien nhiet do va gui MQTT
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=pi
Group=i2c
WorkingDirectory=/home/pi/new_world
ExecStart=/usr/bin/python3 /home/pi/new_world/doc_cam_bien.py
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

| Dòng | Ý nghĩa |
|---|---|
| `After=` | Khởi động **sau** thứ này (chỉ là thứ tự) |
| `Wants=` | **Cần** thứ này chạy (yếu hơn `Requires=`) |
| `Type=simple` | Tiến trình chạy ở tiền cảnh, không tự fork |
| `User=`/`Group=` | **Chạy bằng quyền tối thiểu** — không root |
| `Restart=always` | Chết là dựng lại, bất kể lý do |
| `RestartSec=5` | Chờ 5 giây, tránh quay vòng điên cuồng |
| `WantedBy=multi-user.target` | Tự chạy khi máy boot |

Hai dòng `User=`/`Group=` là chỗ bài 15 trả lãi: dịch vụ chạy bằng user thường, có group `i2c` để đọc được cảm biến. Không cần root.

## 3. Lệnh

```bash
sudo systemctl daemon-reload            # BẮT BUỘC sau khi sửa unit file
sudo systemctl enable --now doc-cam-bien
sudo systemctl status doc-cam-bien
sudo systemctl restart doc-cam-bien
journalctl -u doc-cam-bien -f            # log theo thời gian thực
journalctl -u doc-cam-bien --since "1 hour ago"
```

Quên `daemon-reload` là lỗi phổ biến nhất — bạn sửa file mà systemd vẫn dùng bản cũ, rồi ngồi thắc mắc.

## 4. `Restart=` — chọn cho đúng

| Giá trị | Khởi động lại khi |
|---|---|
| `no` | Không bao giờ |
| `on-failure` | Chỉ khi exit code khác 0, hoặc bị tín hiệu giết |
| `always` | **Luôn luôn**, kể cả khi thoát sạch với code 0 |

Cho dịch vụ đọc cảm biến chạy mãi: `always`. Cho tác vụ chạy một lần rồi xong: `on-failure`.

Đây là chỗ exit code ở bài 16 có giá trị. Chương trình gặp lỗi mà `exit(0)` thì `on-failure` sẽ **không** dựng lại — systemd tưởng bạn xong việc.

### Chống quay vòng

```ini
StartLimitBurst=5
StartLimitIntervalSec=60
```

Chết 5 lần trong 60 giây thì systemd **bỏ cuộc**. Đây là tính năng, không phải lỗi — nó chặn việc một dịch vụ hỏng vĩnh viễn quay vòng ăn hết CPU. Gặp trạng thái này thì phải đọc log và sửa gốc, không phải cứ `restart` mãi.

## 5. Tắt cho tử tế — nối với bài 16

`systemctl stop` gửi `SIGTERM`, chờ `TimeoutStopSec` (mặc định 90 giây), rồi mới `SIGKILL`.

Nên tín hiệu bạn bắt ở bài 16 chính là thứ được dùng ở đây. Không bắt → tiến trình bị giết cứng → **LED còn sáng, relay còn đóng**.

## 6. Watchdog

```ini
WatchdogSec=30
```

Dịch vụ phải "báo còn sống" cho systemd mỗi 30 giây; im lặng là bị coi như treo và bị khởi động lại.

```python
from systemd import daemon
daemon.notify("WATCHDOG=1")      # gọi định kỳ trong vòng lặp chính
```

Khác biệt quan trọng: `Restart=always` xử lý **tiến trình chết**. Watchdog xử lý **tiến trình còn sống nhưng đã treo** — vòng lặp kẹt, deadlock, chờ mãi một cổng serial không bao giờ trả lời. Loại thứ hai khó phát hiện hơn nhiều và gây hại lâu hơn.

Ở bài 59 bạn sẽ dựng watchdog nhiều tầng: systemd cho dịch vụ, watchdog phần cứng cho cả Pi, task watchdog cho ESP32.

## 7. Nghiệm thu — phải thử thật

1. `kill -9 <pid>` → vài giây sau tự sống lại
2. `sudo reboot` → tự chạy khi máy lên
3. `journalctl -u ... -f` → thấy log
4. `systemctl stop` → tắt sạch, LED tắt, cổng đóng

Đừng chỉ đọc `status` thấy `active (running)` rồi kết luận. **Phá nó và xem nó dựng lại.** Đây là lần đầu tiêu chí nghiệm thu của bạn là "nó sống sót qua cái gì", và cách nghĩ đó sẽ theo bạn tới hết Khối 6.
