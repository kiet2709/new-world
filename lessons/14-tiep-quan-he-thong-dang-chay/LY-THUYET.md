# Lý thuyết — Bài 14: Tiếp quản một hệ thống đang chạy

> Bài này có mặt vì một lý do thẳng thắn: **55 bài còn lại cho bạn năng lực, không cho bạn kinh nghiệm.** Một trong những thứ chúng không dạy được là *bước vào hệ thống của người khác đang chạy mà không làm hỏng gì*. Cái Pi của bạn tình cờ đúng là một hệ thống như thế. Đừng bỏ phí.

## 1. Vì sao "chỉ đọc" lại là kỷ luật khó

Bản năng của người kỹ thuật khi thấy hệ thống lạ là **sửa** — gỡ gói thừa, sắp lại cấu hình, cập nhật phiên bản. Trong môi trường OT, đó là bản năng làm hỏng dây chuyền.

Quy tắc ngoài hiện trường: **hiểu trước, chạm sau, và luôn có đường lùi trước khi chạm.**

Bài này ép bạn giữ đúng thứ tự đó, trong điều kiện an toàn (Pi của chính bạn), trước khi gặp nó ở chỗ có tiền bạc và uy tín trên bàn.

## 2. Bốn câu phải trả lời được về bất kỳ hệ thống nào

| Câu hỏi | Lệnh |
|---|---|
| **Cái gì đang chạy?** | `systemctl list-units --type=service --state=running` · `docker ps -a` |
| **Nó chiếm tài nguyên nào?** | `ss -tulpn` (cổng) · `ls -la /dev/...` (thiết bị) |
| **Còn bao nhiêu chỗ trống?** | `df -h` · `free -h` · `vcgencmd measure_temp` |
| **Nó có đang lỗi âm thầm không?** | `journalctl -u <service> --since "24 hours ago"` |

Câu cuối hay bị bỏ qua nhất và thường cho nhiều thông tin nhất. Rất nhiều hệ thống "chạy bình thường" thực ra đang ghi lỗi mỗi phút mà không ai đọc.

## 3. Đọc một unit file systemd

```bash
systemctl cat ten-service
```

Nó in ra định nghĩa đầy đủ. Ba dòng cần nhìn trước:

- `ExecStart=` — thật ra nó chạy **cái gì**, bằng đường dẫn nào
- `User=` — chạy bằng quyền ai (nếu là `root` thì đó là một rủi ro cần ghi lại)
- `Restart=` — nó có tự sống lại không

## 4. Cổng và thiết bị — nguồn xung đột thật

```bash
ss -tulpn
```

`-t` TCP · `-u` UDP · `-l` đang lắng nghe · `-p` tiến trình nào · `-n` số thay vì tên.

Vì sao quan trọng với lộ trình này: bạn sắp cài Mosquitto (1883), Postgres (5432), Grafana (3000). Nếu Pi đang dùng cổng nào trong số đó thì **phải biết trước khi cài**, không phải sau khi hỏng.

Tương tự với thiết bị: nếu một tiến trình đang giữ `/dev/ttyUSB0`, tiến trình thứ hai mở nó sẽ lỗi hoặc đọc được dữ liệu rác.

```bash
sudo lsof /dev/ttyUSB0      # ai đang giữ nó
```

## 5. Docker sửa iptables — cái bẫy ít người biết

Khi cài Docker lên một máy đang chạy, Docker **thêm luật iptables của riêng nó** để làm NAT cho container. Việc này có thể:

- Ghi đè luật tường lửa sẵn có
- Làm cổng của container **phơi ra ngoài** kể cả khi bạn tưởng đã chặn bằng firewall

Nên **chụp lại trạng thái trước khi cài**:

```bash
sudo iptables -S > /tmp/iptables-truoc.txt
```

Bài 20 sẽ cài Docker lên Pi (thẻ mới). Có bản chụp trước là có cái để so.

## 6. Sao lưu ảnh thẻ SD

Đây là phần quan trọng nhất của bài — **lưới an toàn thật**.

- **Windows:** Win32DiskImager → chọn "Read" để đọc từ thẻ ra file `.img`
- **WSL/Linux:** `sudo dd if=/dev/sdX of=pi-backup.img bs=4M status=progress`

Ba điều đừng bỏ qua:

1. **Kiểm chứng ảnh** — kích thước hợp lý, và lý tưởng là ghi thử ra một thẻ khác rồi boot.
2. **Sao lưu lúc Pi đã tắt.** Đọc thẻ của hệ thống đang chạy cho ra ảnh không nhất quán.
3. **Cất ảnh ở chỗ khác**, không phải trên chính cái Pi đó.

> Một bản sao lưu chưa từng được kiểm chứng thì chưa phải bản sao lưu — nó là một niềm tin.

## 7. Đầu ra: tài liệu bàn giao

Viết `docs/pi-hien-trang.md` **như thể sắp giao cho người khác**:

- Danh sách service, mỗi cái làm gì, chạy bằng quyền nào
- Cổng và thiết bị đang bị chiếm
- Tài nguyên còn lại
- **Rủi ro nếu cài thêm** — chỗ nào có thể đụng
- Vị trí bản sao lưu và ngày tạo

Kỹ năng viết được tài liệu này đáng giá hơn bạn nghĩ. Phần lớn kỹ sư mô tả hệ thống bằng lời nói mơ hồ; người viết được ra giấy là người được giao việc khó.
