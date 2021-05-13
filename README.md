# editor-v86-tcc

https://github.com/copy/v86/wiki/How-to-Compile-v86-(Both-for-embedded-use-and-with-the-GUI)
  
Some images for vor v86 emulation:  
https://github.com/copy/images

## Installation

### using Qemu & ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md

```bash
wget https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

# create a 2G disk image
qemu-img create archlinux32-2021.04.06-i686.img 2G
# follow installation process
qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.05.06-i686.iso -boot d -m 512
```

```bash
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

# automate mounting of partitions
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

# systemctl poweroff or ...
reboot
```

Start a simple http server. 

```
npm install -g http-server
http-server -p 8000
```

### using Qemu & BuildRoot

```bash
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