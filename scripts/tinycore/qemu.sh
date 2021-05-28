#!/bin/bash
#------+
# QEMU |
#------+
# https://www.qemu.org/download/

# install qemu-system
sudo apt install qemu-system -y

#---

# download image 
# http://tinycorelinux.net/downloads.html
wget -nc http://tinycorelinux.net/12.x/x86/release/CorePlus-current.iso

# create hda
qemu-img create tinycore.img 150M

# boot iso and mount hda
qemu-system-i386 -hda tinycore.img -cdrom CorePlus-current.iso -boot d -m 512