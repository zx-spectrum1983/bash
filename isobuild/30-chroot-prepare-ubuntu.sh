#!/bin/bash

export PS1="(chroot) $PS1"
dpkg-reconfigure locales
apt update

apt install -y ubuntu-advantage-desktop-daemon ubuntu-advantage-tools ubuntu-desktop ubuntu-desktop-minimal ubuntu-docs ubuntu-drivers-common ubuntu-keyring ubuntu-minimal ubuntu-mono ubuntu-release-upgrader-core ubuntu-release-upgrader-gtk  ubuntu-report ubuntu-session ubuntu-settings ubuntu-standard ubuntu-wallpapers ubuntu-wallpapers-jammy

apt install -y linux-generic

apt install casper laptop-detect  network-manager net-tools wireless-tools ubiquity ubiquity-casper ubiquity-frontend-gtk ubiquity-slideshow-ubuntu ubiquity-ubuntu-artwork

apt clean
rm -rf /tmp/*
find /var/log -regex '.*?[0-9].*?' -exec rm -v {} \;
exit
