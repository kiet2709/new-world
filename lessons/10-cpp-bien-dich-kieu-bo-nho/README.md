# Bài 10 — C++: mô hình biên dịch, kiểu, bộ nhớ
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Bài đệm. C++ không khó vì cú pháp — khó vì nó bắt bạn nghĩ về những thứ Python giấu đi. Bài này bày hết ra.*

**Lý thuyết:** **tiền xử lý → biên dịch → liên kết**, và lỗi ở mỗi bước trông khác nhau thế nào (lỗi linker "undefined reference" là gì) · header và source tách làm gì · include guard · **stack và heap** · con trỏ và tham chiếu · **vì sao C++ không dọn bộ nhớ hộ bạn**.

**Làm gì:**
- Hello world tách `.h` / `.cpp`, biên dịch bằng tay từng bước để **thấy** ba giai đoạn
- Cố tình gây lỗi linker rồi đọc hiểu thông báo
- Các kiểu số, `int` tràn số, `size_t`, và vì sao `auto` hữu ích
- Con trỏ, tham chiếu, `nullptr` — vẽ ra giấy cái nào trỏ vào đâu
- Mảng C vs `std::vector`
- Truyền theo giá trị / tham chiếu / con trỏ — **đo chi phí sao chép** với một object lớn
- **Cố tình gây memory leak rồi bắt bằng `valgrind`**

**Xong khi:** đọc được thông báo lỗi của compiler và linker mà không hoảng; giải thích được stack khác heap chỗ nào và biến của bạn nằm ở đâu.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b10: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
