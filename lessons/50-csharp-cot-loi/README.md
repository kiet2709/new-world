# Bài 50 — C# cốt lõi cho người đã biết PHP
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Bài đệm. Bạn có nền OOP từ PHP nên đi nhanh được — nhưng **không bỏ qua**. Lao thẳng vào Blazor khi chưa nắm C# là công thức tạo vibe code.*

**Lý thuyết:** **kiểu tĩnh đổi cách bạn viết thế nào** (compiler bắt lỗi thay vì runtime) · `class` vs `struct` vs `record` · `interface` và vì sao C# dựa vào nó nhiều hơn PHP · property so với getter/setter · `enum` · **nullable reference types** — thứ PHP không có và nó cứu bạn khỏi cả một lớp bug.

**Làm gì:**
- `dotnet new console` bằng **CLI**, không click chuột trong Visual Studio
- Kiểu, biến, `var`, chuyển kiểu
- Class, property, constructor, kế thừa, `interface`, `abstract`
- Generic ở mức dùng: `List<T>`, `Dictionary<K,V>`
- **Bảng đối chiếu PHP ↔ C#** viết vào nhật ký: cái gì giống, cái gì khác, cái gì PHP không có

**Xong khi:** đọc được code C# lạ mà không tra cú pháp liên tục; nói được ba thứ kiểu tĩnh bắt được mà PHP để lọt tới lúc chạy.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b50: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
