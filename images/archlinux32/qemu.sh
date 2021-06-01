#!/bin/bash
#------+
# QEMU |
#------+
# https://www.qemu.org/download/

# install qemu-system
sudo apt install qemu-system -y

#---

# download image 
# https://mirror.archlinux32.org/archisos
wget -nc https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

# create hda
qemu-img create archlinux32.img 2G

# boot iso and mount hda
qemu-system-i386 -hda archlinux32.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 512