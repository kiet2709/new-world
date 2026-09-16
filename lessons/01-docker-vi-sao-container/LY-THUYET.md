# Lý thuyết — Bài 01: Docker, vì sao container tồn tại

## 1. Vấn đề có thật trước khi có container

Bạn viết một chương trình chạy ngon trên máy mình. Đưa cho người khác, nó không chạy. Vì sao?

Vì chương trình của bạn không sống một mình. Nó cần: đúng phiên bản Python, đúng phiên bản thư viện, đúng thư viện hệ thống (libgl, libglib), đúng biến môi trường, đúng đường dẫn. Tất cả những thứ đó là **môi trường**, và môi trường nằm ngoài code của bạn.

Câu "chạy được trên máy tôi mà" không phải lời bào chữa — nó là mô tả chính xác một vấn đề kỹ thuật thật.

Với lộ trình này vấn đề còn nặng hơn: bạn có **máy Windows** (x86), **Raspberry Pi** (ARM), và sắp tới là **thiết bị ở nhà máy**. Ba môi trường khác nhau. Cài tay ba lần là ba cơ hội sai khác nhau.

## 2. Máy ảo và container khác nhau chỗ nào

**Máy ảo (VM):** giả lập cả một cái máy tính. Có CPU ảo, RAM ảo, đĩa ảo, và **một hệ điều hành đầy đủ riêng**. Nặng vài GB, khởi động vài chục giây.

**Container:** không giả lập máy nào cả. Nó **dùng chung nhân (kernel) Linux của máy chủ**, chỉ tách riêng phần "nhìn thấy cái gì": thư mục nào, tiến trình nào, mạng nào, tài nguyên bao nhiêu. Nặng vài chục MB, khởi động vài trăm mili-giây.

```
   MÁY ẢO                          CONTAINER
   ┌──────────┬──────────┐         ┌──────────┬──────────┐
   │  App A   │  App B   │         │  App A   │  App B   │
   ├──────────┼──────────┤         ├──────────┼──────────┤
   │   OS 1   │   OS 2   │  ← nặng │  thư viện riêng      │
   ├──────────┴──────────┤         ├─────────────────────┤
   │     Hypervisor      │         │   Docker Engine     │
   ├─────────────────────┤         ├─────────────────────┤
   │   OS của máy chủ    │         │   OS của máy chủ    │  ← dùng chung nhân
   └─────────────────────┘         └─────────────────────┘
```

Hai cơ chế của Linux làm nên điều đó:

- **namespace** — quyết định container *nhìn thấy* gì. Nó tưởng nó có hệ thống file riêng, danh sách tiến trình riêng, card mạng riêng.
- **cgroup** — quyết định container *dùng được* bao nhiêu CPU, RAM.

Hệ quả quan trọng: **container không phải máy ảo, nên nó không cách ly bằng máy ảo.** Nếu nhân Linux có lỗ hổng thì container thoát ra được. Đây là lý do `--privileged` (bài 17) là nợ bảo mật.

*Trên Windows, Docker Desktop chạy một máy ảo Linux nhỏ (qua WSL2) rồi chạy container bên trong đó. Vì vậy máy bạn có cả hai tầng — và đó cũng là lý do Docker trên Windows **không thấy cổng COM** (bài 23).*

## 3. Image và container — khác nhau cốt tử

Đây là chỗ người mới lẫn nhiều nhất.

| | Image | Container |
|---|---|---|
| Là gì | **Khuôn**, chỉ đọc | **Vật đúc ra từ khuôn**, đang chạy |
| Trạng thái | Bất biến | Có thể ghi, có tiến trình sống |
| Số lượng | Một image | đẻ ra **bao nhiêu container cũng được** |
| Ví dụ đời thường | File cài đặt | Chương trình đang mở |

Một image `python:3.12-slim` có thể sinh ra 50 container chạy đồng thời, mỗi cái độc lập.

## 4. Vòng đời một container

```
  docker run  ──→  [ĐANG CHẠY]  ──→  [ĐÃ DỪNG]  ──→  docker rm  ──→ biến mất
                       │  ▲              │
               docker stop  └── docker start ┘
```

**Điều quan trọng nhất phải hiểu:** container sống đúng bằng **tiến trình chính** của nó. Tiến trình đó kết thúc → container chết ngay. Không có "container chạy nền mà không có gì bên trong".

Đó là lý do trong `docker-compose.yml` của repo này, service `py` và `cpp` có dòng:

```yaml
command: sleep infinity
```

Không phải để làm gì cả — chỉ để **giữ một tiến trình sống**, cho bạn `exec` vào làm việc. Nếu bỏ dòng đó, container bật lên rồi tắt ngay.

## 5. Cái gì mất khi container chết

Mỗi container có một **lớp ghi** riêng nằm trên image. Mọi thứ bạn tạo bên trong (file mới, gói cài thêm) nằm ở lớp đó.

**`docker rm` xoá lớp ghi đó vĩnh viễn.**

`docker stop` thì không — container dừng nhưng lớp ghi còn, `docker start` lại là thấy nguyên.

Đây là lý do có **volume** và **bind mount** (bài 03). Dữ liệu nào bạn muốn giữ thì phải để ra ngoài container.

> Đây cũng là một cách nghĩ mới: container là thứ **dùng xong vứt đi**. Không nâng cấp, không vá — build image mới rồi thay. Nghe lạ với người quen quản trị máy chủ, nhưng nó làm mọi thứ đoán trước được.

## 6. Lệnh cần nắm ở bài này

| Lệnh | Làm gì | Chú ý |
|---|---|---|
| `docker run <image>` | Tạo container mới từ image và chạy | **Luôn tạo container MỚI**, không dùng lại cái cũ |
| `docker run -it <image> bash` | Chạy có bàn phím, vào shell | `-i` giữ stdin, `-t` cấp terminal |
| `docker ps` | Container **đang chạy** | |
| `docker ps -a` | **Tất cả**, kể cả đã dừng | Chênh lệch giữa hai lệnh dạy bạn về vòng đời |
| `docker exec -it <tên> bash` | Vào một container **đang chạy** | Khác `run` — không tạo cái mới |
| `docker logs <tên>` | Xem đầu ra của tiến trình chính | |
| `docker stop` / `start` / `rm` | Dừng / chạy lại / xoá hẳn | |
| `docker images` | Các image đang có | |

**`run` và `exec` khác nhau chỗ nào** là câu bạn phải trả lời được sau bài này. Gõ `docker run` mười lần là bạn có mười container.

## 7. Cái bài này CHƯA đụng tới

Dockerfile, layer, cache — bài 02. Volume, mạng, compose — bài 03. Đừng nhảy trước; bài này chỉ cần bạn *sống* với container đủ lâu để thấy nó là gì.
