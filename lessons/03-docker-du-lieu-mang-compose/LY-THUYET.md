# Lý thuyết — Bài 03: Dữ liệu, mạng, và compose

## 1. Hệ thống file của container là tạm

Mặc định, mọi thứ container ghi ra đều nằm trong **lớp ghi** của riêng nó, và `docker rm` xoá sạch.

Với một dịch vụ thật thì không chấp nhận được: database mất dữ liệu mỗi lần khởi động lại, log biến mất, model tải về phải tải lại.

Docker có hai cách đưa dữ liệu ra ngoài vòng đời container.

## 2. Bind mount và volume

### Bind mount — nối thẳng một thư mục của máy chủ

```yaml
volumes:
  - .:/work        # thư mục repo trên Windows  →  /work trong container
```

Container nhìn thấy đúng thư mục thật của bạn. Sửa file bằng VS Code trên Windows → container thấy ngay, **không cần build lại**.

Đây là thứ làm cho cả lộ trình này chạy được: bạn code trên Windows, chương trình chạy trong Linux.

| Ưu | Nhược |
|---|---|
| Thấy ngay, không build lại | Phụ thuộc đường dẫn của máy bạn |
| Sửa bằng editor quen thuộc | Quyền truy cập rắc rối (Linux/Windows khác nhau) |
| Đọc/ghi được từ cả hai phía | Chậm hơn volume khi có nhiều file nhỏ |

### Volume — vùng lưu trữ do Docker quản lý

```yaml
volumes:
  - py-cache:/root/.cache
  - db-data:/var/lib/postgresql/data
```

Docker tự cấp một vùng lưu trữ, bạn không cần biết nó nằm đâu trên đĩa. Sống độc lập với container.

| Ưu | Nhược |
|---|---|
| Nhanh hơn, Docker tối ưu sẵn | Không mở bằng editor được dễ dàng |
| Không phụ thuộc máy nào | Phải dùng lệnh Docker để xem |
| Đúng chỗ cho dữ liệu dịch vụ | |

**Quy tắc chọn:** code của bạn → bind mount. Dữ liệu của dịch vụ (database, cache, model tải về) → volume.

## 3. Cái gì sống sót qua cái gì

Bảng này là mục tiêu chính của bài. Tự kiểm chứng từng dòng, đừng tin sẵn:

| Thao tác | Lớp ghi container | Volume | Bind mount |
|---|---|---|---|
| `docker stop` | **còn** | còn | còn |
| `docker rm` | **MẤT** | còn | còn |
| `docker compose down` | **MẤT** | còn | còn |
| `docker compose down -v` | MẤT | **MẤT** | còn |
| Xoá image, build lại | MẤT | còn | còn |
| Format máy Windows | mất | mất | **MẤT** |

Dòng cuối để nhắc: bind mount trỏ vào đĩa thật của bạn — nó **không phải bản sao lưu**. Git mới là bản sao lưu.

`.\dev.ps1 nuke` chính là `down -v`. Biết nó xoá gì trước khi gõ.

## 4. Mạng: vì sao gọi nhau bằng TÊN

Trong compose, các service nằm chung một mạng ảo, và **Docker chạy một máy chủ DNS nội bộ**. Tên service trở thành tên miền.

```python
client.connect("mqtt", 1883)     # "mqtt" là TÊN SERVICE, không phải IP
```

Vì sao điều này quan trọng: IP của container **đổi mỗi lần khởi động**. Nếu hardcode IP thì hôm sau hỏng. Tên service thì không bao giờ đổi.

### `ports` và `expose` khác nhau

```yaml
db:
  ports:
    - "5432:5432"      # <cổng trên máy bạn>:<cổng trong container>
```

`ports` **mở cổng ra ngoài máy bạn**. Không có `ports` thì service vẫn gọi nhau được trong mạng nội bộ — chỉ là bên ngoài không vào được.

Đây là nền của một nguyên tắc bảo mật ở bài 60: **database không nên có `ports`**. Chỉ dashboard và API cần phơi ra; DB thì chỉ service bên trong nói chuyện với nó là đủ.

*Trong repo hiện tại `db` vẫn có `ports` — cố ý, để bạn soi được bằng công cụ trên Windows lúc học. Bài 60 sẽ đóng lại.*

## 5. Compose — mô tả cả hệ thống bằng một file

Một hệ thống thật không có một container. Nó có: gateway, broker MQTT, database, dashboard, AI service. Chạy tay từng cái với `docker run` dài dằng dặc là không kham nổi.

Compose mô tả tất cả trong một file, rồi `up -d` một phát.

Các khoá cần hiểu ở bài này:

| Khoá | Nghĩa |
|---|---|
| `services` | Mỗi service là một container |
| `build` | Dựng image từ Dockerfile của bạn |
| `image` | Dùng image có sẵn từ registry |
| `volumes` | Bind mount hoặc volume |
| `networks` | Mạng nội bộ |
| `environment` | Biến môi trường |
| `ports` | Phơi cổng ra ngoài |
| `command` | Ghi đè lệnh mặc định |
| `profiles` | **Nhóm service, chỉ bật khi được gọi tên** |
| `depends_on` | Thứ tự khởi động |

### `profiles` để làm gì

```yaml
mqtt:
  profiles: [ot]
```

Service có `profiles` thì **không** chạy khi bạn gõ `docker compose up`. Phải gọi rõ:

```bash
docker compose --profile ot up -d
```

Lý do có nó trong repo này: ở Khối 0–1 bạn chưa cần MQTT, database hay Grafana. Bật cả năm service làm máy nặng và làm bạn rối. Tới Khối 2 mới cần thì mở.

Đây là một ví dụ nhỏ của nguyên tắc lớn: **chỉ bật thứ bạn đang dùng**.

## 6. Sau bài này

Bạn đã có đủ Docker cho phần lớn lộ trình. Ba mảnh còn thiếu sẽ tới đúng lúc cần: **build đa kiến trúc** cho Pi (bài 20), **truyền thiết bị vật lý** vào container (bài 21), **healthcheck và tự phục hồi** (bài 33), **multi-stage ép nhỏ image** (bài 44).
