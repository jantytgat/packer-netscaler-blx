#!/bin/sh
echo "########################################################################"
echo "NETSCALER BLX INSTALLATION"
echo "########################################################################"

dpkg --add-architecture i386
apt-get update
apt-get install -y libc6:i386

mkdir /var/blx_install
curl --output-dir /var/blx_install -O "${BLX_BASE_URL}/${BLX_VERSION}/${BLX_BUILD}/blx-deb-${BLX_VERSION}-${BLX_BUILD}.tar.gz"
cd /var/blx_install
tar zxvf *tar.gz
apt-get install -y /var/blx_install/blx-deb-${BLX_VERSION}-${BLX_BUILD}/*.deb

echo "########################################################################"
echo "NETSCALER BLX INSTALLATION - COMPLETED"
echo "########################################################################"
