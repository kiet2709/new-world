# Bài 08 — Python: cốt lõi
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Bài đệm. Bạn đã viết Python nhưng chủ yếu bằng AI. Bài này lấp lại nền để đọc code Python lạ mà không phải đoán.*

**Lý thuyết:** Python chạy thế nào (thông dịch qua bytecode, và vì sao nó chậm hơn C++) · **mutable và immutable** · biến là **nhãn dán vào object**, không phải cái hộp · list/dict/set/tuple khác nhau chỗ nào và khi nào dùng cái nào.

**Làm gì:**
- Kiểu dữ liệu, chuỗi và f-string · `list` / `dict` / `set` / `tuple` thao tác thật
- **Comprehension** — viết được và đọc được
- Hàm: tham số mặc định, `*args`/`**kwargs`, và **cái bẫy mutable default argument**
- `a = b = [1,2]` rồi sửa `a` → `b` đổi theo. Vì sao? Đây là gốc của rất nhiều bug im lặng
- `copy` vs `deepcopy`
- Module, package, `import` — và vì sao `if __name__ == "__main__"` tồn tại
- `venv` và `pip`: vì sao trong container vẫn cần hiểu chúng

**Xong khi:** giải thích được vì sao `def f(x, lst=[])` là bug; đọc một file Python lạ mà không phải tra cú pháp từng dòng.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b08: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
