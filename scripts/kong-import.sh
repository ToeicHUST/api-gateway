#!/bin/bash

# 1. Khai báo biến
FILE="kong.yaml"
CONTAINER="kong-manager"

# echo "=========================================="
# echo "TRẠNG THÁI BAN ĐẦU:"
# # Kiểm tra xem file có đang bị thay đổi không (nếu có sẽ hiện chữ M màu đỏ)
# git status -s $FILE 
# echo "=========================================="

# echo "--- [1/4] Đang lưu tạm cấu hình hiện tại vào Stash ---"
# # Đặt message riêng để dễ nhận diện trong list
# git stash push -m "Auto-stash for Docker Sync: $FILE" $FILE

# echo "--- [DEBUG] Kiểm tra danh sách Stash ---"
# # Lệnh này sẽ show ra danh sách, bạn sẽ thấy dòng "Auto-stash..." ở trên cùng (stash@{0})
# git stash list | head -n 3 

# echo "--- [DEBUG] Kiểm tra trạng thái file sau khi Stash (Phải sạch) ---"
# # Lúc này lệnh này không nên hiện gì cả (file đã sạch)
# git status -s $FILE 

echo "=========================================="
echo "--- [2/4] Đẩy cấu hình sạch vào Container ---"
docker cp $FILE $CONTAINER:/app/$FILE

# 3. Chạy các lệnh deck
echo "--- [3/4] Đang chạy lệnh Deck trong Container ---"
# Dùng && để nếu lệnh trước lỗi thì dừng luôn, không chạy lệnh sau
docker exec $CONTAINER deck gateway validate $FILE && \
docker exec $CONTAINER deck gateway diff $FILE && \
docker exec $CONTAINER deck gateway sync $FILE

# echo "=========================================="
# echo "--- [4/4] Khôi phục lại bản nháp local ---"
# git stash pop

# echo "--- [DEBUG] Kiểm tra trạng thái cuối cùng (Phải có chữ M trở lại) ---"
# git status -s $FILE
# echo "=========================================="