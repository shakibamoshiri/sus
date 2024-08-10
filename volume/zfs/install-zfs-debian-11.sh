#!/bin/bash 

set -ex

apt update -y
apt install -y software-properties-common
apt-add-repository contrib  -y
apt update -y
apt install -y linux-headers-$(uname -r) linux-image-amd64 spl kmod 
apt install -y zfsutils-linux zfs-dkms zfs-zed
