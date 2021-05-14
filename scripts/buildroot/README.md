### using Qemu & BuildRoot

```shell
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
```