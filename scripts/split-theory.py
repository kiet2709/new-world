"""Tach file nhap ly thuyet (phan cach bang ===slug===) vao lessons/<slug>/LY-THUYET.md.

    python3 split-theory.py <file1.md> [file2.md ...]
"""
import re
import sys
from pathlib import Path

LESSONS = Path("/mnt/d/project/new_world/lessons")
total = 0
for arg in sys.argv[1:]:
    txt = Path(arg).read_text(encoding="utf-8")
    for m in re.finditer(r"^===([a-z0-9-]+)===\n(.*?)(?=^===[a-z0-9-]+===|\Z)",
                         txt, re.S | re.M):
        slug, body = m.group(1), m.group(2).rstrip() + "\n"
        d = LESSONS / slug
        if not d.is_dir():
            print(f"  KHONG CO thu muc: {slug}")
            continue
        (d / "LY-THUYET.md").write_text(body, encoding="utf-8")
        total += 1
        print(f"  {slug}")
print(f"Da ghi {total} file ly thuyet")
