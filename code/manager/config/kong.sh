#!/bin/sh



deck version && deck gateway ping



# Định nghĩa định dạng thời gian
NOW=$(date +"%Y_%m_%d_%H_%M_%S")

# Dump dữ liệu ra file có timestamp và ghi đè vào kong.yaml nếu cần
deck gateway dump -o "temp_$NOW.yaml" && mv -f "temp_$NOW.yaml" kong.yaml


deck gateway validate kong.yaml
