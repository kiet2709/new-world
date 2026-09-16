# Bài 02 — Docker: image, layer, và cache
> KHỐI 0 — Nền tảng: công cụ và ba ngôn ngữ  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)  ·  [Giao thức học](../../docs/cach-hoc.md)

---

## Trước khi gõ dòng nào
Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. Đó là nền tối thiểu để bài này không thành mò mẫm.

---

## Yêu cầu

**Lý thuyết cần đọc trước:** Dockerfile là công thức · mỗi lệnh sinh một layer · cache key được tính thế nào · vì sao cache hỏng một layer thì **mọi layer phía sau hỏng theo**.

**Làm gì:**
- `docker history new_world-py` — nhìn thấy từng layer và kích thước của nó.
- `docker images` — **ghi lại size** của `new_world-py` và `new_world-cpp`. Bài 44 sẽ ép con số này xuống, cần mốc để so.
- Thí nghiệm cache: sửa `requirements.txt` → build → đo. Sửa một file `.py` → build → đo. Giải thích chênh lệch.
- **Đọc `docker/python/Dockerfile` và trả lời: có dòng nào COPY file `.py` vào image không?** Nếu không — thí nghiệm trên thật sự đang đo cái gì?
- `docker images -a` trước và sau khi build lại: image cũ có **biến mất** không?
- Tự viết một Dockerfile bé xíu (3–4 dòng), cố tình đặt sai thứ tự lệnh, đo, rồi sắp lại cho đúng.

**Xong khi:** **dự đoán đúng TRƯỚC khi chạy** — "tôi sửa dòng này thì build lại sẽ mất khoảng bao lâu, vì sao". Đoán đúng ba lần liên tiếp là bạn đã hiểu cache.

---

---

---

## Định nghĩa XONG

- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**
- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng
- [ ] Đã commit: `git commit -m "b02: <việc đã làm>"`

## Quy tắc 20 phút

Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. Ghi cả hai loại vào nhật ký.
