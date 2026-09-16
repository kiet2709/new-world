# Lý thuyết — Bài 02: Image, layer, và cache

## 1. Dockerfile là công thức, không phải script

Dockerfile trông giống một script shell nhưng bản chất khác hẳn: nó là **công thức để dựng một image**, và Docker thực hiện nó theo cách rất riêng.

```dockerfile
FROM python:3.12-slim-bookworm      # bắt đầu từ image có sẵn
RUN apt-get update && apt-get ...   # chạy lệnh → sinh layer mới
WORKDIR /work                        # đặt thư mục làm việc
COPY requirements.txt /tmp/          # chép file từ máy bạn vào image
RUN pip install -r /tmp/...          # chạy lệnh → sinh layer mới
CMD ["sleep", "infinity"]            # lệnh mặc định khi container chạy
```

## 2. Layer — ý tưởng trung tâm

**Mỗi lệnh trong Dockerfile sinh ra một layer**, và layer chỉ ghi lại **phần thay đổi** so với layer trước. Image cuối cùng là chồng các layer xếp lên nhau, hợp nhất lại thành một hệ thống file (union filesystem).

```
   ┌────────────────────────────┐  ← layer 5: CMD (metadata, 0 byte)
   ├────────────────────────────┤  ← layer 4: RUN pip install   (~300 MB)
   ├────────────────────────────┤  ← layer 3: COPY requirements (~1 KB)
   ├────────────────────────────┤  ← layer 2: RUN apt-get       (~200 MB)
   ├────────────────────────────┤  ← layer 1: FROM python:3.12  (~130 MB)
   └────────────────────────────┘
```

Hai hệ quả bạn sẽ gặp ngay:

**Layer là bất biến.** Xoá file ở layer trên **không** làm image nhỏ đi — file vẫn nằm ở layer dưới, chỉ bị che đi. Đây là lý do người ta viết:

```dockerfile
RUN apt-get update && apt-get install -y ... && rm -rf /var/lib/apt/lists/*
```

Cả ba lệnh trong **một** `RUN` để chúng cùng một layer — xoá trong cùng layer thì mới thật sự bớt dung lượng. Tách thành ba `RUN` là image phình ra.

**Layer dùng chung được.** Mười image cùng `FROM python:3.12-slim` thì chia sẻ layer đó, chỉ lưu một lần trên đĩa.

## 3. Cache — và quy tắc đổ dây chuyền

Khi build lại, với mỗi lệnh Docker hỏi: *"lệnh này, với đầu vào này, tôi làm rồi chưa?"*

- **Rồi** → dùng lại layer cũ, gần như tức thì (`CACHED`)
- **Chưa** → làm lại layer này **và mọi layer phía sau nó**

Vế thứ hai là điều quan trọng nhất của bài này: **cache hỏng một chỗ thì hỏng xuống dưới hết.** Layer phía sau phụ thuộc vào layer trước, nên không thể giữ lại được.

Khoá cache được tính thế nào:

| Lệnh | Cache hỏng khi |
|---|---|
| `RUN <lệnh>` | **chuỗi lệnh** thay đổi (không phải kết quả của nó!) |
| `COPY` / `ADD` | **nội dung file** được chép thay đổi |
| `FROM` | image nền có bản mới |

Chú ý dòng `RUN`: Docker **không** biết `apt-get update` hôm nay khác hôm qua. Nó chỉ nhìn chuỗi ký tự của lệnh. Đó là lý do đôi khi phải `--no-cache`.

## 4. Vì sao COPY requirements.txt đứng TRƯỚC code

Đây là mẹo quan trọng nhất và là lý do Dockerfile của repo này viết như vậy:

```dockerfile
COPY docker/python/requirements.txt /tmp/requirements.txt   # hiếm khi đổi
RUN pip install --no-cache-dir -r /tmp/requirements.txt      # rất tốn thời gian
```

Bạn sửa code Python hàng chục lần mỗi ngày, nhưng sửa `requirements.txt` vài tuần một lần. Đặt file ít đổi lên trước thì layer `pip install` đắt đỏ kia hầu như không bao giờ phải chạy lại.

Nếu làm ngược — chép cả thư mục vào trước rồi mới `pip install` — thì **sửa một dấu cách trong file `.py` cũng khiến cài lại toàn bộ thư viện**.

**Nguyên tắc chung: cái gì ít thay đổi thì đặt lên trên.**

> Một điểm riêng của repo này: Dockerfile ở đây **không COPY code vào image chút nào**. Code đến với container qua **bind mount** (bài 03). Nên hãy tự kiểm chứng thí nghiệm "sửa file .py rồi build lại" thật sự đang đo cái gì.

## 5. Build lại không xoá gì cả

Khi bạn build lại, image cũ **không biến mất**. Nó chỉ mất cái tên (`new_world-py:latest` chuyển sang trỏ vào image mới), còn image cũ trở thành **dangling** — không tên, vẫn chiếm đĩa.

```bash
docker images -a          # thấy cả những cái <none>
docker image prune        # dọn các image không còn tên
docker system df          # Docker đang ăn bao nhiêu đĩa
```

Nên nếu bạn đoán rằng "sửa requirements làm Docker xoá môi trường cũ đi rồi tải lại" — nửa sau đúng, **nửa đầu sai**. Docker không xoá gì cả; nó dựng một layer mới hoàn toàn, và cài lại **toàn bộ** thư viện chứ không phải chỉ cái mới thêm.

## 6. Công cụ soi

| Lệnh | Cho bạn thấy |
|---|---|
| `docker history <image>` | Từng layer, lệnh sinh ra nó, và **kích thước** |
| `docker images` | Tổng kích thước image |
| `docker images -a` | Cả layer trung gian và image mồ côi |
| `docker build --progress=plain` | Log build đầy đủ, thấy rõ `CACHED` |
| `docker system df` | Dung lượng image + container + volume |

## 7. Mục tiêu thật của bài này

Không phải thuộc lệnh. Là **đoán đúng trước khi chạy**: nhìn một thay đổi và nói được "build lại sẽ mất khoảng bao lâu, vì sao". Đoán đúng ba lần liên tiếp là bạn đã có mô hình layer/cache trong đầu.

Ghi lại kích thước image hôm nay — **bài 40** sẽ ép nó xuống bằng multi-stage build, và bạn sẽ cần con số gốc để so.
