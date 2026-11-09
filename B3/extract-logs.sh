#!/usr/bin/env bash
# Trích xuất 15 dòng log cuối của container rikkei-course-service, kèm timestamps
# Chạy bằng: bash extract-logs.sh
set -euo pipefail

CONTAINER_NAME="rikkei-course-service"

# --tail 15 : chỉ lấy 15 dòng cuối
# -t        : gắn mốc thời gian (timestamps) ở đầu mỗi dòng
docker logs --tail 15 -t "$CONTAINER_NAME"
