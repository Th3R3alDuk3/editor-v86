#!/bin/bash
#-------------------------------+
# CUSTOM KERNEL WITH 9P SUPPORT |
#-------------------------------+

# https://wiki.archlinux.org/title/Kernel/Arch_Build_System

# mount filesystem
mount /dev/sda1 /mnt

#---

# install additional packages
pacman --noconfirm --root /mnt -S asp base-devel pacman-contrib

#---

cat << 'EOF' > /mnt/bootstrap.sh
#!/bin/bash

# create directory
mkdir build
cd build 

#---

# retrieve pkgbuild source
asp32 update linux-lts
asp32 export linux-lts

#---

cd linux-lts

# support 9p
sed -i "s/CONFIG_NET_9P=m/CONFIG_NET_9P=y/g" config
sed -i "s/CONFIG_NET_9P_VIRTIO=m/CONFIG_NET_9P_VIRTIO=y/g" config
sed -i "s/CONFIG_NET_9P_DEBUG=m/CONFIG_NET_9P_DEBUG=y/g" config
sed -i "s/# CONFIG_NET_9P_DEBUG is not set/CONFIG_NET_9P_DEBUG=y/g" config
sed -i "s/CONFIG_VIRTIO=m/CONFIG_VIRTIO=y/g" config
sed -i "s/CONFIG_VIRTIO_PCI=m/CONFIG_VIRTIO_PCI=y/g" config
sed -i "s/CONFIG_9P_FS=m/CONFIG_9P_FS=y/g" config
sed -i "s/CONFIG_9P_FSCACHE=m/CONFIG_9P_FSCACHE=y/g" config
sed -i "s/CONFIG_9P_FS_POSIX_ACL=m/CONFIG_9P_FS_POSIX_ACL=y/g" config

# rename kernel
sed -i "s/pkgbase=linux-lts/pkgbase=linux-lts-custom/g" PKGBUILD

# speed up
sed -i "s/make htmldocs/# make htmldocs/g" PKGBUILD
sed -i 's/pkgname=("$pkgbase" "$pkgbase-headers" "$pkgbase-docs")/# pkgname=("$pkgbase" "$pkgbase-headers")/g' PKGBUILD

#---

# create test user
useradd -M test

# test password
echo "test:test" | chpasswd
# change owner
chown -R test: ../../build

# login
su test 

#---

# updpkgsums
# compile and install kernel
makepkg -s -i --skipinteg

# write initramfs images
mkinitcpio -P
EOF

arch-chroot /mnt bash bootstrap.sh