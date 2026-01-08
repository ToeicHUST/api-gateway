curl -i -X POST "http://localhost:8001/upstreams" \
    --data "name=dummyjson-service-upstream"


curl -i -X POST "http://localhost:8001/upstreams/dummyjson-service-upstream/targets" \
    --data "target=dummyjson.com:80" \
    --data "weight=100"


curl -i -X POST "http://localhost:8001/services" \
    --data "name=dummyjson-service" \
    --data "host=dummyjson-service-upstream"

curl -i -s -X POST "http://localhost:8001/services/dummyjson-service/routes" \
    --data "paths[]=/api/dummyjson" \
    --data "strip_path=true" \
    --data "name=dummyjson-service_route"

# http://localhost:8000/api/dummyjson/products
# http://localhost:8000/api/dummyjson/users
