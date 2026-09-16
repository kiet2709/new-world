# Lý thuyết — Bài 08: Python cốt lõi

> Bài đệm. Mục tiêu không phải học Python từ đầu — mà **lấp những chỗ AI đã viết hộ bạn** để từ giờ đọc code Python nào cũng hiểu vì sao nó chạy.

## 1. Python chạy thế nào

Python **không** dịch thẳng ra mã máy. Nó dịch ra **bytecode** (file `.pyc` trong `__pycache__`), rồi một máy ảo đọc bytecode và thực hiện từng lệnh.

```
   ma nguon .py  ──→  bytecode .pyc  ──→  may ao Python doc va chay
```

Đó là lý do Python chậm hơn C++ vài chục lần trong vòng lặp: mỗi phép tính đi qua một lớp thông dịch, và **mỗi giá trị là một object có kiểu kèm theo** chứ không phải con số trần trụi trong thanh ghi.

Nhớ điều này khi tới bài 22 và 38, lúc bạn đo Python với C++ trên cùng bài toán. Con số chênh lệch sẽ không còn bí ẩn.

## 2. Biến là NHÃN, không phải HỘP

Đây là mô hình quan trọng nhất của bài, và là gốc của rất nhiều bug im lặng.

Trong C, `int x = 5` nghĩa là: cấp một ô nhớ tên `x`, bỏ số 5 vào. Biến là cái hộp.

Trong Python, `x = 5` nghĩa là: tạo object số 5, rồi **dán nhãn `x` lên nó**. Biến là cái nhãn.

```python
a = [1, 2]
b = a          # KHÔNG sao chép. Dán thêm nhãn "b" lên CÙNG một list
a.append(3)
print(b)       # [1, 2, 3]  ← b "đổi" vì nó vốn là cùng một object
```

Kiểm chứng: `id(a) == id(b)` → `True`. Hai nhãn, một object.

## 3. Mutable và immutable

| Immutable (không sửa được) | Mutable (sửa được tại chỗ) |
|---|---|
| `int`, `float`, `str`, `tuple`, `bool` | `list`, `dict`, `set`, hầu hết object tự định nghĩa |

Với immutable, "sửa" thực ra là tạo object mới rồi dán nhãn lại:

```python
s = "abc"
t = s
s += "d"       # tạo chuỗi MỚI "abcd", dán nhãn s lên nó
print(t)       # "abc"  ← t vẫn trỏ object cũ
```

So với list ở mục 2 — cùng một dòng lệnh trông giống nhau nhưng kết quả ngược nhau. Phân biệt được mutable/immutable là hết cả một lớp bug.

### Sao chép cho đúng

```python
import copy
b = a.copy()            # nông: list mới, nhưng các phần tử BÊN TRONG vẫn dùng chung
b = copy.deepcopy(a)    # sâu: sao chép đệ quy tất cả
```

Sao chép nông đủ cho list số. Không đủ cho list-của-list, hay dict lồng dict.

## 4. Cái bẫy mutable default argument

Bug kinh điển nhất của Python:

```python
def them(x, lst=[]):      # SAI
    lst.append(x)
    return lst

them(1)    # [1]
them(2)    # [1, 2]   ← ơ?
```

Vì sao: **giá trị mặc định được tạo MỘT LẦN, lúc định nghĩa hàm**, không phải mỗi lần gọi. Cái list đó sống suốt đời chương trình.

Cách đúng:

```python
def them(x, lst=None):
    if lst is None:
        lst = []
    lst.append(x)
    return lst
```

Quy tắc: **không bao giờ dùng object mutable làm giá trị mặc định.**

## 5. Bốn kiểu chứa dữ liệu — chọn cái nào

| | Thứ tự | Sửa được | Trùng lặp | Tra cứu | Dùng khi |
|---|---|---|---|---|---|
| `list` | có | có | có | O(n) | Dãy có thứ tự, hay thêm bớt |
| `tuple` | có | **không** | có | O(n) | Dữ liệu cố định, làm khoá dict được |
| `dict` | có (theo thứ tự chèn) | có | khoá không trùng | **O(1)** | Tra theo khoá |
| `set` | không | có | **không** | **O(1)** | Kiểm tra tồn tại, loại trùng |

Điểm thực dụng: `x in danh_sach` với list 100.000 phần tử là **duyệt hết** — chậm. Với `set` là gần như tức thì. Đổi một chữ, nhanh gấp trăm lần.

## 6. Comprehension

```python
binh_phuong = [x**2 for x in range(10)]
chan        = [x for x in so if x % 2 == 0]
bang        = {ten: len(ten) for ten in ds_ten}
```

Gọn hơn vòng `for` và thường nhanh hơn. Nhưng **đừng nhồi nhét**: comprehension lồng ba tầng khó đọc hơn vòng lặp thường. Một tầng, kèm tối đa một `if` — quá đó thì viết vòng lặp.

## 7. Hàm: `*args` và `**kwargs`

```python
def f(a, b=2, *args, **kwargs):
    ...
```

- `a` — bắt buộc
- `b=2` — có mặc định
- `*args` — gom các tham số vị trí thừa thành tuple
- `**kwargs` — gom các tham số có tên thừa thành dict

Bạn sẽ gặp chúng liên tục khi đọc thư viện. Cần **đọc hiểu** trước, viết sau.

## 8. Module, package, và `__name__`

- **module** = một file `.py`
- **package** = một thư mục có `__init__.py`

```python
if __name__ == "__main__":
    main()
```

Khi chạy trực tiếp `python a.py` thì `__name__ == "__main__"`. Khi file đó bị `import` từ nơi khác thì `__name__ == "a"`.

Nên dòng đó có nghĩa: *"chỉ chạy phần này khi tôi được gọi trực tiếp, đừng chạy khi tôi bị import"*. Thiếu nó thì `import` một file là vô tình chạy luôn cả chương trình bên trong nó.

## 9. venv và pip — vì sao vẫn cần hiểu dù đã có Docker

`venv` tạo một môi trường Python riêng cho mỗi dự án, để dự án A dùng `numpy 1.x` còn dự án B dùng `numpy 2.x` mà không đánh nhau.

Trong repo này **container đã đóng vai đó** — mỗi container là một môi trường cô lập sẵn. Nhưng bạn vẫn cần hiểu venv vì:

- Lên Pi, đôi khi chạy thẳng không qua Docker
- Đọc tài liệu/hướng dẫn nào cũng nhắc tới nó
- Hiểu venv là hiểu **vì sao cô lập môi trường lại quan trọng** — cùng một lý do sinh ra Docker
