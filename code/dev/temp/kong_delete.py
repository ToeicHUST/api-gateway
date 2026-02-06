import requests


KONG_ADMIN = "http://localhost:8001"

# SERVICE_NAME = "jsonplaceholder-service"
# SERVICE_HOST = "jsonplaceholder.typicode.com"
# SERVICE_PORT = "80"


SERVICE_NAME = "jsonplaceholder-service"
SERVICE_HOST = "jsonplaceholder.typicode.com"
SERVICE_PORT = "80"


SERVICE_NAME = "httpbin"
SERVICE_HOST = "httpbin.org"
SERVICE_PORT = "80"


def main():

    # Các biến phụ trợ tự động suy ra
    route_name = f"{SERVICE_NAME}_route"
    upstream_name = f"{SERVICE_NAME}-upstream"
    target_addr = f"{SERVICE_HOST}:{SERVICE_PORT}"
    base_url = KONG_ADMIN.rstrip('/')

    print(f"--- Đang dọn dẹp tài nguyên cho: {SERVICE_NAME} ---")

    # 1. Xóa Route (Phải xóa trước tiên)
    print(f">>> Deleting route: {route_name}...")
    res_r = requests.delete(f"{base_url}/routes/{route_name}")
    print(f"Status: {res_r.status_code}")

    # 2. Xóa Service
    print(f">>> Deleting service: {SERVICE_NAME}...")
    res_s = requests.delete(f"{base_url}/services/{SERVICE_NAME}")
    print(f"Status: {res_s.status_code}")

    # 3. Xóa Target (Tùy chọn, thường xóa theo Upstream)
    print(f">>> Deleting target: {target_addr}...")
    res_t = requests.delete(
        f"{base_url}/upstreams/{upstream_name}/targets/{target_addr}")
    print(f"Status: {res_t.status_code}")

    # 4. Xóa Upstream
    print(f">>> Deleting upstream: {upstream_name}...")
    res_u = requests.delete(f"{base_url}/upstreams/{upstream_name}")
    print(f"Status: {res_u.status_code}")

    print("\n--- Hoàn tất dọn dẹp ---")


if __name__ == "__main__":
    main()
