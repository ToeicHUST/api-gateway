from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import DoubleQuotedScalarString

yaml = YAML()
yaml.preserve_quotes = True 

# --- THÊM ĐOẠN NÀY ĐỂ GIỮ CHỮ NULL ---
def represent_none(self, data):
    return self.represent_scalar('tag:yaml.org,2002:null', 'null')

yaml.representer.add_representer(type(None), represent_none)
# -------------------------------------

file_path = 'kong.yaml'
try:
    with open(file_path, 'r', encoding='utf-8') as f:
        data = yaml.load(f)

    var_name = "KONG_KEY_AUTH"
    env_variable = DoubleQuotedScalarString(f'${{ env "{var_name}" }}')

    try:
        # Giả định cấu trúc của bạn
        data['consumers'][0]['keyauth_credentials'][0]['key'] = env_variable
        print(f"Đã chuyển đổi giá trị sang biến: {env_variable}")
    except (KeyError, IndexError) as e:
        print(f"Lỗi cấu trúc: {e}")

    with open(file_path, 'w', encoding='utf-8') as f:
        yaml.dump(data, f)

except FileNotFoundError:
    print(f"Không tìm thấy file {file_path}")