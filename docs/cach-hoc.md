# Cách học — giao thức cho mỗi buổi

> Bản lộ trình nói *học gì*. File này nói *học thế nào*.
> Cùng một bài, làm theo giao thức này ra kỹ sư; bỏ qua nó ra người copy code chạy được.

---

## Vòng lặp một buổi (4–6 giờ = 1 bài)

### Bước 1 — Đọc đề và đoán trước (15 phút, không gõ code)

Đọc mục bài trong `LO-TRINH-TUNG-BAI.md`. Rồi **viết vào `NHAT-KY.md` trước khi làm**:

> *"Tôi đoán sẽ làm thế này: ... Chỗ tôi nghĩ sẽ khó: ..."*

Kể cả đoán sai — **nhất là khi đoán sai**. Đây là điểm neo. Cuối bài đọc lại, khoảng cách giữa cái bạn đoán và cái thật sự xảy ra chính là thứ bạn vừa học được. Không có điểm neo thì cuối bài bạn sẽ có cảm giác "à cái này hiển nhiên mà" — cảm giác đó là ảo giác, và nó ăn mất bài học.

### Bước 2 — Tự làm 60–90 phút, KHÔNG AI

Chỉ được dùng: tài liệu chính thức, `man`, `--help`, datasheet, source code của thư viện.

Kẹt? **Ghi câu hỏi vào nhật ký thay vì hỏi ngay.** Nhiều câu sẽ tự trả lời được sau 20 phút nữa. Những câu còn lại là câu hỏi thật, đáng đem đi hỏi.

> **Ngoại lệ — chủ đề hoàn toàn mới:** nếu bạn chưa từng nghe tới thứ đó (lần đầu đụng FreeRTOS, lần đầu đọc datasheet I2C), đảo thứ tự: 30 phút đọc tài liệu/tutorial chính thống trước, rồi mới vào bước 2. Vật lộn trong vô minh không sinh ra hiểu biết, nó chỉ sinh ra chán.

### Bước 3 — Mở AI, nhưng hỏi đúng kiểu

Ba kiểu hỏi **nên** dùng:

| Kiểu | Ví dụ |
|---|---|
| Kiểm tra mô hình tư duy | *"Tôi đang hiểu bind mount thế này: ... Đúng không, sai chỗ nào?"* |
| Xác minh giả thuyết | *"Code này lỗi X, tôi đoán do Y. Giúp tôi kiểm chứng giả thuyết đó."* |
| Đào sâu cái đã chạy | *"Nó chạy rồi, nhưng vì sao phải có dòng này? Bỏ đi thì hỏng thế nào?"* |

Kiểu **không** nên dùng: *"Viết cho tôi code làm X."* Đó chính là chỗ vibe code sinh ra.

**Nếu buộc phải nhận code từ AI** (có lúc hợp lý — thư viện lạ, boilerplate dài): xoá hết comment nó viết, rồi **tự viết lại comment bằng lời của mình cho từng khối**. Khối nào bạn không giải thích nổi là khối bạn chưa sở hữu. Đánh dấu nó, quay lại sau.

### Bước 4 — Chạy, đo, rồi PHÁ

"Nó chạy" là **điểm giữa bài**, không phải điểm cuối. Sau khi chạy được:

- Rút dây cảm biến giữa chừng.
- Gửi input rác, input rỗng, input dài gấp 1000 lần.
- `kill -9` nó. Tắt mạng. Rút điện.
- Đo: nhanh bao nhiêu, tốn RAM bao nhiêu, ở *điều kiện nào*.

Ba mươi phút phá hoại dạy nhiều hơn ba giờ làm cho nó chạy. Và đây đúng là thứ nhà tuyển dụng hỏi mà 90% ứng viên không trả lời được.

### Bước 5 — Đóng sổ

Điền `NHAT-KY.md` (số thật, không ước lượng) → tick checklist trong `README.md` của bài → `git commit -m "bNN: ..."`.

**Không commit = bài chưa xong.** Không có ngoại lệ.

---

## Quy tắc 20 phút

Kẹt **quá** 20 phút mà không tiến thêm được chút nào → được phép hỏi AI.
Kẹt **dưới** 20 phút mà đã hỏi → bạn đang mua tốc độ bằng chiều sâu.

Ghi cả hai loại vào nhật ký. Cuối mỗi chặng nhìn lại tỉ lệ. Nếu gần như bài nào cũng hỏi trước 20 phút → đó là dữ liệu, không phải lời trách; nó nói rằng bạn đang đi quá nhanh so với nền hiện có.

---

## Dùng AI như thế nào — bốn vai

Đây là repo học, không phải repo giao hàng. Nên vai của AI ở đây khác với lúc đi làm.

**1. Người kiểm tra hiểu** *(dùng nhiều nhất)*
> *"Hỏi tôi 5 câu về bài 08. Đừng cho đáp án. Sau khi tôi trả lời thì chấm và chỉ chỗ tôi hiểu lệch."*

**2. Người review, không sửa hộ**
> *"Đọc `analyze.cpp` tôi vừa viết. Chỉ ra chỗ sai và chỗ dở, giải thích vì sao. KHÔNG viết code sửa."*

**3. Người ra đề phụ**
> *"Cho tôi 3 biến thể khó hơn của bài 07, mỗi biến thể thêm đúng một ràng buộc thực tế."*

**4. Người gỡ kẹt** *(chỉ sau quy tắc 20 phút)*
> *"Tôi kẹt ở ... Đã thử A, B, C. Triệu chứng là ... Gợi ý hướng nghĩ, đừng đưa lời giải ngay."*

Để ý: cả bốn vai đều **không** phải "gõ code hộ". Lớp gõ code là lớp mỏng nhất và là lớp duy nhất AI thay được. Cái bạn đang xây là lớp dưới nó.

---

## Nhịp tuần (quỹ 20+ giờ)

| | |
|---|---|
| 4 buổi × 4–5 giờ | 4 bài |
| 1 buổi 2–3 giờ | ôn lại tuần: đọc lại nhật ký, làm phép thử tắt AI, dọn commit |
| 1–2 ngày | **nghỉ hẳn, không đụng** |

Đừng học 7 ngày. Chặng 2 và 3 là marathon; người bỏ cuộc ở tuần 6 thường là người chạy nhanh nhất ở tuần 1.

---

## Ba tín hiệu cần chú ý

**Tín hiệu tốt — bạn đang học đúng:** bắt đầu *dự đoán được* cái sắp hỏng trước khi nó hỏng.

**Tín hiệu cảnh báo — dừng lại và quay về:** làm xong một bài mà không giải thích nổi vì sao nó chạy. Đừng đi tiếp. Nợ hiểu biết cộng dồn nhanh hơn nợ kỹ thuật, và ở bài 25 nó sẽ đòi.

**Tín hiệu trượt ray — cần chỉnh:** ba buổi liền chỉ loay hoay cài đặt/cấu hình, không chạm vào chip hay dữ liệu. Nhớ nguyên tắc 3 của la bàn: *cái bạn đang học lúc này là con chip, hay là cái công cụ?* Nếu là chip → chọn đường ít ma sát nhất, kể cả đường "bẩn", gỡ sau.
