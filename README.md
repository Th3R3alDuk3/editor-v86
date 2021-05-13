https://github.com/copy/v86/wiki/How-to-Compile-v86-(Both-for-embedded-use-and-with-the-GUI)
https://github.com/copy/images
https://git.fslab.de/lschau2s/lunix.io/-/blob/master/v86/docs/archlinux.md

sudo apt install packer --fix-missing

## 1. Option
### Qemu & ArchLinux

https://github.com/copy/v86/blob/master/docs/archlinux.md
https://www.youtube.com/watch?v=iENmRwVhsTQ&t=137s

```
wget https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

qemu-img create archlinux32.img 2G
qemu-system-i386 -hda archlinux32.img -cdrom archlinux32-2021.05.06-i686.iso -boot d -m 512
```

```
# load custom keyboard
loadkeys de-latin1

fdisk -l

# bootable partition
cfdisk /dev/sda

# format partition
mkfs.ext4 /dev/sda1

# mount partition
mount /dev/sda1 /mnt

# install base linux
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# install tinycc
pacman -S tcc

# v86 keyboard support
sed -i 's/MODULES=()/MODULES=(atkbd i8042)/g' /etc/mkinitcpio.conf

# TODO: change locales, timezone, ...
# https://wiki.archlinux.org/title/Installation_guide
# https://wiki.archlinux.de/title/Arch_Linux_auf_Deutsch_stellen#localectl

# set root password
passwd

# TODO: autologin
# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console

# initramfs
mkinicpio -P

# install bootloader
pacman -S grub os-prober

# set bootloader
grub-install /dev/sda

# TODO: hidden menu
# https://wiki.archlinux.org/title/GRUB/Tips_and_tricks

grub-mkconfig -o /boot/grub/grub.cfg

exit

umount /mnt

reboot
```

start simple http server 

```
npm install -g http-server
http-server -p 8000
```

## 2. Option
### Qemu & BuildRoot

```
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

https://copy.sh/v86/