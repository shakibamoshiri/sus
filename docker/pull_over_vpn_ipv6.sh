#!/bin/bash

set -euTCo pipefail

declare -r custom_table_id=${1:-6443}
declare -r vpn_gateway=${2:-fd:1986:2004:254::1}
declare -r domain_list=${3:-domain-list.txt}

printf "### dig resolve A records:\n"
cat < $domain_list
mapfile -t IPS < <(while read domain; do  dig AAAA +short $domain; done < $domain_list  | sort | uniq)


printf "\n\n### ip rule:\n"
for IP in "${IPS[@]}"; do
    echo ip -6 rule add from all to $IP lookup $custom_table_id
done

printf "\n\n### ip route:\n"
echo ip -6 route add table $custom_table_id default via $vpn_gateway
