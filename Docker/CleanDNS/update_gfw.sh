#! /bin/bash

source "/data/default_env.sh"

list2dnsmasq -D /etc/dnsmasq.d/gfw.conf --rules-id gfwrule -i GFWSet --target-dns ${UPSTREAM_DNS}:${UPSTREAM_DNS_PORT} --add-domains /etc/dnsmasq.d/extra_gfw_domain --add-iplist /etc/dnsmasq.d/extra_gfw_ip
pkill dnsmasq
