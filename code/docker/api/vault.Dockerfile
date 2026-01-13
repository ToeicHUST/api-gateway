FROM kong:3.4

USER root

# Cài đặt Envconsul
COPY --from=hashicorp/envconsul:0.13 /bin/envconsul /usr/local/bin/envconsul
RUN chmod +x /usr/local/bin/envconsul

# Cài đặt Vault CLI
COPY --from=hashicorp/vault:1.21 /bin/vault /usr/local/bin/vault
RUN chmod +x /usr/local/bin/vault






# # RUN apt-get update && apt-get install -y git build-essential
# COPY ./plugins/kong-api-gateway-custom-plugin-vault-approle /tmp/kong-api-gateway-custom-plugin-vault-approle
# WORKDIR /tmp/kong-api-gateway-custom-plugin-vault-approle
# RUN luarocks make *.rockspec || luarocks make
# WORKDIR /usr/local/kong





USER kong






EXPOSE 8000 8443 8001 8444 8002

# 3. Sử dụng CMD để chạy chuỗi lệnh logic trực tiếp
# Chúng ta dùng sh -c để có thể thực hiện gán biến và nối lệnh trong cùng một shell session
CMD ["sh", "-c", "\
  export VAULT_TOKEN=$(vault write -field=token auth/approle/login \
  role_id=\"$VAULT_ROLE_ID\" \
  secret_id=\"$VAULT_SECRET_ID\") && \
  envconsul \
  -upcase \
  -no-prefix=true \
  -secret=\"$VAULT_DATA_PATH\" \
  sh -c 'env && kong migrations bootstrap && kong start' \
  "]