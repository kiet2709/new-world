# Bài 52 — .NET và hệ sinh thái: công cụ để làm app thật
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Biết ngôn ngữ chưa đủ để làm ứng dụng. Bài này là phần "xung quanh" mà mọi dự án .NET thật đều có.*

**Lý thuyết:** solution và project khác nhau thế nào · NuGet · **dependency injection** và vì sao .NET dựa vào nó · cấu hình theo môi trường (`appsettings.json`) · `ILogger`.

**Làm gì:**
- `dotnet new sln`, thêm nhiều project, tham chiếu chéo — tất cả bằng CLI
- Thêm gói NuGet (MQTTnet, NModbus) và hiểu file `.csproj`
- **DI container**: đăng ký service, inject qua constructor, hiểu vòng đời singleton/scoped/transient
- `IConfiguration` đọc `appsettings.json` + biến môi trường, **không hardcode**
- `ILogger` — nối tiếp thói quen logging từ bài 09
- `dotnet test` với xUnit

**Xong khi:** dựng được một solution nhiều project, chạy bằng CLI, có test, có cấu hình theo môi trường, không có chuỗi kết nối nào nằm trong code.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b52: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
