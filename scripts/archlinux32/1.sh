#!/bin/bash
#------------------------+
# QEMU ARCHLINUX32 IMAGE |
#------------------------+

# https://mirror.archlinux32.org/archisos

# QEMU

# install qemu-system
sudo apt install qemu-system -y

#---

# IMAGE

# download image
wget -nc https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

# create hda
qemu-img create archlinux32-2021.04.06-i686.img 2G

# boot iso and mount hda
qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 512