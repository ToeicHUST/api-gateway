MIGRATIONS_DIR="./migrations"


for file in $(ls "$MIGRATIONS_DIR"/*.sh | sort); do
    if [ -f "$file" ]; then
        echo "Đang thực thi: $file"

        bash "$file"
        
        if [ $? -eq 0 ]; then
            echo "Hoàn thành: $file"
        else
            echo "Lỗi: Có lỗi xảy ra khi chạy $file. Dừng tiến trình."
            exit 1
        fi
    fi
done

 