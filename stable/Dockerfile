FROM nginx:stable

COPY update-cloudflare-ips.sh /update-cloudflare-ips.sh

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y curl ca-certificates \
    && sh /update-cloudflare-ips.sh \
    && apt-get remove --purge --auto-remove -y curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
