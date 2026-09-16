# Từ vựng ba thứ tiếng — Việt · English · 日本語

> **Kỷ luật xuyên suốt cả lộ trình.** Mỗi bài, khi gặp khái niệm mới, ghi nó vào đây bằng ba thứ tiếng.
> Chi phí ~10 phút mỗi bài. Sau 64 bài của Chặng 1 bạn có một cuốn từ điển kỹ thuật của riêng mình.

---

## Vì sao làm thế này

**Tiếng Anh: không thương lượng.** Datasheet, tài liệu ESP-IDF, Yocto, arXiv — tất cả đều tiếng Anh. Bạn đã đọc nó rồi, chỉ là chưa gọi tên việc đó ra.

**Tiếng Nhật: chiến lược.** Dò thị trường ở Chặng 1 cho thấy mảng **検査装置** (thiết bị kiểm tra) + C# + OpenCV đang được công ty offshore Việt Nam nhận từ Nhật. Đọc được spec tiếng Nhật là một khác biệt thật trong đội offshore — và nó đổi lại một quyết định cũ trong la bàn, vốn loại đường Nhật *vì cần tiếng Nhật*.

**Vì sao học lúc này rẻ:** bạn vừa bỏ công hiểu một khái niệm. Gắn thêm hai cái tên vào nó gần như không tốn gì. Học ngôn ngữ tách rời khỏi khái niệm thì đắt gấp nhiều lần và quên nhanh hơn.

## Hai tầng — đừng lẫn

| Tầng | Chi phí | Đạt được |
|---|---|---|
| **1. Thuật ngữ đối chiếu** (file này) | ~10 phút/bài | Đọc datasheet, spec, tài liệu kỹ thuật. Đủ làm việc trong đội offshore |
| **2. Tiếng Nhật thật (N3–N2)** | Đầu tư riêng, hàng trăm giờ | Xin việc, họp, làm trực tiếp với khách |

File này chỉ là tầng 1. Tầng 2 là quyết định riêng, để sau và tính riêng.

## Cách ghi

Mỗi khi gặp khái niệm mới, thêm một dòng. **Chỉ ghi thứ bạn đã hiểu** — chép từ điển thì vô nghĩa.

Với tiếng Nhật, ghi cả **cách đọc** (hiragana) cho từ Hán tự. Từ nào người Nhật quen dùng dạng katakana thì ghi katakana, đừng cố dịch sang Hán tự.

---

# Công cụ và phần mềm

| Việt | English | 日本語 | Ghi chú |
|---|---|---|---|
| máy ảo | virtual machine | 仮想マシン (かそう―) | |
| vùng chứa | container | コンテナ | |
| ảnh (Docker) | image | イメージ | |
| lớp | layer | レイヤ / 層 (そう) | |
| kho mã nguồn | repository | リポジトリ | |
| nhánh | branch | ブランチ | |
| xung đột (Git) | conflict | 競合 (きょうごう) / コンフリクト | |
| biên dịch | compile | コンパイル | |
| liên kết | link | リンク | bước sau biên dịch |
| gỡ lỗi | debug | デバッグ | |
| kiểm thử | test | テスト | |
| triển khai | deploy | デプロイ / 展開 (てんかい) | |
| bộ nhớ đệm | cache | キャッシュ | |
| mã nguồn | source code | ソースコード | |
| thư viện | library | ライブラリ | |
| phụ thuộc | dependency | 依存関係 (いぞんかんけい) | |

# Nhúng và phần cứng

| Việt | English | 日本語 | Ghi chú |
|---|---|---|---|
| nhúng | embedded | 組み込み (くみこみ) | **組み込みエンジニア** = kỹ sư nhúng |
| vi điều khiển | microcontroller | マイコン | rút gọn của マイクロコントローラ |
| phần sụn | firmware | ファームウェア | |
| nạp firmware | flash / write | 書き込み (かきこみ) | |
| cảm biến | sensor | センサ | thường không có trường âm cuối |
| cơ cấu chấp hành | actuator | アクチュエータ | |
| ngắt | interrupt | 割り込み (わりこみ) | |
| thời gian thực | real-time | リアルタイム | |
| truyền nối tiếp | serial communication | シリアル通信 (―つうしん) | |
| chống nhiễu (nút bấm) | debounce | チャタリング防止 (―ぼうし) | チャタリング = hiện tượng nảy |
| điện trở kéo lên | pull-up resistor | プルアップ抵抗 (―ていこう) | |
| nguồn điện | power supply | 電源 (でんげん) | |
| tiêu thụ điện | power consumption | 消費電力 (しょうひでんりょく) | |
| bo mạch | board / PCB | 基板 (きばん) | |
| sơ đồ mạch | schematic | 回路図 (かいろず) | |
| thông số kỹ thuật | datasheet / spec | 仕様書 (しようしょ) / データシート | |
| khởi động lại | reboot / restart | 再起動 (さいきどう) | |

# Công nghiệp và sản xuất

*Nhóm này đáng đầu tư nhất — đây là chỗ nền sản xuất của bạn gặp tiếng Nhật.*

| Việt | English | 日本語 | Ghi chú |
|---|---|---|---|
| thiết bị / máy | equipment | 装置 (そうち) | **từ khoá trung tâm**: 装置メーカー = hãng làm thiết bị |
| thiết bị kiểm tra | inspection equipment | 検査装置 (けんさそうち) | mảng offshore Nhật ↔ VN |
| dây chuyền sản xuất | production line | 生産ライン (せいさん―) | |
| băng chuyền | conveyor | コンベア | |
| điều khiển | control | 制御 (せいぎょ) | 制御ソフト = phần mềm điều khiển |
| điều khiển tuần tự | sequence control | シーケンス制御 | nền của PLC |
| PLC | PLC | **シーケンサ** / PLC | ở Nhật **rất hay gọi シーケンサ** — từ do Mitsubishi phổ biến |
| màn hình vận hành | HMI / touch panel | タッチパネル / 表示器 (ひょうじき) | |
| biến tần | inverter | インバータ | |
| động cơ servo | servo motor | サーボモータ | |
| hàng lỗi | defective product | 不良品 (ふりょうひん) | **từ dùng hằng ngày trong xưởng** |
| khuyết tật | defect | 欠陥 (けっかん) / 不良 (ふりょう) | |
| tỉ lệ đạt | yield | 歩留まり (ぶどまり) | **từ rất quan trọng** — nói được là biết bạn đã ở xưởng |
| tỉ lệ vận hành | operation rate / uptime | 稼働率 (かどうりつ) | |
| nhịp sản xuất | takt time | タクトタイム | |
| bảo trì | maintenance | 保守 (ほしゅ) / メンテナンス | |
| dừng máy | downtime / line stop | ライン停止 (―ていし) | thứ nhà máy sợ nhất |
| an toàn | safety | 安全 (あんぜん) | 安全装置 = thiết bị an toàn |
| dừng khẩn cấp | emergency stop | 非常停止 (ひじょうていし) | |

# AI và thị giác máy

| Việt | English | 日本語 | Ghi chú |
|---|---|---|---|
| học máy | machine learning | 機械学習 (きかいがくしゅう) | |
| học sâu | deep learning | 深層学習 (しんそうがくしゅう) / ディープラーニング | |
| mạng nơ-ron | neural network | ニューラルネットワーク | |
| huấn luyện | training | 学習 (がくしゅう) | |
| suy luận | inference | 推論 (すいろん) | |
| xử lý ảnh | image processing | 画像処理 (がぞうしょり) | 画像処理エンジニア là một chức danh có thật |
| phát hiện đối tượng | object detection | 物体検出 (ぶったいけんしゅつ) | |
| độ chính xác | accuracy | 精度 (せいど) | |
| báo nhầm | false positive | 過検出 (かけんしゅつ) / 誤検出 (ごけんしゅつ) | |
| bỏ sót | false negative | **見逃し (みのがし)** | nghĩa đen "nhìn mà để lọt" |
| lượng tử hoá | quantization | 量子化 (りょうしか) | |
| làm nhẹ model | lightweight / compression | 軽量化 (けいりょうか) | |
| tập dữ liệu | dataset | データセット | |
| gán nhãn | labeling / annotation | アノテーション / ラベル付け | |

# Mạng và giao thức

| Việt | English | 日本語 | Ghi chú |
|---|---|---|---|
| giao thức | protocol | プロトコル | |
| máy chủ | server | サーバ | |
| máy khách | client | クライアント | |
| độ trễ | latency | 遅延 (ちえん) | |
| thông lượng | throughput | スループット | |
| chứng chỉ | certificate | 証明書 (しょうめいしょ) | |
| xác thực | authentication | 認証 (にんしょう) | |
| mã hoá | encryption | 暗号化 (あんごうか) | |

---

## Ba cụm từ đáng thuộc nguyên câu

Không phải từ đơn — là cách người trong ngành nói:

| 日本語 | Nghĩa | Dùng khi |
|---|---|---|
| **稼働率を上げる** (かどうりつをあげる) | nâng tỉ lệ vận hành | Mục tiêu của gần như mọi dự án IoT nhà máy |
| **歩留まりを改善する** (ぶどまりをかいぜんする) | cải thiện tỉ lệ đạt | Lý do người ta mua hệ thống vision của bạn |
| **見逃しをなくす** (みのがしをなくす) | loại bỏ bỏ sót | Yêu cầu kinh điển của kiểm tra chất lượng — và nối thẳng vào bài 43 |

Ba câu này là **ngôn ngữ của người trả tiền**, không phải ngôn ngữ của kỹ sư. Nói được chúng là nói được lý do dự án tồn tại.

---

## Ghi chú về cách dùng

- **Katakana không phải "lười dịch".** Nhiều thuật ngữ kỹ thuật ở Nhật dùng katakana là chuẩn (コンテナ, デバッグ). Cố dịch sang Hán tự nghe kỳ.
- **Hán tự thì phải nhớ cách đọc**, không chỉ nhận mặt chữ — nếu định nói chứ không chỉ đọc.
- **Từ cùng nghĩa, sắc thái khác:** 不良 thiên về "hàng không đạt", 欠陥 thiên về "lỗi thiết kế/khuyết tật nghiêm trọng".
- Tiếng Anh cũng cần ghi: nhiều khái niệm bạn hiểu bằng tiếng Việt nhưng **không gọi tên được bằng tiếng Anh** khi phỏng vấn hoặc đọc paper.
