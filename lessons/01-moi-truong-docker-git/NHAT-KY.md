# Nhật ký — Bài 01: Môi trường Docker + Git

**Ngày làm:**

**Số giờ thực tế:**

-- 

đây là những gì tôi nghĩ cho bài 1 nha:
tôi chưa làm mới nghĩ thôi, nghĩ là bài này sẽ làm kiểu sẽ cho tôi bật container docker lên, vào xem version các thứ
xong rồi sẽ cho tôi hiểu cái gọi là bind, 1 file nằm trên container và nằm trên ổ đĩa thật thì khi sửa trên ổ đĩa thật và trên container nó bị thay đổi sao, cuối cùng là hỏi về các từ khóa của docker

## 1. Tôi kẹt ở đâu



## 2. Tôi hiểu ra điều gì mà trước đó không biết



## 3. Số liệu đo được

python: Python 3.12.14
g++: g++ (Debian 12.2.0-14+deb12u1) 12.2.0

thử tạo file test-cat.txt trong lessen 01 và cat lên:
root@d6e6164e097c:/work/lessons/01-moi-truong-docker-git# cat test-cat.txt
aaaaroot@d6e6164e097c:/work/lessons/01-moi-truong-docker-git#

tôi build lại sau khi sửa file requirements.txt thì thời gian build cỡ 109.5s (có thế tôi tính toán sai nhưng xấp xỉ á)

tôi tự tạo 1 file là bai1.py và build lại thì tốn 4.8s

tôi nghĩ sự chênh lệch này là do đổi requirements làm docker phải xóa đi môi trường cũ, tải thêm cái mới mà nó cần nên thời gian build sẽ lâu hơn, còn file py thì không ảnh hưởng môi trường nên cache từ môi trường cũ sẽ giúp nó build nhanh hơn (đây chỉ là phán đoán, tôi không tìm thấy tài liệu nói về cái này hoặc tôi không tra ra, chỉ có trả lời từ gemini là na ná tôi, tôi chưa tham khảo gemini nhé, tôi trả lời dựa trên tôi hiểu)


| Chỉ số | Giá trị | Điều kiện đo |
|---|---|---|
|  |  |  |

## 4. Câu tôi chưa trả lời được

_(ghi lại — đây chính là danh sách ôn phỏng vấn của bạn)_

tại sao 2 lệnh này như nhau?
root@d6e6164e097c:/work# cpp --version
cpp (Debian 12.2.0-14+deb12u1) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

root@d6e6164e097c:/work# g++ --version
g++ (Debian 12.2.0-14+deb12u1) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE


## 5. Phép thử tắt AI

- [ ] Đã thử tự làm lại, không dùng AI

Kết quả trung thực (chọn một):
hiểu và gõ được / hiểu nhưng gõ chậm / nhìn mà không hiểu vì sao nó chạy


