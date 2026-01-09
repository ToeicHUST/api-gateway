# docker ps

# docker exec -it kong-manager pwd && ls -la
docker exec -it kong-manager sh -c "if [ -f kong.yaml ]; then rm kong.yaml; echo 'Đã xóa file kong.yaml'; else echo 'File kong.yaml không tồn tại'; fi"

docker exec -it kong-manager deck gateway dump -o kong.yaml

docker cp kong-manager:/app/kong.yaml kong.yaml
npm run kong-credentials
