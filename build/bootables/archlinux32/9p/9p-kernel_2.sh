#!/bin/bash
#-------------------------------+
# CUSTOM KERNEL WITH 9P SUPPORT |
#-------------------------------+

sudo apt install expect
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

#---

# https://cdn.kernel.org/pub/linux/kernel/v5.x/
# https://linuxhint.com/upgrade-kernel-on-arch-linux/

KERNEL_VERSION=5.12.6

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$(KERNEL_VERSION).tar.xz
tar -xf linux-$(KERNEL_VERSION).tar-xz

cd linux-$(KERNEL)

#---

# Network support
# [*] Plan 9 Resource Sharing Support (9P2000)
make nconfig

export ARCH=x86
make -j 4

make modules_install

cp -v arch/x86/boot/bzImage /boot/vmlinuz-$(KERNEL_VERSION)

#---

# mkinitcpio -P --kernel $(KERNEL_VERSION)
mkinitcpio -k $(KERNEL_VERSION) -g /boot/initramfs-$(KERNELVERSION).img

grub-mkconfig -o /boot/grub/grub.cfg