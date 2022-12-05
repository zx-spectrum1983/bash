#!/bin/bash

sudo apt install debootstrap -y

mkdir -p work/chroot

cd work/

sudo debootstrap --arch=amd64 jammy chroot/ http://mirror.yandex.ru/ubuntu

cd chroot/

sudo mount proc -t proc ./proc
sudo mount sys -t sysfs ./sys
sudo mount --bind /dev ./dev
sudo mount --bind /dev/pts ./dev/pts

