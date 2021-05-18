#!/bin/bash
#####################
# ARCHLINUX32 IMAGE #
#####################

# https://mirror.archlinux32.org/archisos

## download archlinux32 image
wget -nc https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

###

## install qemu-system with i386 support
sudo apt install qemu-system -y

## create hda image file
# qemu-img create archlinux32-2021.04.06-i686.img 2G
qemu-img create archlinux32-2021.04.06-i686.img 5G

## boot iso file and mount hda image file
# qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 512
qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 1024