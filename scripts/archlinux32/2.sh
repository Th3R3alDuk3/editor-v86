#!/bin/bash
########################
# BOOTABLE ARCHLINUX32 #
########################

## load custom keymap
loadkeys de-latin1

###

## create partition
# fdisk -l
# cfdisk /dev/sda
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sda
## format filesystem
mkfs.ext4 /dev/sda1
##  mount filesystem
mount /dev/sda1 /mnt

###

## install linux
# https://wiki.archlinux.org/title/Kernel/Arch_Build_System
# pacstrap /mnt base linux linux-firmware
pacstrap /mnt base linux-lts linux-firmware

###

## automount partitions
genfstab -U /mnt >> /mnt/etc/fstab

###

cat << "EOF" > /mnt/bootstrap.sh
#!/bin/bash

## update database cache
pacman -Sy
## additional packages
pacman -S vim tcc sl --noconfirm

## root password
echo "root:toor" | chpasswd

## autologin root
# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console
PATH=/etc/systemd/system/getty.target.wants/getty@tty1.service
# sed -i "s/agetty -o '.*'/agetty --autologin root/g" $PATH
# sed -i "s/TYPE=idle/TYPE=simple/g" $PATH

## system config
# TODO: change locales, timezone, ...
# https://wiki.archlinux.org/title/Installation_guide
# https://wiki.archlinux.de/title/Arch_Linux_auf_Deutsch_stellen#localectl
## timezone
timedatectl set-timezone Europe/Berlin
## keyboard
localectl set-keymap --no-convert de-latin1
## hostname
echo "archlinux32" > /etc/hostname
# network
pacman -S dhcpcd net-tools --noconfirm

## linux bootloader
pacman -S grub --noconfirm
## hidden style
# https://wiki.archlinux.org/title/GRUB/Tips_and_tricks
PATH=/etc/default/grub
sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g" $PATH
sed -i "s/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/g" $PATH
## serial console
https://wiki.archlinux.org/title/Working_with_the_serial_console
## install and write config
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg



###

## initramfs modules support v86 keyboard
PATH=/etc/mkinitcpio.conf
sed -i "s/MODULES=()/MODULES=(atkbd i8042)/g" $PATH

## write initramfs images
mkinitcpio -P
EOF

## chroot and bootstrap
arch-chroot /mnt bash bootstrap.sh

###

umount -R /mnt

# systemctl poweroff or ...
# reboot