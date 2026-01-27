docker cp ../../code/config/kong.yaml kong-manager:/app/kong.yaml

docker exec kong-manager deck gateway validate kong.yaml && \
docker exec kong-manager deck gateway diff kong.yaml && \
docker exec kong-manager deck gateway sync kong.yaml
