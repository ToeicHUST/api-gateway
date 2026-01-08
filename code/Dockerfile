FROM kong:3.4

# # Chuyển sang root để có quyền ghi đè và đổi permission
# USER root

# # Copy và cấp quyền
# COPY docker-entrypoint.sh /docker-entrypoint.sh
# RUN chmod +x /docker-entrypoint.sh

# # (Tùy chọn) Chuyển lại user kong nếu muốn container chạy dưới quyền kong như mặc định
# USER kong

EXPOSE 8000 8443 8001 8444 8002

# ENTRYPOINT ["/docker-entrypoint.sh"]
# # CMD ["kong", "docker start"]