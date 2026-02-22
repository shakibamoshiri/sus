#!/bin/bash

set -ex

###
### link
### https://pkg.cloudflareclient.com/
###

### enable wireguard kernel log
# modprobe wireguard 
# echo module wireguard +p > /sys/kernel/debug/dynamic_debug/control

apt-get update -y
apt-get install -y gpg


# Add cloudflare gpg key
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

# Add this repo to your apt repositories
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list

# Install
apt-get -o Acquire::ForceIPv4=true update -y
apt-get -o Acquire::ForceIPv4=true install -y cloudflare-warp

### disable the service
systemctl disable warp-svc

### exclude all
# warp-cli add-excluded-route 0.0.0.0/0
warp-cli tunnel ip add-range 0.0.0.0/0

### set mode and protocol
warp-cli mode warp
warp-cli tunnel protocol set MASQUE

### show settings
warp-cli settings

### make an account
# warp-cli register
echo try: warp-cli registration new

### connect
# warp-cli connect
echo try: warp-cli connect
