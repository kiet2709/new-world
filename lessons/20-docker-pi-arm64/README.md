# Bài 20 — Docker trên Pi: kiến trúc arm64
> KHỐI 1 — Embedded Linux trên Pi  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Làm gì:** cài Docker trên Pi → build image ngay trên Pi (chậm, để thấy nó chậm) → rồi dùng `docker buildx` trên PC build **multi-arch** (amd64 + arm64), đẩy lên registry.

**Xong khi:** cùng một lệnh `docker run` chạy được cùng một image trên cả PC và Pi. Giải thích được vì sao image amd64 không chạy trên Pi, và QEMU đang làm gì trong buildx.

**Điểm nhấn CV:** multi-arch build là thứ dân web hiếm khi đụng. Ghi lại thời gian build của hai cách.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b20: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
