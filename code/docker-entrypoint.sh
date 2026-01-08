#!/bin/sh
set -e

# Chạy migrations
kong migrations bootstrap || kong migrations up

# Khởi động Kong
exec "$@"