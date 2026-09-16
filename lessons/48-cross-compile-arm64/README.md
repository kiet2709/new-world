# Bài 48 — Cross-compile sang arm64
> KHỐI 4 — C++ vào cuộc  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** không cài compiler lên thiết bị production. Build ở nơi mạnh, chạy ở nơi nhỏ.

**Làm gì:** CMake toolchain file cho `aarch64-linux-gnu` → build trong container trên PC → copy binary sang Pi → chạy.

**Xong khi:** binary build trên Windows/Docker chạy được trên Pi, và trên Pi **không có** gcc/cmake nào cả. Hiểu `ldd` báo gì khi thiếu thư viện, và vì sao static link đôi khi đáng giá.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b48: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
