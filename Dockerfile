# Build Stage
FROM --platform=$BUILDPLATFORM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136

# Runtime Stage
FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN setcap cap_net_bind_service=+ep /usr/bin/caddy; \
	chmod +x /usr/bin/caddy; \
	caddy version