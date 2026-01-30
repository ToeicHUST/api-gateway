curl -i -X POST http://localhost:8001/routes \
  --data paths[]=/favicon.ico \
  --data name=block-favicon


curl -i -X POST http://localhost:8001/routes/block-favicon/plugins \
  --data name=request-termination \
  --data config.status_code=200 \
  --data config.message="No favicon"

# http://localhost:8000/favicon.ico
