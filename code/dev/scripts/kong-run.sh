

docker exec -it kong-manager   deck gateway reset --force
 




MIGRATIONS_DIR="./migrations"


# 3. Lấy danh sách file .sh, sắp xếp theo tên và lặp qua từng file
# Việc sắp xếp theo tên giúp các file chạy đúng thứ tự thời gian YYYY_MM_DD
for file in $(ls "$MIGRATIONS_DIR"/*.sh | sort); do
  if [ -f "$file" ]; then
    echo "Đang thực thi: $file"
    
    # Chạy file migration
    bash "$file"
    
    # Kiểm tra xem file trước đó có chạy thành công không
    if [ $? -eq 0 ]; then
      echo "Hoàn thành: $file"
    else
      echo "Lỗi: Có lỗi xảy ra khi chạy $file. Dừng tiến trình."
      exit 1
    fi
  fi
done



docker exec -it kong-manager sh -c "if [ -f kong.yaml ]; then rm kong.yaml; echo 'Đã xóa file kong.yaml'; else echo 'File kong.yaml không tồn tại'; fi"
docker exec -it kong-manager deck gateway dump -o kong.yaml
docker cp kong-manager:/app/kong.yaml config/kong.yaml
