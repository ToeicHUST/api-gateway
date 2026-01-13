
curl -i -X POST http://localhost:8001/plugins \
--data "name=correlation-id" \
--data "config.header_name=request-id" \
--data "config.generator=uuid#counter" \
--data "config.echo_downstream=true"
