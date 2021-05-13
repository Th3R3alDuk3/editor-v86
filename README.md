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

# fdisk -l
# bootable partition
cfdisk /dev/sda
# format partition
mkfs.ext4 /dev/sda1
# mount filesystem
mount /dev/sda1 /mnt

# TODO: eigen linux kernel mit 9p support
# install base linux
pacstrap /mnt base linux linux-firmware

# automate mounting of partitions
genfstab -U /mnt >> /mnt/etc/fstab

# TODO: 9p support (speed up)
# https://github.com/copy/v86/blob/master/docs/linux-9p-image.md

# v86 keyboard support
sed -i 's/MODULES=()/MODULES=(atkbd i8042)/g' /etc/mkinitcpio.conf

cat << 'EOF' > /mnt/bootstrap.sh

# install packages
pacman -S vi vim tcc sl --noconfirm

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

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/g' /etc/default/grub

EOF

arch-chroot /mnt bash bootstrap.sh

umount /mnt

# systemctl poweroff or ...
reboot
```

Start a simple http server. 

```
npm install -g http-server
http-server -p 8000
```

### 9p filesystem

```bash
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