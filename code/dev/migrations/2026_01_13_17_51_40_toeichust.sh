curl -i -X POST http://localhost:8001/plugins \
--data "name=http-log" \
--data "config.http_endpoint=https://webhook.site/82d86c80-19a2-46a1-a07d-e3188443710b" \
--data "config.method=POST" \
--data "config.content_type=application/json" \
--data "config.headers.Authorization=Bearer vuvannghia" \
--data "config.timeout=1000" \
--data "config.keepalive=60000" \
--data "config.retry_count=10" \
--data "config.queue_size=10" \
--data "config.flush_timeout=2"

