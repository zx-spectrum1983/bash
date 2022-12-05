#!/bin/bash

CHROOTDIR="$1"
UBUNTU="jammy"

sudo apt install debootstrap -y

mkdir -p $CHROOTDIR

sudo debootstrap --arch=amd64 $UBUNTU $CHROOTDIR/ http://mirror.yandex.ru/ubuntu

cd $CHROOTDIR/

sudo mount proc -t proc ./proc
sudo mount sys -t sysfs ./sys
sudo mount --bind /dev ./dev
sudo mount --bind /dev/pts ./dev/pts

sudo cp /etc/hosts ./etc/hosts
sudo cp /etc/resolv.conf ./etc/resolv.conf
sudo cp /etc/apt/sources.list ./etc/apt/sources.list

echo "sudo chroot ./ /usr/bin/env -i HOME=/root TERM=\"$TERM\" /bin/bash --login"

