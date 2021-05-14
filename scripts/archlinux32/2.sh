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
# pacstrap /mnt base linux-zen linux-firmware
pacstrap /mnt base linux-lts linux-firmware

###

## automatic mount partition
genfstab -U /mnt >> /mnt/etc/fstab

###

arch-chroot /mnt

## os settings
# TODO: change locales, timezone, ...
# https://wiki.archlinux.org/title/Installation_guide
# https://wiki.archlinux.de/title/Arch_Linux_auf_Deutsch_stellen#localectl

## root password
echo 'root:qwepoi123098' | chpasswd

## root autologin
# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console
mkdir -p /etc/systemd/system/getty@tty1.service.d
cat << 'EOF' > /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=-/usr/bin/agetty --autologin root --noclear %I $TERM
EOF

###

## packages
pacman -S vim tcc sl --noconfirm
pacman -S grub os-prober --noconfirm

###

## grub
grub-install /dev/sda
## hidden grub menu
# https://wiki.archlinux.org/title/GRUB/Tips_and_tricks
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/g' /etc/default/grub
## write grub config 
grub-mkconfig -o /boot/grub/grub.cfg

###

## initramfs modules support v86 keyboard
sed -i 's/MODULES=(/MODULES=(atkbd i8042 /g' /etc/mkinitcpio.conf

###

## write initramfs images
mkinitcpio -P

exit 

###

umount /mnt

# systemctl poweroff or ...
# reboot