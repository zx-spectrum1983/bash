#!/bin/bash

mkdir -p /home/$USER/work/chroot
cd /home/$USER/work/chroot
sudo debootstrap --arch=amd64 jammy . http://mirror.yandex.ru/ubuntu

echo "Next cmd: sudo arch-chroot ."
