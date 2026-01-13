import os

def cleanup_empty_files(directory_path):
    # Duyệt qua tất cả các file trong thư mục được chỉ định
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        
        # Kiểm tra xem có phải là file không (tránh xóa nhầm thư mục)
        if os.path.isfile(file_path):
            try:
                with open(file_path, 'r', encoding='utf-8') as file:
                    content = file.read()
                
                # Kiểm tra nếu nội dung sau khi strip() bị trống
                if content.strip() == "":
                    print(f"Đang xóa file trống: {filename}")
                    os.remove(file_path)
            except Exception as e:
                print(f"Không thể xử lý file {filename}: {e}")

# Sử dụng hàm (Thay '.' bằng đường dẫn thư mục của bạn)
path = r"C:\Users\Admin\Desktop\ToeicHUST\api-gateway - Copy\code\dev\temp\x"
cleanup_empty_files(path)