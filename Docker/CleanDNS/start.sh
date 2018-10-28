#! /bin/bash

source "$(dirname "$0")/default_env.sh"

BASE_CONF=/etc/CleanDNS
BASE_DNSMASQ_CONF=/etc/dnsmasq.d
SUPERVISOR_CONF=$BASE_CONF/supervisor.conf

if ! [ -e "$BASE_CONF" ]; then
    mkdir "$BASE_CONF"
fi

if ! [ -e "$SUPERVISOR_CONF" ]; then
    cp /data/supervisor.conf "$SUPERVISOR_CONF"
fi

print_setting
envsubst < /data/dnsmasq.d/templates/by_env.conf.tmpl >> "/etc/dnsmasq.d/by_env.conf"

if ! [ -e /etc/dnsmasq.d/gfw.conf ]; then
    envsubst < /data/dnsmasq.d/templates/default_gfw.conf.tmpl >> "/etc/dnsmasq.d/gfw.conf"
fi

for file in $(find /data/dnsmasq.d/static); do
    if ! [ -e "/etc/dnsmasq.d/$(basename "$file")" ]; then
        if [ -f "$file" ]; then
            cp "$file" "/etc/dnsmasq.d/$(basename "$file")"
        fi
    fi
done

cp "/data/update_gfw.sh" "/etc/periodic/update_gfw.sh"
chmod a+x "/data/update_gfw.sh"

"/data/update_gfw.sh"

echo port=${LISTEN_PORT} > "/etc/dnsmasq.d/by_env.conf"
if ! [ -z "${LISTEN_ADDRESS}" ]; then
    echo listen-address=${LISTEN_ADDRESS} >> "/etc/dnsmasq.d/by_env.conf"
fi

supervisord -c "$SUPERVISOR_CONF"
