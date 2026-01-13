

curl -i -X POST http://localhost:8001/upstreams \
--data "name=httpbin-upstream" \
--data "algorithm=round-robin" \
--data "hash_on=none" \
--data "hash_fallback=none" \
--data "slots=10000" \
--data "healthchecks.threshold=0"

curl -i -X POST http://localhost:8001/upstreams/httpbin-upstream/targets \
--data "target=httpbin.org:80" \
--data "weight=1"

curl -i -X POST http://localhost:8001/services \
--data "name=httpbin" \
--data "host=httpbin-upstream" \
--data "port=80" \
--data "protocol=http" \
--data "connect_timeout=60000" \
--data "read_timeout=60000" \
--data "write_timeout=60000" \
--data "retries=5"

curl -i -X POST http://localhost:8001/services/httpbin/routes \
--data "name=httpbin_route" \
--data "paths[]=/api/httpbin" \
--data "strip_path=true" \
--data "protocols[]=http" \
--data "protocols[]=https"

