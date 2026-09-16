# Bài 09 — Python: đủ dùng cho hệ thống thật
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** exception và triết lý EAFP (*xin lỗi dễ hơn xin phép*) · context manager · **iterator/generator và vì sao "lười" lại quan trọng** khi xử lý luồng dữ liệu không có điểm dừng · type hint để làm gì khi Python không ép kiểu.

**Làm gì:**
- `try`/`except`/`else`/`finally` đúng cách · **đừng bao giờ `except:` trần** · tự định nghĩa exception
- `with` và **tự viết một context manager** (mở/đóng cổng serial chẳng hạn)
- **Generator** đọc file 1GB mà không nạp hết vào RAM — so RAM đỉnh với cách đọc thường
- `dataclass`
- Type hint + `ruff` bắt lỗi
- **`logging` thay cho `print`** — mức log, handler, format. Từ bài này trở đi không dùng `print` trong code thật nữa

**Xong khi:** viết được generator xử lý luồng cảm biến liên tục; mọi script của bạn dùng `logging`; giải thích được vì sao generator tiết kiệm RAM.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b09: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
