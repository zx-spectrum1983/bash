#!/bin/bash
#
# Usage: $0 ~/ubuntu-22.04.1-desktop-amd64.iso
# wget https://releases.ubuntu.com/22.04.1/ubuntu-22.04.1-desktop-amd64.iso
#

ISOFILE="$1"

sudo rm -rf ~/work/iso
sudo mkdir /mnt/iso$USER
sudo mount -o loop $ISOFILE /mnt/iso$USER
mkdir -p ~/work/iso
sudo cp -rf /mnt/iso$USER/* ~/work/iso
sudo umount /mnt/iso$USER
sudo rm -rf /mnt/iso$USER
