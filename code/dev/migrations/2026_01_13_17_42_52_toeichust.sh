curl -X POST http://localhost:8001/plugins \
--data "name=rate-limiting" \
--data "config.minute=20" \
--data "config.policy=local"
