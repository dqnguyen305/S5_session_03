#!/usr/bin/env bash
# Cấu hình môi trường cho Frontend QA: truyền biến môi trường và xác minh bên trong container
# Chạy bằng: bash exec-frontend.sh
set -euo pipefail

CONTAINER_NAME="rikkei-frontend-qa"

# Xóa container cũ cùng tên (nếu có) để chạy lại được nhiều lần
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# 1. Khởi chạy container nginx (chạy ngầm), truyền biến môi trường API_ENDPOINT bằng cờ -e
docker run -d \
  --name "$CONTAINER_NAME" \
  -e API_ENDPOINT=https://qa-api.rikkei.edu.vn \
  nginx

# 2. Mở bash shell tương tác bên trong container
#    Tại shell của container, gõ:  echo $API_ENDPOINT
#    Kết quả mong muốn: https://qa-api.rikkei.edu.vn
#    Gõ exit để thoát về máy host.
docker exec -it "$CONTAINER_NAME" bash
