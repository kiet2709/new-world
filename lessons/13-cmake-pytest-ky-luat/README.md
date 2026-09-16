# Bài 13 — CMake, pytest, và kỷ luật kỹ thuật
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** vì sao C++ cần build system · biên dịch và liên kết là hai bước khác nhau · `Debug` khác `Release` chỗ nào · test tự động để làm gì khi chỉ có một mình.

**Làm gì:**
- `CMakeLists.txt` cho bài 12: target, `Debug` vs `Release`, build ra `build/`.
- Đo lại bản `Release` (`-O2`) so với `Debug`. Con số sẽ làm bạn bất ngờ.
- pytest cho `analyze.py`: test dòng hỏng, file rỗng, outlier biên.
- `make fmt`, `make lint`, `make test` chạy được.

**Xong khi:** `make test` xanh; cmake build ra binary; hiểu vì sao **đo hiệu năng trên bản Debug là vô nghĩa**.

> **PHÉP THỬ TẮT AI #1** — tắt AI, dựng lại từ đầu một repo Git nháp: init, 2 nhánh, 1 conflict, giải, tag. Không nhìn ghi chép.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b13: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
