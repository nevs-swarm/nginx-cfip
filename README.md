nginx-cfip
===
nginx Cloudflare IP

Based on the official [nginx](https://hub.docker.com/_/nginx) Docker image, this includes some additional configuration to easily block direct access to your origin.

This is by no means a highly secure approach, it is rather meant to prevent unwanted routes to your content/services.

In this image basically 3 files are added to the container:
File | Description
---- | -----------
/update-cloudflare-ips.sh | Script that fetches the current IP-ranges from Cloudflare
/etc/nginx/conf.d/cloudflare-realip.conf | Configuration block that will set the correct source IP of your visitor (e.g. for access logs)
/etc/nginx/conf.d/cloudflare-geo.conf | Configuration block that sets a variable to then conditionally allow/block access (see below)

Block or grant access
---
The added configuration will set a variable `$cloudflare_ip`, being either `0` or `1`. This can be utilized to e.g. block access when a request is not originating from a Cloudflare server:
```
if ($cloudflare_ip != 1) {
    return 403;
}
```

E.g.
```
server {
    listen       80;
    server_name  localhost;

    if ($cloudflare_ip != 1) {
        return 403;
    }

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```
