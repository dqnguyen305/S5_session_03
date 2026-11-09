#!/usr/bin/env bash
# Thiết lập user và không gian làm việc cho Rikkei LMS (course-service)
# Chạy bằng: sudo bash setup-workspace.sh
set -euo pipefail

APP_USER="rikkeilms"
APP_DIR="/opt/rikkei/course-service"

# 1. Tạo user rikkeilms (kèm group cùng tên và thư mục home), bỏ qua nếu đã tồn tại
if id "$APP_USER" &>/dev/null; then
    echo "User $APP_USER đã tồn tại, bỏ qua bước tạo user."
else
    useradd -m -s /bin/bash "$APP_USER"
fi

# 2. Tạo thư mục gốc chứa mã nguồn và cấu hình
mkdir -p "$APP_DIR"

# 3. Chuyển quyền sở hữu cho user rikkeilms và group rikkeilms
chown "$APP_USER":"$APP_USER" "$APP_DIR"

# 4. Phân quyền: chủ sở hữu rwx, group và người khác chỉ r-x  => drwxr-xr-x
#    (chỉ chủ sở hữu mới có quyền ghi)
chmod 755 "$APP_DIR"

# 5. Kiểm tra kết quả
ls -ld "$APP_DIR"
