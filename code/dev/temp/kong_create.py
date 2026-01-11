import requests


KONG_ADMIN_URL = "http://localhost:8001"

# SERVICE_NAME = "jsonplaceholder"
# SERVICE_HOST = "jsonplaceholder.typicode.com"
# SERVICE_PORT = "80"

SERVICE_NAME = "httpbin"
SERVICE_HOST = "httpbin.org"
SERVICE_PORT = "80"


def main():

    # Tự động tạo các biến định danh dựa trên tên Service
    upstream_name = f"{SERVICE_NAME}-upstream"
    target_addr = f"{SERVICE_HOST}:{SERVICE_PORT}"
    route_name = f"{SERVICE_NAME}_route"
    route_path = f"/api/{SERVICE_NAME}"
    base_url = KONG_ADMIN_URL.rstrip('/')

    print(f"--- Đang khởi tạo tài nguyên Kong cho: {SERVICE_NAME} ---")

    # 1. Tạo Upstream
    print(f"\n1. >>> Creating upstream: {upstream_name}...")
    res_u = requests.post(f"{base_url}/upstreams",
                          data={"name": upstream_name})
    print(f"   Status: {res_u.status_code}")

    # 2. Tạo Target
    print(f"2. >>> Creating target: {target_addr}...")
    res_t = requests.post(
        f"{base_url}/upstreams/{upstream_name}/targets",
        data={"target": target_addr, "weight": 1}
    )
    print(f"   Status: {res_t.status_code}")

    # 3. Tạo Service
    print(f"3. >>> Creating service: {SERVICE_NAME}...")
    res_s = requests.post(
        f"{base_url}/services",
        data={"name": SERVICE_NAME, "host": upstream_name}
    )
    print(f"   Status: {res_s.status_code}")

    # 4. Tạo Route
    print(f"4. >>> Creating route: {route_name}...")
    res_r = requests.post(
        f"{base_url}/services/{SERVICE_NAME}/routes",
        data={
            "name": route_name,
            "paths[]": route_path,
            # "strip_path": "false"
        }
    )
    print(f"   Status: {res_r.status_code}")

    print("\n--- Hoàn tất thiết lập ---")
    print(f"URL truy cập: http://localhost:8000{route_path}")


if __name__ == "__main__":
    main()
