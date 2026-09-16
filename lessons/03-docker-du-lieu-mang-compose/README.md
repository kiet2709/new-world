# Bài 03 — Docker: dữ liệu, mạng, và compose
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** filesystem của container là tạm · bind mount khác volume · network bridge và DNS theo tên service · compose là gì và `profiles` để làm gì.

**Làm gì:**
- Bind mount **cả hai chiều**: tạo file trên Windows → tìm trong container. Tạo trong container → tìm trên Windows.
- `docker compose down` rồi `up` — file trong `/work` còn không? File trong volume `py-cache` còn không? Vì sao khác nhau?
- `.\dev.ps1 nuke` — giờ cái gì mất?
- Mạng: từ container `py` ping container `cpp` **bằng tên**. Vì sao gọi được bằng tên mà không cần IP?
- Đọc `docker-compose.yml` của repo, giải thích từng khối cho chính mình.

**Xong khi:** vẽ được bảng "dữ liệu nào sống sót qua `down` / qua `nuke` / qua `docker rm`", và trả lời không do dự: mất điện máy tính thì mất gì?

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b03: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
