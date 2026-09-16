# Lý thuyết — Bài 12: Cùng một bài toán, hai ngôn ngữ

> Bài 08–11 dạy hai ngôn ngữ riêng rẽ. Bài này bắt chúng **đối đầu trên cùng một việc** — chỗ duy nhất sinh ra hiểu biết so sánh thật.

## 1. Vì sao phải CÙNG một bài toán

Học Python bằng bài A và C++ bằng bài B thì bạn có hai mớ kiến thức rời. Bắt cả hai giải **đúng một việc** thì mọi khác biệt còn lại chính là khác biệt của ngôn ngữ, không phải của bài toán.

Đây là kỷ luật số 2 trong lộ trình, và nó lặp lại ở bài 22, 38, 47.

## 2. Biên dịch và thông dịch

| | Python | C++ |
|---|---|---|
| Trước khi chạy | không có bước riêng | **phải biên dịch** |
| Lỗi cú pháp/kiểu phát hiện khi | **chạy tới dòng đó** | biên dịch |
| Sửa một dòng rồi chạy | tức thì | phải build lại |
| Sản phẩm | mã nguồn + runtime | **một file chạy độc lập** |

Hệ quả thực dụng: một lỗi gõ nhầm tên biến ở nhánh `if` hiếm gặp, Python chỉ nổ khi nhánh đó chạy — có thể là ba tuần sau, lúc 2 giờ sáng. C++ chặn ngay lúc build.

Đổi lại, vòng lặp sửa–chạy của Python nhanh hơn nhiều. **Không có cái nào tốt hơn; chúng đắt ở hai chỗ khác nhau.**

## 3. Ai dọn bộ nhớ

Câu bắt buộc trả lời được sau bài này.

**Python:** đếm tham chiếu + bộ dọn rác. Object không còn ai trỏ tới thì được thu hồi. Bạn **không nghĩ về nó** — cho tới khi chương trình ăn 3GB RAM mà bạn không hiểu vì sao.

**C++:** object trên stack tự huỷ khi ra khỏi phạm vi. Object trên heap thì **bạn chịu trách nhiệm** — hoặc trực tiếp bằng `delete`, hoặc đúng hơn là gián tiếp qua RAII/`unique_ptr` (bài 11).

Điều đó đổi cách bạn viết code thế nào:

- C++ bắt bạn nghĩ **ai sở hữu dữ liệu này** ngay lúc thiết kế. Truyền theo giá trị hay tham chiếu? Ai xoá?
- Python cho bạn hoãn câu hỏi đó — và thường không bao giờ phải trả lời
- Khi cần **đoán trước được thời gian** (điều khiển thiết bị, thời gian thực), việc bộ dọn rác chạy lúc nào là không đoán được lại thành vấn đề thật

## 4. Cái đắt của Python trong vòng lặp

```python
tong = 0
for x in danh_sach:      # mỗi vòng: tra kiểu, gọi hàm, cấp phát object
    tong += x
```

```cpp
double tong = 0;
for (double x : v) tong += x;   // cộng thẳng trên thanh ghi
```

Chênh 10–100 lần với vòng lặp chặt. **Nhưng**: nếu bạn dùng `numpy`, phần nặng chạy bằng C bên dưới và khoảng cách thu hẹp còn vài lần.

Đây là bài học thật: **"Python chậm" là câu nói lười.** Python chậm ở vòng lặp mức Python. Python gọi thư viện C thì không chậm. Biết phân biệt hai chuyện đó là biết khi nào cần viết lại bằng C++ (bài 47) và khi nào không.

## 5. Đo cho đúng

Bài này có số liệu, nên phải đo cho tử tế:

1. **Đo bản Release.** `g++` không có `-O2` sinh mã chậm gấp nhiều lần. Đo bản Debug rồi kết luận là vô nghĩa (bài 13 sẽ làm rõ).
2. **Chạy nhiều lần lấy trung vị**, đừng lấy một lần. Máy có nhiễu.
3. **Bỏ lần chạy đầu.** Cache nguội, nạp thư viện — lần đầu luôn chậm bất thường.
4. **Tách thời gian khởi động.** Python mất ~30–50ms chỉ để khởi động. Với script chạy một lần thì đó là phần lớn thời gian; với dịch vụ chạy nhiều ngày thì không đáng kể.
5. **Đo cả RAM đỉnh**, không chỉ thời gian. `/usr/bin/time -v` trên Linux cho cả hai.

```bash
/usr/bin/time -v ./analyze sensor_log.csv      # thoi gian + RAM dinh
python -X importtime analyze.py                # thoi gian nap tung module
```

## 6. Xử lý dữ liệu bẩn — chỗ hai ngôn ngữ lộ rõ tính cách

File `sensor_log.csv` cố tình có dòng hỏng, ô trống, giá trị vô lý. Đây không phải để làm khó — **dữ liệu thiết bị thật luôn bẩn**, và cách hai ngôn ngữ đối xử với chuyện đó rất khác nhau:

| Tình huống | Python | C++ |
|---|---|---|
| `float("abc")` | ném `ValueError` — rõ ràng | `std::stod` ném; `atof` trả **0.0 im lặng** |
| Ô trống | `""` → lỗi khi ép kiểu | chuỗi rỗng → `atof` cho 0.0 |
| Thiếu cột | `IndexError` | đọc bậy vùng nhớ nếu không kiểm tra |

Chú ý dòng đầu: **`atof` trả về 0.0 và không báo gì cả.** Nhiệt độ hỏng biến thành 0°C, và báo cáo của bạn sai mà không ai biết. Dùng `std::stod` trong `try/catch`, hoặc `std::from_chars`.

> Bài học lớn hơn con số hiệu năng: **C++ cho bạn nhiều cách sai âm thầm hơn.** Đó là cái giá thật của việc ở gần phần cứng — và là lý do phải bật `-Wall -Wextra` và viết test.

## 7. Bảng cần điền vào nhật ký

| Chỉ số | Python | C++ | Điều kiện đo |
|---|---|---|---|
| Số dòng code | | | |
| Thời gian (1 triệu dòng, Release, trung vị 5 lần) | | | |
| RAM đỉnh | | | |
| Thời gian khởi động tiến trình | | | |
| Kích thước sản phẩm giao đi | | | binary vs mã nguồn + runtime |

Rồi hai cột chữ:

- **Ngôn ngữ này làm hộ tôi cái gì**
- **Nó bắt tôi tự làm cái gì**

Cột thứ hai mới là chỗ bài này đáng giá.
