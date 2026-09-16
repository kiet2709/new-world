# Bài 56 — WPF và XAML từ số 0
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)
> **Nhãn: ĐỆM**

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

*Bài đệm. Desktop khác web ở chỗ căn bản, và XAML lạ mắt với người quen HTML.*

**Lý thuyết:** **XAML là gì** — mô tả giao diện bằng đánh dấu, đối chiếu với HTML bạn đã biết · hệ thống layout (`Grid`, `StackPanel`, `DockPanel`) so với flexbox/grid của CSS · **data binding và `DataContext`** — trái tim của WPF · `INotifyPropertyChanged` · **MVVM ở mức tối thiểu** (đừng đào sâu, chỉ cần đủ dùng) · vòng lặp sự kiện giao diện và vì sao **không được chặn nó**.

**Làm gì:** `dotnet new wpf` → cửa sổ đầu tiên · layout với `Grid` · binding một property vào `TextBlock`, đổi property → giao diện tự đổi · `ObservableCollection` cho danh sách · nút bấm gọi lệnh · **cố tình chặn luồng UI bằng `Thread.Sleep`** để thấy app đơ, rồi sửa bằng `async`.

**Xong khi:** binding chạy đúng mà không gọi tay hàm cập nhật nào; giải thích được vì sao chặn luồng UI làm app đơ và `async` sửa nó thế nào.

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b56: <việc đã làm>"`
- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra thì chưa xong

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
