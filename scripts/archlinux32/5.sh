#################################
# ARCHLINUX32 9P DIRECTORY JSON #
#################################

### create mount directory
mkdir mnt

## prepare loop
sudo losetup -f
sudo losetup /dev/loop12 /archlinux32-2021.04.06-i686.img
sudo kpartx -a /dev/loop12vim
## mount archlinux32
sudo mount /dev/mapper/loop12p1 mnt

# make dirs
mkdir -p out/archlinux32

# https://github.com/copy/v86/tree/master/tools
wget https://github.com/copy/v86/blob/3791d63ffd09881782690902c6ee57f0edbd56a3/tools/fs2json.py

## filesystem to json
sudo python fs2json.py --exclude /boot/ --out out/fs.json mnt

## copy filesystem
sudo rsync -q -av mnt/ out/archlinux32
## chown to nonroot user
sudo chown -R $(whoami):$(whoami) out/archlinux32

## clean up mounts
sudo umount diskmount -f
sudo kpartx  -d /dev/loop0
sudo losetup -d /dev/loop0

# TODO: copy image to out/
echo "copy image to out/"