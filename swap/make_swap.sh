#!/bin/bash

set -euTCo pipefail
set -x

declare -ir swap_size=${1:? error ... swap_size [G] ?}
declare -r swap_file=/swapfile

### allocate space 
fallocate -l "${swap_size}G" $swap_file

### or
# dd if=/dev/zero of=/swapfile bs=1024 count=1048576

### set permission
chmod 600 $swap_file

### make the swap partition
mkswap $swap_file

### enable swap
swapon $swap_file

### add to fstab
# echo "$swap_file swap swap defaults 0 0" >> /etc/fstab

### test
swapon --show

### test 2
free -h

