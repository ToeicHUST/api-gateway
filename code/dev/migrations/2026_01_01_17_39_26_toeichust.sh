

curl -i -X POST http://localhost:8001/consumers \
--data "username=kong-api-gateway"

curl -i -X POST http://localhost:8001/consumers/kong-api-gateway/key-auth \
--data "key=vuvannghia"

curl -i -X POST http://localhost:8001/services \
--data "name=kong-api-gateway" \
--data "host=localhost" \
--data "port=8001"

curl -i -X POST http://localhost:8001/services/kong-api-gateway/routes \
--data "id=187a9376-e1a4-4a39-b446-b8d51f673dd6" \
--data "paths[]=/kong-api-gateway"

curl -i -X POST http://localhost:8001/services/kong-api-gateway/plugins \
--data "name=key-auth"

# echo "Không có thông tin"
# curl -i http://localhost:8000/kong-api-gateway/status

# echo "Gửi giá trị sai"
# curl -i http://localhost:8000/kong-api-gateway/status -H "apikey: example"

# echo "Gửi giá trị đúng"
# curl -i http://localhost:8000/kong-api-gateway/status -H "apikey: vuvannghia"

