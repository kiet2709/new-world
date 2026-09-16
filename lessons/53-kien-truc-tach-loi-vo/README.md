# Bài 53 — Kiến trúc ứng dụng: tách lõi khỏi vỏ
> KHỐI 5 — Viết ứng dụng thật: C#  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Đây mới là "viết ứng dụng" theo nghĩa nhà tuyển dụng hiểu.** Không phải làm ra một cửa sổ có nút bấm — mà là tách được phần lõi ra khỏi phần hiển thị.

Và đây là lần đầu bạn tự tay làm **nguyên tắc 4 của la bàn** ("tách lõi khỏi vỏ") với code của chính mình, chứ không phải với công cụ của người khác.

```
        ┌────────────────────┐   ┌────────────────────┐
        │  Blazor web HMI    │   │  WPF desktop app   │
        └─────────┬──────────┘   └─────────┬──────────┘
                  └───────────┬────────────┘
                     ┌────────▼─────────┐
                     │  Core library    │  ← C#, dùng chung
                     │  MQTT · Modbus   │
                     │  · model dữ liệu │
                     └──────────────────┘
```

**Làm gì:** class library chứa model dữ liệu + client MQTT + client Modbus · **cấu hình theo môi trường** (không hardcode) · **logging có cấu trúc** · vòng đời: khởi động, tắt êm, xử lý lỗi kết nối · viết test cho core mà **không cần UI nào**.

**Xong khi:** core library chạy được và test được **hoàn toàn không có giao diện**. Nếu phải sửa UI mới test được core thì bạn chưa tách xong.

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b53: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
