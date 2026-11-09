#!/usr/bin/env bash
# Khởi chạy Course-Service phiên bản Mock (nginxdemos/hello)
# Chạy bằng: bash run-course-service.sh
set -euo pipefail

CONTAINER_NAME="rikkei-course-service"
HOST_PORT=8081
CONTAINER_PORT=80

# Kiểm tra cổng 8081 trên host có đang bị chương trình khác chiếm không
if ss -ltn | grep -q ":${HOST_PORT} "; then
    echo "Cổng ${HOST_PORT} đang được dùng bởi tiến trình khác (ví dụ user-service)."
    echo "Hãy tắt tiến trình đó trước, ví dụ: pkill -f user-service"
    ss -ltnp | grep ":${HOST_PORT} " || true
    exit 1
fi

# Xóa container cũ cùng tên (nếu có) để chạy lại được nhiều lần
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# Chạy container: detached (-d), đặt tên (--name), ánh xạ cổng host 8081 -> container 80 (-p)
docker run -d \
  --name "$CONTAINER_NAME" \
  -p ${HOST_PORT}:${CONTAINER_PORT} \
  nginxdemos/hello

# Kiểm tra
echo "---- docker ps ----"
docker ps --filter "name=${CONTAINER_NAME}"

echo "---- curl http://localhost:${HOST_PORT} ----"
sleep 2
curl -s http://localhost:${HOST_PORT} | head -n 20
