# Bài 32 — OPC UA: mặt bắc của gateway
> KHỐI 2 — ESP32-S3 và cây cầu OT  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết:** vì sao OPC UA khác Modbus về **bản chất** — Modbus chỉ có *một con số ở một địa chỉ*; OPC UA có **mô hình thông tin có ngữ nghĩa**: đối tượng, thuộc tính, kiểu dữ liệu, quan hệ. Máy tự mô tả chính nó.

**Làm gì:** Pi dựng **OPC UA server** (`asyncua`) phơi chính các tag đã gom từ Modbus → kết nối bằng client (UaExpert) duyệt address space → hiểu node, NodeId, kiểu dữ liệu → bảo mật cơ bản (chế độ bảo mật, chứng chỉ tự ký).

Đúng cách gateway công nghiệp thật hoạt động: **Modbus đi vào, OPC UA đi ra.**

**Xong khi:** mở UaExpert duyệt được cây thiết bị của bạn và đọc giá trị realtime; giải thích được một tag Modbus "nhiệt độ ở địa chỉ 40001" trở thành cái gì trong mô hình OPC UA.

**Không đụng:** companion specification, PubSub, redundancy — để Chặng 2 (khối G2).

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b32: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
