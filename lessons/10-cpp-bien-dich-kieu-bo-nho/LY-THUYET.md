# Lý thuyết — Bài 10: C++ — biên dịch, kiểu, bộ nhớ

> C++ không khó vì cú pháp. Khó vì nó **bắt bạn nghĩ về những thứ Python giấu đi**. Bài này bày hết ra.

## 1. Ba giai đoạn — và lỗi ở mỗi chỗ trông khác nhau

```
   a.cpp ──[tiền xử lý]──→ a.i ──[biên dịch]──→ a.o ──[liên kết]──→ chương trình
```

| Giai đoạn | Làm gì | Lỗi trông thế nào |
|---|---|---|
| **Tiền xử lý** | Dán nội dung `#include` vào, thay `#define` | `fatal error: xxx.h: No such file` |
| **Biên dịch** | Kiểm tra cú pháp và kiểu, sinh mã máy cho **từng file riêng** | `error: 'x' was not declared` |
| **Liên kết** | Ghép các `.o` lại, nối tên hàm với thân hàm | `undefined reference to 'f()'` |

**Phân biệt được hai lỗi cuối là kỹ năng thật.**

- `'f' was not declared` → compiler chưa **thấy khai báo**. Thiếu `#include`, hoặc sai chính tả.
- `undefined reference to 'f'` → compiler **đã thấy khai báo** nhưng linker **không tìm ra thân hàm**. Bạn quên biên dịch file chứa nó, hoặc quên link thư viện.

Làm từng bước bằng tay một lần để thấy tận mắt:

```bash
g++ -E a.cpp -o a.i        # chỉ tiền xử lý — mở a.i ra xem, nó khổng lồ
g++ -c a.cpp -o a.o        # chỉ biên dịch
g++ a.o b.o -o ct          # chỉ liên kết
```

## 2. Header và source

C++ biên dịch **từng file độc lập**. File `main.cpp` không tự biết trong `sensor.cpp` có gì. Nên phải có bản khai báo:

```cpp
// sensor.h — LỜI HỨA: có một hàm tên thế này
#pragma once
double doc_nhiet_do();

// sensor.cpp — THỰC HIỆN lời hứa
#include "sensor.h"
double doc_nhiet_do() { return 25.4; }

// main.cpp — chỉ cần biết lời hứa
#include "sensor.h"
```

`#pragma once` là **include guard**: chống việc cùng một header bị dán vào hai lần (dẫn tới "định nghĩa trùng").

> Python không cần chuyện này vì `import` chạy lúc thực thi và Python tự biết trong module có gì. C++ quyết định mọi thứ **trước khi chạy**, nên phải nói trước.

## 3. Kiểu tĩnh và tràn số

```cpp
int a = 2147483647;
a = a + 1;            // KHÔNG phải 2147483648. Là -2147483648.
```

Số nguyên C++ có kích thước cố định. Vượt quá thì **quay vòng**, và compiler mặc định không nói gì.

| Kiểu | Kích thước | Dải |
|---|---|---|
| `int32_t` | 4 byte | ±2.1 tỷ |
| `uint32_t` | 4 byte | 0 … 4.3 tỷ |
| `int64_t` | 8 byte | ±9.2 triệu tỷ |
| `size_t` | 4 hoặc 8 | không âm, dùng cho kích thước/chỉ số |

Trên ESP32 (bài 24), nơi RAM tính bằng KB, việc chọn `uint8_t` thay vì `int` là chuyện có thật.

**Bẫy hay gặp:** `size_t` không âm. `for (size_t i = v.size() - 1; i >= 0; i--)` là **vòng lặp vô hạn** — `i` không bao giờ âm được.

`auto` để compiler tự suy kiểu, dùng khi kiểu quá dài và đã rõ từ ngữ cảnh — không phải để né việc nghĩ về kiểu.

## 4. Stack và heap

```
   ┌─────────────────┐
   │      STACK      │  biến cục bộ · tự dọn khi ra khỏi hàm
   │        ↓        │  nhanh · nhỏ (~1–8MB) · kích thước biết trước
   ├─────────────────┤
   │        ↑        │
   │      HEAP       │  new / malloc · BẠN phải dọn
   │                 │  lớn · chậm hơn · kích thước tuỳ lúc chạy
   └─────────────────┘
```

```cpp
void f() {
    int a = 5;                 // stack — tự biến mất khi hết hàm
    int* b = new int(5);       // heap  — TỒN TẠI MÃI cho tới khi delete
}                              // ← rò rỉ 4 byte: b mất nhưng vùng nhớ còn đó
```

Trên vi điều khiển, stack chỉ vài KB — **tràn stack làm board tự khởi động lại**. Đó chính là thứ bạn sẽ gặp ở bài 25 (FreeRTOS), khi phải tự chọn kích thước stack cho mỗi task.

## 5. Con trỏ và tham chiếu

```cpp
int x = 10;
int* p = &x;      // con trỏ: giữ ĐỊA CHỈ của x
int& r = x;       // tham chiếu: BÍ DANH khác của x

*p = 20;          // qua con trỏ, phải "giải tham chiếu" bằng *
r  = 30;          // qua tham chiếu, dùng như x luôn
```

| | Con trỏ | Tham chiếu |
|---|---|---|
| Rỗng được | có (`nullptr`) | **không** |
| Trỏ chỗ khác | được | **không**, gắn chết một lần |
| Cú pháp | cần `*` và `&` | dùng như biến thường |

**Quy tắc thực dụng: mặc định dùng tham chiếu. Chỉ dùng con trỏ khi cần "có thể không có gì" hoặc cần đổi chỗ trỏ.**

**Vẽ ra giấy.** Nghe trẻ con nhưng đây là cách nhanh nhất để con trỏ hết trừu tượng: vẽ ô nhớ, vẽ mũi tên.

## 6. Truyền tham số — và cái giá của sao chép

```cpp
void a(std::vector<int> v);          // SAO CHÉP toàn bộ vector
void b(const std::vector<int>& v);   // không sao chép, và không cho sửa
void c(std::vector<int>& v);         // không sao chép, ĐƯỢC sửa
```

Với vector 1 triệu phần tử, cách `a` sao chép 4MB **mỗi lần gọi**. Đây là nguồn "C++ sao chậm thế" phổ biến nhất ở người mới.

**Mặc định: `const T&`.** Đo thử trong bài để thấy chênh lệch bằng số.

## 7. Mảng C và `std::vector`

```cpp
int a[10];                  // kích thước cố định lúc biên dịch, KHÔNG kiểm tra biên
std::vector<int> v;         // co giãn được, biết size(), tự dọn
v.push_back(1);
v.at(100);                  // ném exception nếu vượt biên
v[100];                     // KHÔNG kiểm tra — hành vi không xác định
```

`a[15]` với mảng 10 phần tử: compiler không báo, chương trình không crash ngay — nó **đọc bộ nhớ của thứ khác**. Có thể chạy đúng hôm nay và sai vào tuần sau. Đây là loại bug tệ nhất của C++.

**Dùng `std::vector`, trừ khi có lý do rõ ràng.**

## 8. Rò rỉ bộ nhớ và valgrind

```cpp
int* p = new int[1000];
// quên delete[] p;
```

Python có bộ dọn rác. C++ **không**. Quên dọn là rò rỉ, và dịch vụ chạy nhiều ngày sẽ phình lên tới lúc chết.

```bash
valgrind --leak-check=full ./ct
```

Trong bài: **cố tình gây rò rỉ rồi bắt bằng valgrind**. Thấy nó chỉ đúng dòng là bạn có một công cụ dùng được cả đời.

*(Bài 11 sẽ cho cách để gần như không bao giờ phải `delete` bằng tay nữa — đó là RAII.)*

## 9. Bật cảnh báo, và coi cảnh báo là lỗi

```bash
g++ -Wall -Wextra -std=c++20 a.cpp -o a
```

Mặc định compiler im lặng trước rất nhiều thứ đáng ngờ. `-Wall -Wextra` bắt chúng lên. **Sửa hết cảnh báo, đừng bỏ qua cái nào** — phần lớn cảnh báo C++ là bug thật đang chờ.
