# Bài 15 — Dựng Pi học từ đầu (thẻ mới)
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** flash OS (bản Lite, không desktop) → SSH bằng **key**, tắt đăng nhập mật khẩu → hiểu group `dialout` / `i2c` / `gpio` / `video`, và vì sao thiếu group thì "Permission denied" dù `sudo` vẫn chạy được.

**Xong khi:** đăng nhập không cần mật khẩu; user thường (không sudo) đọc được `/dev/i2c-1`; giải thích được vì sao **không nên** chạy mọi thứ bằng root.

**Bẫy:** đừng cài desktop lên Pi. Mọi thứ qua SSH — đó là cách edge thật vận hành.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b15: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
