curl -i -X POST http://localhost:8001/services \
--data name=supabase-auth-service \
--data url=https://nthlcwuxpdnpgbgsxdoh.supabase.co/auth/v1



curl -i -X POST http://localhost:8001/services/supabase-auth-service/routes \
--data "paths[]=/api/auth" \
--data strip_path=true \
--data preserve_host=false \
--data name=supabase-auth-route


# http://localhost:8000/api/auth/authorize?provider=google
# http://localhost:8000/api/auth/.well-known/jwks.json