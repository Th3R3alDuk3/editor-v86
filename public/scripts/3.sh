#################################
# CUSTOM KERNEL WITH 9P SUPPORT #
#################################

# https://wiki.archlinux.org/title/Kernel/Arch_Build_System

arch-chroot /mnt

## install packages
pacman -S asp base-devel pacman-contrib --noconfirm

## create directory
mkdir build
cd build 

## retrieve pkgbuild source
asp32 update linux-lts
asp32 export linux-lts

cd linux-lts

## add 9p support to kernel config 
sed -i "s/CONFIG_NET_9P=m/CONFIG_NET_9P=y/g" config
sed -i "s/CONFIG_NET_9P_VIRTIO=m/CONFIG_NET_9P_VIRTIO=y/g" config
sed -i "s/CONFIG_NET_9P_DEBUG=m/CONFIG_NET_9P_DEBUG=y/g" config
sed -i "s/# CONFIG_NET_9P_DEBUG is not set/CONFIG_NET_9P_DEBUG=y/g" config
sed -i "s/CONFIG_VIRTIO=m/CONFIG_VIRTIO=y/g" config
sed -i "s/CONFIG_VIRTIO_PCI=m/CONFIG_VIRTIO_PCI=y/g" config
sed -i "s/CONFIG_9P_FS=m/CONFIG_9P_FS=y/g" config
sed -i "s/CONFIG_9P_FSCACHE=m/CONFIG_9P_FSCACHE=y/g" config
sed -i "s/CONFIG_9P_FS_POSIX_ACL=m/CONFIG_9P_FS_POSIX_ACL=y/g" config

## change kernel name
sed -i "s/pkgbase=/pkgbase=custom-/g" PKGBUILD

## create test user
useradd -M test
## wheel to sudoers
# usermod --append --groups wheel test
# visudo
## password
echo -n "test:test" | chpasswd
chown -R test: ../../build
su test 

## compile and install kernel
makepkg -s -i --skipinteg

## write initramfs images
mkinitcpio -P

exit