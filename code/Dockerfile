FROM kong:3.4

# Copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8000 8443 8001 8444 8002

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kong", "docker-start"]