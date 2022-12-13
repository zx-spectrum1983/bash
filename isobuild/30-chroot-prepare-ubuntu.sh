#!/bin/bash

export PS1="(chroot) $PS1"
#dpkg-reconfigure locales
locale-gen --purge en_US.UTF-8
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale

cp sources.list /etc/apt/sources.list

apt update

apt install -y wget nano

apt install -y linux-firmware
PKGS="skl_guc_70.1.1.bin bxt_guc_70.1.1.bin kbl_guc_70.1.1.bin glk_guc_70.1.1.bin cml_guc_70.1.1.bin icl_guc_70.1.1.bin ehl_guc_70.1.1.bin tgl_guc_70.1.1.bin dg1_guc_70.1.1.bin adlp_guc_70.1.1.bin dg2_guc_70.1.2.bin dg2_dmc_ver2_06.bin"; for ITEM in $PKGS; do wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915/$ITEM -P /lib/firmware/i915/; done

apt install -y amd64-microcode busybox-initramfs cpio gettext-base grub-common grub-gfxpayload-lists grub-pc grub-pc-bin grub2-common initramfs-tools initramfs-tools-bin initramfs-tools-core intel-microcode iucode-tool klibc-utils libbrotli1 libdbus-glib-1-2 libefiboot1 libefivar1 libevdev2 libfreetype6 libfuse3-3 libgudev-1.0-0 libimobiledevice6 libklibc libplist3 libpng16-16 libpolkit-agent-1-0 libpolkit-gobject-1-0 libupower-glib3 libusb-1.0-0 libusbmuxd6 linux-base os-prober pkexec policykit-1 polkitd thermald upower usbmuxd wireless-regdb zstd

dpkg -i ./*.deb
rm -f *.deb

ln -s /boot/vmlinuz-* /boot/vmlinuz
ln -s /boot/initrd.img-* /boot/initrd.img

apt install -y ubuntu-advantage-desktop-daemon ubuntu-advantage-tools ubuntu-desktop ubuntu-desktop-minimal ubuntu-docs ubuntu-drivers-common ubuntu-keyring ubuntu-minimal ubuntu-mono ubuntu-release-upgrader-core ubuntu-release-upgrader-gtk  ubuntu-report ubuntu-session ubuntu-settings ubuntu-standard ubuntu-wallpapers ubuntu-wallpapers-jammy

#apt install -y linux-generic
#apt install ./linux-image-6.0.12_6.0.12-1_amd64.deb ./linux-headers-6.0.12_6.0.12-1_amd64.deb ./linux-libc-dev_6.0.12-1_amd64.deb


apt install -y casper laptop-detect  network-manager net-tools wireless-tools ubiquity ubiquity-casper ubiquity-frontend-gtk ubiquity-slideshow-ubuntu ubiquity-ubuntu-artwork


apt install -y network-manager network-manager-gnome network-manager-openvpn network-manager-openconnect network-manager-openvpn-gnome
systemctl disable systemd-networkd.service
systemctl disable networkd-dispatcher.service

apt clean
rm -rf /tmp/*
find /var/log -regex '.*?[0-9].*?' -exec rm -v {} \;
#exit
