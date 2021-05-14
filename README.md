# editor-v86-tcc
  
Some images for v86 emulation:  
https://github.com/copy/images  

```
wget -P images/ https://copy.sh/v86/images/{linux.iso,linux3.iso,kolibri.img,windows101.img,os8.dsk,freedos722.img,openbsd.img}
```  

Some examples for v86 emulation:  
https://github.com/copy/v86/tree/master/examples  
https://copy.sh/v86/

## Installation

### using Qemu & ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md  

- execute script `/scripts/archlinux32/1.sh`  
-- download archlinux32 image  
-- create hda image file  
-- boot iso file and mount hda image file  

```shell
#####################
# ARCHLINUX32 IMAGE #
#####################

# https://mirror.archlinux32.org/archisos

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

- switch to `qemu gui`  

```shell
# loadkeys de-latin1

## download script
curl -O 192.168.xxx.xxx:xxxx/2.sh

chmod +x *.sh
```

- execute script `/scripts/archlinux32/2.sh`  
-- create and mount filesystem `/dev/sda1`  
-- setting up `linux`  
-- setting up `bootloader`  

```shell
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
```

---

### 9p Support

- switch to `qemu gui`  
-- execute `scripts/archlinux32/3.sh`  
-- execute `scripts/archlinux32/4.sh`  

```shell
# loadkeys de-latin1

## download script
curl -O 192.168.xxx.xxx:xxxx/3.sh
curl -O 192.168.xxx.xxx:xxxx/4.sh

chmod +x *.sh
```

- switch to `local system`  
-- execute `scripts/archlinux32/5.sh`  

---

Start a simple http server. 

```
npm install -g http-server
http-server -p 8000
```