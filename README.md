# editor-v86-tcc

https://github.com/copy/v86/wiki/How-to-Compile-v86-(Both-for-embedded-use-and-with-the-GUI)
  
Some images for vor v86 emulation:  
https://github.com/copy/images

## Installation

### using Qemu & ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md

- execute script `/public/scripts/1.sh`
-- download archlinux32 image 
-- create hda image file
-- boot iso file and mount hda image file

```shell
## download archlinux32 image
wget -nc https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

###

## create hda image file
# qemu-img create archlinux32-2021.04.06-i686.img 2G
qemu-img create archlinux32-2021.04.06-i686.img 5G

## boot iso file and mount hda image file
# qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 512
qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 1024
```

- switch to qemu console

```shell
## download script
curl -O 192.168.xxx.xxx:xxxx/2.sh
```

- execute script `/public/scripts/2.sh`
-- create and mount filesystem `/dev/sda1`
-- setting up `linux`
-- setting up `bootloader`

```shell
## load custon keymap
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
# TODO: build linux kernel with 9p support
# https://wiki.archlinux.org/title/Kernel/Arch_Build_System
# pacstrap /mnt base linux linux-firmware
pacstrap /mnt base linux-lts linux-firmware
# pacstrap /mnt base linux-zen linux-firmware
# pacstrap /mnt base linux-hardened linux-firmware

###

## automatic mount partition
genfstab -U /mnt >> /mnt/etc/fstab

###

## root autologin
# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console
mkdir -p /mnt/etc/systemd/system/getty@tty1.service.d
cat << 'EOF' > /mnt/etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=-/usr/bin/agetty --autologin root --noclear %I $TERM
EOF

###

## 9p support
# https://github.com/copy/v86/blob/master/docs/linux-9p-image.md
## initcpio hooks
mkdir -p /mnt/etc/initcpio/hooks
cat << 'EOF' > /mnt/etc/initcpio/hooks/9p_root
#!/usr/bin/bash
run_hook() {
    mount_handler="mount_9p_root"
}
mount_9p_root() {
    msg ":: mounting '$root' on real root (9p)"
    if ! mount -t 9p host9p "$1"; then
        echo "You are now being dropped into an emergency shell."
        launch_interactive_shell
        msg "Trying to continue (this will most likely fail) ..."
    fi
}
EOF
## initcpio install
mkdir -p /mnt/etc/initcpio/install
cat << 'EOF' > /mnt/etc/initcpio/install/9p_root
#!/bin/bash
build() {
	add_runscript
}
EOF
## initramfs modules support 9p
sed -i 's/MODULES=(/MODULES=(virtio_pci 9p 9pnet 9pnet_virtio /g' /mnt/etc/mkinitcpio.conf
sed -i 's/HOOKS=(/HOOKS=(9p_root /g' /mnt/etc/mkinitcpio.conf

###

## write arch-chroot bootstrap  
cat << 'EOF' > /mnt/bootstrap.sh
## os settings
# TODO: change locales, timezone, ...
# https://wiki.archlinux.org/title/Installation_guide
# https://wiki.archlinux.de/title/Arch_Linux_auf_Deutsch_stellen#localectl

## root password
echo 'root:qwepoi123098' | chpasswd

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
EOF
## execute arch-chroot bootstrap
arch-chroot /mnt bash bootstrap.sh

###

umount /mnt

# systemctl poweroff or ...
# reboot
```

---

Start a simple http server. 

```
npm install -g http-server
http-server -p 8000
```

### 9p filesystem

```shell
mkdir mnt

sudo losetup -f
sudo losetup /dev/loop12 /archlinux32-2021.04.06-i686.img
sudo kpartx -a /dev/loop12vim

sudo mount /dev/mapper/loop12p1 mnt

# make dirs
mkdir -p out/arch32
mkdir -p out/images

wget https://github.com/copy/v86/blob/3791d63ffd09881782690902c6ee57f0edbd56a3/tools/fs2json.py
# filesystem to json
sudo python fs2json.py --exclude /boot/ --out out/images/fs.json mnt

# copy filesystem
sudo rsync -q -av mnt/ out/arch32
# chown to nonroot user
sudo chown -R $(whoami):$(whoami) out/arch32

# clean up mounts
sudo umount diskmount -f
sudo kpartx  -d /dev/loop0
sudo losetup -d /dev/loop0

# TODO: copy image to out/images
```

### using Qemu & BuildRoot

```shell
sudo apt install qemu-system

wget https://buildroot.uclibc.org/downloads/buildroot-2021.02.1.tar.gz
tar -xvzf buildroot-2021.02.1.tar.gz

cd buildroot-2021.02.1

make menuconfig
make nconfig
make xconfig
make qconfig

make list-defconfigs

make qemu_x86_defconfig
make

wget -P images/ https://copy.sh/v86/images/{linux.iso,linux3.iso,kolibri.img,windows101.img,os8.dsk,freedos722.img,openbsd.img}
```

### Examples

https://copy.sh/v86/