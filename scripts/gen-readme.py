"""Sinh README.md day du cho tung bai tu LO-TRINH-TUNG-BAI.md.
Chay lai duoc: luon ghi de README.md (nguon su that la file lo trinh),
KHONG dung toi NHAT-KY.md hay LY-THUYET.md.
"""
import re
from pathlib import Path

ROOT = Path("/mnt/d/project/new_world")
LESSONS = ROOT / "lessons"
md = (ROOT / "LO-TRINH-TUNG-BAI.md").read_text(encoding="utf-8")

slug = {n: s for n, s in re.findall(r"\| (\d{2}) \| .+? \| `lessons/([^`]+)` \|", md)}
khoi = {}  # so bai -> ten khoi
cur_khoi = ""
for line in md.splitlines():
    m = re.match(r"^# (KHỐI \d) — (.+?) \(Bài (\d{2})–(\d{2})", line)
    if m:
        cur_khoi = f"{m.group(1)} — {m.group(2)}"
        for n in range(int(m.group(3)), int(m.group(4)) + 1):
            khoi[f"{n:02d}"] = cur_khoi

body = md[md.index("# KHỐI 0 —"): md.index("## Đầu ra Chặng 1")]
marks = list(re.finditer(r"(?m)^### Bài (\d{2}) — (.+?)$", body))
count = 0
for k, m in enumerate(marks):
    num, title_raw = m.group(1), m.group(2)
    end = marks[k + 1].start() if k + 1 < len(marks) else len(body)
    sec = body[m.end():end]
    cut = re.search(r"(?m)^#{1,2} ", sec)
    if cut:
        sec = sec[: cut.start()]
    sec = sec.strip()
    sec = re.sub(r"\n*---\s*$", "", sec).strip()

    label = ""
    lm = re.search(r"`\[(.+?)\]`", title_raw)
    if lm:
        label = lm.group(1)
    title = re.sub(r"\s*`\[.*", "", title_raw).strip()

    d = LESSONS / slug[num]
    if not d.is_dir():
        print(f"  THIEU thu muc cho bai {num}")
        continue

    out = [f"# Bài {num} — {title}\n"]
    out.append(f"> {khoi.get(num, '')}  ·  [Toàn bộ lộ trình](../../LO-TRINH-TUNG-BAI.md)"
               f"  ·  [Giao thức học](../../docs/cach-hoc.md)\n")
    if label:
        out.append(f"> **Nhãn: {label}**\n")
    out.append("\n---\n\n## Trước khi gõ dòng nào\n")
    out.append("Đọc [LY-THUYET.md](LY-THUYET.md) trong chính thư mục này. "
               "Đó là nền tối thiểu để bài này không thành mò mẫm.\n")
    out.append("\n---\n\n## Yêu cầu\n\n")
    out.append(sec + "\n")
    out.append("\n---\n\n## Định nghĩa XONG\n\n")
    out.append('- [ ] Đạt tiêu chí "Xong khi" ở trên, và **kiểm chứng được**\n')
    out.append("- [ ] Đã điền [NHAT-KY.md](NHAT-KY.md) bằng số liệu thật, không ước lượng\n")
    out.append(f'- [ ] Đã commit: `git commit -m "b{num}: <việc đã làm>"`\n')
    if label == "SO-SÁNH":
        out.append("- [ ] Có bảng so sánh hai ngôn ngữ **trên cùng một bài toán**\n")
    if label == "PHÁN ĐOÁN":
        out.append("- [ ] Đã viết ra lựa chọn kèm **lý do bằng số**, không phải cảm tính\n")
    if label == "ĐỆM":
        out.append("- [ ] Tự viết lại được phần cốt lõi **không dùng AI** — bài đệm mà vẫn phải tra "
                   "thì chưa xong\n")
    out.append("\n## Quy tắc 20 phút\n\n")
    out.append("Kẹt **quá** 20 phút không nhúc nhích → được hỏi AI. "
               "Kẹt **dưới** 20 phút mà đã hỏi → đang mua tốc độ bằng chiều sâu. "
               "Ghi cả hai loại vào nhật ký.\n")
    (d / "README.md").write_text("".join(out), encoding="utf-8")
    count += 1

print(f"Da sinh {count} README.md")
