#!/bin/bash
#
# Usage: $0 ~/ubuntu-22.04.1-desktop-amd64.iso
#

if [[ $(grep "boot=casper" ~/work/iso/boot/grub/grub.cfg) == "" ]]; then
    echo "grub.cfg"
    sudo sed -i 's/vmlinuz/vmlinuz boot=casper/g' ~/work/iso/boot/grub/grub.cfg
fi
if [[ $(grep "boot=casper" ~/work/iso/boot/grub/loopback.cfg) == "" ]]; then
    echo "loopback.cfg"
    sudo sed -i 's/vmlinuz/vmlinuz boot=casper/g' ~/work/iso/boot/grub/loopback.cfg
fi

cd ~/work/iso
sudo rm md5sum.txt
find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt

ISO="$1"
ISONAME=$(basename -- "$ISO")
ISOBNAME="${ISONAME%.*}"
MBR="$ISOBNAME.mbr"
EFI="$ISOBNAME.efi"
echo "$ISO $ISONAME $MBR $EFI"

# Extract the MBR template
if [ ! -f ~/$MBR ]; then
    dd if="$ISO" bs=1 count=446 of="$HOME/$MBR"
fi

# Extract EFI partition image
if [ ! -f ~/$EFI ]; then
    SKIP=$(/sbin/fdisk -l "$ISO" | fgrep '.iso2 ' | awk '{print $2}')
    SIZE=$(/sbin/fdisk -l "$ISO" | fgrep '.iso2 ' | awk '{print $4}')
    dd if="$ISO" bs=512 skip="$SKIP" count="$SIZE" of="$HOME/$EFI"
fi

TIMESTAMP=$(date +%s%3N)

sudo xorriso -as mkisofs \
    -r -V "$TIMESTAMP" -J -joliet-long -l \
    -iso-level 3 \
    -partition_offset 16 \
    --grub2-mbr $HOME/$MBR \
    --mbr-force-bootable \
    -append_partition 2 0xEF $HOME/$EFI \
    -appended_part_as_gpt \
    -c /boot.catalog \
    -b /boot/grub/i386-pc/eltorito.img \
    -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info \
    -eltorito-alt-boot \
    -e '--interval:appended_partition_2:all::' \
    -no-emul-boot \
    -o $HOME/$TIMESTAMP.iso \
    ~/work/iso

sudo chown $USER:$USER $HOME/$TIMESTAMP.iso
