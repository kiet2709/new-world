# Lý thuyết — Bài 15: Dựng Pi học từ đầu (thẻ mới)

## 1. Vì sao bản Lite, không desktop

Raspberry Pi OS Lite không có giao diện đồ hoạ. Nghe như thiếu thốn, thực ra là đúng:

- **Giao diện ăn RAM và CPU** mà bạn cần cho AI ở Khối 3
- **Thiết bị edge thật không có màn hình.** Tập đúng cách nó sẽ được vận hành
- Ít gói cài sẵn = ít bề mặt tấn công, ít thứ hỏng

Mọi thứ qua SSH. Sau một tuần bạn sẽ thấy nó nhanh hơn dùng chuột.

## 2. Cấu hình trước khi cắm điện lần đầu

Raspberry Pi Imager cho phép đặt sẵn (nút bánh răng): hostname, user/password, **SSH + khoá công khai**, WiFi, múi giờ. Làm hết ở đây thì Pi bật lên là SSH vào được ngay, không cần màn hình.

**Đặt hostname khác hẳn Pi production.** Ví dụ `pi-hoc`. Nghe nhỏ nhặt nhưng nó là thứ chặn bạn gõ nhầm lệnh vào máy thật lúc 11 giờ đêm.

## 3. SSH key — vì sao an toàn hơn mật khẩu

```
   Máy bạn                          Pi
   ┌──────────────┐                 ┌──────────────────────┐
   │ khoá riêng   │  ←── ký ──→     │ khoá công khai       │
   │ (KHÔNG BAO   │                 │ ~/.ssh/authorized_keys│
   │  GIỜ gửi đi) │                 └──────────────────────┘
   └──────────────┘
```

Khoá riêng **không bao giờ rời máy bạn**. Máy chủ gửi một thử thách, bạn ký bằng khoá riêng, máy chủ kiểm bằng khoá công khai. Không có bí mật nào đi qua đường truyền — nên nghe lén cũng vô ích, và không có gì để đoán mò.

```bash
ssh-keygen -t ed25519 -C "may-windows"     # ed25519: ngắn, nhanh, mạnh
ssh-copy-id pi@pi-hoc                       # chép khoá công khai lên Pi
```

Rồi tắt đăng nhập mật khẩu trong `/etc/ssh/sshd_config`:

```
PasswordAuthentication no
PermitRootLogin no
```

> **Trước khi restart sshd, MỞ SẴN một phiên SSH thứ hai.** Nếu cấu hình sai, phiên đang mở là đường cứu duy nhất. Đây là bài học kinh điển, và người nào cũng học nó đúng một lần bằng cách đau đớn.

`~/.ssh/config` để gõ cho nhanh:

```
Host pihoc
    HostName 192.168.1.50
    User pi
    IdentityFile ~/.ssh/id_ed25519
```

Từ đó chỉ cần `ssh pihoc`.

## 4. User, group, permission

```
   -rw-r--r--  1 pi  pi   1234  file.txt
   │└┬┘└┬┘└┬┘     │   │
   │ │  │  └── others (người khác)
   │ │  └───── group
   │ └──────── owner (chủ)
   └────────── loại: - file, d thư mục, c thiết bị ký tự, b thiết bị khối
```

`r`=4, `w`=2, `x`=1 → `chmod 644` là chủ đọc-ghi, còn lại chỉ đọc.

**Với thư mục, `x` nghĩa là "được đi vào"**, không phải "chạy được". Thư mục không có `x` thì không `cd` vào được dù có `r`.

### Group là chỗ hay gây "Permission denied" khó hiểu

```bash
ls -l /dev/i2c-1
# crw-rw---- 1 root i2c 89, 1 ... /dev/i2c-1
#            └owner └group
```

File này thuộc group `i2c`. User của bạn **không** trong group đó → không đọc được, dù `sudo` thì được.

```bash
sudo usermod -aG i2c,gpio,dialout,video $USER
# rồi ĐĂNG XUẤT VÀ VÀO LẠI — group chỉ áp dụng cho phiên mới
groups        # kiểm tra
```

Dòng "đăng xuất và vào lại" là chỗ người ta mất hàng giờ. Group được gán lúc đăng nhập; thêm group xong mà vẫn ở phiên cũ thì chưa có hiệu lực.

| Group | Cho phép |
|---|---|
| `i2c` | `/dev/i2c-*` |
| `gpio` | chân GPIO |
| `dialout` | cổng serial `/dev/ttyUSB*`, `/dev/ttyACM*` |
| `video` | camera `/dev/video*` |
| `docker` | **chạy Docker không cần sudo — tương đương quyền root, cấp có cân nhắc** |

## 5. Vì sao không chạy mọi thứ bằng root

Ba lý do thật:

1. **Một bug thành thảm hoạ.** Script sai đường dẫn chạy bằng root có thể xoá hệ thống.
2. **Bị chiếm là mất cả máy.** Dịch vụ mạng chạy bằng root, có lỗ hổng → kẻ tấn công có root.
3. **Nó giấu lỗi cấu hình.** Chạy root thì mọi thứ "chạy được", và bạn không bao giờ phát hiện là mình cấp quyền sai — cho tới khi triển khai thật.

Cách đúng: user thường + đúng group. Nếu phải sudo mới chạy được, đó là tín hiệu **thiếu group**, không phải tín hiệu cần sudo.

## 6. Bật giao diện phần cứng

```bash
sudo raspi-config     # Interface Options → I2C, SPI, Serial, Camera
```

Hoặc sửa thẳng `/boot/firmware/config.txt`:

```
dtparam=i2c_arm=on
dtparam=spi=on
```

Cần khởi động lại. Sau đó `/dev/i2c-1` xuất hiện — đó là thứ bài 18 sẽ dùng.
