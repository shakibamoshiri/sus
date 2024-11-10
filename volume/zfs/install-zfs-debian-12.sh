#/bin/bash

set -euTCo pipefail
set -x

cat <<END > /etc/apt/sources.list.d/bookworm-backports.list
deb http://deb.debian.org/debian bookworm-backports main contrib
deb-src http://deb.debian.org/debian bookworm-backports main contrib
END

cat <<END > /etc/apt/preferences.d/90_zfs
Package: src:zfs-linux
Pin: release n=bookworm-backports
Pin-Priority: 990
END

apt update -y
apt install -y -t bookworm-backports linux-image-amd64
apt install -y -t bookworm-backports linux-headers-amd64

reboot

### after reboot
# apt install dpkg-dev linux-headers-generic linux-image-generic
# apt install zfs-dkms zfsutils-linux
