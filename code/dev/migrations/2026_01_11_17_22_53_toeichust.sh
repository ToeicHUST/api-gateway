
curl -i -X POST http://localhost:8001/plugins \
  --data "name=http-log" \
  --data "config.http_endpoint=https://webhook.site/82d86c80-19a2-46a1-a07d-e3188443710b" \
  --data "config.method=POST" \
  --data "config.timeout=1000" \
  --data "config.keepalive=60000" \
  --data "config.content_type=application/json" \
  --data "config.headers.Authorization=Bearer vuvannghia" \
  --data "config.retry_count=10" \
  --data "config.queue_size=1" \
  --data "config.flush_timeout=0" \
  --data "config.queue.max_batch_size=1" \
  --data "config.queue.max_entries=10000" \
  --data "config.queue.max_coalescing_delay=1" \
  --data "config.queue.initial_retry_delay=0.01" \
  --data "config.queue.max_retry_delay=60" \
  --data "config.queue.max_retry_time=60"