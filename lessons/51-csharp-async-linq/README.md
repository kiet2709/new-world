# Bài 51 — C#: async, LINQ, và quản lý tài nguyên
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** **`async`/`await` — và nó KHÔNG phải đa luồng** (đây là hiểu lầm phổ biến nhất về C#) · `Task` · LINQ · `IDisposable` và `using` · exception trong C#.

**Làm gì:**
- Chương trình `async` đọc nhiều nguồn cùng lúc, đo thời gian so với đọc tuần tự
- **Cố tình chặn luồng bằng `.Result`** để thấy deadlock — rồi sửa
- LINQ: `Where`, `Select`, `GroupBy`, `OrderBy` trên dữ liệu cảm biến thật
- `IDisposable` + `using` — so sánh với `with` của Python và RAII của C++
- `CancellationToken` — dừng một tác vụ đang chạy cho tử tế

**Xong khi:** giải thích được `async/await` thật ra làm gì; viết được vòng lặp đọc dữ liệu có thể huỷ giữa chừng.

**Ba ngôn ngữ, một khái niệm:** giải phóng tài nguyên — C++ dùng **destructor/RAII**, Python dùng **`with`**, C# dùng **`using`/`IDisposable`**. Viết so sánh ba cái vào nhật ký. Đây là lúc học song song sinh giá trị thật.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b51: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
