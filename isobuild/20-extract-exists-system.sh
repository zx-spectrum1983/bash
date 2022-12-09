#!/bin/bash

sudo rm -rf ~/work/chroot
mkdir -p ~/work/chroot
sudo unsquashfs -f -p 3 -d ~/work/chroot ~/work/iso/casper/filesystem.squashfs
