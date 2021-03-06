#!/bin/bash
#--------+
# PACKER |
#--------+
# https://www.packer.io/downloads

# https://wiki.archlinux.de/title/Anleitung_f%C3%BCr_Einsteiger

# load custom keymap
loadkeys de-latin1-nodeadkeys

#---

# PARTITION
echo "\n\nPARTITION"

# dos partition table
# cfdisk
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sda

# format filesystem
mkfs.ext4 /dev/sda1

# mount filesystem
mount /dev/sda1 /mnt

#---

# LINUX
echo "\n\nLINUX"

# https://wiki.archlinux.org/title/Kernel/Arch_Build_System
# pacstrap /mnt base base-devel linux-lts linux-firmware
pacstrap /mnt base linux-lts

# automount partitions
genfstab -U /mnt >> /mnt/etc/fstab

#---

# PACKAGES
echo "\n\nPACKAGES"

# update database cache
pacman --noconfirm --root /mnt -Syu

# install bootloader
pacman --noconfirm --root /mnt -S grub
# install network tools
# pacman --noconfirm --root /mnt -S dhcpcd net-tools
# install addtional tools
pacman --noconfirm --root /mnt -S gcc tcc python

# clean cache
pacman --noconfirm --root /mnt -Sc

#---

# INITRAMFS
echo "\n\nINITRAMFS"

# support v86 keyboard
TMP=/mnt/etc/mkinitcpio.conf
sed -i "s/MODULES=()/MODULES=(atkbd i8042)/g" $TMP

#---

# BOOTLOADER
echo "\n\nBOOTLOADER"

# hide menu
# https://wiki.archlinux.org/title/GRUB/Tips_and_tricks
TMP=/mnt/etc/default/grub
sed -i "s/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/g" $TMP
sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/g" $TMP

# TODO: connect tty1 and ttyS0
# https://wiki.archlinux.org/title/Working_with_the_serial_console

#---

# hostname
echo "archlinux32" > /mnt/etc/hostname

#---

# CHROOT BOOTSTRAP
echo "\n\nBOOTSTRAP"

cat << 'EOF' > /mnt/bootstrap.sh
#!/bin/bash

# INITRAMFS

mkinitcpio -P

#---

# PASSWORD

echo "root:toor" | chpasswd

#---

# TELETYPE

# disable tty1
# systemctl disable getty@tty1.service
# enable ttyS0
systemctl enable serial-getty@ttyS0.service

#---

# CONFIGURATION

# TODO: change locales, timezone, ...
# https://wiki.archlinux.org/title/Installation_guide
# https://wiki.archlinux.de/title/Arch_Linux_auf_Deutsch_stellen
timedatectl set-timezone Europe/Berlin

#---

# BOOTLOADER

# install and write config
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
EOF

arch-chroot /mnt bash bootstrap.sh

#---

# AUTOLOGIN
echo "\n\nAUTOLOGIN"

# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console

# autologin ttyS0
# TMP=/mnt/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service
TMP=/mnt/usr/lib/systemd/system/serial-getty@.service
sed -i "s/agetty -o '.*'/agetty --autologin root/g" $TMP
sed -i "s/Type=idle/Type=simple/g" $TMP

#---

umount -R /mnt

# poweroff
# reboot