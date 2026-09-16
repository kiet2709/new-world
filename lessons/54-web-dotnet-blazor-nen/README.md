# Bài 54 — Web .NET từ số 0: ASP.NET Core và Blazor
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Bài đệm quan trọng nhất của khối. **Bạn chưa từng biết Blazor**, nên bài này chỉ để hiểu nó, chưa xây HMI thật.*

**Lý thuyết:**
- ASP.NET Core xử lý một request thế nào · **middleware pipeline** · routing
- **Razor** — cú pháp trộn C# vào HTML. Đối chiếu thẳng với PHP trộn vào HTML mà bạn đã quen
- **Component** là gì, khác một trang PHP chỗ nào
- **Blazor Server vs Blazor WebAssembly** — và vì sao HMI của chúng ta chọn **Server** (state nằm trên máy chủ, gần dữ liệu thiết bị, tải trang nhẹ, phù hợp mạng nội bộ nhà máy)
- Vòng đời component, binding một chiều và hai chiều

**Làm gì:** `dotnet new blazor` → đọc từng file sinh ra, hiểu file nào làm gì · viết vài component nhỏ: hiển thị danh sách, nhận input, truyền tham số cha–con · binding · gọi một service từ DI vào component · cập nhật giao diện khi dữ liệu đổi.

**Xong khi:** giải thích được **Blazor Server giữ kết nối SignalR và render ở đâu**; viết được một component từ đầu không copy mẫu.

**Đối chiếu bắt buộc viết vào nhật ký:** một trang PHP và một component Blazor — cái gì tương đương, cái gì khác hẳn về mô hình.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b54: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
