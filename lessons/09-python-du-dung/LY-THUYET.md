# Lý thuyết — Bài 09: Python đủ dùng cho hệ thống thật

> Bài 08 là nền ngôn ngữ. Bài này là những thứ **phân biệt script chạy một lần với dịch vụ chạy nhiều ngày**.

## 1. Exception và triết lý EAFP

Python theo **EAFP** — *Easier to Ask Forgiveness than Permission*: cứ làm, hỏng thì bắt lỗi. Khác với kiểu "kiểm tra trước rồi mới làm" (LBYL).

```python
# LBYL — kiểm tra trước
if os.path.exists(f):
    with open(f) as fh: ...     # vẫn hỏng nếu file bị xoá giữa hai dòng!

# EAFP — cách Python
try:
    with open(f) as fh: ...
except FileNotFoundError:
    ...
```

Cách EAFP không có khe hở thời gian đó. Với thiết bị vật lý thì khe hở luôn tồn tại — dây bị rút đúng giữa hai dòng lệnh là chuyện thật.

### Bốn từ khoá

```python
try:      ...   # thử
except:   ...   # nếu hỏng
else:     ...   # nếu KHÔNG hỏng
finally:  ...   # luôn chạy, hỏng hay không
```

`finally` là chỗ dọn dẹp — đóng cổng serial, tắt LED. Nó chạy kể cả khi có `return` hay exception.

### Ba luật

**1. Không bao giờ `except:` trần.**

```python
try:
    doc_cam_bien()
except:            # SAI — nuốt cả Ctrl+C và lỗi lập trình của bạn
    pass
```

Nó nuốt `KeyboardInterrupt`, `SystemExit`, và mọi lỗi cú pháp logic. Chương trình của bạn trở nên không tắt được và không gỡ lỗi được.

**2. Bắt cụ thể, từ hẹp tới rộng.**

```python
except FileNotFoundError:  ...
except OSError:            ...
except Exception as e:     logger.exception("khong luong truoc")
```

**3. `raise` lại nếu bạn không xử lý được.** Nuốt lỗi mà không xử lý là giấu vấn đề tới lúc nó nổ ở chỗ khác.

### Exception của riêng bạn

```python
class LoiCamBien(Exception):
    """Cảm biến không phản hồi hoặc trả giá trị vô lý."""
```

Đáng làm vì nó cho phép người gọi bắt **đúng loại lỗi của miền vấn đề**, thay vì đoán mò trong đống `OSError`.

## 2. Context manager — `with`

```python
with open("f.txt") as fh:
    data = fh.read()
# file ĐÃ đóng ở đây, kể cả khi có exception
```

`with` bảo đảm dọn dẹp. Không cần nhớ gọi `close()`, và không sợ exception làm nhảy qua chỗ dọn.

Tự viết một cái:

```python
from contextlib import contextmanager

@contextmanager
def mo_cong(duong_dan):
    cong = Serial(duong_dan)
    try:
        yield cong          # phần thân "with" chạy ở đây
    finally:
        cong.close()        # LUÔN đóng
```

Dùng nhiều trong lộ trình này: cổng serial (bài 29), kết nối Modbus, camera. Bất cứ thứ gì **mở ra thì phải đóng**.

> **So sánh ba ngôn ngữ — ghi vào nhật ký:** C++ dùng **destructor/RAII** (bài 11), Python dùng **`with`**, C# dùng **`using`/`IDisposable`** (bài 51). Cùng một vấn đề: giải phóng tài nguyên cho chắc chắn. Ba lời giải khác nhau.

## 3. Generator — và vì sao "lười" lại quan trọng

Hàm thường `return` một lần rồi hết. Generator dùng `yield` — **trả ra một giá trị rồi dừng lại chờ**, lần sau gọi thì chạy tiếp từ chỗ đó.

```python
def doc_dong(duong_dan):
    with open(duong_dan) as fh:
        for dong in fh:
            yield dong.strip()
```

Khác biệt sống còn:

| | Nạp hết vào list | Generator |
|---|---|---|
| File 1GB | RAM ~1GB+ | RAM vài KB |
| Có kết quả đầu tiên sau | đọc xong cả file | ngay lập tức |
| Luồng vô hạn | **không làm được** | làm được |

Dòng cuối là lý do generator quan trọng với lộ trình này: **luồng dữ liệu cảm biến không có điểm kết thúc**. Không thể "đọc hết rồi xử lý". Phải xử lý từng cái một khi nó tới.

```python
def doc_cam_bien_mai():
    while True:
        yield doc_mot_lan()
        time.sleep(0.1)
```

Đo thử trong bài: RAM đỉnh khi đọc file lớn bằng hai cách. Con số sẽ thuyết phục hơn mọi giải thích.

## 4. `dataclass` — dữ liệu có hình dạng

```python
from dataclasses import dataclass

@dataclass
class SoDo:
    thoi_diem: float
    nhiet_do: float
    do_am: float | None = None
```

Tự có `__init__`, `__repr__`, `__eq__`. Thay cho dict lỏng lẻo — **trình soạn thảo gợi ý được tên trường, và gõ sai tên là báo lỗi ngay**, thay vì trả `None` âm thầm như dict.

Dùng nó cho mọi dữ liệu có cấu trúc trong lộ trình: số đo cảm biến, tag Modbus, kết quả nhận dạng.

## 5. Type hint

```python
def trung_binh(so: list[float]) -> float:
    return sum(so) / len(so)
```

Python **không** ép kiểu lúc chạy — type hint chỉ là chú thích. Giá trị của nó:

- Trình soạn thảo gợi ý đúng và bắt lỗi khi bạn gõ
- `ruff` / `mypy` bắt lỗi **trước khi chạy**
- Nó là tài liệu không bao giờ lỗi thời

Với người đang chuyển sang C++ và C# (cả hai đều kiểu tĩnh), type hint là cây cầu tư duy rất tốt.

## 6. `logging` — bỏ `print` từ đây

`print` có ba vấn đề với dịch vụ chạy thật: không có mức độ, không có thời điểm, không chuyển hướng được.

```python
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s: %(message)s",
)

logger.debug("gia tri tho: %s", raw)      # chi tiết, thường tắt
logger.info("da ket noi cam bien")        # sự kiện bình thường
logger.warning("doc lai lan 2")           # bất thường nhưng còn chạy
logger.error("mat ket noi", exc_info=True)  # hỏng thật
```

Ba điều làm cho đúng:

1. `logger = logging.getLogger(__name__)` ở mỗi module — về sau lọc được theo module
2. **Dùng `%s` chứ đừng f-string**: `logger.debug("x=%s", x)` chỉ ghép chuỗi khi mức log thật sự bật
3. `exc_info=True` (hoặc `logger.exception`) để có cả vết gọi

Từ bài này trở đi: **code thật không dùng `print`**. Ở bài 23 (systemd) bạn sẽ thấy vì sao — `journalctl` đọc được log có cấu trúc, còn `print` thì trôi mất.
