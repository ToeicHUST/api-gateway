from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import PlainScalarString

yaml = YAML()
yaml.preserve_quotes = True 

# Hàm giữ chữ null thay vì để trống
def represent_none(self, data):
    return self.represent_scalar('tag:yaml.org,2002:null', 'null')

yaml.representer.add_representer(type(None), represent_none)

file_path = '../../config/kong.yaml'

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        data = yaml.load(f)

    # --- Cấu hình tên biến môi trường (Không chứa giá trị thật) ---
    var_key_auth = "DECK_KONG_KEY_AUTH"
    var_log_url = "DECK_LOG_URL"
    var_log_token = "DECK_LOG_SECRET_TOKEN"
    var_supabase_host = "DECK_SUPABASE_HOST"

    # Định dạng chuỗi cho decK
    env_key_auth = PlainScalarString(f'${{{{ env "{var_key_auth}" }}}}')
    env_log_url  = PlainScalarString(f'${{{{ env "{var_log_url}" }}}}')
    env_log_token = PlainScalarString(f'Bearer ${{{{ env "{var_log_token}" }}}}')
    env_supabase_host = PlainScalarString(f'${{{{ env "{var_supabase_host}" }}}}')

    found_updates = False

    # 1. Xử lý Key-Auth (Dựa vào cấu trúc, không dựa vào giá trị cũ)
    try:
        if 'consumers' in data:
            data['consumers'][0]['keyauth_credentials'][0]['key'] = env_key_auth
            print(f"✅ Đã gán Key-Auth: {var_key_auth}")
    except (KeyError, IndexError):
        print("⚠️ Không tìm thấy cấu trúc keyauth_credentials")

    # 2. Xử lý Log URL và Token (Dựa vào key cấu hình)
    if 'plugins' in data:
        for plugin in data['plugins']:
            config = plugin.get('config', {})
            
            if 'http_endpoint' in config:
                config['http_endpoint'] = env_log_url
                found_updates = True
                print(f"✅ Đã gán URL: {var_log_url}")
            
            if 'headers' in config and 'Authorization' in config['headers']:
                config['headers']['Authorization'] = env_log_token
                found_updates = True
                print(f"✅ Đã gán Token: {var_log_token}")

    # 3. Xử lý Supabase Host (Dựa vào NAME service, an toàn hơn)
    if 'services' in data:
        target_service_name = 'supabase-auth-service' # Tên này không phải secret
        
        for service in data['services']:
            # Chỉ check nếu name trùng khớp
            if service.get('name') == target_service_name:
                service['host'] = env_supabase_host
                found_updates = True
                print(f"✅ Đã gán Supabase Host cho service: {target_service_name}")

    if not found_updates:
        print("⚠️ Không tìm thấy các vị trí cần cập nhật.")

    # Ghi lại vào file
    with open(file_path, 'w', encoding='utf-8') as f:
        yaml.dump(data, f)
    print("--- 🚀 Cập nhật file thành công ---")

except FileNotFoundError:
    print(f"❌ Không tìm thấy file {file_path}")