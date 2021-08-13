### seabios

Use the appropriate configuration `.config` for [coreboot](https://doc.coreboot.org/).

```
git clone https://github.com/coreboot/seabios

cd seabios

make menuconfig
make -j 4
```