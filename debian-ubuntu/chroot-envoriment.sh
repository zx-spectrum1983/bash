#!/bin/bash

#apt update

export PS1="(chroot) $PS1"

#apt install locales -y
#echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#locale-gen
#update-locale LANG=en_US.UTF-8

#ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

#apt install ubuntu-standard casper -y
#apt install discover laptop-detect os-prober -y
#apt install linux-generic -y
#apt install grub2 plymouth-x11
#apt install --no-install-recommends network-manager

#apt install ubiquity-frontend-gtk -y

cd /tmp
cp /initrd.img ./initrd0.gz
casper-new-uuid /tmp/initrd0.gz /tmp/initrd.gz /tmp/casper-uuid-generic
mkdir /tmp/tmp
cd ./tmp
gunzip -dc ../initrd.gz | cpio -imvd --no-absolute-filenames
find . | cpio --quiet --dereference -o -H newc | lzma -7 > ../initrd.lz
cp -v /tmp/{initrd.lz,casper-uuid-generic} /
cd /
rm -rfv /tmp/*
