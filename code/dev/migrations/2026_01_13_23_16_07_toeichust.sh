curl -X POST http://localhost:8001/plugins \
  --data "name=request-size-limiting" \
  --data "config.allowed_payload_size=10" \
  --data "config.require_content_length=false"