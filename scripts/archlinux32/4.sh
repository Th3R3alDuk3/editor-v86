#!/bin/bash
###############################
# ARCHLINUX32 WITH 9P SUPPORT #
###############################

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

## initramfs modules and hooks support 9p
PATH=/mnt/etc/mkinitcpio.conf
sed -i 's/MODULES=(/MODULES=(virtio_pci 9p 9pnet 9pnet_virtio /g' $PATH
sed -i 's/HOOKS=(/HOOKS=(9p_root /g' $PATH

## write initramfs images
arch-chroot /mnt bash 'mkinitcpio -P'