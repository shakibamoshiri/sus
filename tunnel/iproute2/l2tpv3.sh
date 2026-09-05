#!/bin/bash
#
### source
# https://manpages.debian.org/testing/iproute2/ip-l2tp.8.en.html
###

set -e

declare -r local=${1:? local ?}
declare -r remote=${2:? remote ?}

echo "
### site-A
ip l2tp add tunnel tunnel_id 3000 peer_tunnel_id 4000 encap udp local $local remote $remote udp_sport 5000 udp_dport 6000
ip l2tp add session tunnel_id 3000 session_id 1000 peer_session_id 2000
ip link set l2tpeth0 up mtu 1488
ip addr add 10.200.1.1 peer 10.200.1.2 dev l2tpeth0
ip link set l2tpeth0 up


### site-B
ip l2tp add tunnel tunnel_id 4000 peer_tunnel_id 3000 encap udp local $remote remote $local udp_sport 6000 udp_dport 5000
ip l2tp add session tunnel_id 4000 session_id 2000 peer_session_id 1000
ip link set l2tpeth0 up mtu 1488
ip addr add 10.200.1.2 peer 10.200.1.1 dev l2tpeth0
ip link set l2tpeth0 up


### result (you should see)
# site-A
l2tpeth0         UNKNOWN        10.200.1.1 peer 10.200.1.2/32 fe80::e027:d1ff:fe82:b2e/64
# site-B
l2tpeth0         UNKNOWN        10.200.1.2 peer 10.200.1.1/32 fe80::748d:fff:fedf:926d/64


### clean up
# site-A
ip link set l2tpeth0 down
ip addr delete 10.200.1.1 peer 10.200.1.2 dev l2tpeth0
ip l2tp delete session tunnel_id 3000 session_id 1000 peer_session_id 2000

# site-B
ip link set l2tpeth0 down
ip addr delete 10.200.1.2 peer 10.200.1.1 dev l2tpeth0
ip l2tp delete session tunnel_id 4000 session_id 2000 peer_session_id 1000
"
