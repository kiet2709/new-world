#!/usr/bin/env bash
# Sinh thu muc bai hoc tu bang tra cuu cuoi file LO-TRINH-TUNG-BAI.md.
# Chay lai duoc nhieu lan: khong ghi de file da co.
# Luu y: viet bang bash thuan (khong xargs/sed/subshell) vi tao process
# tren Git Bash/Windows rat cham.
set -euo pipefail
cd "$(dirname "$0")/.."

ROADMAP="LO-TRINH-TUNG-BAI.md"
created=0
skipped=0

trim() { # tra ket qua qua bien global TRIMMED, khong dung subshell
  TRIMMED="$1"
  TRIMMED="${TRIMMED#"${TRIMMED%%[![:space:]]*}"}"
  TRIMMED="${TRIMMED%"${TRIMMED##*[![:space:]]}"}"
}

while IFS='|' read -r _ c_num c_name c_path c_label _; do
  trim "$c_num";   num="$TRIMMED"
  [[ "$num" =~ ^[0-9][0-9]$ ]] || continue
  trim "$c_name";  name="$TRIMMED"
  trim "${c_path//\`/}"; path="$TRIMMED"
  trim "$c_label"; label="$TRIMMED"

  mkdir -p "$path"
  readme="$path/README.md"
  diary="$path/NHAT-KY.md"
  theory="$path/LY-THUYET.md"

  if [[ ! -f "$theory" ]]; then
    {
      printf '# Lý thuyết — Bài %s: %s\n\n' "$num" "$name"
      printf '> **Chưa viết.** Tôi viết file này trước khi bạn tới bài đó.\n'
      printf '> Nếu bạn đang đọc dòng này mà sắp làm bài %s, nhắn tôi: "viết lý thuyết bài %s".\n\n' "$num" "$num"
      printf -- '---\n\nPhần này chứa **nền lý thuyết tối thiểu** để bạn bắt đầu bài — không phải\n'
      printf 'giáo trình đầy đủ. Khái niệm nền thì tôi đưa; cách áp dụng và gỡ lỗi thì bạn tự vật lộn.\n'
    } >"$theory"
  fi

  if [[ -f "$readme" ]]; then
    skipped=$((skipped + 1))
  else
    {
      printf '# Bài %s — %s\n\n' "$num" "$name"
      if [[ -n "$label" ]]; then printf '> Nhãn: **%s**\n\n' "$label"; fi
      printf '**Đề bài đầy đủ:** xem mục `Bài %s` trong [LO-TRINH-TUNG-BAI.md](../../LO-TRINH-TUNG-BAI.md).\n\n' "$num"
      printf -- '---\n\n## Định nghĩa XONG\n\n'
      printf -- '- [ ] Tiêu chí "Xong khi" trong lộ trình đã đạt, và kiểm chứng được\n'
      printf -- '- [ ] Đã điền `NHAT-KY.md` bằng số liệu thật, không ước lượng\n'
      printf -- '- [ ] Đã commit: `git commit -m "b%s: <việc đã làm>"`\n' "$num"
      if [[ "$label" == "SO-SÁNH" ]]; then
        printf -- '- [ ] Có bảng so sánh Python vs C++ **trên cùng một bài toán**\n'
      fi
      if [[ "$label" == "PHÁN ĐOÁN" ]]; then
        printf -- '- [ ] Đã viết ra lựa chọn kèm **lý do bằng số**, không phải cảm tính\n'
      fi
      printf '\n## Ghi chú khi làm\n\n_(chỗ này của bạn)_\n'
    } >"$readme"
    created=$((created + 1))
  fi

  if [[ ! -f "$diary" ]]; then
    {
      printf '# Nhật ký — Bài %s: %s\n\n' "$num" "$name"
      printf '**Ngày làm:**\n\n**Số giờ thực tế:**\n\n---\n\n'
      printf '## 1. Tôi kẹt ở đâu\n\n\n\n'
      printf '## 2. Tôi hiểu ra điều gì mà trước đó không biết\n\n\n\n'
      printf '## 3. Số liệu đo được\n\n'
      printf '| Chỉ số | Giá trị | Điều kiện đo |\n|---|---|---|\n|  |  |  |\n\n'
      printf '## 4. Câu tôi chưa trả lời được\n\n'
      printf '_(ghi lại — đây chính là danh sách ôn phỏng vấn của bạn)_\n\n\n\n'
      printf '## 5. Phép thử tắt AI\n\n'
      printf -- '- [ ] Đã thử tự làm lại, không dùng AI\n\n'
      printf 'Kết quả trung thực (chọn một):\n'
      printf 'hiểu và gõ được / hiểu nhưng gõ chậm / nhìn mà không hiểu vì sao nó chạy\n\n\n'
    } >"$diary"
  fi
done <"$ROADMAP"

printf 'Đã tạo %s thư mục bài, bỏ qua %s thư mục đã có.\n' "$created" "$skipped"
