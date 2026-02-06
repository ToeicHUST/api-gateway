git stash push -m "Auto-stash for Docker Sync: kong.yaml" ../../code/config/kong.yaml
git stash list | head -n 3

npm run import

git stash pop
