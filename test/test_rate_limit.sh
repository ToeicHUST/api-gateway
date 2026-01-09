#!/bin/bash

# URL của API bạn muốn kiểm tra (cổng mặc định của Kong Proxy là 8000)
URL="http://localhost:8000/your-api-endpoint"

echo "Bắt đầu gửi 25 requests để test Rate Limiting..."
echo "-----------------------------------------------"

for i in {1..25}
do
   # Gửi request và chỉ lấy mã trạng thái HTTP (HTTP Status Code)
   RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
   
   echo "Request lần $i: HTTP Status $RESPONSE"
   
   # Nếu nhận được mã 429 tức là đã bị chặn thành công
   if [ "$RESPONSE" == "429" ]; then
      echo ">>> Đã chạm ngưỡng giới hạn (Rate limit exceeded)!"
   fi
done

echo "-----------------------------------------------"
echo "Kết thúc kiểm tra."