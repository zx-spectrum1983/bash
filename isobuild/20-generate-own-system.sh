#!/bin/bash

sudo rm -rf ~/work/chroot/

mkdir -p /home/$USER/work/chroot
sudo cp ./30-chroot-prepare-ubuntu.sh /home/$USER/work/chroot/
sudo cp ./sources.list /home/$USER/work/chroot/
cd /home/$USER/work/chroot
sudo debootstrap --arch=amd64 jammy . http://mirror.yandex.ru/ubuntu
cp /home/$USER/work/*.deb /home/$USER/work/chroot/

echo "Next cmd: sudo arch-chroot ~/work/chroot"
