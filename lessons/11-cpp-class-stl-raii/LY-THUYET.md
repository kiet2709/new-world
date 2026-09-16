# Lý thuyết — Bài 11: C++ — class, STL, và RAII

## 1. Class và struct

```cpp
struct Diem { double x, y; };        // mặc định public — dùng cho dữ liệu thuần

class CamBien {                       // mặc định private — dùng khi có hành vi
public:
    CamBien(int dia_chi);
    double doc();
private:
    int fd_;
};
```

Khác biệt duy nhất về kỹ thuật: `struct` mặc định public, `class` mặc định private. Khác biệt về **quy ước** thì quan trọng hơn: `struct` cho túi dữ liệu, `class` cho thứ có hành vi và trạng thái cần bảo vệ.

## 2. Constructor và destructor

```cpp
class CamBien {
public:
    CamBien(const std::string& dev) {      // constructor: mở tài nguyên
        fd_ = open(dev.c_str(), O_RDWR);
        if (fd_ < 0) throw std::runtime_error("khong mo duoc " + dev);
    }
    ~CamBien() {                            // destructor: TỰ ĐỘNG dọn
        if (fd_ >= 0) close(fd_);
    }
private:
    int fd_ = -1;
};
```

**Destructor chạy tự động** khi object ra khỏi phạm vi — kể cả khi có `return` giữa chừng, kể cả khi có exception bay qua. Đây là thứ C++ có mà Python không có (Python phải dùng `with` để đạt hiệu quả tương tự).

## 3. RAII — ý tưởng trung tâm của C++

**Resource Acquisition Is Initialization**: gắn vòng đời của *tài nguyên* vào vòng đời của *object*.

> Lấy tài nguyên trong constructor. Trả tài nguyên trong destructor. Từ đó về sau **không thể quên trả**.

```cpp
{
    CamBien cb("/dev/i2c-1");   // mở
    double t = cb.doc();
    if (t > 100) throw std::runtime_error("vo ly");   // ném exception ở đây
}   // ← destructor VẪN chạy, cổng VẪN được đóng
```

So sánh với cách thủ công:

```cpp
int fd = open(...);
double t = doc(fd);
if (t > 100) throw ...;   // ← RÒ RỈ: dòng close() bên dưới không bao giờ chạy
close(fd);
```

RAII áp dụng cho **mọi** tài nguyên, không chỉ bộ nhớ: file, cổng serial, socket, khoá mutex, kết nối database.

> **Ba ngôn ngữ, một vấn đề** (viết vào nhật ký):
> | | Cơ chế | Ai gọi |
> |---|---|---|
> | C++ | destructor / RAII | **compiler**, tự động |
> | Python | `with` / context manager | lập trình viên phải nhớ viết `with` |
> | C# | `using` / `IDisposable` | lập trình viên phải nhớ viết `using` |
>
> C++ là ngôn ngữ duy nhất trong ba cái mà bạn **không thể quên**.

## 4. Smart pointer — RAII cho bộ nhớ

```cpp
#include <memory>

auto p = std::make_unique<CamBien>("/dev/i2c-1");
// không cần delete — tự xoá khi p ra khỏi phạm vi
```

| | Dùng khi |
|---|---|
| `unique_ptr` | **Mặc định.** Một chủ sở hữu duy nhất |
| `shared_ptr` | Nhiều chỗ cùng sở hữu, đếm tham chiếu. Nặng hơn, dùng khi thật cần |
| con trỏ trần `T*` | Chỉ để **nhìn**, không sở hữu, không bao giờ `delete` |

**Trong C++ hiện đại, `new`/`delete` viết tay là mùi code xấu.** Nếu bạn thấy mình gõ `delete`, hãy hỏi: chỗ này dùng `unique_ptr` được không?

## 5. STL — bốn thứ dùng hằng ngày

```cpp
#include <vector>
#include <string>
#include <map>
#include <algorithm>

std::vector<double> v {1.0, 2.0};
v.push_back(3.0);
for (double x : v) { ... }               // vòng lặp theo phạm vi

std::string s = "nhiet do";
s += ": 25.4";

std::map<std::string, double> tag;       // cây cân bằng, khoá có thứ tự, O(log n)
tag["nhiet_do"] = 25.4;
std::unordered_map<std::string, double> t2;   // bảng băm, O(1) trung bình

std::sort(v.begin(), v.end());
auto it = std::find_if(v.begin(), v.end(), [](double x){ return x > 10; });
if (it != v.end()) { /* tìm thấy */ }
```

Đoạn `[](double x){ ... }` là **lambda** — hàm không tên viết tại chỗ. Gặp rất nhiều, cần đọc hiểu.

Quy tắc chọn container giống Python: dãy có thứ tự → `vector`; tra theo khoá → `unordered_map`; cần khoá có thứ tự → `map`.

## 6. `const` correctness

```cpp
double doc() const;                        // hàm này KHÔNG đổi object
void xu_ly(const std::vector<int>& v);     // không sao chép, không sửa
const double PI = 3.14159;
```

`const` là **lời hứa được compiler kiểm tra**. Nó không làm chương trình nhanh hơn; nó làm bạn không phá được thứ không nên phá, và cho người đọc biết ý định của bạn.

Thói quen: mặc định viết `const`, chỉ bỏ ra khi thật sự cần sửa.

## 7. Template — mức đọc hiểu là đủ

```cpp
template <typename T>
T lon_nhat(T a, T b) { return a > b ? a : b; }
```

Compiler sinh ra một bản riêng cho mỗi kiểu bạn dùng. Đó là lý do `std::vector<int>` và `std::vector<double>` đều nhanh như viết tay.

Ở giai đoạn này: **đọc hiểu được template là đủ**, chưa cần tự viết. Cả STL là template, nên bạn sẽ thấy chúng liên tục trong thông báo lỗi — thông báo lỗi template nổi tiếng dài và khó đọc. Mẹo: **đọc dòng đầu tiên và dòng cuối cùng trước**, phần giữa thường là chi tiết nội bộ.

## 8. Mục tiêu nghiệm thu

Viết được một class RAII thật — mở file hoặc cổng serial, đóng trong destructor — và **chứng minh** nó đóng kể cả khi exception bay qua (in ra trong destructor mà thấy).

Làm được điều đó là bạn đã nắm thứ quan trọng nhất mà C++ dạy cho một lập trình viên.
