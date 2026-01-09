# docker ps

# docker exec -it kong-manager pwd && ls -la
docker exec -it kong-manager sh -c "if [ -f kong.yaml ]; then rm kong.yaml; echo 'Đã xóa file kong.yaml'; else echo 'File kong.yaml không tồn tại'; fi"

docker cp kong.yaml kong-manager:/app/kong.yaml
# docker exec -it kong-manager pwd && ls -la


# docker exec -it kong-manager cat kong.yaml
# docker exec -it kong-manager sh -c 'echo $DECK_KONG_KEY_AUTH'

 


docker exec -it kong-manager deck gateway validate kong.yaml
docker exec -it kong-manager deck gateway diff kong.yaml
docker exec -it kong-manager deck gateway sync kong.yaml
