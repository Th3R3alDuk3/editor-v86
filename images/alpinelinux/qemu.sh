#!/bin/bash
#------+
# QEMU |
#------+
# https://www.qemu.org/download/

# install qemu-system
sudo apt install qemu-system -y

#---

# download image 
# https://alpinelinux.org/downloads/
wget -nc https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86/alpine-virt-3.13.5-x86.iso

# create hda
qemu-img create alpinelinux.img 600M

# boot iso and mount hda
qemu-system-i386 -hda alpinelinux.img -cdrom alpine-virt-3.13.5-x86.iso -boot d -m 512