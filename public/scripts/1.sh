## download archlinux32 image
wget -nc https://mirror.archlinux32.org/archisos/archlinux32-2021.04.06-i686.iso

## create a 2G disk image
# qemu-img create archlinux32-2021.04.06-i686.img 2G
qemu-img create archlinux32-2021.04.06-i686.img 5G

## follow installation process
# qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 512
qemu-system-i386 -hda archlinux32-2021.04.06-i686.img -cdrom archlinux32-2021.04.06-i686.iso -boot d -m 1024