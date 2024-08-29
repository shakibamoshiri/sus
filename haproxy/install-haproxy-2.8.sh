#!/bin/bash

set -euTCo pipefail
set -x

### source
# https://haproxy.debian.net/#distribution=Debian&release=bullseye&version=2.8

curl https://haproxy.debian.net/bernat.debian.org.gpg |  gpg --dearmor > /usr/share/keyrings/haproxy.debian.net.gpg

echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
      http://haproxy.debian.net bullseye-backports-2.8 main \
      > /etc/apt/sources.list.d/haproxy.list

apt-get update -y

apt-get install haproxy=2.8.\* -y
