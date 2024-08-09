#!/bin/bash

set -euTCo pipefail
# set -x

declare -i max_timeout=60
declare -i counter=0

while true; do
# if timeout 10s nc -t -4 -v -l 172.31.10.2 7070; then
if timeout 15 tcpdump -qni any icmp and dst host 192.168.192.105 -c4 > /dev/null 2>&1; then
	echo healthy [okay]
	counter=0
else
	counter+=15
	if (( $counter >= 180 )); then
		echo error: host is down
		sleep $counter
	fi
	if (( $counter == 120 )); then
		echo warning: host is down
		# counter=120
	fi
	if (( $counter == 60 )); then
		echo notice: host is down
		# counter=60
	fi
	echo timeout: ${counter}s
fi
done

