

  curl -X POST http://localhost:8001/services \
    --data name=kong-api-gateway \
    --data url=http://localhost:8001

  curl -X POST http://localhost:8001/services/kong-api-gateway/routes \
    --data paths[]=/kong-api-gateway



  curl -X POST http://localhost:8001/services/kong-api-gateway/plugins \
    --data name=key-auth

  curl -X POST http://localhost:8001/consumers \
    --data username=kong-api-gateway

  curl -X POST http://localhost:8001/consumers/kong-api-gateway/key-auth \
    --data key=2026_01_07_23_44_56_737139NghialIlIlIlIl2002$python



curl -i -X POST "http://localhost:8001/upstreams" \
    --data "name=jsonplaceholder-service-upstream"

curl -i -X POST "http://localhost:8001/upstreams/jsonplaceholder-service-upstream/targets" \
    --data "target=jsonplaceholder.typicode.com:80" \
    --data "weight=50"


curl -i -X POST "http://localhost:8001/services" \
    --data "name=jsonplaceholder-service" \
    --data "host=jsonplaceholder-service-upstream"

curl -i -s -X POST "http://localhost:8001/services/jsonplaceholder-service/routes" \
    --data "paths[]=/api/jsonplaceholder-service" \
    --data "strip_path=false" \
    --data "name=jsonplaceholder-service_route"

# http://localhost:8000/api/jsonplaceholder-service/posts
# http://localhost:8000/api/jsonplaceholder-service/users


# https://api.toeichust.me/api/jsonplaceholder-service/posts
# https://api.toeichust.me/api/jsonplaceholder-service/users




