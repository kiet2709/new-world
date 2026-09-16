# Bài 61 — CI trên GitHub Actions
> KHỐI 6 — Chịu lỗi, CI, giao hàng  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Mục tiêu:** chỗ Git + Docker + CI/CD gặp nhau. Trả luôn phần "cày CI/CD" mà không cần học riêng.

**Làm gì:** mỗi push → chạy pytest + ruff + build C++ → build Docker image **multi-arch** → push lên registry. Tag `v*` → tạo release tự động.

**Xong khi:** badge xanh trên README; một lần push tự ra image chạy được trên Pi mà bạn không làm gì thêm.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b61: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
