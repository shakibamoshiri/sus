#!/bin/bash

declare -r local=${1:? local}
declare -r remote=${2:? remote}

echo "
ip tunnel add gre1 mode ip6gre local $local remote $remote ttl 255
ip addr add 192.168.192.1/30 dev gre1
ip link set dev gre1 mtu 1436
ip link set gre1 up

ip tunnel add gre1 mode ip6gre local $remote remote $local ttl 255
ip addr add 192.168.192.2/30 dev gre1
ip link set dev gre1 mtu 1436
ip link set gre1 up
"
