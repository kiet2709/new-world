# Bài 14 — Tiếp quản một hệ thống đang chạy
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: CHỈ ĐỌC**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** đây là kỹ năng mà một dự án cá nhân bình thường **không bao giờ dạy được** — bước vào hệ thống của người khác đang chạy, hiểu nó, mà không làm hỏng gì. Cái Pi của bạn tình cờ là một hệ thống như thế. Tận dụng.

**Luật của bài này: mọi lệnh phải là lệnh ĐỌC.** Không `install`, không `enable`, không sửa file cấu hình. Tự ép mình giữ kỷ luật đó chính là bài học.

**Làm gì:**
```bash
systemctl list-units --type=service --state=running   # cái gì đang chạy
systemctl cat <service>                                # nó được định nghĩa thế nào
ss -tulpn                                              # cổng nào bị chiếm, bởi ai
docker ps -a                                           # có container không
crontab -l; ls -la /etc/cron.d/                        # có job định kỳ không
df -h; free -h; vcgencmd measure_temp                  # đĩa, RAM, nhiệt
journalctl -u <service> --since "24 hours ago"         # nó có đang lỗi âm thầm không
ls -la /dev/i2c* /dev/tty* /dev/video*                 # thiết bị nào đang có
```

**Rồi sao lưu:** tạo ảnh toàn bộ thẻ SD (Win32DiskImager, hoặc `dd` trong WSL). Kiểm chứng ảnh đọc được.

**Xong khi:** có `docs/pi-hien-trang.md` — tài liệu bàn giao: service nào chạy, chiếm cổng nào, dùng thiết bị nào, còn bao nhiêu tài nguyên, rủi ro gì nếu cài thêm. Viết như thể sắp bàn giao cho người khác.

**Và một ảnh sao lưu đã kiểm chứng.** Có nó rồi thì mọi sai lầm về sau đều lùi được.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b14: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
