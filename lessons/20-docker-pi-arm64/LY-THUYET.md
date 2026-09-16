# Lý thuyết — Bài 20: Docker trên Pi và kiến trúc arm64

## 1. Vì sao image của bạn không chạy trên Pi

Image Docker chứa **mã máy đã biên dịch cho một kiến trúc CPU cụ thể**.

| | Máy bạn | Raspberry Pi |
|---|---|---|
| Kiến trúc | `x86_64` (còn gọi `amd64`) | `aarch64` (còn gọi `arm64`) |
| Tập lệnh | Intel/AMD | ARM |

Hai tập lệnh **hoàn toàn khác nhau**. Mã máy x86 đưa cho CPU ARM thì nó không hiểu gì cả:

```
exec format error
```

Lỗi này nghĩa là: file chạy được, nhưng không phải cho CPU này.

*Pi Zero và Pi 1 dùng `armv6`, Pi 2/3 32-bit là `armv7`, Pi 3/4/5 64-bit là `arm64`. Kiểm tra bằng `uname -m`.*

## 2. Ba cách giải quyết

### Cách 1 — Build ngay trên Pi

```bash
docker build -t anh:latest .     # chạy trên Pi
```

Đúng kiến trúc chắc chắn. Nhưng **chậm**: Pi có 4 nhân yếu và RAM ít. Build image có OpenCV có thể mất 40 phút, và có khi hết RAM giữa chừng.

Vẫn nên làm **một lần** trong bài này để cảm nhận. Ghi lại thời gian.

### Cách 2 — buildx với QEMU (dùng chính)

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t user/anh:latest --push .
```

Máy Windows mạnh của bạn build cho **cả hai** kiến trúc. Nó làm được nhờ **QEMU** — bộ giả lập dịch lệnh ARM sang x86 lúc chạy.

```
   Máy bạn (x86)
   ┌──────────────────────────────────┐
   │  buildx                          │
   │   ├─ build cho amd64  (chạy thẳng, nhanh)
   │   └─ build cho arm64  (qua QEMU, chậm hơn ~2–5 lần
   │                         nhưng vẫn nhanh hơn Pi nhiều)
   └──────────────────────────────────┘
                 │ push
                 ▼
          Docker registry
                 │ pull
                 ▼
             Pi (arm64)
```

Bật hỗ trợ (Docker Desktop thường có sẵn):

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --name nw --use --bootstrap
```

### Cách 3 — Cross-compile thật (bài 48)

Không giả lập gì cả: dùng compiler sinh thẳng mã ARM. Nhanh nhất, nhưng phải dựng toolchain. Để dành cho C++ ở bài 48.

## 3. Manifest đa kiến trúc

Điều hay nhất của buildx: `user/anh:latest` trở thành **một danh sách manifest** — một cái tên trỏ tới nhiều image, mỗi cái cho một kiến trúc.

```
   user/anh:latest
   ├── linux/amd64  → sha256:aaa...
   └── linux/arm64  → sha256:bbb...
```

`docker pull` trên máy nào thì Docker **tự chọn đúng bản** cho máy đó. Cùng một lệnh, cùng một tên, chạy đúng ở mọi nơi.

```bash
docker buildx imagetools inspect user/anh:latest    # xem manifest có gì
```

Đây là điểm đáng đưa vào CV: dân web hiếm khi đụng đa kiến trúc, còn với IoT/edge thì nó là chuyện hằng ngày.

## 4. Cài Docker lên Pi — và chuyện iptables

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER      # rồi đăng xuất/vào lại
```

**Trước khi cài, chụp lại luật tường lửa** (bài 14 đã nhắc):

```bash
sudo iptables -S > ~/iptables-truoc-docker.txt
```

Docker chèn chuỗi luật riêng để làm NAT cho container. Hệ quả cần biết:

> **Docker `ports:` có thể vượt qua tường lửa của bạn.** Bạn chặn cổng 5432 bằng `ufw`, nhưng container có `ports: 5432:5432` vẫn phơi ra ngoài — vì luật của Docker nằm ở chuỗi `DOCKER` được xử lý trước.

Đây là bất ngờ khó chịu mà nhiều người chỉ phát hiện khi bị quét cổng. Cách xử lý ở bài 60: **đừng phơi cổng không cần**, và ràng cổng vào `127.0.0.1` khi chỉ dùng cục bộ.

## 5. Cấu hình Docker cho thẻ SD

Thẻ SD có số lần ghi hữu hạn. Docker ghi log rất nhiều.

```json
// /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": { "max-size": "10m", "max-file": "3" }
}
```

Không có giới hạn này, một container nói nhiều có thể **ghi đầy thẻ SD** trong vài tuần và làm chết hệ thống. Đây là lỗi vận hành rất thật.

## 6. Registry

Để đẩy image từ PC sang Pi cần một chỗ trung gian:

| Cách | Khi nào |
|---|---|
| Docker Hub (miễn phí, public) | Học, chia sẻ |
| GitHub Container Registry (ghcr.io) | **Tốt cho lộ trình này** — cùng chỗ với code, hợp với CI ở bài 61 |
| Registry tự dựng | Mạng nội bộ nhà máy, không có Internet |
| `docker save` + `scp` + `docker load` | Không có registry, làm nhanh |

Cách cuối đáng biết: nhà máy thật thường **không cho thiết bị ra Internet**. Chuyển image bằng file là chuyện bình thường ở đó.

## 7. Nghiệm thu

Một lệnh `docker run <tên>` chạy được **cùng một image name** trên cả PC và Pi. Và bạn giải thích được:

- Vì sao image amd64 không chạy trên Pi
- QEMU đang làm gì trong buildx
- Chênh lệch thời gian giữa build-trên-Pi và build-bằng-buildx (có số)
