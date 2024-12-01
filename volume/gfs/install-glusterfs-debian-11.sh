#!/bin/bash

set -euo pipefail
set -x

###
apt-get install -y gnupg2 apt-transport-https software-properties-common curl vim tree wget

###
curl https://download.gluster.org/pub/gluster/glusterfs/10/rsa.pub | gpg --dearmor > /usr/share/keyrings/glusterfs-archive-keyring.gpg

### 
DEBID=$(grep 'VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
DEBVER=$(grep 'VERSION=' /etc/os-release | grep -Eo '[a-z]+')
DEBARCH=$(dpkg --print-architecture)
echo "deb [signed-by=/usr/share/keyrings/glusterfs-archive-keyring.gpg] https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/${DEBID}/${DEBARCH}/apt ${DEBVER} main" | tee /etc/apt/sources.list.d/gluster.list

### 
apt-get update -y
apt-cache madison glusterfs-server | grep 11.1
apt-get install -y glusterfs-server

###
systemctl start glusterd
systemctl enable glusterd
systemctl status glusterd

