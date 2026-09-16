# Bài 01 — Docker: vì sao container tồn tại
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** máy ảo khác container chỗ nào · image khác container chỗ nào · vòng đời một container · vì sao "chạy được trên máy tôi" là một vấn đề có thật.

**Làm gì:** sống với container chứ chưa build gì cả.
- `docker run` một image có sẵn (`alpine`, `python:3.12-slim`) — chạy một lệnh rồi container tự chết. Vì sao nó chết?
- `docker run -it` — vào trong, ngó nghiêng, `exit`. Container còn sống không?
- `docker ps` vs `docker ps -a` — khác nhau chỗ nào, và điều đó nói gì về vòng đời?
- `docker exec`, `docker logs`, `docker stop`, `docker rm`.
- Tạo file trong container rồi `rm` container → tạo lại → file còn không?

**Xong khi:** giải thích được bằng lời — container khác máy ảo chỗ nào, một image đẻ ra được mấy container, và **cái gì mất khi container chết**.

**Bẫy:** đừng đụng Dockerfile ở bài này. Chưa tới lượt.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b01: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
