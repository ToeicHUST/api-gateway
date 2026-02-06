import uncurl
import re
import os

sh_file_path = r"C:\Users\Admin\Documents\GitHub\api-gateway\code\dev\migrations\2026_01_11_17_06_21_toeichust.sh"
py_file_path = sh_file_path.replace(".sh", ".py")

def clean_curl_command(cmd):
    # Loại bỏ các dấu gạch chéo ngược (\) ở cuối dòng trong file .sh
    cmd = cmd.replace("\\\n", " ").replace("\\", "")
    # Loại bỏ các khoảng trắng thừa và dòng trống
    cmd = " ".join(cmd.split())
    return cmd

def convert_sh_to_py():
    try:
        with open(sh_file_path, "r", encoding="utf-8") as f:
            content = f.read()

        # Regex tìm các lệnh bắt đầu bằng curl cho đến lệnh curl tiếp theo hoặc hết file
        list_curl_commands = re.findall(r'(curl.*?(?=curl|$))', content, re.DOTALL)

        py_content = "import requests\n\n"
        
        for index, curl_cmd in enumerate(list_curl_commands):
            # Làm sạch lệnh trước khi parse
            clean_cmd = clean_curl_command(curl_cmd)
            
            if not clean_cmd or len(clean_cmd) < 10: # Bỏ qua các chuỗi quá ngắn hoặc rỗng
                continue
            
            try:
                # Chuyển đổi sang code python requests
                python_code = uncurl.parse(clean_cmd)
                
                # py_content += f"# --- Lệnh curl số {index + 1} ---\n"
                # py_content += f"try:\n"
                py_content += f"response = {python_code}\n"
                py_content += f"print(f'Request {index + 1} - Status: {{response.status_code}}')\n"
                py_content += f"\n"
                py_content += f"\n"
                # py_content += f"    print(response.json() if 'application/json' in response.headers.get('Content-Type', '') else response.text)\n"
                # py_content += f"except Exception as e:\n"
                # py_content += f"    print(f'Lỗi khi thực thi lệnh {index + 1}: {{e}}')\n\n"
                
            except Exception as e:
                print(f"Không thể parse lệnh số {index + 1}: {e}")
                py_content += f"# Lỗi parse tại lệnh {index + 1}: {e}\n\n"

        with open(py_file_path, "w", encoding="utf-8") as f:
            f.write(py_content)
            
        print(f"Thành công! File lưu tại: {py_file_path}")

    except Exception as e:
        print(f"Lỗi: {e}")

if __name__ == "__main__":
    convert_sh_to_py()