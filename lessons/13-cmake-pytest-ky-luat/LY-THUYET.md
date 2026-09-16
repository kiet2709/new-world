# Lý thuyết — Bài 13: CMake, pytest, và kỷ luật kỹ thuật

## 1. Vì sao C++ cần build system

Với một file thì `g++ a.cpp -o a` là đủ. Với hai mươi file, thư viện ngoài, hai chế độ build, và hai kiến trúc CPU thì lệnh gõ tay trở nên bất khả thi.

**CMake không biên dịch.** Nó **sinh ra** thứ biên dịch — Makefile hoặc Ninja — dựa trên mô tả của bạn và máy hiện tại. Đó là lý do có hai bước:

```bash
cmake -B build -DCMAKE_BUILD_TYPE=Release   # cấu hình → sinh build system
cmake --build build                          # build thật
```

Vì sao dùng CMake chứ không phải Makefile viết tay: nó đa nền tảng, và ở **bài 48 (cross-compile sang arm64)** bạn chỉ cần đổi một toolchain file là build được cho Pi. Makefile viết tay thì phải sửa tay.

## 2. CMakeLists tối thiểu

```cmake
cmake_minimum_required(VERSION 3.20)
project(new_world CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(analyze src/analyze.cpp)

target_compile_options(analyze PRIVATE -Wall -Wextra)
```

Khái niệm trung tâm là **target** — một thứ được build ra (chương trình hoặc thư viện). Mọi thiết lập nên gắn vào target (`target_...`), không đặt biến toàn cục. Đó là "CMake hiện đại".

Xây thư mục build **ngoài** cây mã nguồn (`-B build`) để `rm -rf build` là sạch, không lẫn file sinh ra với file bạn viết.

## 3. Debug và Release — chênh lệch sẽ làm bạn bất ngờ

| | `Debug` | `Release` |
|---|---|---|
| Cờ | `-g -O0` | `-O2` hoặc `-O3 -DNDEBUG` |
| Tối ưu | **không** | mạnh |
| Gỡ lỗi bằng gdb | dễ, biến đúng như code | khó, biến bị tối ưu mất |
| Tốc độ | chậm **3–20 lần** | thật |

> **Đo hiệu năng trên bản Debug là vô nghĩa.** Bạn đang đo một chương trình mà compiler cố tình không tối ưu.

Thử cả hai trong bài này và ghi con số vào nhật ký. Nó sẽ định hình cách bạn đo ở bài 22, 38, 47.

Ngược lại: **gỡ lỗi trên bản Release cũng khổ** — compiler gộp hàm, bỏ biến, đảo thứ tự dòng. Quy trình đúng: phát triển và gỡ lỗi bằng `Debug`, đo và giao hàng bằng `Release`.

## 4. pytest — và vì sao cần test khi chỉ có một mình

Lý lẽ thường nghe: "test cho nhóm đông người". Sai. Với người làm một mình, test giải quyết ba việc:

1. **Bạn của sáu tháng nữa là người lạ.** Sửa code cũ mà không có test là sửa mù.
2. **Nó là chỗ ghi lại các ca lạ.** Bạn phát hiện dòng CSV hỏng làm crash → viết test cho nó → nó không bao giờ quay lại.
3. **Nó cho phép bạn mạnh tay.** Viết lại bằng C++ ở bài 47 mà không có test thì lấy gì chứng minh kết quả vẫn đúng?

```python
# test_analyze.py
import pytest
from analyze import phan_tich

def test_dong_hong_khong_lam_crash():
    ket_qua = phan_tich(["2026-01-01,ERR,45.2"])
    assert ket_qua.so_dong_hong == 1

def test_file_rong():
    assert phan_tich([]).so_dong == 0

@pytest.mark.parametrize("gia_tri,mong_doi", [
    (25.0, False),
    (999.0, True),
])
def test_phat_hien_outlier(gia_tri, mong_doi):
    assert la_outlier(gia_tri) == mong_doi
```

**Test cái gì trước:** các ca biên và ca hỏng, không phải đường chính. Đường chính bạn chạy tay mỗi ngày rồi. Ca biên mới là chỗ bug sống: file rỗng, một dòng, giá trị thiếu, chữ ở chỗ phải là số, giá trị âm, giá trị khổng lồ.

## 5. Format và lint

```bash
make fmt      # black .        — format lại, không bàn cãi
make lint     # ruff check .   — bắt lỗi tiềm ẩn
make test     # pytest -q
```

`black` không có tuỳ chọn để cãi nhau về style — đó chính là điểm mạnh. Bạn thôi nghĩ về dấu cách và dồn sức nghĩ về logic.

`ruff` bắt những thứ thật: biến gán mà không dùng, import thừa, so sánh `== None` thay vì `is None`, biến dùng trước khi gán ở một nhánh.

Phía C++: `clang-format` để format, `-Wall -Wextra` là lint, và `clang-tidy` khi cần sâu hơn. Đều có sẵn trong container `cpp`.

## 6. Ba lệnh này là hợp đồng với chính mình

Từ bài này trở đi, **trước mỗi commit**:

```bash
make fmt && make lint && make test
```

Ba lệnh, vài giây. Nó rẻ tới mức không có lý do gì bỏ qua, và nó chặn được phần lớn commit hỏng.

Ở **bài 61 (CI GitHub Actions)**, đúng ba lệnh này sẽ chạy tự động mỗi lần push. Nếu giờ bạn tập chạy tay, thì lúc đó CI chỉ là tự động hoá một thói quen đã có — không phải một môn mới.

## 7. Kết thúc Khối 0

Sau bài này bạn có: môi trường không phải nghĩ tới nữa, Git đủ để dám mạnh tay, nền thật ở Python và C++, và một quy trình build–test dùng được tới hết lộ trình.

Từ Khối 1 trở đi, mọi bài đều là **thiết bị thật**.
