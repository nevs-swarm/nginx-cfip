#!/bin/sh

CONFFILE_REALIP="/etc/nginx/conf.d/cloudflare-realip.conf"
CONFFILE_GEO="/etc/nginx/conf.d/cloudflare-geo.conf"
TEMPFILE="/tmp/cloudflareips"

curl -s -o - https://www.cloudflare.com/ips-v4 > $TEMPFILE
curl -s -o - https://www.cloudflare.com/ips-v6 >> $TEMPFILE

rm -f $CONFFILE_REALIP $CONFFILE_GEO

echo 'geo $realip_remote_addr $cloudflare_ip {' >> $CONFFILE_GEO
echo "default 0;" >> $CONFFILE_GEO

for LINE in $(cat $TEMPFILE); do
    echo "set_real_ip_from $LINE;" >> $CONFFILE_REALIP
    echo "$LINE 1;" >> $CONFFILE_GEO
done
echo "real_ip_header CF-Connecting-IP;" >> $CONFFILE_REALIP
echo "}" >> $CONFFILE_GEO

rm -f $TEMPFILE
