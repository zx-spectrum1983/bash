#!/bin/bash

sudo rm -rf ~/work/iso/casper
sudo mkdir ~/work/iso/casper

sudo cp ~/work/chroot/boot/vmlinuz-* ~/work/iso/casper/vmlinuz
sudo cp ~/work/chroot/boot/initrd.img-* ~/work/iso/casper/initrd

sudo chroot ~/work/chroot dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee ~/work/iso/casper/filesystem.manifest
sudo cp -v ~/work/iso/casper/filesystem.manifest ~/work/iso/casper/filesystem.manifest-desktop
REMOVE='ubiquity ubiquity-frontend-gtk ubiquity-frontend-kde casper laptop-detect os-prober'
for i in $REMOVE
do
    sudo sed -i "/${i}/d" ~/work/iso/casper/filesystem.manifest-desktop
done

sudo mksquashfs ~/work/chroot ~/work/iso/casper/filesystem.squashfs -processors 3 -throttle 50
printf $(sudo du -sx --block-size=1 ~/work/chroot | cut -f1) | sudo tee ~/work/iso/casper/filesystem.size
