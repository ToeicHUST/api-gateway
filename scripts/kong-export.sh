docker exec -it kong-manager rm kong.yaml
docker exec -it kong-manager deck gateway dump -o kong.yaml

docker cp kong-manager:/app/kong.yaml kong.yaml
