# Bài 60 — Bảo mật tối thiểu
> KHỐI 6 — Chịu lỗi, CI, giao hàng  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** vì sao mặc định của mọi thứ trong lộ trình này đều **không an toàn** (Mosquitto `allow_anonymous true`, Postgres mật khẩu `nw`, Grafana `admin/admin`) — có chủ ý, để giờ bạn thấy rõ sự khác biệt.

**Làm gì:** bật xác thực MQTT (user/password), rồi **TLS** với chứng chỉ tự ký · đổi mật khẩu DB, không để trong Git · quản lý secret theo môi trường · nguyên tắc đặc quyền tối thiểu: service nào cần quyền gì · rà lại `--privileged` và cổng đang phơi ra ngoài.

**Xong khi:** không còn mật khẩu nào trong Git; MQTT từ chối client không có chứng chỉ; giải thích được ba rủi ro lớn nhất còn lại của hệ thống bạn.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b60: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
