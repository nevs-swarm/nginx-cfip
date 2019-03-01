FROM nginx:stable-alpine

COPY update-cloudflare-ips.sh /update-cloudflare-ips.sh

RUN apk add --no-cache curl \
    && sh /update-cloudflare-ips.sh \
    && apk del curl
