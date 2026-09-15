# Moi truong DEV cho Python. Co y giu don gian:
# image production (multi-stage, non-root, nho gon) la bai hoc rieng o Chang 3.
FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Cong cu he thong toi thieu: build wheel, git de xem diff trong container,
# i2c-tools/usbutils de soi thiet bi that khi chay tren Pi.
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        curl \
        iputils-ping \
        i2c-tools \
        usbutils \
        libgl1 \
        libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

# Copy rieng requirements truoc -> layer cache khong vo khi ban sua code.
# Day chinh la bai "toi uu thoi gian build" o muc 6 cua lo trinh.
COPY docker/python/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

CMD ["sleep", "infinity"]
