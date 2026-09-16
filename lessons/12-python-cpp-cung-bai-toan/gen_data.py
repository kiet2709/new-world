"""Sinh file sensor_log.csv de lam de bai 02.

Day KHONG phai phan bai tap - no chi tao du lieu ban de ban co cai ma xu ly.
Phan bai tap la analyze.py va analyze.cpp: ban tu viet.

    python gen_data.py            # 1000 dong, du de doc bang mat
    python gen_data.py 1000000    # 1 trieu dong, du de do hieu nang
"""

import random
import sys
from datetime import datetime, timedelta, timezone

N = int(sys.argv[1]) if len(sys.argv) > 1 else 1000
OUT = "sensor_log.csv"

random.seed(42)  # cung seed -> cung file -> so do duoc so sanh giua cac lan chay

# Ty le loi co y giong du lieu that tu thiet bi: phan lon sach, thinh thoang ban.
P_DONG_HONG = 0.01  # thieu cot, chu thay vi so
P_THIEU_GIATRI = 0.02  # o trong
P_OUTLIER = 0.005  # cam bien nhieu / mat tiep xuc

t = datetime(2026, 1, 1, tzinfo=timezone.utc)

with open(OUT, "w", encoding="utf-8", newline="\n") as f:
    f.write("timestamp,nhiet_do,do_am\n")
    for i in range(N):
        t += timedelta(seconds=1)
        ts = t.isoformat()

        r = random.random()
        if r < P_DONG_HONG:
            # Dong hong that: thieu cot, hoac chu o cho phai la so.
            f.write(random.choice([f"{ts},23.1\n", f"{ts},ERR,45.2\n", f"{ts},,,\n"]))
            continue

        # Nhiet do dao quanh 25C theo mot nhip ngay dem gia lap.
        nhiet = 25.0 + 3.0 * random.gauss(0, 0.3) + (i % 3600) / 3600.0 * 2.0
        am = 60.0 + random.gauss(0, 4.0)

        if random.random() < P_OUTLIER:
            nhiet += random.choice([-40.0, 55.0])  # gia tri vo ly ro rang

        s_nhiet = "" if random.random() < P_THIEU_GIATRI else f"{nhiet:.2f}"
        s_am = "" if random.random() < P_THIEU_GIATRI else f"{am:.2f}"
        f.write(f"{ts},{s_nhiet},{s_am}\n")

print(f"Da ghi {N} dong vao {OUT}")
