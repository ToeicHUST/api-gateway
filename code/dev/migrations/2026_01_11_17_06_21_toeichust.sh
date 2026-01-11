

curl -i -X POST http://localhost:8001/consumers \
  --data "username=kong-api-gateway"

curl -i -X POST http://localhost:8001/consumers/kong-api-gateway/key-auth \
  --data "key=vuvannghia"

curl -i -X POST http://localhost:8001/services \
  --data "name=kong-api-gateway" \
  --data "host=localhost" \
  --data "port=8001" \
  --data "protocol=http" \
  --data "connect_timeout=60000" \
  --data "read_timeout=60000" \
  --data "write_timeout=60000" \
  --data "retries=5"

curl -i -X POST http://localhost:8001/services/kong-api-gateway/routes \
  --data "id=187a9376-e1a4-4a39-b446-b8d51f673dd6" \
  --data "paths[]=/kong-api-gateway" \
  --data "strip_path=true" \
  --data "protocols[]=http" \
  --data "protocols[]=https"



curl -i -X POST http://localhost:8001/services/kong-api-gateway/plugins \
  --data "name=key-auth" \
  --data "config.key_names[]=apikey" \
  --data "config.key_in_header=true" \
  --data "config.key_in_query=true" \
  --data "config.key_in_body=false" \
  --data "config.hide_credentials=false" \
  --data "config.run_on_preflight=true"