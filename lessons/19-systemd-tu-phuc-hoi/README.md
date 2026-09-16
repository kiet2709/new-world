# Bài 19 — systemd: dịch vụ tự phục hồi
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** biến script bài 18 thành service — `Restart=always`, `RestartSec`, `After=network.target`, log qua `journalctl`, thử `WatchdogSec`.

**Xong khi:** `kill -9` tiến trình → vài giây sau tự sống lại. Reboot Pi → tự chạy. `journalctl -u <service> -f` thấy log.

Đây là lần đầu bạn chạm vào **vận hành** — thứ khách hàng thật quan tâm hơn cả tính năng.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b19: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
