# Moi truong DEV cho C/C++ (host x86_64).
# Cross-compile sang arm64 (Pi) va xtensa (ESP32) la bai hoc rieng, khong nhet vao day.
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        ninja-build \
        gdb \
        git \
        curl \
        pkg-config \
        clang-format \
        clang-tidy \
        valgrind \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

CMD ["sleep", "infinity"]
