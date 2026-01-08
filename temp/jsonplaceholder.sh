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

